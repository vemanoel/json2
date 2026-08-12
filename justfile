set quiet

gopls_version := "0.23.0"
go_version := "1.26.5"

start_gopls:
    pkgx +go@{{ go_version }} +gopls@{{ gopls_version }} gopls

run *args:
	pkgx +go@{{ go_version }} go run ./main.go {{ args }}

build os arch:
	rm -rf ./build/{{ os }}-{{ arch }}
	GOOS={{ os }} GOARCH={{ arch }} pkgx +go@{{ go_version }} go build -o ./build/{{ os }}-{{ arch }}{{ if os == "windows" { ".exe" } else { "" } }}

crossbuild:
	rm -rf ./crossbuild/*

	GOOS=linux GOARCH=amd64 pkgx +go@{{ go_version }} go build -o ./crossbuild/linux-amd64
	GOOS=linux GOARCH=386 pkgx +go@{{ go_version }} go build -o ./crossbuild/linux-386

	GOOS=darwin GOARCH=amd64 pkgx +go@{{ go_version }} go build -o ./crossbuild/macos-amd64
	GOOS=darwin GOARCH=arm64 pkgx +go@{{ go_version }} go build -o ./crossbuild/macos-arm64

	GOOS=windows GOARCH=amd64 pkgx +go@{{ go_version }} go build -o ./crossbuild/windows-amd64.exe
	GOOS=windows GOARCH=386 pkgx +go@{{ go_version }} go build -o ./crossbuild/windows-386.exe
