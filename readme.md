## Development

### Prerequisites

- [zed](https://zed.dev)
- [git](https://git-scm.com)
- [mise](https://mise.jdx.dev)

### Environment setup

1. Fork this repository
2. Clone the forked repository
3. Navigate to the project directory
4. Run `mise install`
5. Access https://github.com/settings/tokens/new
6. Enter a name and expiration date for the token
7. Select the following scopes: `repo`, `read:org`, and `gist`
8. Click **Generate token** and copy the token
9. Run `mise exec -- just setup-git`
10. Enter your name, github account email, and paste the access token

### Commands

```bash
just clean                 # clean build artifacts and caches
just run [args]            # run the application
just crossbuild            # build for all platforms
just build [os] [target]   # build for a specific platform
just release [version]     # try create and publish a new release
```
