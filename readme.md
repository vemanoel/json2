## Development

### Prerequisites

- [Zed](https://zed.dev)
- [Git](https://git-scm.com)
- [Mise](https://mise.jdx.dev)

### Environment setup

1. Fork this repository and clone your fork
2. Open the terminal and navigate to the project directory
3. Run `mise install` to install the required tools
4. Run `zed .; exit` to open the project in Zed
5. Open the Zed terminal
6. Run `just setup_git "<git_name>" <github_account_email>`
7. Access https://github.com/settings/tokens/new
8. Generate a token with the following scopes: `repo`, `read:org`, `gist`
9. Copy the generated token
10. Run `just setup_gh`, paste the token and press enter

### Daily Commands

```bash
just clean                 # Clean build artifacts and caches
just run [args]            # Run the application
just crossbuild            # Build for all platforms
just build [os] [target]   # Build for a specific platform
just release [version]     # Create and publish a new release
```
