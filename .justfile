set quiet

[windows]
set shell := ["powershell.exe", "-NoLogo", "-Command"]

[unix]
set shell := ["bash", "-c"]

[windows]
env:
    $env:MISE_PWSH_CHPWD_WARNING=0; powershell.exe -Command "mise activate pwsh | Out-String | Invoke-Expression; powershell.exe -NoLogo -NoProfile"

[unix]
env:
    bash --login -c 'eval "$(mise activate bash)"; exec bash'

[windows]
setup-gh:
    #!powershell
    $ErrorActionPreference = "Stop"
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
setup-gh:
    #!/usr/bin/env bash
    set -e
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

