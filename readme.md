## Development

### Environment Setup

1. Install pkgx

```bash
curl -fsS https://pkgx.sh | sh
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
pkgx make crossbuild               # build for all platforms
pkgx make build [os] [target]      # build for a specific platform
```
