---
name: go-dockerfile
description: Best practices for creating production-ready Docker images for Go applications. Covers multi-stage builds, security, optimization, and common pitfalls.
license: MIT
compatibility: opencode
metadata:
  audience: developers, devops
  workflow: deployment, containerization
  language: go, docker
---

# Go Dockerfile Best Practices

A comprehensive guide for building secure, efficient, and production-ready Docker images for Go applications.

## Quick Reference: The Template

Here's a production-ready Dockerfile template - explanations follow:

```dockerfile
# Build stage
FROM golang:1.22-alpine AS builder

# Install build dependencies
RUN apk add --no-cache git ca-certificates tzdata

# Set working directory
WORKDIR /build

# Copy go mod files first (for layer caching)
COPY go.mod go.sum ./
RUN go mod download

# Copy source code
COPY . .

# Build the binary
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build \
    -ldflags='-w -s -extldflags "-static"' \
    -o /app/server \
    ./cmd/server

# Final stage
FROM scratch

# Copy CA certificates for HTTPS
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

# Copy timezone data
COPY --from=builder /usr/share/zoneinfo /usr/share/zoneinfo

# Copy the binary
COPY --from=builder /app/server /server

# Use non-root user
USER 65534:65534

# Expose port
EXPOSE 8080

# Run the binary
ENTRYPOINT ["/server"]
```

## Core Principles

### 1. Multi-Stage Builds

**Always use multi-stage builds.** This dramatically reduces image size by separating build dependencies from runtime.

```dockerfile
# ❌ BAD: Single stage (image will be ~800MB)
FROM golang:1.22
WORKDIR /app
COPY . .
RUN go build -o server
CMD ["./server"]

# ✅ GOOD: Multi-stage (image will be ~10MB)
FROM golang:1.22-alpine AS builder
WORKDIR /build
COPY . .
RUN go build -o server

FROM alpine:3.19
COPY --from=builder /build/server /server
CMD ["/server"]
```

**Why:** Build stage has compilers and tools (~800MB). Runtime only needs the binary (~10MB).

### 2. Layer Caching

**Copy go.mod and go.sum before source code** to maximize Docker layer caching.

```dockerfile
# ❌ BAD: Copies everything, downloads deps every time
COPY . .
RUN go mod download

# ✅ GOOD: Downloads deps only when go.mod/go.sum changes
COPY go.mod go.sum ./
RUN go mod download
COPY . .
```

**Why:** Dependencies rarely change. This pattern caches the `go mod download` layer, speeding up builds from ~2min to ~10sec.

### 3. Minimal Base Images

Choose the smallest base image that works for your needs.

| Base Image | Size | Use Case | Notes |
|------------|------|----------|-------|
| `scratch` | 0 MB | Static binaries | No shell, no utilities, maximum security |
| `alpine` | ~5 MB | Most apps | Has shell and basic utilities |
| `distroless` | ~2 MB | Production | No shell, package manager, more secure than alpine |
| `debian-slim` | ~80 MB | Complex deps | Use only if you need it |

```dockerfile
# ✅ BEST: For pure Go apps with no C dependencies
FROM scratch

# ✅ GOOD: For apps that need shell/debugging
FROM alpine:3.19

# ✅ GOOD: For maximum security in production
FROM gcr.io/distroless/static-debian12

# ⚠️ USE SPARINGLY: Only if you need system packages
FROM debian:12-slim
```

## Complete Examples

### Example 1: Simple API Server (scratch base)

```dockerfile
# Build stage
FROM golang:1.22-alpine AS builder

# Install git for go mod (if needed)
RUN apk add --no-cache git ca-certificates tzdata

WORKDIR /build

# Cache dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy source
COPY . .

# Build static binary
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build \
    -ldflags='-w -s -extldflags "-static"' \
    -a \
    -o /app/server \
    ./cmd/server

# Final stage - scratch for smallest size
FROM scratch

# Copy CA certs for HTTPS requests
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

# Copy timezone data (if your app needs it)
COPY --from=builder /usr/share/zoneinfo /usr/share/zoneinfo

# Copy binary
COPY --from=builder /app/server /server

# Non-root user (nobody)
USER 65534:65534

EXPOSE 8080

ENTRYPOINT ["/server"]
```

