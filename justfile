set quiet

[windows]
setup_git name email:
    #!powershell
    git config --local user.name {{ name }}
    git config --local user.email {{ email }}
	git config user.name; git config user.email

[windows]
setup_github:
    #!powershell
    $token = Read-Host "paste your personal access token" -AsSecureString
	$token = [System.Net.NetworkCredential]::new("", $token).Password
	$token | mise exec -- gh auth login --with-token
	mise exec -- gh auth status
	git config --local --add credential.https://github.com.helper ""
	git config --local --add credential.https://github.com.helper "!mise exec -- gh auth git-credential"
	git config --local --add credential.https://gist.github.com.helper ""
	git config --local --add credential.https://gist.github.com.helper "!mise exec -- gh auth git-credential"

[windows]
release version:
    #!powershell
	$tag = "v{{ version }}"
    git tag $tag
    git push origin $tag
    $run_id = ""
    while (-not $run_id) {
        $run_id = mise exec -- gh run list --workflow release.yaml --branch $tag --limit 1 --json databaseId --jq '.[0].databaseId'
        if (-not $run_id) {
            Start-Sleep -Seconds 1
        }
    }
    mise exec -- gh run watch $run_id --interval 1
    $status = mise exec -- gh run view $run_id --json conclusion --jq '.conclusion'
    if ($status -ne "success") {
        Write-Host "release failed ($status). deleting tag $tag"
        git tag --delete $tag
        git push origin --delete $tag
        exit 1
    }
    Write-Host "release $tag completed successfully"

[windows]
run *args:
	#!powershell
	mise exec -- go run main.go {{ args }}

[windows]
build os arch:
	#!powershell
	$env:GOOS={{ os }}; $env:GOARCH={{ arch }}
    mise exec -- go build -o build/{{ os }}_{{ arch }}{{ if os == "windows" { ".exe" } else { "" } }}

[windows]
crossbuild:
	#!powershell
    mise exec -- just build linux amd64
    mise exec -- just build linux 386
    mise exec -- just build darwin amd64
    mise exec -- just build darwin arm64
    mise exec -- just build windows amd64
    mise exec -- just build windows 386

[windows]
clean:
	#!powershell
    rm -rf ./build
    rm -rf ${HOME}/.pkgx
    rm -rf ${HOME}/.local/share/pkgx
    rm -rf ${HOME}/.cache/{deno,pkgx}
    rm -rf ${HOME}/go/pkg
    rm -rf ${HOME}/.config/go
    rm -rf ${HOME}/.cache/{go,gopls,go-build,goimports}
