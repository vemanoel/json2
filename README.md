## Development

### Prerequisites

- [Zed](https://zed.dev)
- [Git](https://git-scm.com)
- [Mise](https://mise.jdx.dev)

### Environment setup

1. Clone this repository and navigate to the project directory
2. Run `mise trust; mise install;`
3. Run `git config --local user.name <your name>`
4. Run `git config --local user.name <your github account email>`
5. Access https://github.com/settings/tokens/new
6. Generate a token with the following scopes: `repo`, `read:org`, `gist`
7. Run `mise exec -- gh auth login --with-token` and enter your token
8. Run `zed .; exit` to open the project in Zed
