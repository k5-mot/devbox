# Architecture Decision Records (ADR)

## Project Structure

### ADR-001: Monorepo Structure
- **Status**: Accepted
- **Date**: 2024-10-07
- **Context**: Want unified management of frontend, backend, and infrastructure
- **Decision**: Place multiple template projects in single repository
- **Alternatives**:
  - Multi-repo: Difficult synchronization, duplicate configuration
  - Submodules: Complex management
- **Consequences**:
  - Easy code sharing
  - Consistent tool configuration
  - Larger repository size

### ADR-002: Template-based Development
- **Status**: Accepted
- **Date**: 2024-10-07
- **Context**: Want to speed up new project initialization
- **Decision**: Provide 3 templates
  - `next-daisyui-template`: Next.js + DaisyUI
  - `vite-serendie-template`: Vite + React + Serendie
  - `python-template`: Python + FastAPI
- **Alternatives**:
  - Single stack: No flexibility
  - Generator: High maintenance cost
- **Consequences**:
  - No environment setup needed when starting projects
  - Template maintenance required
  - Each template operates independently

## Frontend Architecture

### ADR-003: Next.js vs Vite
- **Status**: Accepted
- **Date**: 2024-10-07
- **Context**: Need to support different use cases
- **Decision**: 
  - Next.js: Projects requiring SSR/SSG
  - Vite: SPA/client-side rendering
- **Alternatives**:
  - Next.js only: Overkill for SPAs
  - Vite only: SSR implementation difficult
- **Consequences**:
  - Optimal choice based on project
  - Learning cost for two frontend stacks
  - Different build tools for each

### ADR-004: UI Frameworks
- **Status**: Accepted
- **Date**: 2024-10-07
- **Decision**: 
  - Next.js: DaisyUI (Tailwind CSS)
  - Vite: Serendie (custom CSS)
- **Alternatives**:
  - Material-UI: Large bundle size
  - Chakra UI: Limited customization
- **Consequences**:
  - DaisyUI: Lightweight Tailwind CSS-based
  - Serendie: Minimal dependencies
  - UI component consistency only within each template

### ADR-005: State Management
- **Status**: Pending
- **Date**: TBD
- **Context**: Global state management not standardized
- **Decision**: Choose per project
- **Alternatives**:
  - Redux Toolkit
  - Zustand
  - Jotai
  - React Context
- **Consequences**: Currently individual decision per project

## Backend Architecture

### ADR-006: Python + FastAPI
- **Status**: Accepted
- **Date**: 2024-10-07
- **Context**: Need fast and modern Python API framework
- **Decision**: Adopt FastAPI
- **Alternatives**:
  - Django: Too heavy
  - Flask: Weak type support
  - Express.js (Node): Can't unify language
- **Consequences**:
  - Good developer experience with type hints
  - Automatic API documentation generation (OpenAPI)
  - Async processing support
  - Leverage Python ecosystem

### ADR-007: uv Package Manager
- **Status**: Accepted
- **Date**: 2024-10-07
- **Context**: Want to speed up Python dependency management
- **Decision**: Adopt uv
- **Alternatives**:
  - pip: Slow, non-standard lock file
  - poetry: Slower than uv
  - pipenv: Insufficient maintenance
- **Consequences**:
  - Extremely fast (implemented in Rust)
  - Dependency management with pyproject.toml + uv.lock
  - Automatic virtual environment management
  - Still relatively new tool

## Database

### ADR-008: Database Strategy
- **Status**: Pending
- **Date**: TBD
- **Context**: Database choice depends on project
- **Decision**: Not included in templates; choose per project
- **Alternatives**:
  - PostgreSQL: Relational DB
  - MongoDB: NoSQL
  - DynamoDB: Serverless
- **Consequences**: 
  - High flexibility
  - Setup procedures described per project

## Testing Strategy

### ADR-009: Frontend Testing
- **Status**: Accepted
- **Date**: 2024-10-11
- **Context**: Unified test framework for Next.js/Vite
- **Decision**: 
  - Vitest: Unit/integration tests
  - Testing Library: Component tests
- **Alternatives**:
  - Jest: Slow, complex configuration
  - Mocha/Chai: Not modern
- **Consequences**:
  - Excellent Vite integration
  - Fast test execution
  - Can use Vitest with Next.js too

### ADR-010: Backend Testing
- **Status**: Accepted
- **Date**: 2024-10-11
- **Context**: Python test framework
- **Decision**: pytest + pytest-cov
- **Alternatives**:
  - unittest: Limited functionality
  - nose: End of maintenance
- **Consequences**:
  - Python community standard
  - Rich plugin ecosystem
  - Integrated coverage reporting

## CI/CD

### ADR-011: GitLab CI/CD
- **Status**: Accepted
- **Date**: 2024-10-11
- **Context**: CI/CD pipeline automation
- **Decision**: Use GitLab CI/CD (.gitlab-ci.yml)
- **Alternatives**:
  - GitHub Actions: GitHub dependent
  - Jenkins: Complex setup
- **Consequences**:
  - GitLab native integration
  - Use include syntax for monorepo
  - Stages: build → test → deploy

### ADR-012: Pre-commit Hooks
- **Status**: Accepted
- **Date**: 2024-10-11
- **Context**: Automate pre-commit quality checks
- **Decision**: Use pre-commit framework
- **Alternatives**:
  - Manual checks: Human error
  - husky: Node.js only
- **Consequences**:
  - Supports both Python/TypeScript
  - Auto-run lint, format, type check, tests
  - Slightly increased commit time

## Security

### ADR-013: Secret Management
- **Status**: Accepted
- **Date**: 2024-10-07
- **Context**: Manage API keys and sensitive information
- **Decision**: 
  - Environment variables (.env)
  - Exclude with Git ignore
  - Bind mount host credentials
- **Alternatives**:
  - Hardcode: Security risk
  - Vault: Overkill for small projects
- **Consequences**:
  - Simple and practical
  - Provide template with .env.example
  - Recommend separate secret management service for production

## Documentation

### ADR-014: Documentation Management
- **Status**: Accepted
- **Date**: 2024-12-21
- **Context**: Need to persist and utilize project knowledge
- **Decision**: 
  - README.md: Project overview
  - SETUP.md: Environment setup procedures
  - CLAUDE.md: AI-driven development guidelines
  - Serena Memory: Project context
- **Alternatives**:
  - Wiki only: Separated from code
  - Comments only: Low searchability
- **Consequences**:
  - Structured information
  - AI agents can leverage context
  - Need to maintain documentation synchronization
