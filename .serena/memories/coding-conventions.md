# Coding Conventions

## Development Philosophy
- Write code with quality, maintainability, and safety in mind, not just working code
- Balance appropriately based on project stage (prototype, MVP, production)
- Never ignore problems; address them or explicitly document them
- Boy Scout Rule: Leave code better than you found it

## Error Handling Principles
- Resolve all errors, even seemingly unrelated ones
- Fix root causes instead of suppressing errors (@ts-ignore, try-catch silencing)
- Detect errors early and provide clear error messages
- Always cover error cases in tests
- Consider failure scenarios for external APIs and network communication

## Code Quality Standards
- DRY principle: Avoid duplication, maintain single source of truth
- Use meaningful variable/function names to express intent clearly
- Maintain consistent coding style across the project
- Fix small issues immediately (Broken Windows theory)
- Comments explain "why", code expresses "what"
  - Write comments in **Japanese**

## Testing Discipline
- Never skip tests; fix issues when they arise
- Test behavior, not implementation details
- Avoid dependencies between tests; run in any order
- Tests should be fast and deterministic
- Coverage is a metric; prioritize high-quality tests

## Maintainability and Refactoring
- Consider improving existing code while adding features
- Break large changes into small steps
- Actively delete unused code
- Update dependencies regularly (security and compatibility)
- Explicitly document technical debt in comments or docs

## Security Mindset
- Manage API keys, passwords via environment variables (no hardcoding)
- Validate all external input
- Operate with minimum necessary privileges (principle of least privilege)
- Avoid unnecessary dependencies
- Run security audit tools regularly

## Performance Awareness
- Optimize based on measurement, not speculation
- Consider scalability from early stages
- Defer resource loading until needed
- Define clear cache expiration and invalidation strategies
- Avoid N+1 queries and over-fetching

## Reliability Assurance
- Set appropriate timeout handling
- Implement retry mechanisms (consider exponential backoff)
- Utilize circuit breaker patterns
- Build resilience against transient failures
- Ensure observability with proper logging and metrics

## Understanding Project Context
- Balance business and technical requirements
- Determine appropriate quality level for current phase
- Maintain minimum quality standards even under time constraints
- Choose implementations matching team's technical level

## Recognizing Trade-offs
- Perfection is impossible (no silver bullet)
- Find optimal balance within constraints
- Prioritize simplicity for prototypes, robustness for production
- Clearly document compromises and their rationale

## Debugging Best Practices
- Establish reproducible steps for issues
- Narrow down problem scope using binary search
- Start investigation from recent changes
- Utilize appropriate tools (debugger, profiler)
- Document findings and solutions; share knowledge

## Dependency Management
- Add only truly necessary dependencies
- Always commit lock files (package-lock.json, etc.)
- Check license, size, maintenance status before adding dependencies
- Update regularly for security patches and bug fixes

## Documentation Standards
- README should clearly state project overview, setup, usage
- Keep documentation in sync with code
- Prioritize providing examples
- Record important design decisions in ADR (Architecture Decision Records)

## Continuous Improvement
- Apply learnings to next projects
- Conduct regular retrospectives to improve processes
- Appropriately evaluate and adopt new tools/techniques
- Document knowledge for team and future developers
