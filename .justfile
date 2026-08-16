set quiet

[windows]
set shell := ["powershell.exe", "-NoLogo", "-Command"]

[unix]
set shell := ["bash", "-c"]

[windows]
env:
	#!powershell
    $env:MISE_PWSH_CHPWD_WARNING=0
	powershell.exe -Command "mise activate pwsh | Out-String | Invoke-Expression; powershell.exe -NoLogo -NoProfile"

[unix]
env:
    bash --login -c 'eval "$(mise activate bash)"; exec bash'

[windows]
setup_gh:
    #!powershell
    $name = Read-Host "enter your name"
    git config --local user.name $name
    $email = Read-Host "enter your github account email"
    git config --local user.email $email
    $token = Read-Host "paste your access token" -AsSecureString
    $token = [System.Net.NetworkCredential]::new("", $token).Password
    $token | mise exec -- gh auth login --with-token
    mise exec -- gh auth status
    git config --local --add credential.https://github.com.helper '""'
    git config --local --add credential.https://github.com.helper "!mise exec -- gh auth git-credential"
    git config --local --add credential.https://gist.github.com.helper '""'
    git config --local --add credential.https://gist.github.com.helper "!mise exec -- gh auth git-credential"

[unix]
setup_gh:
    #!/usr/bin/env bash
    read -rp "enter your name: " name
    git config --local user.name $name
    read -rp "enter your github account email: " email
    git config --local user.email $email
    read -rsp "paste your access token: " token
    echo
    echo $token | mise exec -- gh auth login --with-token
    mise exec -- gh auth status
    git config --local --add credential.https://github.com.helper ''
    git config --local --add credential.https://github.com.helper "!mise exec -- gh auth git-credential"
    git config --local --add credential.https://gist.github.com.helper ''
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
        git tag --delete $tag
        git push origin --delete $tag
        exit 1
    }

[unix]
release version:
    #!/usr/bin/env bash
    tag="v{{ version }}"
    git tag $tag
    git push origin $tag
    run_id=""
    while [ -z $run_id ]; do
        run_id=$(mise exec -- gh run list --workflow release.yaml --branch $tag --limit 1 --json databaseId --jq '.[0].databaseId')
        if [ -z $run_id ]; then
            sleep 1
        fi
    done
    mise exec -- gh run watch $run_id --interval 1
    status=$(mise exec -- gh run view $run_id --json conclusion --jq '.conclusion')
    if [ $status != "success" ]; then
        git tag --delete $tag
        git push origin --delete $tag
        exit 1
    fi

run *extra_args:
	mise exec -- go run main.go {{ extra_args }}

[windows]
build os arch *extra_args:
	#!powershell
	$env:GOOS={{ os }}
	$env:GOARCH={{ arch }};
	mise exec -- go build -o build/{{ os }}_{{ arch }}{{ if os == "windows" { ".exe" } else { "" } }} {{ extra_args }}

[unix]
build os arch *extra_args:
	#!/usr/bin/env bash
    export GOOS={{ os }}
	export GOARCH={{ arch }}
	mise exec -- go build -o build/{{ os }}_{{ arch }}{{ if os == "windows" { ".exe" } else { "" } }} {{ extra_args }}

crossbuild:
    mise exec -- just build linux amd64
    mise exec -- just build linux 386
    mise exec -- just build darwin amd64
    mise exec -- just build darwin arm64
    mise exec -- just build windows amd64
    mise exec -- just build windows 386

[windows]
clean:
    Remove-Item -LiteralPath .\build -Recurse -Force
    Remove-Item -LiteralPath $HOME\go\pkg -Recurse -Force
    Remove-Item -LiteralPath $env:APPDATA\go -Recurse -Force
    Remove-Item -LiteralPath $env:LOCALAPPDATA\gopls -Recurse -Force
    Remove-Item -LiteralPath $env:LOCALAPPDATA\go-build -Recurse -Force
    Remove-Item -LiteralPath $env:LOCALAPPDATA\goimports -Recurse -Force
    Remove-Item -LiteralPath $HOME\.local\state\mise
    Remove-Item -LiteralPath $env:LOCALAPPDATA\mise -Recurse -Force

[linux]
clean:
    rm -rf ./build
    rm -rf $HOME/go/pkg
    rm -rf $HOME/.config/go
	rm -rf $HOME/.local/{share,state}/mise
    rm -rf $HOME/.cache/{go,gopls,go-build,goimports,mise,sigstore-rust}
