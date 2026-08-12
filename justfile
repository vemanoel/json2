gopls_version := "0.23.0"
go_version := "1.26.0"

gopls:
    exec pkgx +go@{{ go_version }} go +gopls@{{ gopls_version }} gopls

run *args:
	pkgx +go@{{ go_version }} go run main.go {{ args }}

crossbuild:
	GOOS=linux GOARCH=amd64 pkgx +go@{{ go_version }} go build -o ./build/linux-amd64
	GOOS=linux GOARCH=386 pkgx +go@{{ go_version }} go build -o ./build/linux-386

	GOOS=darwin GOARCH=amd64 pkgx +go@{{ go_version }} go build -o ./build/macos-amd64
	GOOS=darwin GOARCH=arm64 pkgx +go@{{ go_version }} go build -o ./build/macos-arm64

	GOOS=windows GOARCH=amd64 pkgx +go@{{ go_version }} go build -o ./build/windows-amd64.exe
	GOOS=windows GOARCH=386 pkgx +go@{{ go_version }} go build -o ./build/windows-386.exe
