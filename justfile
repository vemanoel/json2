build os arch:
    GOOS=linux GOARCH=amd64 go build -o linux-amd64
    GOOS=linux GOARCH=386 go build -o linux-386

    GOOS=darwin GOARCH=amd64 go build -o macos-amd64
    GOOS=darwin GOARCH=arm64 go build -o macos-arm64

    GOOS=windows GOARCH=amd64 go build -o windows-amd64.exe
    GOOS=windows GOARCH=386 go build -o windows-386.exe
