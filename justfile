set quiet

vGH := "2.97.0"
vGO := "1.26.5"
vGOPLS := "0.23.0"

auth:
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
    printf $token | pkgx gh@{{ vGH }} auth login --with-token
    pkgx gh@{{ vGH }} auth status
    pkgx git config --local --add credential.https://github.com.helper ""
    pkgx git config --local --add credential.https://github.com.helper '!pkgx gh@{{ vGH }} auth git-credential'
    pkgx git config --local --add credential.https://gist.github.com.helper ""
    pkgx git config --local --add credential.https://gist.github.com.helper '!pkgx gh@{{ vGH }} auth git-credential'

release version:
    pkgx git tag v{{ version }}
    pkgx git push origin v{{ version }}

run *args:
	pkgx go@{{ vGO }} run ./main.go {{ args }}

build os arch:
    GOOS={{ os }} GOARCH={{ arch }} pkgx go@{{ vGO }} build \
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

gopls:
    pkgx +go@{{ vGO }} +gopls@{{ vGOPLS }} gopls
