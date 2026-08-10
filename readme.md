## Development

### Environment Setup

1. Uninstall Nix

```bash
sudo rm -rf /nix \
  ~root/.nix-channels \
  ~root/.nix-defexpr \
  ~root/.nix-profile \
  /etc/nix \
  /etc/profile.d/nix.sh \
  /etc/tmpfiles.d/nix-daemon.conf \
  /etc/bash.bashrc.backup-before-nix

for i in $(seq 1 32); do
  sudo userdel nixbld$i
done
sudo groupdel nixbld

sudo sed -i '/^# Nix$/,/^# End Nix$/d' /etc/bashrc
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
