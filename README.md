# asdf-cangjie

[Cangjie](https://cangjie-lang.cn) plugin for the [asdf version manager](https://asdf-vm.com).

## Install

```bash
asdf plugin add cangjie https://github.com/dacec354/asdf-cangjie.git
```

## Use

```bash
# List available versions
asdf list-all cangjie

# Show latest version
asdf latest cangjie

# Install a Cangjie SDK version
asdf install cangjie 1.1.3

# Set version (current directory)
asdf set cangjie 1.1.3

# Set version for all directories (home)
asdf set -u cangjie 1.1.3

# Set version using latest
asdf set cangjie latest

# Verify
asdf current cangjie
cjc --version
cjpm --version
```

> **Note:** Downloads are resolved from the [cangjie-version-manifest](https://github.com/Zxilly/cangjie-version-manifest)
> maintained by the [cjv](https://github.com/Zxilly/cjv) project. Set `CANGJIE_MANIFEST_URL` to
> use a custom mirror.

## System Requirements

### Linux

- glibc >= 2.27
- libstdc++.so.6 >= 6.0.24 (GLIBCXX_3.4.22)
- libssl.so.3 / libcrypto.so.3 (OpenSSL 3)

```bash
# Ubuntu/Debian
sudo apt-get install build-essential libssl-dev

# Fedora
sudo dnf install gcc-c++ openssl-devel

# Arch
sudo pacman -S gcc openssl
```

### macOS

- macOS 12.0 or later
- libffi

```bash
brew install libffi
```

## Supported Platforms

| Platform | Architectures |
|----------|--------------|
| Linux | x86_64, aarch64 |
| macOS | x86_64 (Intel), arm64 (Apple Silicon) |

## Installed Tools

All Cangjie SDK tools are available as asdf shims:

| Tool | Location | Description |
|------|----------|-------------|
| `cjc` | bin/ | Cangjie compiler |
| `cjc-frontend` | bin/ | Compiler frontend |
| `cjpm` | tools/bin/ | Package manager |
| `cjdb` | tools/bin/ | Debugger |
| `cjfmt` | tools/bin/ | Code formatter |
| `cjlint` | tools/bin/ | Linter |
| `cjcov` | tools/bin/ | Code coverage |
| `cjprof` | tools/bin/ | Profiler |
| `cjtrace-recover` | tools/bin/ | Trace recovery |
| `chir-dis` | tools/bin/ | CHIR disassembler |
| `hle` | tools/bin/ | Heterogeneous language extension |
| `LSPServer` | tools/bin/ | Language server |
| `LSPMacroServer` | tools/bin/ | LSP macro server |

## Credits

Download URLs are resolved from the [cangjie-version-manifest](https://github.com/Zxilly/cangjie-version-manifest)
maintained by the [cjv](https://github.com/Zxilly/cjv) project, a community Cangjie version manager.
Without their work tracking auth-protected download URLs, automatic installation would not be possible.

## License

MIT — see [LICENSE](./LICENSE)