### Example 2: With Database Migrations

```dockerfile
# Build stage
FROM golang:1.22-alpine AS builder

RUN apk add --no-cache git ca-certificates

WORKDIR /build

COPY go.mod go.sum ./
RUN go mod download

COPY . .

# Build main app
RUN CGO_ENABLED=0 go build -ldflags='-w -s' -o /app/server ./cmd/server

# Build migration tool (if using golang-migrate or custom tool)
RUN CGO_ENABLED=0 go build -ldflags='-w -s' -o /app/migrate ./cmd/migrate

# Final stage
FROM alpine:3.19

# Install ca-certificates
RUN apk --no-cache add ca-certificates

# Copy binaries
COPY --from=builder /app/server /server
COPY --from=builder /app/migrate /migrate

# Copy migration files
COPY --from=builder /build/migrations /migrations

# Non-root user
RUN addgroup -g 1000 appuser && \
    adduser -D -u 1000 -G appuser appuser

USER appuser

EXPOSE 8080

# Use shell form to allow running migrations first
CMD ["/bin/sh", "-c", "/migrate up && /server"]
```

### Example 3: With CGO (SQLite, etc.)

```dockerfile
# Build stage - use full golang (not alpine) for CGO
FROM golang:1.22 AS builder

WORKDIR /build

COPY go.mod go.sum ./
RUN go mod download

COPY . .

# CGO_ENABLED=1 is default, but explicit is better
RUN CGO_ENABLED=1 GOOS=linux go build \
    -ldflags='-w -s' \
    -o /app/server \
    ./cmd/server

# Final stage - cannot use scratch with CGO, need libc
FROM debian:12-slim

# Install runtime dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /app/server /server

# Non-root user
RUN useradd -r -u 1000 appuser
USER appuser

EXPOSE 8080

ENTRYPOINT ["/server"]
```

### Example 4: Multi-Binary (Multiple Services)

```dockerfile
# Build stage
FROM golang:1.22-alpine AS builder

RUN apk add --no-cache git ca-certificates

WORKDIR /build

COPY go.mod go.sum ./
RUN go mod download

COPY . .

# Build all services
RUN CGO_ENABLED=0 go build -ldflags='-w -s' -o /app/api ./cmd/api
RUN CGO_ENABLED=0 go build -ldflags='-w -s' -o /app/worker ./cmd/worker
RUN CGO_ENABLED=0 go build -ldflags='-w -s' -o /app/migrator ./cmd/migrator

# API service
FROM alpine:3.19 AS api
RUN apk --no-cache add ca-certificates
COPY --from=builder /app/api /api
RUN adduser -D -u 1000 appuser
USER appuser
EXPOSE 8080
ENTRYPOINT ["/api"]

# Worker service
FROM alpine:3.19 AS worker
RUN apk --no-cache add ca-certificates
COPY --from=builder /app/worker /worker
RUN adduser -D -u 1000 appuser
USER appuser
ENTRYPOINT ["/worker"]

# Migrator (one-shot)
FROM alpine:3.19 AS migrator
RUN apk --no-cache add ca-certificates
COPY --from=builder /app/migrator /migrator
COPY migrations /migrations
RUN adduser -D -u 1000 appuser
USER appuser
ENTRYPOINT ["/migrator"]
```

## Build Flags Explained

### Essential Build Flags

```dockerfile
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build \
    -ldflags='-w -s -extldflags "-static"' \
    -a \
    -o /app/server \
    ./cmd/server
```

**Flag breakdown:**

