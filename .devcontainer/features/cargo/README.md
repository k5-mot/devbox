# Cargo Packages Feature

This Dev Container feature installs useful Rust command-line utilities using Cargo, the Rust package manager.

## Description

This feature extends the Rust development environment by installing commonly used CLI tools from the Rust ecosystem. It's designed to run after the base Rust feature has been installed.

## Usage

Add this feature to your `devcontainer.json`:

```json
{
  "features": {
    "ghcr.io/devcontainers/features/rust": {},
    "./features/cargo": {
      "toolsToInstall": "zellij,exa,bat,fd-find,ripgrep"
    }
  }
}
```

## Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `toolsToInstall` | string | `zellij,exa,bat,fd-find,ripgrep` | Comma-separated list of Cargo packages to install |

## Default Tools

The following tools are installed by default:

| Tool | Description |
|------|-------------|
| `zellij` | Terminal workspace with batteries included |
| `exa` | Modern replacement for `ls` with better defaults and colors |
| `bat` | Cat clone with syntax highlighting and Git integration |
| `fd-find` | Simple, fast, and user-friendly alternative to `find` |
| `ripgrep` | Extremely fast text search tool |

## Installation Details

The feature:
1. Waits for the base Rust feature to be installed (via `installsAfter`)
2. Parses the comma-separated list of tools
3. Installs each tool using `cargo install`

## Dependencies

This feature requires the base Rust feature to be installed first:
- `ghcr.io/devcontainers/features/rust`

## Customization

To install a different set of tools, specify them in the `toolsToInstall` option:

```json
{
  "features": {
    "./features/cargo": {
      "toolsToInstall": "starship,tokei,hyperfine"
    }
  }
}
```

## Common Installed Tools

Here are some popular Rust CLI tools you might want to install:

- `starship` - Minimal, fast, and customizable prompt
- `tokei` - Fast code statistics
- `hyperfine` - Command-line benchmarking tool
- `cargo-edit` - Commands to add/remove dependencies from CLI
- `cargo-watch` - Watch for changes and run Cargo commands
- `cargo-audit` - Audit dependencies for security vulnerabilities
- `delta` - Syntax-highlighting pager for git and diff output
- `dust` - More intuitive version of du
- `procs` - Modern replacement for ps

## Verification

After the container is built, verify the installation:

```bash
# Check individual tools
zellij --version
exa --version
bat --version
fd --version
rg --version

# List all installed cargo packages
cargo install --list
```

## Notes

- Installation time may vary depending on the number of tools specified
- Each tool is compiled from source, which may take several minutes
- Make sure to list this feature after the Rust feature in your configuration
