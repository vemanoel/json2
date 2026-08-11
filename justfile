set quiet

GO := "pkgx go@1.26.5"

run *args:
	#!/usr/bin/env bash
	{{ GO }} run main.go {{ args }}

crossbuild:
	#!/usr/bin/env bash
	GOOS=linux GOARCH=amd64 {{ GO }} build -o build/linux-amd64
	GOOS=linux GOARCH=386 {{ GO }} build -o build/linux-386
	
	GOOS=darwin GOARCH=amd64 {{ GO }} build -o build/macos-amd64
	GOOS=darwin GOARCH=arm64 {{ GO }} build -o build/macos-arm64
	
	GOOS=windows GOARCH=amd64 {{ GO }} build -o build/windows-amd64.exe
	GOOS=windows GOARCH=386 {{ GO }} build -o build/windows-386.exe
