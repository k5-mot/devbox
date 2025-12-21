# Development Environment Setup

## Project Overview

**IMPORTANT**: This is a **TEMPLATE repository**. It is not for developing actual applications, but a collection of templates for quickly starting new projects.

### Project Structure
```
devbox/
├── .devcontainer/          # Dev Container configuration
│   ├── devcontainer.json   # Container settings
│   ├── features/           # Custom features
│   │   ├── aws-sam-cli/
│   │   ├── cargo/
│   │   ├── helix/
│   │   └── npm/
│   ├── initialize.sh       # Initialization script
│   ├── postCreate.sh       # Post-create script
│   └── postStart.sh        # Post-start script
├── next-daisyui-template/  # Next.js + DaisyUI template
├── vite-serendie-template/ # Vite + Serendie template
├── python-template/        # Python + FastAPI template
├── CLAUDE.md               # AI development guidelines
├── README.md               # Project description
├── SETUP.md                # Setup procedures
└── biome.jsonc             # Biome configuration (shared)
```

## Prerequisites

### Required Environment
- **OS**: Windows 11 (admin privileges required)
- **WSL2**: Ubuntu (latest recommended)
- **Docker Desktop**: WSL2 integration enabled
- **VSCode**: Dev Container extension installed

### Installed Tools (Windows side)
```powershell
# Windows Terminal
winget install Microsoft.WindowsTerminal

# PowerShell 7+
winget install Microsoft.PowerShell

# VSCode
winget install Microsoft.VisualStudioCode

# Git
winget install Git.Git

# AWS CLI
winget install Amazon.AWSCLI

# Azure CLI
winget install Microsoft.AzureCLI
```

### WSL2 Setup
```powershell
# Enable WSL2
wsl --install

# Install Ubuntu
wsl --install -d Ubuntu

# Install Docker (in WSL)
sudo apt update
sudo apt install docker.io docker-compose
sudo usermod -aG docker $USER
```

## Dev Container Environment

### Base Image
- `mcr.microsoft.com/devcontainers/base:noble`
- Ubuntu 24.04 (Noble) based

### Pre-installed Tools

#### Languages & Runtimes
- **Node.js**: 24.12.0
- **Python**: 3.14
- **Rust**: latest

#### Package Managers
- **pnpm**: For Node.js (global install)
- **uv**: For Python (fast)
- **cargo**: For Rust

#### Cloud Tools
- **AWS CLI**: v2
- **Azure CLI**: latest
- **AWS SAM CLI**: latest (custom feature)
- **AWS CDK**: latest

#### Development Tools
- **Helix**: Modern text editor (custom feature)
- **Zellij**: Terminal multiplexer
- **exa**: ls alternative
- **bat**: cat alternative
- **fd-find**: find alternative
- **ripgrep**: grep alternative

#### AI Coding Agents
- **Claude Code**: Anthropic official CLI
- **Cline**: VSCode extension (formerly Claude Dev)
- **Codex**: OpenAI Codex
- **GitHub Copilot**: Code completion

#### Code Quality Tools
- **Biome**: JavaScript/TypeScript Linter/Formatter
- **Ruff**: Python Linter/Formatter
- **Pyright**: Python type checker
- **pre-commit**: Git hook framework

### Volume Mounts

#### Credential Sharing (bind mount)
```json
"mounts": [
  "source=${localEnv:HOME}${localEnv:USERPROFILE}/.aws,target=/home/vscode/.aws,type=bind",
  "source=${localEnv:HOME}${localEnv:USERPROFILE}/.azure,target=/home/vscode/.azure,type=bind",
  "source=${localEnv:HOME}${localEnv:USERPROFILE}/.claude,target=/home/vscode/.claude,type=bind",
  "source=${localEnv:HOME}${localEnv:USERPROFILE}/.codex,target=/home/vscode/.codex,type=bind"
]
```

#### Package Cache (volume mount)
```json
"mounts": [
  "source=${localWorkspaceFolderBasename}-vite-pkgs,target=${containerWorkspaceFolder}/vite-serendie-template/node_modules,type=volume",
  "source=${localWorkspaceFolderBasename}-next-pkgs,target=${containerWorkspaceFolder}/next-daisyui-template/node_modules,type=volume",
  "source=${localWorkspaceFolderBasename}-python-pkgs,target=${containerWorkspaceFolder}/python-template/.venv,type=volume",
  "source=${localWorkspaceFolderBasename}-serena,target=${containerWorkspaceFolder}/.serena/cache,type=volume"
]
```

### Environment Variables
```json
"runArgs": [
  "--env", "UV_LINK_MODE=copy",
  "--env", "UV_ENV_FILE=.env",
  "--env", "DOCKER_BUILDKIT=1"
],
"containerEnv": {
  "DOCKER_BUILDKIT": "1",
  "COMPOSE_DOCKER_CLI_BUILD": "1"
}
```

