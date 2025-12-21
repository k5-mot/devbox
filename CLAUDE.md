# LLM-Driven Development Guidelines

Use Serena MCP server memory for all project context.

## Serena Memory Keys

| Key | Description |
|-----|-------------|
| `git-branch-rules` | Branch naming, merge strategy |
| `coding-conventions` | Code style, naming, lint/format |
| `infrastructure` | Cloud services with IDR |
| `architecture` | System design with ADR |
| `frontend-dev-guide` | Frontend development workflow |
| `backend-dev-guide` | Backend development workflow |
| `deployment` | Deployment procedures |
| `cicd-rules` | CI/CD pipeline rules |
| `dev-environment` | Development environment setup |

## IDR/ADR Format

```
## [Service/Technology Name]

- Status: Accepted
- Date: YYYY-MM-DD
- Context: Why this decision was needed
- Decision: What was decided
- Alternatives: Other options considered
- Consequences: Trade-offs and implications
```

## Workflow

1. Read relevant memory keys before design, and implementation.: `mcp__serena__read_memory`
2. Update memory immediately when any project configuration, infrastructure, or architecture changes: `mcp__serena__write_memory`
