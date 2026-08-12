set quiet

gopls_version := "0.23.0"
go_version := "1.26.5"

gopls:
    pkgx +go@{{ go_version }} +gopls@{{ gopls_version }} gopls

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
    pkgx go@{{ go_version }} clean -cache
    pkgx go@{{ go_version }} clean -testcache
    pkgx go@{{ go_version }} clean -modcache
