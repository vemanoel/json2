set quiet

setup-git:
    #!/usr/bin/env bash
    set -e

    echo -n "enter your name: "
    read name
    echo
    git config --local user.name $name

    echo -n "enter your github account email: "
    read email
    echo
    git config --local user.email $email

    echo -n "paste your personal access token: "
    read -s token
    echo
    printf $token | mise exec -- gh auth login --with-token
    mise exec -- gh auth status

    git config --local --add credential.https://github.com.helper ""
    git config --local --add credential.https://github.com.helper '!gh auth git-credential'
    git config --local --add credential.https://gist.github.com.helper ""
    git config --local --add credential.https://gist.github.com.helper '!gh auth git-credential'

release tag_name:
    #!/usr/bin/env bash
    set -e

    mise en

    git tag {{ tag_name }}
    git push origin {{ tag_name }}

    run_id=""

    while [ -z $run_id ]; do
        run_id=$(gh run list --workflow release.yaml --branch {{ tag_name }} --limit 1 --json databaseId --jq '.[0].databaseId')
        [ -z $run_id ] && sleep 1
    done

   	gh run watch $run_id --interval 1

    status=$(gh run view $run_id --json conclusion --jq '.conclusion')

    if [ $status != "success" ]; then
        echo "release failed ($status). deleting tag {{ tag_name }}..."
        git tag --delete {{ tag_name }}
        git push origin --delete {{ tag_name }}
        exit 1
    fi

    echo "release {{ tag_name }} completed successfully"

run *args:
	mise exec -- go run ./main.go {{ args }}

build os arch:
    GOOS={{ os }} GOARCH={{ arch }} mise exec -- go build -o ./build/{{ os }}_{{ arch }}{{ if os == "windows" { ".exe" } else { "" } }}

crossbuild:
    #!/usr/bin/env bash
    set -e
    mise en
    just build linux amd64
    just build linux 386
    just build darwin amd64
    just build darwin arm64
    just build windows amd64
    just build windows 386

clean:
    rm -rf ./build
    rm -rf ${HOME}/.pkgx
    rm -rf ${HOME}/.local/share/pkgx
    rm -rf ${HOME}/.cache/{deno,pkgx}
    rm -rf ${HOME}/go/pkg
    rm -rf ${HOME}/.config/go
    rm -rf ${HOME}/.cache/{go,gopls,go-build,goimports}

gopls:
    mise exec -- gopls
