## Development

### Prerequisites

- [zed](https://zed.dev)
- [git](https://git-scm.com)
- [mise](https://mise.jdx.dev)

### Environment setup

1. Clone this repository and navigate to the project directory
2. Run `mise trust; mise install`
3. Access https://github.com/settings/tokens/new
4. Generate a token with the following scopes: `repo`, `read:org`, `gist`
5. Copy the generated token to clipboard
6. Run `mise run gitconfig`
7. Enter your github account email, your name and paste the token
8. `zed .; exit`
