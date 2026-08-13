## Development

### Prerequisites

- [Zed](https://zed.dev)
- [pkgx](https://github.com/pkgxdev/pkgx#readme)

### Git setup

1. Access https://github.com/settings/tokens/new
2. Enter a name and expiration date for the token
3. Select the following scopes: `repo`, `read:org`, and `gist`
4. Click **Generate token** and copy the token
5. Fork this repository
6. Clone the forked repository
7. Navigate to the project directory
8. Run `pkgx just setup-git`
9. Enter your name, github account email, and paste the access token

### Commands

```bash
pkgx git [command]              # run git commands
pkgx just clean                 # clean build artifacts and caches
pkgx just run [args]            # run the application
pkgx just crossbuild            # build for all platforms
pkgx just build [os] [target]   # build for a specific platform
pkgx just release [version]     # try create and publish a new release
```
