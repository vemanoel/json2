## Development

### Prerequisites

- [Zed](https://zed.dev)
- [Mise](https://mise.jdx.dev)

### Environment setup

1. Clone this repository and navigate to the project directory
2. Run `mise trust`
3. Run `mise install`

### Daily Commands

```bash
mise run [args]             # run the application
mise run lint               # run static analysis
mise run test               # run tests
mise run crossbuild         # build for all platforms
mise run build [os] [arch]  # build for a specific platform
```
