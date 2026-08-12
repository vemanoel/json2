set quiet

go := "pkgx go@1.26.5"

run *args:
	{{ go }} run main.go {{ args }}

crossbuild:
	GOOS=linux GOARCH=amd64 {{ go }} build -o build/linux-amd64
	GOOS=linux GOARCH=386 {{ go }} build -o build/linux-386
	GOOS=darwin GOARCH=amd64 {{ go }} build -o build/macos-amd64
	GOOS=darwin GOARCH=arm64 {{ go }} build -o build/macos-arm64
	GOOS=windows GOARCH=amd64 {{ go }} build -o build/windows-amd64.exe
	GOOS=windows GOARCH=386 {{ go }} build -o build/windows-386.exe