- `CGO_ENABLED=0` - Disable CGO for static binary (required for scratch)
- `GOOS=linux` - Target Linux OS
- `GOARCH=amd64` - Target AMD64 architecture (or arm64 for ARM)
- `-ldflags='-w -s'` - Strip debug info, reduces binary size ~30%
  - `-w` - Disable DWARF generation (debug symbols)
  - `-s` - Disable symbol table
- `-extldflags "-static"` - Force static linking
- `-a` - Force rebuild of all packages
- `-o /app/server` - Output path

### Size Optimization

```dockerfile
# Maximum size reduction
RUN go build -ldflags='-w -s' -trimpath -o server

# With version info
RUN go build \
    -ldflags="-w -s -X main.version=${VERSION} -X main.commit=${COMMIT}" \
    -trimpath \
    -o server
```

### Build Tags

```dockerfile
# Build with specific tags
RUN go build -tags=production,nomock -o server

# Exclude test files
RUN go build -tags='!test' -o server
```

## Security Best Practices

### 1. Non-Root User

**Always run as non-root user.**

```dockerfile
# ❌ BAD: Running as root
FROM alpine
COPY server /server
CMD ["/server"]

# ✅ GOOD: Scratch with nobody user (UID 65534)
FROM scratch
USER 65534:65534
CMD ["/server"]

# ✅ GOOD: Alpine with custom user
FROM alpine
RUN addgroup -g 1000 appuser && \
    adduser -D -u 1000 -G appuser appuser
USER appuser
CMD ["/server"]

# ✅ GOOD: Distroless (has nonroot user built-in)
FROM gcr.io/distroless/static-debian12:nonroot
CMD ["/server"]
```

### 2. Scan for Vulnerabilities

Use multi-stage builds and minimal base images to reduce attack surface.

```dockerfile
# Add labels for security scanning
LABEL org.opencontainers.image.source="https://github.com/yourorg/yourapp"
LABEL org.opencontainers.image.description="Your app description"
LABEL org.opencontainers.image.licenses="MIT"
```

```bash
# Scan your image
docker scout cves yourimage:latest
trivy image yourimage:latest
```

### 3. Don't Include Secrets

```dockerfile
# ❌ BAD: Never copy secrets into image
COPY .env /app/.env
COPY secrets.yaml /app/secrets.yaml

# ✅ GOOD: Use environment variables or volume mounts
# Pass secrets at runtime:
docker run -e DATABASE_URL="..." yourimage

# Or use Docker secrets (Swarm/K8s)
docker run --secret database_url yourimage
```

### 4. Use Specific Image Tags

```dockerfile
# ❌ BAD: Latest can change
FROM golang:latest
FROM alpine:latest

# ✅ GOOD: Pin specific versions
FROM golang:1.22.0-alpine3.19
FROM alpine:3.19.1

# ✅ BETTER: Use SHA256 digests for reproducibility
FROM golang:1.22.0-alpine3.19@sha256:abc123...
```

## Performance Optimization

### 1. Leverage Build Cache

```dockerfile
# Order matters! Put rarely-changing stuff first

# ✅ GOOD ORDER:
COPY go.mod go.sum ./          # Changes rarely
RUN go mod download            # Cached unless go.mod changes
COPY . .                       # Changes often
RUN go build                   # Uses cached dependencies
```

### 2. Use .dockerignore

Create `.dockerignore` to exclude unnecessary files:

```
# .dockerignore
.git
.gitignore
.dockerignore
Dockerfile
docker-compose.yml
*.md
.env
.env.*
*.log

# Test files
*_test.go
testdata/

# Build artifacts
bin/
dist/
*.exe
*.dll
*.so
*.dylib

# IDE
.idea/
.vscode/
*.swp
*.swo
*~

# CI/CD
.github/
.gitlab-ci.yml

# Documentation
docs/
README.md
```

### 3. Parallel Downloads

```dockerfile
# Download dependencies in parallel
RUN go mod download -x
```

