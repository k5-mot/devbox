# Frontend Development Guide

## Project Selection

This devbox contains 2 frontend templates:

### Next.js + DaisyUI Template (`next-daisyui-template`)
- **Use Cases**: Projects requiring SSR/SSG, SEO-focused, App Router
- **UI Framework**: DaisyUI (Tailwind CSS v4)
- **Recommended For**: Marketing sites, blogs, E-commerce

### Vite + Serendie Template (`vite-serendie-template`)
- **Use Cases**: SPA, admin panels, dashboards
- **UI Framework**: Serendie (lightweight CSS)
- **Recommended For**: Internal tools, interactive apps

## Common Technology Stack

### Language & Runtime
- **Node.js**: 24.12.0
- **TypeScript**: ~5.9.3+
- **React**: 19.2.x

### Package Manager
- **pnpm**: Workspace support, disk efficient
- Lock file: Always commit `pnpm-lock.yaml`

### Code Quality Tools
- **Linter/Formatter**: Biome 2.2.0+ (faster than ESLint)
- **Type Checker**: TypeScript Compiler (tsc)
- **Test Framework**: Vitest 4.x
- **Test Library**: Testing Library (component tests)

## Development Workflow

### Initial Setup
```bash
cd <template-directory>
pnpm install
```

### Start Dev Server
```bash
# Next.js
pnpm dev          # http://localhost:3000

# Vite
pnpm dev          # http://localhost:5173 (--host for network access)
```

### Code Quality Checks
```bash
# Lint with Biome
pnpm lint

# Format with Biome
pnpm format

# Type check
pnpm type         # Vite
tsc --noEmit      # Next.js (auto-run on build)

# Run tests
pnpm test         # Unit tests
pnpm test:ui      # Vitest UI (Vite only)
pnpm test:coverage # Coverage report
```

### Build
```bash
pnpm build
```

### Preview (Vite only)
```bash
pnpm preview      # Preview build result
```

## Coding Conventions

### File Structure
```
src/
├── components/   # Reusable components
├── pages/        # Page components (Vite)
├── app/          # App Router (Next.js)
├── hooks/        # Custom hooks
├── utils/        # Utility functions
├── types/        # TypeScript type definitions
└── assets/       # Static assets
```

### Naming Conventions
- **Components**: PascalCase (`UserProfile.tsx`)
- **Hooks**: camelCase + use prefix (`useAuth.ts`)
- **Utilities**: camelCase (`formatDate.ts`)
- **Constants**: UPPER_SNAKE_CASE (`API_ENDPOINT`)
- **Types/Interfaces**: PascalCase (`User`, `ApiResponse`)

### TypeScript Style
- Array type: Use `T[]` notation (not `Array<T>`)
- Enums prohibited: Use union types or const objects
- namespace notation prohibited

### React Style
- Use function components (class components deprecated)
- Hooks only at top level
- No props reassignment
- Don't use array index as `key` attribute
- Minimize `dangerouslySetInnerHTML` usage

### Imports
- Unused imports auto-removed (Biome)
- Imports auto-organized (Biome assist)
- Circular references prohibited (detected by Biome)

## Testing Strategy

### Test File Naming
- `*.test.ts(x)`: Unit tests
- `*.spec.ts(x)`: Integration tests

### Testing Principles
- Test behavior, not implementation details
- Avoid dependencies between tests
- Fast and deterministic tests
- Coverage is a metric; prioritize high-quality tests

### Vitest Configuration
- Coverage tool: @vitest/coverage-v8
- DOM environment: happy-dom
- UI: @vitest/ui

## Styling

### Next.js (Tailwind CSS v4 + DaisyUI)
```tsx
// Tailwind utility classes
<button className="btn btn-primary">Click me</button>

// DaisyUI components
<div className="card bg-base-100 shadow-xl">
  <div className="card-body">...</div>
</div>
```

### Vite (Serendie)
```tsx
// Serendie components
import { Button } from '@serendie/ui';

<Button variant="primary">Click me</Button>
```

### CSS-in-JS
- Currently not used (covered by Tailwind/Serendie)
- Choose per project if needed

## State Management

### Local State
- Use `useState`, `useReducer`

### Global State
- **Not standardized**: Choose per project
- Recommended options:
  - Zustand: Lightweight and simple
  - Jotai: Atomic state management
  - React Context: Small-scale sharing

### Server State
- Recommend React Query / TanStack Query (not pre-installed)

## Performance Optimization

### General Principles
- Optimize based on measurement, not speculation
- Utilize React DevTools Profiler
- Measure performance with Chrome DevTools Lighthouse

### React Optimization
- Prevent unnecessary re-renders with `React.memo`
- Memoize calculations/functions with `useMemo`, `useCallback`
- Reduce initial load time with Code Splitting
- Image optimization (Next.js Image, lazy loading)

### Bundle Size
- Check dependency size with `wix.vscode-import-cost` extension
- Don't add unnecessary dependencies
- Leverage Tree-shaking

## Debugging

### Browser DevTools
- React Developer Tools
- Console logging (remove in production)
- Network tab (verify API communication)
- Performance tab (performance analysis)

### VSCode Debugger
- Configurable with `launch.json`
- Breakpoints, variable watch

### Error Handling
- Catch component errors with Error Boundary
- Handle async errors with try-catch
- Provide clear error messages

## Documentation Generation

### TypeDoc
- Generate markdown docs with `pnpm docs`
- Auto-generate from JSDoc comments
- Plugin: typedoc-plugin-markdown

### Comment Conventions
- Write JSDoc in **Japanese**
- Explain "why" (code expresses "what")

## CI/CD Integration

### Pre-commit hooks
- Biome format & lint
- TypeScript type check
- Vitest test execution
- Vite build (Vite only)

### GitLab CI/CD
- Stages: build → test → deploy
- Each template has `.gitlab-ci.yml` (recreate if deleted)

## Troubleshooting

### pnpm install errors
- Delete `pnpm-lock.yaml` and retry
- Verify Node.js version (24.12.0)

### Type errors
- Verify with `pnpm type`
- `@ts-ignore` prohibited (fix root cause)

### Build errors
- Clear cache: Delete `.next` (Next.js), `dist` (Vite)
- Reinstall dependencies

### Test failures
- Parallel execution issues: Use `--no-threads` option
- Environment variables: Create `.env.test` file
