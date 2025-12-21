# NPM Tools Feature

This Dev Container feature installs commonly used Node.js development tools and package managers using npm.

## Description

This feature extends the Node.js development environment by installing essential CLI tools and alternative package managers. It's designed to run after the base Node.js feature has been installed.

## Usage

Add this feature to your `devcontainer.json`:

```json
{
  "features": {
    "ghcr.io/devcontainers/features/node": {},
    "./features/npm": {
      "toolsToInstall": "npm,yarn,pnpm,git-cz,npm-check-updates"
    }
  }
}
```

## Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `toolsToInstall` | string | `npm,yarn,pnpm,git-cz,npm-check-updates` | Comma-separated list of npm packages to install globally |

## Default Tools

The following tools are installed by default:

| Tool | Description |
|------|-------------|
| `npm` | Node Package Manager (latest version) |
| `yarn` | Fast, reliable, and secure dependency management |
| `pnpm` | Fast, disk space efficient package manager |
| `git-cz` | Commitizen adapter for formatting commit messages |
| `npm-check-updates` | Upgrade package.json dependencies to latest versions |

## Installation Details

The feature:
1. Waits for the base Node.js feature to be installed (via `installsAfter`)
2. Sets proper ownership for NVM directories
3. Parses the comma-separated list of tools
4. Installs each tool globally using `npm install -g`
5. Resets ownership after installation

## Dependencies

This feature requires the base Node.js feature to be installed first:
- `ghcr.io/devcontainers/features/node`

## Customization

To install a different set of tools, specify them in the `toolsToInstall` option:

```json
{
  "features": {
    "./features/npm": {
      "toolsToInstall": "typescript,eslint,prettier,nodemon"
    }
  }
}
```

## Common npm Global Packages

Here are some popular npm packages you might want to install globally:

### Development Tools
- `typescript` - TypeScript compiler
- `ts-node` - TypeScript execution engine
- `nodemon` - Auto-restart on file changes
- `pm2` - Process manager for Node.js

### Code Quality
- `eslint` - Linting utility for JavaScript/TypeScript
- `prettier` - Code formatter
- `stylelint` - CSS/SCSS linter
- `markdownlint-cli` - Markdown linter

### Build Tools
- `webpack-cli` - Webpack command line interface
- `vite` - Next generation frontend tooling
- `esbuild` - Extremely fast bundler

### Package Management
- `npm-check` - Check for outdated packages
- `ncu` - Alias for npm-check-updates
- `depcheck` - Check unused dependencies

### Git Tools
- `commitizen` - Conventional commit messages
- `husky` - Git hooks
- `semantic-release` - Automated versioning

### Testing
- `jest` - JavaScript testing framework
- `vitest` - Vite-native testing framework
- `playwright` - End-to-end testing

## Verification

After the container is built, verify the installation:

```bash
# Check npm
npm --version

# Check yarn
yarn --version

# Check pnpm
pnpm --version

# Check git-cz
git-cz --version

# Check npm-check-updates
ncu --version

# List all globally installed packages
npm list -g --depth=0
```

## Usage Examples

### Using different package managers

```bash
# npm
npm install
npm run dev

# yarn
yarn install
yarn dev

# pnpm
pnpm install
pnpm dev
```

### Using git-cz for commits

```bash
# Stage your changes
git add .

# Use commitizen for formatted commit messages
git-cz
```

### Using npm-check-updates

```bash
# Check for updates
ncu

# Update package.json to latest versions
ncu -u

# Install updated packages
npm install
```

## Notes

- All packages are installed globally using `npm install -g`
- The feature handles NVM directory permissions automatically
- Installation time depends on the number of packages specified
- Make sure to list this feature after the Node.js feature in your configuration
- Global packages are shared across all projects in the container

## Official Documentation

- [npm Documentation](https://docs.npmjs.com/)
- [Yarn Documentation](https://yarnpkg.com/)
- [pnpm Documentation](https://pnpm.io/)
- [Commitizen](https://github.com/commitizen/cz-cli)
- [npm-check-updates](https://github.com/raineorshine/npm-check-updates)
