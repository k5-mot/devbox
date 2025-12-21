# Helix Text Editor Feature

This Dev Container feature installs Helix, a modern modal text editor with built-in LSP support and Tree-sitter integration.

## Description

Helix is a post-modern text editor that comes with batteries included. It features multiple selections, Tree-sitter integration for syntax highlighting, and Language Server Protocol (LSP) support out of the box.

## Usage

Add this feature to your `devcontainer.json`:

```json
{
  "features": {
    "./features/helix": {
      "version": "latest"
    }
  }
}
```

## Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `version` | string | `latest` | The version of Helix to install (or "latest" for the newest release) |

## Supported Architectures

- x86_64 (amd64)
- arm64 (aarch64)

## What Gets Installed

- Helix text editor binary (`hx` command)
- Runtime files (themes, queries, grammars)
- Language support files

## Installation Details

The feature supports multiple installation methods:

1. **APT (Debian/Ubuntu)**: Installs via the official PPA
2. **DNF (Fedora/RHEL)**: Installs via DNF package manager
3. **Manual (fallback)**: Downloads and installs from GitHub releases

The installation process:
1. Detects the available package manager
2. Installs Helix using the appropriate method
3. Sets up the `HELIX_RUNTIME` environment variable
4. Verifies the installation

## Environment Variables

The feature sets the following environment variable:

```bash
HELIX_RUNTIME=/usr/local/lib/helix/runtime
```

This is automatically configured in `/etc/profile.d/helix.sh`.

## Verification

After the container is built, verify the installation:

```bash
hx --version
```

## Basic Usage

```bash
# Open a file
hx filename.txt

# Open multiple files
hx file1.txt file2.txt

# Open with line number
hx filename.txt:42

# Health check for language support
hx --health
hx --health typescript
```

## Key Features

- **Built-in LSP**: Language Server Protocol support without configuration
- **Tree-sitter**: Syntax highlighting and code analysis
- **Multiple Selections**: Edit multiple locations simultaneously
- **Modal Editing**: Vim-like modal interface with improved ergonomics
- **No Configuration Required**: Works out of the box with sensible defaults

## Common Keybindings

| Key | Action |
|-----|--------|
| `i` | Enter insert mode |
| `Esc` | Return to normal mode |
| `:` | Enter command mode |
| `:q` | Quit |
| `:w` | Save |
| `Space + f` | File picker |
| `Space + s` | Symbol picker |
| `g d` | Go to definition |
| `g r` | Go to references |

## Configuration

Helix configuration is stored in:
- Config: `~/.config/helix/config.toml`
- Languages: `~/.config/helix/languages.toml`
- Themes: `~/.config/helix/themes/`

Example config:

```toml
theme = "onedark"

[editor]
line-number = "relative"
mouse = false
auto-save = true
```

## Official Documentation

For more information about Helix, see:
- [Official Website](https://helix-editor.com/)
- [GitHub Repository](https://github.com/helix-editor/helix)
- [Documentation](https://docs.helix-editor.com/)
- [Language Support](https://github.com/helix-editor/helix/wiki/Language-Server-Configurations)

## Notes

- Helix comes with Tree-sitter grammars pre-installed
- LSP servers need to be installed separately for full language support
- The editor is designed to work without a configuration file
- For PPA installation, only the latest version is available
