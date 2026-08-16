## Development

### Prerequisites

- [Zed](https://zed.dev)
- [Git](https://git-scm.com)
- [Mise](https://mise.jdx.dev)

### Environment setup

1. Clone this repository and navigate to the project directory
2. Run `mise install`
3. Access https://github.com/settings/tokens/new
4. Generate a token with the following scopes: `repo`, `read:org`, `gist`
5. Run `mise exec -- just setup_gh`
6. Enter your name, github account email and the generated token
7. Run `zed .; exit` to open the project in Zed
