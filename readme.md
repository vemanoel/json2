## Development

### Environment Setup

1. Install Devbox

```bash
curl -fsSL https://get.jetify.com/devbox | bash -s -- --force
exec bash -l
```

3. Navigate to project directory

```bash
cd rd
```

4. Install required development tools

```bash
echo | devbox install
```

### Daily Commands

```bash
devbox run -- just crossbuild               # build for all platforms
devbox run -- just build [os] [target]      # build for a specific platform
```

> [!NOTE]
> Run `devbox shell` to avoid the `devbox run --` prefix
