---
name: changelog-redactor
description: Generates user-facing changelog entries following keepachangelog.com 1.1.0 format. Apply when asked to update, generate, or review a CHANGELOG.md. Focuses on what changed for the user between versions, not internal implementation details or refactoring history.
license: MIT
compatibility: opencode
metadata:
  workflow: versioning, release-management
---

# Changelog Redactor

Generates user-facing changelog entries following keepachangelog.com 1.1.0.

## Core Philosophy

A changelog is NOT a commit log. It answers one question:

**"What is different for someone using this software compared to the last published version?"**

Internal refactors, intermediate implementations, and development churn are
invisible to users — they must be invisible in the changelog too.

---

## Scope

**Generating new entries**: Apply the diff rule and format rules
automatically when creating a new version entry.

**Reviewing existing entries**: When asked to review or fix an
existing changelog:

1. Identify the last published version (most recent version entry
   with a date in the changelog)
2. For entries in that published version and earlier — flag only,
   never modify. These are historical record.
3. For entries in [Unreleased] or versions newer than last published:
   - Apply the diff rule: compare against last published version state
   - Flag entries describing internal changes, refactoring, or
     intermediate states
   - Suggest merging or removing flagged entries
   - Suggest the correct user-facing description where applicable
4. Present all suggested changes for human approval before applying

**Never**: Silently reformat or restructure existing entries
without explicit instruction.

---

## The Diff Rule (Most Important)

When generating a new version entry, think in terms of:

```
CHANGELOG ENTRY = state(new version) - state(last published version)
```

**Example:**

- Last published: v1.1 — no Docker support
- Development commits: Added Docker → Refactored Docker → Fixed Docker networking
- New version: v1.2 — has Docker support

**Correct changelog entry:**

```
### Added
- Docker support with multi-architecture builds and non-root security hardening
```

**Wrong changelog entry:**

```
### Added
- Docker initial implementation

### Changed
- Refactored Docker configuration
- Fixed Docker networking
```

The user only cares that Docker was added. How it was built internally
is irrelevant. The diff is: "Docker didn't exist, now it does."

---

## What Belongs in a Changelog

### Include — user-facing changes

- New features a user can interact with or benefit from
- Behavior changes that affect how the software works
- Bug fixes that affected users
- Performance improvements users would notice
- Breaking changes that require user action
- Security fixes (even if internal — users need to know)
- Dependency updates only if they affect user behavior

### Exclude — internal changes

- Refactoring that doesn't change behavior
- Code cleanup and formatting
- Test additions or improvements
- Internal architecture changes with no user impact
- Intermediate implementations later superseded
- Development tooling changes
- Comments and documentation improvements (unless it's user-facing docs)
- CI/CD pipeline changes
- Dependency updates with no user-facing impact

---

## keepachangelog.com 1.1.0 Format

```markdown
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.2.0] - 2026-02-20

### Added

- [New feature or capability]

### Changed

- [Behavior change in existing feature]

### Deprecated

- [Feature that will be removed in future version]

### Removed

- [Feature that was removed]

### Fixed

- [Bug that was fixed]

### Security

- [Vulnerability fixed]

## [1.1.0] - 2026-01-15

[previous version entries...]

[1.2.0]: https://github.com/user/repo/compare/v1.1.0...v1.2.0
[1.1.0]: https://github.com/user/repo/compare/v1.0.0...v1.1.0
[Unreleased]: https://github.com/user/repo/compare/v1.2.0...HEAD
```

**Rules:**

- Versions in reverse chronological order (newest first)
- Date format: YYYY-MM-DD
- Only include sections that have entries — omit empty sections
- One entry per line, starting with a dash
- Entries are concise — one sentence maximum per item
- No periods at end of entries
- Comparison links at the bottom

---

## Entry Writing Rules

### Be concise

One line per change. If it needs more than one line, you're
describing implementation, not change.

❌ "Added Docker support including multi-stage builds for minimal
image sizes, non-root user configuration with UID 65534 for
security hardening, Docker Compose orchestration for the
5-service stack, and secrets management for credentials"

✅ "Docker support with multi-architecture builds and security hardening"

### Use imperative mood for Added/Changed/Fixed

Write as if completing the sentence "This release..."

❌ "Adding Docker support"
❌ "Docker was added"
✅ "Docker support with Compose orchestration"

### Group related changes

If three commits all relate to the same feature, one entry covers all three.

❌

```
### Added
- Docker initial support
- Docker Compose configuration
- Docker multi-architecture builds
```

✅

```
### Added
- Docker support with Compose orchestration and multi-architecture builds
```

### Breaking changes get extra visibility

Always note what breaks and what users need to do:

```
### Changed
- **BREAKING** — Configuration file format changed from JSON to YAML;
  rename `config.json` to `config.yaml` and wrap all values in quotes
```

---

## Process for Generating a New Version Entry

### Step 1 — Identify the last published version

Read the existing CHANGELOG.md to find the most recent version entry.
This is the baseline. Everything before this version is irrelevant.

### Step 2 — Identify the current state

Read the current codebase, not the commit history.
What does the software do NOW that it didn't do at the last published version?

### Step 3 — Apply the diff

For each difference between current state and last published version:

- Is it user-facing? → Include
- Is it internal? → Exclude
- Is it the final result of multiple intermediate commits? → One entry for the result only

### Step 4 — Categorize

Place each change in the correct section:

- Added: completely new capability
- Changed: existing capability works differently
- Deprecated: still works but will be removed
- Removed: no longer exists
- Fixed: was broken, now works
- Security: vulnerability addressed

### Step 5 — Write entries

One line each, concise, user-facing language, no implementation details.

### Step 6 — Update comparison links

Add the new version comparison link at the bottom.
Update [Unreleased] to compare from the new version.

---

## Common Mistakes to Avoid

| Mistake                            | Correct approach                 |
| ---------------------------------- | -------------------------------- |
| Listing every commit as an entry   | Diff state, not commits          |
| Including refactoring              | Only include if behavior changed |
| "Improved code quality"            | Not user-facing — omit           |
| "Fixed typo in variable name"      | Not user-facing — omit           |
| Multi-paragraph entries            | One line maximum                 |
| Past tense ("was added")           | Noun phrase ("Docker support")   |
| Implementation details             | User-observable result only      |
| Intermediate versions of a feature | Final state only                 |

---

## Quick Reference — Include or Exclude?

Ask: **"Would a user notice this change without reading the code?"**

- Yes → Include
- No → Exclude
- Maybe → Include only if it affects reliability, performance, or security

Ask: **"Is this the final state, or was it later superseded?"**

- Final state → Include
- Later changed again before release → Describe the final state only
