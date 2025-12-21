# Git Branch Strategy and Commit Rules

## Branch Strategy

### Default Branch
- Main branch: `main`
- All PRs target the main branch

### Branch Naming Convention
- `feature/<feature-name>`: New feature development
- `fix/<bug-description>`: Bug fixes
- `refactor/<target>`: Refactoring
- `docs/<update-description>`: Documentation updates
- `chore/<other-changes>`: Other changes

## Commit Conventions

### Conventional Commits Compliant
- Use `git cz` command (configured in changelog.config.js)
- Write commit messages in **Japanese**

### Commit Message Format
```
{type}{scope}: {emoji} {subject}
```

### Commit Types
| Type | Description | Emoji |
|------|-------------|-------|
| `feat` | New feature | ✨ |
| `fix` | Bug fix | 🐛 |
| `docs` | Documentation change | 📝 |
| `style` | UI change | 💄 |
| `refactor` | Refactoring | ♻️ |
| `perf` | Performance improvement | ⚡️ |
| `test` | Test addition | ✅ |
| `ci` | CI/CD | 👷 |
| `chore` | Development tool change | 📦 |
| `release` | Release | 🚀 |

### Scopes (Change Areas)
- `開発環境`: Dev Container, tool configuration
- `フロントエンド`: Next.js, Vite, React related
- `バックエンド`: Python, FastAPI related
- `インフラ`: AWS, Azure, Terraform related

### Commit Message Constraints
- Max length: 64 characters
- Min length: 3 characters
- Clearly explain reason and content of fix in **Japanese**

## Commit Principles
- Commits should be atomic, focusing on single changes
- Avoid direct commits to main/master branch
- Pre-commit hooks run before commits

## Merge Strategy
- Merge through Pull Request/Merge Request
- Accept code review comments as constructive improvement suggestions
- Focus on code, not individuals