### 4. Build Cache Mount (BuildKit)

```dockerfile
# syntax=docker/dockerfile:1

FROM golang:1.22-alpine AS builder

WORKDIR /build

COPY go.mod go.sum ./

# Use cache mount for faster builds
RUN --mount=type=cache,target=/go/pkg/mod \
    go mod download

COPY . .

RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=cache,target=/root/.cache/go-build \
    CGO_ENABLED=0 go build -o /app/server ./cmd/server

FROM scratch
COPY --from=builder /app/server /server
CMD ["/server"]
```

Build with BuildKit:
```bash
DOCKER_BUILDKIT=1 docker build -t myapp .
```

## Health Checks

Add health checks to your Dockerfile:

```dockerfile
FROM alpine:3.19

COPY --from=builder /app/server /server

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD ["/server", "healthcheck"] || exit 1

# Or with curl (requires curl in image)
# HEALTHCHECK CMD curl -f http://localhost:8080/health || exit 1

CMD ["/server"]
```

Implement health check in your Go app:

```go
// In main.go
func main() {
    // Check if running in healthcheck mode
    if len(os.Args) > 1 && os.Args[1] == "healthcheck" {
        healthCheck()
        return
    }
    
    // Normal server startup
    startServer()
}

func healthCheck() {
    resp, err := http.Get("http://localhost:8080/health")
    if err != nil || resp.StatusCode != 200 {
        os.Exit(1)
    }
    os.Exit(0)
}
```

## Common Patterns

### Pattern 1: Configuration via Environment Variables

```dockerfile
FROM scratch

COPY --from=builder /app/server /server

# Document expected environment variables
ENV PORT=8080 \
    DATABASE_URL="" \
    LOG_LEVEL=info

USER 65534:65534

EXPOSE ${PORT}

CMD ["/server"]
```

### Pattern 2: Graceful Shutdown

```go
// In your Go app
func main() {
    server := &http.Server{Addr: ":8080"}
    
    // Start server in goroutine
    go func() {
        if err := server.ListenAndServe(); err != nil && err != http.ErrServerClosed {
            log.Fatal(err)
        }
    }()
    
    // Wait for interrupt signal
    quit := make(chan os.Signal, 1)
    signal.Notify(quit, os.Interrupt, syscall.SIGTERM)
    <-quit
    
    // Graceful shutdown with timeout
    ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
    defer cancel()
    
    if err := server.Shutdown(ctx); err != nil {
        log.Fatal("Server forced to shutdown:", err)
    }
}
```

```dockerfile
# In Dockerfile - no special config needed
# Kubernetes/Docker will send SIGTERM before killing
FROM scratch
COPY --from=builder /app/server /server
CMD ["/server"]
```

### Pattern 3: Static Assets

```dockerfile
FROM golang:1.22-alpine AS builder

WORKDIR /build

COPY go.mod go.sum ./
RUN go mod download

COPY . .

# Embed static files at build time
RUN CGO_ENABLED=0 go build -o /app/server ./cmd/server

FROM scratch

COPY --from=builder /app/server /server

# Copy static assets
COPY --from=builder /build/static /static
COPY --from=builder /build/templates /templates

USER 65534:65534

CMD ["/server"]
```

Or use Go embed:
```go
//go:embed static/*
var staticFiles embed.FS

//go:embed templates/*
var templates embed.FS
```

## Docker Compose for Development

```yaml
# docker-compose.yml
version: '3.9'

services:
  app:
    build:
      context: .
      dockerfile: Dockerfile
      target: builder  # Use builder stage for development
    volumes:
      - .:/build  # Mount source code
    command: go run ./cmd/server  # Use go run in dev
    ports:
      - "8080:8080"
    environment:
      - DATABASE_URL=postgres://user:pass@db:5432/mydb
      - LOG_LEVEL=debug
    depends_on:
      - db
    
  db:
    image: postgres:16-alpine
    environment:
      - POSTGRES_USER=user
      - POSTGRES_PASSWORD=pass
      - POSTGRES_DB=mydb
    volumes:
      - postgres_data:/var/lib/postgresql/data
    ports:
      - "5432:5432"

volumes:
  postgres_data:
```

