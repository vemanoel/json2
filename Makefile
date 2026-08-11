crossbuild:
    GOOS=linux GOARCH=amd64 pkgx go@1.26.5 build -o linux-amd64
    GOOS=linux GOARCH=386 pkgx go@1.26.5 build -o linux-386

    GOOS=darwin GOARCH=amd64 pkgx go@1.26.5 build -o macos-amd64
    GOOS=darwin GOARCH=arm64 pkgx go@1.26.5 build -o macos-arm64

    GOOS=windows GOARCH=amd64 pkgx go@1.26.5 build -o windows-amd64.exe
    GOOS=windows GOARCH=386 pkgx go@1.26.5 build -o windows-386.exe
