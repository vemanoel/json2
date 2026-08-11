GO := pkgx +go@1.26.0

crossbuild:
    GOOS=linux GOARCH=amd64 $(GO) build -o linux-amd64
    GOOS=linux GOARCH=386 $(GO) build -o linux-386

    GOOS=darwin GOARCH=amd64 $(GO) build -o macos-amd64
    GOOS=darwin GOARCH=arm64 $(GO) build -o macos-arm64

    GOOS=windows GOARCH=amd64 $(GO) build -o windows-amd64.exe
    GOOS=windows GOARCH=386 $(GO) build -o windows-386.exe
