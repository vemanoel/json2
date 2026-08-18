## Development

### Prerequisites

- [Zed](https://zed.dev)
- [Mise](https://mise.jdx.dev)

### Environment setup

1. Go to the project directory
2. Run `mise trust`
3. Run `mise install`
4. Run `zed .; exit`

### Daily Commands

```bash
mise run [args]             # run the application
mise run test               # run tests
mise run vet                # run static analysis
mise run crossbuild         # build for all platforms
mise run build [os] [arch]  # build for a specific platform
```
