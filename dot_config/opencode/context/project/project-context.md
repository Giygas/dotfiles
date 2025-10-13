# OpenCode Agent System Project Context

## Technology Stack

**Primary Languages:** TypeScript, Python, Go
**Runtimes:** Node.js/Bun (TypeScript), Python interpreter, Go runtime
**Package Managers:** npm/pnpm/yarn (TypeScript), pip/poetry (Python), Go modules
**Build Tools:** 
- TypeScript: TypeScript Compiler (tsc), Vite, Webpack
- Python: mypy, flake8, black, pytest
- Go: go build, go test, go vet
**Testing:** 
- TypeScript: Jest/Vitest (if configured)
- Python: pytest (if configured)
- Go: go test (built-in)
**Linting:** 
- TypeScript: ESLint (if configured)
- Python: flake8, pylint (if configured)
- Go: go vet, golint (if configured)

## Project Structure

```
.opencode/
├── agent/           # AI agents for specific tasks
│   ├── subagents/   # Specialized subagents
│   └── *.md         # Primary agents
├── command/         # Slash commands
├── context/         # Knowledge base for agents
└── plugin/          # Extensions and integrations

tasks/               # Task management files
```

## Core Patterns

### Agent Structure Pattern

```markdown
---
description: "What this agent does"
mode: primary|subagent
tools: [read, edit, bash, etc.]
permissions: [security restrictions]
---

# Agent Name

[Direct instructions for behavior]

**EXECUTE** this [process type] for every [task type]:

**1. [ACTION]** the [subject]:

- [Specific instruction 1]
- [Specific instruction 2]

**RULES:**

- **ALWAYS** [critical requirement]
- **NEVER** [forbidden action]
```

### Command Structure Pattern

```markdown
---
name: command-name
agent: target-agent
---

You are [doing specific task].

**Request:** $ARGUMENTS

**Context Loaded:**
@.opencode/context/core/essential-patterns.md
@[additional context files]

Execute [task] now.
```

### Context Loading Rules

- Commands load context immediately using @ references
- Agents can look up additional context deterministically
- Maximum 4 context files per command (250-450 lines total)
- Keep context files focused (50-150 lines each)

## Security Guidelines

- Agents have restricted permissions by default
- Sensitive operations require explicit approval
- No direct file system modifications without validation
- Build commands limited to safe operations
- Language-specific security considerations:
  - TypeScript: Dependency vulnerability scanning
  - Python: Package security checks, virtual environment isolation
  - Go: Module verification, minimal dependency footprint

## Development Workflow

1. **Planning:** Create detailed task plans for complex work
2. **Implementation:** Execute one step at a time with language-specific validation
3. **Review:** Code review and security checks
4. **Testing:** Automated testing and build validation (language-specific)
5. **Documentation:** Update docs and context files

### Language-Specific Considerations

**TypeScript:**
- Type safety validation with tsc
- Package management with npm/pnpm/yarn
- Modern JavaScript/ESNext features

**Python:**
- Type hints with mypy
- Virtual environment management
- PEP 8 compliance with flake8/black

**Go:**
- Static compilation
- Module management with go.mod
- Idiomatic Go patterns and error handling

## Quality Gates

- Language-specific compilation passes (tsc, go build, Python syntax)
- Code review completed
- Build process succeeds for the target language
- Tests pass (if available) - Jest/Vitest, pytest, go test
- Linting passes (if configured) - ESLint, flake8, go vet
- Documentation updated
