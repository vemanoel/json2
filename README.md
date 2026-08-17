## Development

### Prerequisites

- [zed](https://zed.dev)
- [git](https://git-scm.com)
- [mise](https://mise.jdx.dev)

### Environment setup

1. `git clone https://github.com/vemanoel/rd.git`
2. `cd rd`
3. `mise trust`
4. `mise install`
5. `git config --local user.name <name>`
6. `git config --local user.email <github account email>`
7. [click here](https://github.com/settings/tokens/new) and generate a token with the following scopes: repo, read:org, gist
9. `echo $token | mise exec -- gh auth login --with-token` and enter the token
10. mise exec -- gh auth status
11. `git config --local --add credential.https://github.com.helper '""'`
12. `git config --local --add credential.https://github.com.helper "!mise exec -- gh auth git-credential"`
13. `git config --local --add credential.https://gist.github.com.helper '""'`
14. `git config --local --add credential.https://gist.github.com.helper "!mise exec -- gh auth git-credential"`
15. `zed .; exit`
