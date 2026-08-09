## Development

### Environment Setup (WSL, Linux, macOS)

1. Uninstall Nix

```bash
sudo rm -rf /nix
sudo rm -rf ~root/.nix-channels
sudo rm -rf ~root/.nix-defexpr
sudo rm -rf ~root/.nix-profile
sudo rm -rf /etc/nix
sudo rm -rf /etc/profile.d/nix.sh
sudo rm -rf /etc/tmpfiles.d/nix-daemon.conf

for i in $(seq 1 32); do
  sudo userdel nixbld$i
done
sudo groupdel nixbld

sudo mv /etc/bashrc.backup-before-nix /etc/bashrc
```

2. Install Nix

```bash
curl -L https://releases.nixos.org/nix/nix-2.35.1/install | sh -s -- --daemon
exec bash -l
```

3. Install Devbox

```bash
nix --extra-experimental-features 'nix-command flakes' profile add nixpkgs#devbox
```

4. Install Git

```bash
nix --extra-experimental-features 'nix-command flakes' profile add nixpkgs#git
```

5. Clone this repository

```bash
git clone https://github.com/vemanoel/rd.git
```

6. Navigate to project directory

```bash
cd rd
```

7. Install required development tools

```bash
devbox install
```

### Daily Commands

```bash
devbox run -- just crossbuild               # build for all platforms
devbox run -- just build [os] [target]      # build for a specific platform
```

> [!NOTE]
> Run `devbox shell` to avoid the `devbox run --` prefix
