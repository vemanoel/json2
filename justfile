set quiet

gh_version := "2.97.0"
go_version := "1.26.5"
gopls_version := "0.23.0"

setup-git:
    #!/usr/bin/env bash
    set -e

    echo -n "enter your name: "
    read name
    echo
    pkgx git config --local user.name $name

    echo -n "enter your github account email: "
    read email
    echo
    pkgx git config --local user.email $email

    echo -n "paste your personal access token: "
    read -s token
    echo
    printf $token | pkgx gh@{{ gh_version }} auth login --with-token
    pkgx gh@{{ gh_version }} auth status
    pkgx git config --local --add credential.https://github.com.helper ""
    pkgx git config --local --add credential.https://github.com.helper '!pkgx gh@{{ gh_version }} auth git-credential'
    pkgx git config --local --add credential.https://gist.github.com.helper ""
    pkgx git config --local --add credential.https://gist.github.com.helper '!pkgx gh@{{ gh_version }} auth git-credential'

release version:
    #!/usr/bin/env bash
    set -e

    tag_name=v{{ version }}

    pkgx git tag $tag_name
    pkgx git push origin $tag_name

    run_id=$(pkgx gh@{{ gh_version }} run list --workflow=release --branch=$tag_name --limit=1 --json databaseId --jq '.[0].databaseId')
    pkgx gh@{{ gh_version }} run watch $run_id
    status=$(pkgx gh@{{ gh_version }} run view $run_id --json conclusion --jq '.conclusion')

    if [ $status != "success" ]; then
        echo "release failed ($status). deleting tag $tag_name..."
        pkgx git tag -d $tag_name
        pkgx git push origin --delete $tag_name
        exit 1
    fi

	echo "release $tag_name completed successfully"

_release version:
	#!/usr/bin/env bash
	set -e

	tag_name=v{{ version }}

    pkgx git tag $tag_name
    pkgx git push origin $tag_name

	pkgx gh@{{ gh_version } run watch $(pkgx gh@{{ gh_version }} run list -w release -b $tag_name -L 1 --json databaseId -q '.[0].databaseId')

run *args:
	pkgx go@{{ go_version }} run ./main.go {{ args }}

build os arch:
    GOOS={{ os }} GOARCH={{ arch }} pkgx go@{{ go_version }} build -o ./build/{{ os }}_{{ arch }}{{ if os == "windows" { ".exe" } else { "" } }}

crossbuild:
    pkgx just build linux amd64
    pkgx just build linux 386
    pkgx just build darwin amd64
    pkgx just build darwin arm64
    pkgx just build windows amd64
    pkgx just build windows 386

clean:
    rm -rf ./build
    rm -rf ${HOME}/.pkgx
    rm -rf ${HOME}/.local/share/pkgx
    rm -rf ${HOME}/.cache/{deno,pkgx}
    rm -rf ${HOME}/go/pkg
    rm -rf ${HOME}/.config/go
    rm -rf ${HOME}/.cache/{go,gopls,go-build,goimports}

gopls:
    pkgx +go@{{ go_version }} +gopls@{{ gopls_version }} gopls
