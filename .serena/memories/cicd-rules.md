# CI/CD Pipeline Rules

## Pipeline Structure

### Stages
1. **build**: Build processing
2. **test**: Test execution
3. **deploy**: Deployment processing

### Triggers
- **Push**: All branches
- **Merge Request**: All MRs
- **Scheduled**: Periodic execution (optional)

## Pre-commit Hooks

### Execution Timing
- Auto-execute on `git commit` command
- Skip with `git commit --no-verify` (emergency only)

### Hook Configuration File
`.pre-commit-config.yaml`

### Python Projects
```yaml
# Ruff Format
- id: ruff-format
  name: PY ruff_format
  files: "^api/.*\\.py$"

# Ruff Lint
- id: ruff
  name: PY ruff_lint
  args: ["--fix"]
  files: "^api/.*\\.py$"

# Pyright Type Check
- id: py-pyright
  name: PY pyright_type_check
  entry: bash -c "cd api && uv run --no-env-file -- pyright --project . --warnings"
  files: "^api/"

# pytest
- id: py-pytest
  name: PY pytest
  entry: bash -c "cd api && mkdir -p report && uv run --no-env-file -- pytest -q --junitxml=coverage/junit.xml --cov=. --cov-report=xml:coverage/coverage.xml --cov-report=html:coverage/coverage_html"
  files: "^api/"
```

### TypeScript/React Projects
```yaml
# Biome Format
- id: ts-biome-format
  name: TS biome_format
  entry: bash -c "cd app && pnpm run format"
  files: "^app/.*\\.(ts|tsx|js|jsx|json)$"

# Biome Lint
- id: ts-biome-lint
  name: TS biome_lint
  entry: bash -c "cd app && pnpm run lint"
  files: "^app/.*\\.(ts|tsx|js|jsx|json)$"

# TypeScript Type Check
- id: ts-tsc-type-check
  name: TS tsc_type_check
  entry: bash -c "cd app && pnpm run type"
  files: "^app/.*\\.(ts|tsx|js|jsx)$"

# Vitest
- id: ts-vitest
  name: TS vitest
  entry: bash -c "cd app && pnpm run test:ci"
  files: "^app/"

# Vite Build
- id: ts-vite-build
  name: TS vite_build
  entry: bash -c "cd app && pnpm run build"
  files: "^app/"
```

## GitLab CI/CD

### Main Pipeline (.gitlab-ci.yml)
```yaml
stages:
  - build
  - test
  - deploy

include:
  - local: "app/.gitlab-ci.yml"
  - local: "api/.gitlab-ci.yml"
```

### Frontend Pipeline Example
```yaml
# app/.gitlab-ci.yml
stages:
  - build
  - test

variables:
  NODE_VERSION: "24.12.0"

before_script:
  - cd app
  - npm install -g pnpm
  - pnpm install --frozen-lockfile

build:app:
  stage: build
  script:
    - pnpm build
  artifacts:
    paths:
      - app/dist/
      - app/.next/
    expire_in: 1 week

lint:app:
  stage: test
  script:
    - pnpm lint

type-check:app:
  stage: test
  script:
    - pnpm type

test:app:
  stage: test
  script:
    - pnpm test:ci
  coverage: '/All files[^|]*\|[^|]*\s+([\d\.]+)/'
  artifacts:
    reports:
      junit: app/junit-report.xml
      coverage_report:
        coverage_format: cobertura
        path: app/coverage/cobertura-coverage.xml
```

### Backend Pipeline Example
```yaml
# api/.gitlab-ci.yml
stages:
  - build
  - test

variables:
  PYTHON_VERSION: "3.12"

before_script:
  - cd api
  - curl -LsSf https://astral.sh/uv/install.sh | sh
  - export PATH="$HOME/.cargo/bin:$PATH"
  - uv sync --frozen

lint:api:
  stage: test
  script:
    - uv run poe lint

type-check:api:
  stage: test
  script:
    - uv run poe type

test:api:
  stage: test
  script:
    - uv run poe test
  coverage: '/TOTAL.*\s+(\d+%)$/'
  artifacts:
    reports:
      junit: api/coverage/junit.xml
      coverage_report:
        coverage_format: cobertura
        path: api/coverage/coverage.xml
```