## Setup Procedures

### 1. Clone Repository
```bash
# Execute on Windows (PowerShell)
cd $env:USERPROFILE\Documents
git clone <repository-url> devbox
```

### 2. Open with VSCode
```bash
code devbox
```

### 3. Reopen in Dev Container
1. Open VSCode Command Palette (Ctrl+Shift+P)
2. Select "Dev Containers: Reopen in Container"
3. Wait for container build (10-20 minutes first time)

### 4. Verify Installation
```bash
# Verify inside container
node --version    # 24.12.0
python --version  # 3.14.x
uv --version      # latest
pnpm --version    # latest
sam --version     # SAM CLI
hx --version      # Helix
```

## Using Template Projects

### Creating New Project

#### Option 1: Copy Template
```bash
# Copy outside devbox
cp -r next-daisyui-template ~/projects/my-new-project
cd ~/projects/my-new-project

# Install dependencies
pnpm install

# Start development
pnpm dev
```

#### Option 2: Develop Inside This Repository
```bash
# Develop directly in each template
cd next-daisyui-template
pnpm install
pnpm dev
```

### Template Selection Guide

#### Next.js + DaisyUI
**Use Cases**:
- SSR/SSG required
- SEO focused
- Marketing sites, blogs

**Features**:
- App Router
- Tailwind CSS v4
- DaisyUI components

#### Vite + Serendie
**Use Cases**:
- SPA
- Admin panels, dashboards
- Internal tools

**Features**:
- Ultra-fast build
- Serendie lightweight UI
- React Router

#### Python + FastAPI
**Use Cases**:
- REST API
- Microservices
- LangChain applications

**Features**:
- Async processing
- Automatic API docs
- Pydantic validation

## Authentication Setup

### AWS CLI
```bash
aws configure
# AWS Access Key ID: <your-key>
# AWS Secret Access Key: <your-secret>
# Default region name: us-west-2
# Default output format: json
```

### Azure CLI
```bash
az login
# Authenticate in browser
```

### Claude Code
```bash
claude auth login
# Authenticate in browser
```

### Codex
```bash
# Authenticate from VSCode Codex extension
```

## Troubleshooting

### Container Build Failure
```bash
# Rebuild without cache
Dev Containers: Rebuild Container Without Cache
```

### Volume Mount Error
```bash
# Delete volumes in Docker Desktop
docker volume ls
docker volume rm devbox-vite-pkgs devbox-next-pkgs devbox-python-pkgs
```

### Package Install Error
```bash
# Node.js
rm -rf node_modules pnpm-lock.yaml
pnpm install

# Python
rm -rf .venv uv.lock
uv sync
```

### Credentials Not Shared
- Verify Docker Desktop WSL integration
- Check mount path environment variables
- Verify credentials exist on host side

## Performance Optimization

### WSL2 Memory Settings
`.wslconfig` (`%USERPROFILE%\.wslconfig`):
```ini
[wsl2]
memory=8GB
processors=4
swap=2GB
```

### Docker Desktop Settings
- Resources → WSL Integration → Enable Ubuntu
- Resources → Advanced → 8GB+ memory recommended

### File Location
- Place projects inside WSL2 filesystem
- Avoid Windows side (`/mnt/c/`) - performance degradation

## Customization

### Adding New Tools
1. Add to `devcontainer.json` `features`
2. Or install in `postCreateCommand`

### Creating Custom Features
```
.devcontainer/features/my-feature/
├── devcontainer-feature.json
└── install.sh
```

### Adding VSCode Extensions
Add to `devcontainer.json` `customizations.vscode.extensions`

## Update Procedures

### Update Dev Container Configuration
1. Edit `devcontainer.json`
2. Execute "Dev Containers: Rebuild Container"

### Update Templates
```bash
# Get latest devbox
git pull origin main

# Update dependencies in each template
cd next-daisyui-template
pnpm update

cd ../python-template
uv sync --upgrade
```

## Security

### .env Files
- Verify included in `.gitignore`
- Provide template with `.env.example`
- Use environment variables or secret management service in production

### Credentials
- Don't edit credentials directly inside container
- Manage on host side, share via bind mount

### Docker Security
- Use Docker-in-Docker (safer than socket mount)
- Consider rootless Docker (advanced configuration)

## Recommended Workflow

1. **Clone devbox repository**
2. **Open in Dev Container**
3. **Select template**
4. **Copy template to create new project**
5. **Authentication setup (first time only)**
6. **Start development**

Keep devbox itself unchanged; recommended to continue using as template.
