## Development

### Prerequisites

- [Zed](https://zed.dev)
- [Git](https://git-scm.com)
- [Mise](https://mise.jdx.dev)

### Environment setup

1. Clone this repository and navigate to the project directory
3. Run `mise install`
4. Access https://github.com/settings/tokens/new
5. Generate a token with the following scopes: `repo`, `read:org`, `gist`
6. Run `mise exec -- just setup_gh`
7. Enter your name, github account email and the generated token
8. Run `zed .; exit` to open the project in Zed