## GitHub Actions

### Workflow Example
```yaml
# .github/workflows/ci.yml
name: CI

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main, develop]

jobs:
  frontend:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '24.12.0'
      - uses: pnpm/action-setup@v2
        with:
          version: 8
      - name: Install dependencies
        run: |
          cd app
          pnpm install --frozen-lockfile
      - name: Lint
        run: cd app && pnpm lint
      - name: Type check
        run: cd app && pnpm type
      - name: Test
        run: cd app && pnpm test:ci
      - name: Build
        run: cd app && pnpm build

  backend:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v5
        with:
          python-version: '3.12'
      - name: Install uv
        run: curl -LsSf https://astral.sh/uv/install.sh | sh
      - name: Install dependencies
        run: |
          cd api
          uv sync --frozen
      - name: Lint
        run: cd api && uv run poe lint
      - name: Type check
        run: cd api && uv run poe type
      - name: Test
        run: cd api && uv run poe test
```

## Pipeline Execution Rules

### All Branches
- Lint check
- Type check
- Unit tests
- Build verification

### main/master Branch
- All of the above
- Coverage reports
- Automatic deployment (production)

### develop Branch
- All of the above
- Automatic deployment (staging)

### feature Branches
- Lint, Type, Test, Build only
- No deployment

## Artifact Management

### Retention Period
- Build artifacts: 1 week
- Test reports: 1 month
- Coverage reports: 1 month

### Artifact Types
- **Build artifacts**: `dist/`, `.next/`
- **Test reports**: JUnit XML
- **Coverage reports**: Cobertura XML, HTML

## Coverage Requirements

### Minimum Coverage
- **Frontend**: 70%
- **Backend**: 80%

### Coverage Reports
- XML format for CI/CD integration
- HTML format for detailed review
- Display badges in GitLab/GitHub

## Cache Strategy

### GitLab CI
```yaml
cache:
  key:
    files:
      - pnpm-lock.yaml
  paths:
    - node_modules/
    - .pnpm-store/
```

### GitHub Actions
```yaml
- uses: actions/cache@v4
  with:
    path: |
      node_modules
      .pnpm-store
    key: ${{ runner.os }}-pnpm-${{ hashFiles('**/pnpm-lock.yaml') }}
```

## Security Scanning

### Dependency Scanning
```yaml
security:scan:
  stage: test
  script:
    - pnpm audit
    - uv pip list --format=json | uv pip check
  allow_failure: true
```

### Vulnerability Checks
- Dependabot / Renovate
- Snyk
- npm audit / pnpm audit
- Safety (Python)

## Deployment Strategy

### Environments
- **production**: main branch
- **staging**: develop branch
- **preview**: feature branches (optional)

### Deployment Approval
- Production: Manual approval required
- Staging: Automatic deployment
- Preview: Automatic deployment

### Rollback
- Auto-rollback on deployment failure
- Manual rollback also available

## Notification Settings

### Success
- Notify only for main branch

### Failure
- Notify for all branches
- Slack / Email / GitLab/GitHub Issues

### Coverage Decrease
- Warn when coverage drops below threshold

## Pipeline Optimization

### Parallel Execution
- Run Lint, Type, Test in parallel
- Run multiple projects in parallel

### Early Termination
- Skip subsequent stages on Lint failure
- `fail_fast: true`

### Conditional Execution
```yaml
test:app:
  only:
    changes:
      - app/**/*
```

## Monitoring

### Pipeline Execution Time
- Target: Under 10 minutes
- Consider optimization if too long

### Failure Rate
- Target: Below 5%
- Investigate if frequently failing

## Troubleshooting

### Pipeline Failures
1. Check logs
2. Reproduce locally
3. Run pre-commit hooks
4. Verify dependencies

### Slow Pipelines
1. Check cache configuration
2. Introduce parallel execution
3. Remove unnecessary steps

### Coverage Decrease
1. Check coverage report
2. Add missing tests
3. Delete dead code