## Troubleshooting

### Issue: Binary won't run in scratch

```
Error: standard_init_linux.go:228: exec user process caused: no such file or directory
```

**Solution:** Make sure you're building a static binary:
```dockerfile
RUN CGO_ENABLED=0 go build -ldflags='-extldflags "-static"' -o server
```

### Issue: HTTPS doesn't work

```
Error: x509: certificate signed by unknown authority
```

**Solution:** Copy CA certificates:
```dockerfile
FROM scratch
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
```

### Issue: Timezone issues

```
Error: cannot find timezone data
```

**Solution:** Copy timezone data:
```dockerfile
FROM scratch
COPY --from=builder /usr/share/zoneinfo /usr/share/zoneinfo
ENV TZ=UTC
```

### Issue: Cannot debug scratch image

**Solution:** Use alpine for debugging, scratch for production:
```dockerfile
# Development/Debug
FROM alpine:3.19 AS debug
RUN apk add --no-cache ca-certificates tzdata
COPY --from=builder /app/server /server
CMD ["/server"]

# Production
FROM scratch AS production
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /usr/share/zoneinfo /usr/share/zoneinfo
COPY --from=builder /app/server /server
USER 65534:65534
CMD ["/server"]
```

Build specific target:
```bash
docker build --target debug -t myapp:debug .
docker build --target production -t myapp:latest .
```

## Quick Checklist

Before deploying your Dockerfile, verify:

- ✅ Multi-stage build (builder + runtime)
- ✅ Go dependencies cached (COPY go.mod/go.sum first)
- ✅ Minimal base image (scratch, alpine, or distroless)
- ✅ Non-root user (65534 or custom)
- ✅ Static binary if using scratch (CGO_ENABLED=0)
- ✅ CA certificates copied (for HTTPS)
- ✅ Specific image tags (not :latest)
- ✅ .dockerignore file exists
- ✅ No secrets in image
- ✅ Health check defined
- ✅ Size < 50MB (ideally < 20MB)
- ✅ Vulnerability scan passed

## Common Mistakes

### ❌ Mistake 1: Not using multi-stage builds
```dockerfile
FROM golang:1.22
COPY . .
RUN go build -o server
CMD ["./server"]
# Result: 800MB image!
```

### ❌ Mistake 2: Running as root
```dockerfile
FROM alpine
COPY server /server
CMD ["/server"]
# Running as root = security risk
```

### ❌ Mistake 3: Not caching dependencies
```dockerfile
COPY . .
RUN go mod download
# Every source change re-downloads dependencies
```

### ❌ Mistake 4: Including unnecessary files
```dockerfile
COPY . .
# Copies .git, test files, docs, etc. = larger context, slower builds
```

### ❌ Mistake 5: Using latest tags
```dockerfile
FROM golang:latest
FROM alpine:latest
# Builds are not reproducible
```

## Summary

**The Golden Rules:**

1. **Always use multi-stage builds** - Separate build from runtime
2. **Use smallest possible base image** - scratch > distroless > alpine > debian
3. **Cache dependencies** - COPY go.mod/sum before source code
4. **Run as non-root** - Use UID 65534 or create custom user
5. **Build static binaries** - CGO_ENABLED=0 for scratch base
6. **Include CA certificates** - Required for HTTPS in scratch
7. **Use .dockerignore** - Reduce build context size
8. **Pin image versions** - Reproducible builds
9. **Add health checks** - Container orchestration needs them
10. **Keep it simple** - Don't over-optimize prematurely

**Target image size:** < 20MB for most Go applications

**Build time:** < 30 seconds for cached builds, < 2 minutes for clean builds
