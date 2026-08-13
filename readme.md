## Development

### Prerequisites

- [zed](https://zed.dev)
- [git](https://git-scm.com)
- [mise](https://mise.jdx.dev)

### Git setup

1. Access https://github.com/settings/tokens/new
2. Enter a name and expiration date for the token
3. Select the following scopes: `repo`, `read:org`, and `gist`
4. Click **Generate token** and copy the token
5. Fork this repository
6. Clone the forked repository
7. Navigate to the project directory
8. Run `just setup-git`
9. Enter your name, github account email, and paste the access token

### Commands

```bash
just clean                 # clean build artifacts and caches
just run [args]            # run the application
just crossbuild            # build for all platforms
just build [os] [target]   # build for a specific platform
just release [version]     # try create and publish a new release
```
