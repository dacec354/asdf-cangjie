# asdf-cangjie

[Cangjie](https://cangjie-lang.cn) plugin for the [asdf version manager](https://asdf-vm.com).

## Install

```bash
asdf plugin add cangjie https://github.com/user/asdf-cangjie.git
```

## Use

```bash
# Install a Cangjie SDK version
asdf install cangjie 1.1.3

# Set as default
asdf global cangjie 1.1.3

# Verify
cjc --version
cjpm --version
```

> **Note:** Automatic download is not yet available. `asdf install` will prompt you to
> manually download the SDK tarball from [cangjie-lang.cn/download](https://cangjie-lang.cn/download)
> and place it in the indicated location.

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

## License

MIT — see [LICENSE](./LICENSE)
