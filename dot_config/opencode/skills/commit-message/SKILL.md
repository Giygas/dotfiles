---
name: commit-messages
description: Write clear, conventional commit messages. Use when staging changes, summarizing diffs, or helping developers write good commit messages.
---

# Commit Message Skill

Write concise, meaningful commit messages following Conventional Commits.

## Format

```
<type>(<scope>): <short summary>

[optional body — explain WHY, not what]
```

- **Subject line**: 50-72 chars max, imperative mood ("add", "fix", "remove")
- **Body**: only when context or reasoning is non-obvious, separated by blank line
- **No period** at the end of the subject line

## Types

| Type | Use for |
|------|---------|
| `feat` | New feature or endpoint |
| `fix` | Bug fix |
| `chore` | Deps, config, tooling — no production logic |
| `refactor` | Code change with no behavior change |
| `docs` | Documentation only |
| `test` | Adding or fixing tests |
| `perf` | Performance improvement |
| `breaking` | Breaking change (also add `!` after type: `feat!:`) |

## Rules

- Read the diff/changes before writing — don't guess
- One logical change per commit message
- If a change breaks the API contract, always flag it with `feat!:` or `breaking:`
- Scope is optional but helpful: `fix(auth):`, `feat(municipalities):`
- Avoid vague words: "update", "fix stuff", "changes", "wip"

## Examples

```
feat(municipalities): add /v2/municipalities endpoint with pagination

fix: handle missing fields in upstream government API response

chore: upgrade axios to 1.6.0

refactor(parser): extract date normalization into dedicated service

feat!: remove XML response format from /data endpoint

docs: document rate limiting behavior in README

fix(auth): return 401 instead of 500 on expired tokens
```

**With body (when why matters):**
```
fix: return 404 for unknown municipality codes instead of 500

The upstream INE API doesn't document behavior for invalid codes.
Defaulting to 404 is more semantically correct and prevents
unhandled exception logs from flooding Sentry.
```

## Workflow

1. Look at the staged diff or file changes
2. Identify the **type** of change
3. Write the subject line — imperative, under 72 chars
4. Add a body only if the *why* isn't obvious from the subject
5. If it's a breaking change, use `!` and mention it in the body too
