# Infrastructure Decision Records (IDR)

**IMPORTANT**: This is a TEMPLATE repository.
This document only contains infrastructure decisions for the development environment (Dev Container).
Production infrastructure (AWS/Azure cloud resources) is managed separately by projects generated from these templates.

## Dev Container Environment

### IDR-001: Dev Container Base Image
- **Status**: Accepted
- **Date**: 2024-10-07
- **Context**: Need unified development environment across team
- **Decision**: Use `mcr.microsoft.com/devcontainers/base:noble`
- **Alternatives**: 
  - Alpine Linux: Lightweight but tool compatibility issues
  - Custom image: High maintenance cost
- **Consequences**: 
  - High stability with Microsoft official image
  - Rich tool support with Ubuntu Noble base
  - Slightly larger image size

### IDR-002: Package Management
- **Status**: Accepted
- **Date**: 2024-10-07
- **Context**: Need to efficiently manage multiple languages and tools
- **Decision**: 
  - Node.js: pnpm (workspace support)
  - Python: uv (fast package management)
  - Rust: cargo
- **Alternatives**:
  - Node.js: npm, yarn (slower than pnpm)
  - Python: pip, poetry (slower than uv)
- **Consequences**:
  - Improved disk efficiency
  - Fast installation speed
  - Monorepo configuration support

### IDR-003: Volume Mount Strategy
- **Status**: Accepted
- **Date**: 2024-10-07
- **Context**: Avoid package reinstallation on container rebuild
- **Decision**: 
  - Volume mount `node_modules`
  - Volume mount `.venv`
  - Volume mount Serena cache
- **Alternatives**: 
  - Install to host directory: Performance degradation
  - No mount: Reinstall every time
- **Consequences**:
  - Fast container rebuild
  - Increased disk usage
  - Improved environment consistency

## Cloud Providers

### IDR-004: AWS CLI/Azure CLI Integration
- **Status**: Accepted
- **Date**: 2024-10-07
- **Context**: Need multi-cloud development environment
- **Decision**: Pre-install both AWS CLI and Azure CLI
- **Alternatives**: 
  - Single cloud only: Lacks flexibility
  - Install when needed: Increased setup time
- **Consequences**:
  - Ready for multi-cloud projects immediately
  - Increased image size
  - Complex credential management (solved with bind mount)

### IDR-005: AWS SAM CLI
- **Status**: Accepted
- **Date**: 2024-12-21
- **Context**: Need serverless application development support
- **Decision**: Install AWS SAM CLI via custom feature
- **Alternatives**:
  - Execute via Docker: Complex configuration
  - Manual installation: Not automated
- **Consequences**:
  - Easy Lambda/SAM development
  - Auto-detect architecture (x86_64/arm64)
  - Slightly increased installation time

### IDR-006: Credential Sharing
- **Status**: Accepted
- **Date**: 2024-10-07
- **Context**: Want to share credentials across multiple devbox projects
- **Decision**: Bind mount host's `~/.aws`, `~/.azure`, `~/.claude`, `~/.codex`
- **Alternatives**:
  - Individual container configuration: High management cost
  - Secret management service: Too complex
- **Consequences**:
  - Single authentication for all projects
  - Security risk (synced with host)
  - Dynamic mount with Windows/WSL environment variables

## Editor & Development Tools

### IDR-007: Helix Text Editor
- **Status**: Accepted
- **Date**: 2024-12-21
- **Context**: Need modern text editing in CLI environment
- **Decision**: Install Helix editor via custom feature
- **Alternatives**:
  - vim/neovim: Complex configuration
  - nano: Limited functionality
- **Consequences**:
  - Built-in LSP/Tree-sitter
  - Ready to use without configuration
  - Different key bindings from Vim

### IDR-008: Rust CLI Tools
- **Status**: Accepted
- **Date**: 2024-12-21
- **Context**: Need fast and reliable CLI tools
- **Decision**: Install zellij, exa, bat, fd, ripgrep via cargo
- **Alternatives**:
  - Traditional Unix tools only: Inferior functionality and speed
  - Individual binary distribution: Complex management
- **Consequences**:
  - Improved CLI experience
  - Increased build time (first time only)
  - Dependency on Rust ecosystem

## AI Development Tools

### IDR-009: AI Coding Agents
- **Status**: Accepted
- **Date**: 2024-10-07
- **Context**: Need AI-driven development support
- **Decision**: Pre-install Claude Code, Cline, Codex, Copilot
- **Alternatives**:
  - Specific AI tool only: Limited options
  - Install later: Poor initial experience
- **Consequences**:
  - Can compare multiple AI assistants
  - Large VSCode extension size
  - Centralized credential management

### IDR-010: Serena MCP Server
- **Status**: Accepted
- **Date**: 2024-12-21
- **Context**: Need project context persistence
- **Decision**: Use Serena MCP server memory functionality
- **Alternatives**:
  - Markdown files only: Low searchability
  - External database: Too complex
- **Consequences**:
  - Easy project knowledge accumulation
  - Semantic search capability
  - Persistence with cache volume mount

## Code Quality Tools

### IDR-011: Biome (JavaScript/TypeScript)
- **Status**: Accepted
- **Date**: 2024-12-21
- **Context**: Need fast unified JS/TS toolchain
- **Decision**: Adopt Biome as linter/formatter
- **Alternatives**:
  - ESLint + Prettier: Slow, complex configuration
  - deno fmt/lint: Inconsistent with Node.js projects
- **Consequences**:
  - Significantly improved execution speed
  - Unified and simple configuration
  - Still growing ecosystem

### IDR-012: Ruff (Python)
- **Status**: Accepted
- **Date**: 2024-10-11
- **Context**: Need fast Python linting/formatting
- **Decision**: Adopt Ruff as linter/formatter
- **Alternatives**:
  - black + flake8 + isort: Slow, multiple tool management
  - pylint: Very slow
- **Consequences**:
  - Extremely fast (implemented in Rust)
  - Integrates multiple tool functionalities
  - Auto-run with pre-commit hooks

## Docker Environment

### IDR-013: Docker-in-Docker
- **Status**: Accepted
- **Date**: 2024-10-07
- **Context**: Need to use Docker inside container
- **Decision**: Use Docker-in-Docker feature
- **Alternatives**:
  - Docker socket mount: Security risk
  - Execute outside container: Poor development experience
- **Consequences**:
  - Can execute Docker commands inside container
  - Nested container overhead
  - Enable BuildKit for faster builds
