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
mise r [args]             # run the application
mise r lint               # run static analysis
mise r test               # run tests
mise r crossbuild         # build for all platforms
mise r build [os] [arch]  # build for a specific platform
```
