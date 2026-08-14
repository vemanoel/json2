set quiet

setup_git git_name github_account_email:
    #!powershell
    git config --local user.name {{ git_name }}
    git config --local user.email {{ github_account_email }}

setup_github:
    #!powershell

    $token = Read-Host "Paste your personal access token" -AsSecureString
	$token = [System.Net.NetworkCredential]::new("", $token).Password

	$token | mise exec -- gh auth login --with-token

	mise exec -- gh auth status

	git config --local `
	    --add credential.https://github.com.helper ""
	
	git config --local `
	    --add credential.https://github.com.helper `
	    "!mise exec -- gh auth git-credential"
	
	git config --local `
	    --add credential.https://gist.github.com.helper ""
	
	git config --local `
	    --add credential.https://gist.github.com.helper `
	    "!mise exec -- gh auth git-credential"

release tag_name:
    #!powershell

    git tag {{ tag_name }}
    git push origin {{ tag_name }}

    $run_id = ""

    while (-not $run_id) {
        $run_id = mise exec -- gh run list `
            --workflow release.yaml `
            --branch {{ tag_name }} `
            --limit 1 `
            --json databaseId `
            --jq '.[0].databaseId'

        if (-not $run_id) {
            Start-Sleep -Seconds 1
        }
    }

    mise exec -- gh run watch `
        $run_id `
        --interval 1

    $status = mise exec -- gh run view `
        $run_id `
        --json conclusion `
        --jq '.conclusion'

    if ($status -ne "success") {
        Write-Host "release failed ($status)"
		Write-Host "deleting tag {{ tag_name }}"

        git tag --delete {{ tag_name }}
        git push origin --delete {{ tag_name }}

        exit 1
    }

    Write-Host "release {{ tag_name }} completed successfully"

run *args:
	#!powershell
	mise exec -- go run main.go {{ args }}

build os arch:
	#!powershell
	$env:GOOS={{ os }}; $env:GOARCH={{ arch }}
    mise exec -- go build -o build/{{ os }}_{{ arch }}{{ if os == "windows" { ".exe" } else { "" } }}

crossbuild:
	#!powershell
    mise exec -- just build linux amd64
    mise exec -- just build linux 386
    mise exec -- just build darwin amd64
    mise exec -- just build darwin arm64
    mise exec -- just build windows amd64
    mise exec -- just build windows 386

clean:
    rm -rf ./build
    rm -rf ${HOME}/.pkgx
    rm -rf ${HOME}/.local/share/pkgx
    rm -rf ${HOME}/.cache/{deno,pkgx}
    rm -rf ${HOME}/go/pkg
    rm -rf ${HOME}/.config/go
    rm -rf ${HOME}/.cache/{go,gopls,go-build,goimports}
