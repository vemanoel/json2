set quiet

gh_version := "2.97.0"
go_version := "1.26.5"
gopls_version := "0.23.0"

auth:
    #!/usr/bin/env bash

    set -e

    echo -n "Paste your personal access token: "
    read -s token
    echo

    echo -n "Enter your name: "
    read name
    echo

    echo -n "Enter your github account email: "
    read email
    echo

    pkgx git config --local user.name $name
    pkgx git config --local user.email $email

    printf $token | pkgx gh@{{ gh_version }} auth login --with-token

    pkgx gh@{{ gh_version }} auth status

    pkgx git config --local --add credential.https://github.com.helper ""
    pkgx git config --local --add credential.https://github.com.helper '!/home/victor/.pkgx/cli.github.com/v2.97.0/bin/gh auth git-credential'

run *args:
	pkgx go@{{ go_version }} run ./main.go {{ args }}

build os arch:
    GOOS={{ os }} GOARCH={{ arch }} pkgx go@{{ go_version }} build \
        -o ./build/{{ os }}_{{ arch }}{{ if os == "windows" { ".exe" } else { "" } }}

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

release version:
    pkgx git tag v{{ version }}
    pkgx git push origin v{{ version }}

gopls:
    pkgx +go@{{ go_version }} +gopls@{{ gopls_version }} gopls
