---
name: go-pr-review
description: Comprehensive pre-production code review for Go projects. Analyzes code quality, security, performance, tests, documentation, and deployment readiness. Use before merging PRs or deploying to production.
license: MIT
compatibility: opencode
metadata:
  audience: developers, reviewers, devops
  workflow: code-review, ci-cd, quality-assurance
  language: go
---

# Go PR Review - Pre-Production Code Review

A comprehensive code review checklist and analysis tool for Go projects. Use this before merging PRs or deploying to production to catch issues early.

## Review Categories

The review covers 8 critical areas:

1. **Code Quality** - Structure, readability, Go idioms
2. **Security** - Vulnerabilities, secrets, authentication
3. **Performance** - Bottlenecks, memory leaks, inefficiencies
4. **Testing** - Coverage, quality, mocking patterns
5. **Documentation** - READMEs, comments, API docs
6. **Error Handling** - Proper error propagation and logging
7. **Dependencies** - Outdated packages, security vulnerabilities
8. **Deployment** - Docker, configs, migrations

## Review Process

### Phase 1: Automated Checks

Run these checks first (fastest feedback):

```bash
# 1. Format check
gofmt -l . | tee /tmp/format-issues.txt
test -z "$(cat /tmp/format-issues.txt)" || echo "❌ Format issues found"

# 2. Lint
golangci-lint run ./... --timeout 5m

# 3. Tests
go test ./... -race -coverprofile=coverage.out
go tool cover -func=coverage.out | grep total

# 4. Security scan
gosec -quiet ./...

# 5. Dependency check
go list -u -m -json all | go-mod-outdated -update

# 6. Vulnerability scan
govulncheck ./...
```

### Phase 2: Manual Code Review

After automated checks pass, review code manually using this skill as a guide.

## 1. Code Quality Review

### ✅ Go Idioms and Best Practices

**Check for:**

- [ ] **Exported names** - All exported functions/types have comments
- [ ] **Error handling** - No ignored errors (`_ = err`)
- [ ] **Context usage** - Context passed as first parameter
- [ ] **Interface design** - Accept interfaces, return structs
- [ ] **Package structure** - Logical organization, no circular deps
- [ ] **Naming conventions** - camelCase, descriptive names
- [ ] **Constants vs variables** - Immutable values are constants

**Red Flags:**

```go
// ❌ BAD: Exported without comment
func ProcessOrder(order Order) error {

// ❌ BAD: Ignoring errors
data, _ := json.Marshal(user)

// ❌ BAD: Context not first parameter
func GetUser(id string, ctx context.Context) error

// ❌ BAD: Returning interface
func NewUserService() UserServiceInterface

// ❌ BAD: Generic naming
func DoStuff(data interface{}) error

// ❌ BAD: Variable that should be constant
var maxRetries = 3
```

**Good Patterns:**

```go
// ✅ GOOD: Exported with comment
// ProcessOrder validates and processes the given order.
func ProcessOrder(order Order) error {

// ✅ GOOD: Handling errors
data, err := json.Marshal(user)
if err != nil {
    return fmt.Errorf("marshal user: %w", err)
}

// ✅ GOOD: Context first
func GetUser(ctx context.Context, id string) (*User, error)

// ✅ GOOD: Return concrete type
func NewUserService(repo UserRepository) *UserService

// ✅ GOOD: Descriptive naming
func ValidateOrderItems(items []OrderItem) error

// ✅ GOOD: Constant for immutable values
const maxRetries = 3
```

### ✅ Code Complexity

**Check for:**

- [ ] **Function length** - Functions < 50 lines (ideally < 30)
- [ ] **Cyclomatic complexity** - Low nesting, clear control flow
- [ ] **God objects** - No single struct doing too much
- [ ] **DRY principle** - No repeated code blocks
- [ ] **Single responsibility** - Each function does one thing

**Tools:**

```bash
# Check complexity
gocyclo -over 15 .

# Check function length
golocc .
```

### ✅ Code Smells

**Watch for:**

- Deeply nested if statements (> 3 levels)
- Long parameter lists (> 4 parameters)
- Large structs (> 10 fields)
- Magic numbers without constants
- Commented-out code
- TODO comments without tickets
- Panic in library code (should return errors)

## 2. Security Review

### ✅ Authentication & Authorization

**Check for:**

- [ ] **Authentication** - All endpoints require auth where appropriate
- [ ] **Authorization** - Permission checks before sensitive operations
- [ ] **Token validation** - JWT/session tokens properly validated
- [ ] **Password handling** - Never stored in plain text, use bcrypt/argon2
- [ ] **API keys** - Not hardcoded, loaded from environment

**Red Flags:**

```go
// ❌ BAD: No authentication check
func DeleteUser(w http.ResponseWriter, r *http.Request) {
    userID := r.URL.Query().Get("id")
    db.Delete(userID)
}

// ❌ BAD: Password in plain text
user := User{Password: "secret123"}

// ❌ BAD: Hardcoded API key
const apiKey = "sk-abc123xyz"

// ❌ BAD: Weak password check
if len(password) > 6 { /* allow */ }
```

**Good Patterns:**

```go
// ✅ GOOD: Auth middleware
func DeleteUser(w http.ResponseWriter, r *http.Request) {
    // Middleware has already validated token
    userID := r.Context().Value("userID").(string)

    // Check authorization
    if !canDeleteUser(userID, targetID) {
        http.Error(w, "forbidden", http.StatusForbidden)
        return
    }

    db.Delete(targetID)
}

// ✅ GOOD: Hashed password
hashedPassword, _ := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
user := User{PasswordHash: hashedPassword}

// ✅ GOOD: Environment variable
apiKey := os.Getenv("API_KEY")
if apiKey == "" {
    log.Fatal("API_KEY not set")
}

// ✅ GOOD: Strong password requirements
if len(password) < 12 || !hasUpperLower(password) || !hasDigit(password) {
    return errors.New("password too weak")
}
```

### ✅ Input Validation

**Check for:**

- [ ] **SQL injection** - Use parameterized queries or ORM
- [ ] **XSS prevention** - Sanitize HTML output
- [ ] **Path traversal** - Validate file paths
- [ ] **Command injection** - Never pass user input to exec
- [ ] **JSON parsing** - Limit size, validate structure
- [ ] **Integer overflow** - Check bounds on numeric inputs

**Red Flags:**

```go
// ❌ CRITICAL: SQL injection
query := fmt.Sprintf("SELECT * FROM users WHERE id = %s", userInput)
db.Query(query)

// ❌ CRITICAL: Command injection
exec.Command("sh", "-c", "ls " + userInput).Run()

// ❌ BAD: No path validation
http.ServeFile(w, r, "./files/" + fileName)

// ❌ BAD: Unbounded JSON parsing
var data map[string]interface{}
json.NewDecoder(r.Body).Decode(&data)

// ❌ BAD: No integer bounds checking
port := r.URL.Query().Get("port")
listen(":" + port)
```

**Good Patterns:**

```go
// ✅ GOOD: Parameterized query
db.Query("SELECT * FROM users WHERE id = ?", userID)

// ✅ GOOD: Avoid shell execution
exec.Command("ls", directory).Run()

// ✅ GOOD: Path validation
cleanPath := filepath.Clean(fileName)
if !strings.HasPrefix(cleanPath, "./files/") {
    return errors.New("invalid path")
}

// ✅ GOOD: Limit JSON size
r.Body = http.MaxBytesReader(w, r.Body, 1048576) // 1MB limit
var data RequestBody // Strongly typed
if err := json.NewDecoder(r.Body).Decode(&data); err != nil {
    return err
}
if err := validateRequestBody(data); err != nil {
    return err
}

// ✅ GOOD: Integer validation
portStr := r.URL.Query().Get("port")
port, err := strconv.Atoi(portStr)
if err != nil || port < 1024 || port > 65535 {
    return errors.New("invalid port")
}
```

### ✅ Secrets Management

**Check for:**

- [ ] **No hardcoded secrets** - Check for API keys, passwords, tokens
- [ ] **Environment variables** - Secrets loaded from env/vault
- [ ] **.env files** - Not committed to git (.gitignore)
- [ ] **Logs** - No secrets in logs
- [ ] **Error messages** - No sensitive data exposed

**Scan for secrets:**

```bash
# Use gitleaks to scan for secrets
gitleaks detect --source . --verbose

# Manual search patterns
grep -r "password.*=.*['\"]" . --include="*.go"
grep -r "api[_-]key.*=.*['\"]" . --include="*.go"
grep -r "secret.*=.*['\"]" . --include="*.go"
```

### ✅ Cryptography

**Check for:**

- [ ] **TLS enabled** - HTTPS for all external communication
- [ ] **Strong algorithms** - No MD5, SHA1, DES, RC4
- [ ] **Random numbers** - Use crypto/rand, not math/rand
- [ ] **Certificate validation** - Don't skip TLS verification

**Red Flags:**

```go
// ❌ BAD: Weak hashing
hash := md5.Sum([]byte(password))

// ❌ BAD: Insecure random
rand.Seed(time.Now().Unix())
token := rand.Intn(999999)

// ❌ CRITICAL: Skip TLS verification
client := &http.Client{
    Transport: &http.Transport{
        TLSClientConfig: &tls.Config{InsecureSkipVerify: true},
    },
}

// ❌ BAD: HTTP instead of HTTPS
resp, _ := http.Get("http://api.example.com/data")
```

**Good Patterns:**

```go
// ✅ GOOD: Strong hashing
hash, _ := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)

// ✅ GOOD: Cryptographically secure random
token := make([]byte, 32)
crypto_rand.Read(token)
tokenStr := base64.URLEncoding.EncodeToString(token)

// ✅ GOOD: Proper TLS
client := &http.Client{
    Transport: &http.Transport{
        TLSClientConfig: &tls.Config{
            MinVersion: tls.VersionTLS13,
        },
    },
}

// ✅ GOOD: HTTPS only
resp, err := http.Get("https://api.example.com/data")
```

## 3. Performance Review

### ✅ Memory Management

**Check for:**

- [ ] **Memory leaks** - Goroutines that never exit
- [ ] **Unnecessary allocations** - String concatenation in loops
- [ ] **Large copies** - Passing large structs by value
- [ ] **Slice capacity** - Pre-allocate when size is known
- [ ] **String building** - Use strings.Builder for concatenation

**Red Flags:**

```go
// ❌ BAD: String concatenation in loop
var result string
for _, item := range items {
    result += item + ", " // N allocations
}

// ❌ BAD: Passing large struct by value
func ProcessData(data LargeStruct) // Copies entire struct

// ❌ BAD: Goroutine leak
func StartWorker() {
    go func() {
        for {
            // Never exits, no cancellation
            doWork()
        }
    }()
}

// ❌ BAD: Growing slice without capacity
var results []Result
for i := 0; i < 10000; i++ {
    results = append(results, Result{}) // Multiple reallocations
}
```

**Good Patterns:**

```go
// ✅ GOOD: Use strings.Builder
var builder strings.Builder
for _, item := range items {
    builder.WriteString(item)
    builder.WriteString(", ")
}
result := builder.String()

// ✅ GOOD: Pass pointer
func ProcessData(data *LargeStruct)

// ✅ GOOD: Cancellable goroutine
func StartWorker(ctx context.Context) {
    go func() {
        for {
            select {
            case <-ctx.Done():
                return
            default:
                doWork()
            }
        }
    }()
}

// ✅ GOOD: Pre-allocate with capacity
results := make([]Result, 0, 10000)
for i := 0; i < 10000; i++ {
    results = append(results, Result{})
}
```

### ✅ Concurrency

**Check for:**

- [ ] **Race conditions** - Run tests with `-race` flag
- [ ] **Deadlocks** - Proper mutex ordering
- [ ] **Goroutine leaks** - All goroutines can exit
- [ ] **Channel usage** - Proper buffer sizes, close channels
- [ ] **Context cancellation** - Respect context.Done()

**Common Issues:**

```go
// ❌ BAD: Race condition
type Counter struct {
    count int // Not protected
}
func (c *Counter) Increment() {
    c.count++ // Race!
}

// ❌ BAD: Deadlock potential
mu1.Lock()
mu2.Lock() // If another goroutine does mu2, mu1 = deadlock

// ❌ BAD: Unbuffered channel deadlock
ch := make(chan int)
ch <- 1 // Blocks forever if no receiver

// ❌ BAD: Not respecting context
func DoWork(ctx context.Context) {
    for {
        // Never checks ctx.Done()
        heavyComputation()
    }
}
```

**Good Patterns:**

```go
// ✅ GOOD: Mutex protection
type Counter struct {
    mu    sync.Mutex
    count int
}
func (c *Counter) Increment() {
    c.mu.Lock()
    defer c.mu.Unlock()
    c.count++
}

// ✅ GOOD: Consistent lock ordering
// Always lock in same order: mu1, then mu2
func transfer() {
    mu1.Lock()
    defer mu1.Unlock()
    mu2.Lock()
    defer mu2.Unlock()
}

// ✅ GOOD: Buffered or with receiver
ch := make(chan int, 1)
ch <- 1 // Won't block

// ✅ GOOD: Respect context
func DoWork(ctx context.Context) error {
    for {
        select {
        case <-ctx.Done():
            return ctx.Err()
        default:
            if err := heavyComputation(); err != nil {
                return err
            }
        }
    }
}
```

### ✅ Database Performance

**Check for:**

- [ ] **N+1 queries** - Use joins or batch loading
- [ ] **Missing indexes** - Check query plans
- [ ] **Connection pooling** - Proper pool size configuration
- [ ] **Prepared statements** - For repeated queries
- [ ] **Transaction size** - Not too large
- [ ] **Query timeouts** - Use context with timeout

**Red Flags:**

```go
// ❌ BAD: N+1 query problem
users, _ := db.Query("SELECT * FROM users")
for users.Next() {
    var user User
    users.Scan(&user.ID, &user.Name)

    // Query in loop! N+1 problem
    orders, _ := db.Query("SELECT * FROM orders WHERE user_id = ?", user.ID)
    user.Orders = scanOrders(orders)
}

// ❌ BAD: No query timeout
rows, _ := db.Query("SELECT * FROM large_table") // Could hang forever

// ❌ BAD: Not using prepared statements
for _, id := range ids {
    db.Query("SELECT * FROM users WHERE id = ?", id) // Reparsed each time
}
```

**Good Patterns:**

```go
// ✅ GOOD: Single query with JOIN
rows, _ := db.Query(`
    SELECT u.id, u.name, o.id, o.total
    FROM users u
    LEFT JOIN orders o ON o.user_id = u.id
`)

// ✅ GOOD: Query with timeout
ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
defer cancel()
rows, err := db.QueryContext(ctx, "SELECT * FROM large_table")

// ✅ GOOD: Prepared statement for repeated queries
stmt, _ := db.Prepare("SELECT * FROM users WHERE id = ?")
defer stmt.Close()
for _, id := range ids {
    stmt.Query(id)
}

// ✅ GOOD: Batch insert
tx, _ := db.Begin()
stmt, _ := tx.Prepare("INSERT INTO users (name, email) VALUES (?, ?)")
for _, user := range users {
    stmt.Exec(user.Name, user.Email)
}
stmt.Close()
tx.Commit()
```

## 4. Testing Review

### ✅ Test Coverage

**Check for:**

- [ ] **Coverage threshold** - At least 70% (aim for 80%+)
- [ ] **Critical paths covered** - Authentication, payments, data modification
- [ ] **Edge cases** - Boundary conditions, empty inputs, nil values
- [ ] **Error paths** - Test error handling, not just happy path
- [ ] **Integration tests** - Test actual database, not just mocks

**Measure coverage:**

```bash
# Overall coverage
go test ./... -coverprofile=coverage.out
go tool cover -func=coverage.out

# HTML report
go tool cover -html=coverage.out -o coverage.html

# Coverage by package
go test ./... -coverprofile=coverage.out
go tool cover -func=coverage.out | sort -k 3 -n
```

### ✅ Test Quality

**Check for:**

- [ ] **Table-driven tests** - Used for multiple scenarios
- [ ] **Test names** - Descriptive (TestFunction_Scenario_ExpectedResult)
- [ ] **Assertions** - Clear error messages
- [ ] **Test independence** - Tests don't depend on each other
- [ ] **Cleanup** - Use t.Cleanup() for resources
- [ ] **No sleep** - Use channels/sync primitives, not time.Sleep

**Reference:** See `go-testing-guide` skill for detailed testing patterns.

### ✅ Mock Quality

**Check for:**

- [ ] **Mock realism** - Mocks behave like real implementations
- [ ] **Not over-mocked** - Only mock external dependencies
- [ ] **Interface-based** - Mocking interfaces, not concrete types
- [ ] **In-memory implementations** - Preferred over stub mocks

**Red flags:** See `go-testing-guide` skill for mock anti-patterns.

## 5. Documentation Review

### ✅ Code Documentation

**Check for:**

- [ ] **Package comments** - Every package has doc.go or package comment
- [ ] **Exported symbols** - All exported types/functions have comments
- [ ] **Examples** - Complex functions have example tests
- [ ] **Godoc compliance** - Comments start with symbol name
- [ ] **Links** - Reference related functions/types

**Format:**

```go
// Package userservice provides user management functionality.
//
// The service handles user creation, authentication, and profile management.
// All operations require proper authentication and authorization.
package userservice

// User represents a user account in the system.
//
// Users are identified by a unique email address and can have
// multiple roles for authorization purposes.
type User struct {
    ID    string
    Email string
    Roles []string
}

// CreateUser creates a new user account.
//
// The email must be unique and valid. Password must meet
// minimum security requirements (see ValidatePassword).
//
// Returns ErrDuplicateEmail if the email is already registered.
//
// Example:
//
//	user, err := svc.CreateUser("user@example.com", "securePass123!")
//	if err != nil {
//	    // handle error
//	}
func (s *Service) CreateUser(email, password string) (*User, error) {
```

### ✅ README and Guides

**Check for:**

- [ ] **README.md** - Exists and is up-to-date
- [ ] **Installation instructions** - How to build and run
- [ ] **Configuration** - Environment variables documented
- [ ] **API documentation** - If exposing API
- [ ] **Architecture overview** - High-level design
- [ ] **Contributing guide** - For open source

**README Template:**

````markdown
# Project Name

Brief description of what this does.

## Features

- Feature 1
- Feature 2
- Feature 3

## Installation

```bash
go get github.com/yourorg/yourproject
```
````

## Configuration

Required environment variables:

- `DATABASE_URL` - PostgreSQL connection string
- `API_KEY` - Third-party API key
- `PORT` - Server port (default: 8080)

## Usage

```go
import "github.com/yourorg/yourproject"

// Example usage
```

## API Documentation

See [docs/api.md](docs/api.md) or access Swagger UI at `/swagger`

## Development

```bash
# Run tests
go test ./...

# Run locally
go run cmd/server/main.go
```

## License

MIT

````

### ✅ API Documentation

**Check for:**

- [ ] **OpenAPI/Swagger** - If REST API exists
- [ ] **Request/response examples** - For each endpoint
- [ ] **Error responses** - Document error codes and meanings
- [ ] **Rate limits** - If applicable
- [ ] **Authentication** - How to authenticate

## 6. Error Handling Review

### ✅ Error Patterns

**Check for:**

- [ ] **Error wrapping** - Use fmt.Errorf with %w
- [ ] **Error types** - Custom errors for different scenarios
- [ ] **Sentinel errors** - For common errors (ErrNotFound)
- [ ] **Error context** - Errors include useful information
- [ ] **No panic** - Libraries should return errors, not panic
- [ ] **Error checking** - No ignored errors

**Good Error Handling:**

```go
// ✅ Define sentinel errors
var (
    ErrUserNotFound     = errors.New("user not found")
    ErrDuplicateEmail   = errors.New("email already registered")
    ErrInvalidPassword  = errors.New("invalid password")
)

// ✅ Custom error types
type ValidationError struct {
    Field   string
    Message string
}

func (e *ValidationError) Error() string {
    return fmt.Sprintf("%s: %s", e.Field, e.Message)
}

// ✅ Wrap errors with context
func (s *Service) GetUser(ctx context.Context, id string) (*User, error) {
    user, err := s.repo.Get(ctx, id)
    if err != nil {
        if errors.Is(err, ErrUserNotFound) {
            return nil, ErrUserNotFound // Don't wrap sentinel errors
        }
        return nil, fmt.Errorf("get user %s: %w", id, err)
    }
    return user, nil
}

// ✅ Check error types
func (h *Handler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
    user, err := h.service.GetUser(r.Context(), id)
    if err != nil {
        if errors.Is(err, ErrUserNotFound) {
            http.Error(w, "not found", http.StatusNotFound)
            return
        }
        var valErr *ValidationError
        if errors.As(err, &valErr) {
            http.Error(w, valErr.Error(), http.StatusBadRequest)
            return
        }
        http.Error(w, "internal error", http.StatusInternalServerError)
        return
    }
    json.NewEncoder(w).Encode(user)
}
````

### ✅ Logging

**Check for:**

- [ ] **Structured logging** - Use slog or zap, not fmt.Println
- [ ] **Log levels** - Appropriate levels (debug, info, warn, error)
- [ ] **Contextual info** - Include request ID, user ID, etc.
- [ ] **No secrets in logs** - Sanitize before logging
- [ ] **Performance** - Logging doesn't impact performance

**Good Logging:**

```go
// ✅ GOOD: Structured logging
logger := slog.New(slog.NewJSONHandler(os.Stdout, nil))

logger.Info("user created",
    "user_id", user.ID,
    "email", user.Email,
    "request_id", requestID,
)

logger.Error("database error",
    "error", err,
    "query", query,
    "duration_ms", duration.Milliseconds(),
)

// ✅ GOOD: Context-aware logger
type contextKey string
const loggerKey contextKey = "logger"

func LoggerFromContext(ctx context.Context) *slog.Logger {
    if logger, ok := ctx.Value(loggerKey).(*slog.Logger); ok {
        return logger
    }
    return slog.Default()
}

// In middleware
func RequestLogger(next http.Handler) http.Handler {
    return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
        requestID := uuid.New().String()
        logger := slog.Default().With(
            "request_id", requestID,
            "method", r.Method,
            "path", r.URL.Path,
        )
        ctx := context.WithValue(r.Context(), loggerKey, logger)
        next.ServeHTTP(w, r.WithContext(ctx))
    })
}
```

## 7. Dependencies Review

### ✅ Dependency Management

**Check for:**

- [ ] **go.mod/go.sum** - Committed and up-to-date
- [ ] **Direct dependencies** - Only necessary dependencies
- [ ] **Version pinning** - Not using `@latest` in production
- [ ] **Outdated dependencies** - Check for updates
- [ ] **Vulnerabilities** - Scan for known CVEs
- [ ] **License compatibility** - Check dependency licenses

**Commands:**

```bash
# Update dependencies
go get -u ./...
go mod tidy

# Check for outdated
go list -u -m all

# Vulnerability scan
govulncheck ./...

# Dependency graph
go mod graph

# Why is this dependency here?
go mod why github.com/some/package

# Remove unused dependencies
go mod tidy
```

### ✅ Dependency Quality

**Evaluate each dependency:**

- Is it actively maintained? (check last commit)
- How many stars/users? (community size)
- Are there known security issues?
- Is the license compatible with your project?
- Could you implement it yourself? (avoid dependency for simple things)
- Are there better alternatives?

**Red flags:**

- No commits in > 1 year
- Many open security issues
- GPL license (if you're closed source)
- Dependency for something trivial

## 8. Deployment Readiness

### ✅ Configuration Management

**Check for:**

- [ ] **Environment-based** - Dev, staging, prod configs
- [ ] **Environment variables** - Documented and validated
- [ ] **Config validation** - Fail fast on startup with bad config
- [ ] **Defaults** - Sensible defaults provided
- [ ] **No secrets** - Secrets not in config files

**Good Config Pattern:**

```go
type Config struct {
    Port         int    `env:"PORT" envDefault:"8080"`
    DatabaseURL  string `env:"DATABASE_URL,required"`
    LogLevel     string `env:"LOG_LEVEL" envDefault:"info"`
    JWTSecret    string `env:"JWT_SECRET,required"`
}

func LoadConfig() (*Config, error) {
    var cfg Config
    if err := env.Parse(&cfg); err != nil {
        return nil, fmt.Errorf("parse config: %w", err)
    }

    // Validate
    if cfg.Port < 1024 || cfg.Port > 65535 {
        return nil, errors.New("invalid port")
    }

    if !isValidLogLevel(cfg.LogLevel) {
        return nil, fmt.Errorf("invalid log level: %s", cfg.LogLevel)
    }

    return &cfg, nil
}

func main() {
    cfg, err := LoadConfig()
    if err != nil {
        log.Fatalf("Failed to load config: %v", err)
    }

    // Now safe to use cfg
}
```

### ✅ Docker and Deployment

**Check for:**

- [ ] **Dockerfile** - Follows best practices (see `go-dockerfile-best-practices`)
- [ ] **Health checks** - /health endpoint implemented
- [ ] **Graceful shutdown** - Handles SIGTERM properly
- [ ] **Resource limits** - Memory/CPU limits set
- [ ] **Multi-stage builds** - Minimal final image
- [ ] **Non-root user** - Not running as root

**Reference:** See `go-dockerfile-best-practices` skill for details.

### ✅ Database Migrations

**Check for:**

- [ ] **Migration tool** - Using golang-migrate or similar
- [ ] **Up and down migrations** - All migrations are reversible
- [ ] **Idempotent** - Can run migrations multiple times safely
- [ ] **Tested** - Migrations tested before production
- [ ] **Backup strategy** - Database backed up before migrations
- [ ] **Rollback plan** - Know how to rollback if needed

**Migration Structure:**

```
migrations/
├── 000001_create_users_table.up.sql
├── 000001_create_users_table.down.sql
├── 000002_add_email_index.up.sql
├── 000002_add_email_index.down.sql
```

### ✅ Monitoring and Observability

**Check for:**

- [ ] **Metrics** - Prometheus metrics exported
- [ ] **Tracing** - Distributed tracing (if microservices)
- [ ] **Logging** - Structured logs to central system
- [ ] **Alerts** - Critical failures trigger alerts
- [ ] **Dashboards** - Key metrics visualized
- [ ] **Health checks** - Liveness and readiness probes

**Metrics Example:**

```go
import "github.com/prometheus/client_golang/prometheus"

var (
    requestDuration = prometheus.NewHistogramVec(
        prometheus.HistogramOpts{
            Name: "http_request_duration_seconds",
            Help: "HTTP request duration in seconds",
        },
        []string{"method", "path", "status"},
    )

    requestsTotal = prometheus.NewCounterVec(
        prometheus.CounterOpts{
            Name: "http_requests_total",
            Help: "Total HTTP requests",
        },
        []string{"method", "path", "status"},
    )
)

func init() {
    prometheus.MustRegister(requestDuration)
    prometheus.MustRegister(requestsTotal)
}

// In middleware
func MetricsMiddleware(next http.Handler) http.Handler {
    return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
        start := time.Now()

        recorder := &statusRecorder{ResponseWriter: w, status: 200}
        next.ServeHTTP(recorder, r)

        duration := time.Since(start).Seconds()
        status := strconv.Itoa(recorder.status)

        requestDuration.WithLabelValues(r.Method, r.URL.Path, status).Observe(duration)
        requestsTotal.WithLabelValues(r.Method, r.URL.Path, status).Inc()
    })
}
```

## Review Checklist Summary

Use this checklist for every PR:

### Pre-Merge Checklist

**Automated Checks:**

- [ ] `gofmt -l .` returns nothing
- [ ] `golangci-lint run` passes
- [ ] `go test ./... -race` passes
- [ ] Test coverage > 70%
- [ ] `gosec ./...` reports no critical issues
- [ ] `govulncheck ./...` reports no vulnerabilities
- [ ] Docker build succeeds
- [ ] All CI checks pass

**Manual Review:**

- [ ] Code follows Go idioms and conventions
- [ ] No security vulnerabilities identified
- [ ] Performance considerations addressed
- [ ] Tests are comprehensive and high-quality
- [ ] Documentation is complete and accurate
- [ ] Error handling is proper and consistent
- [ ] Dependencies are necessary and secure
- [ ] Deployment configuration is production-ready

**Additional for Production Deploy:**

- [ ] Database migrations tested
- [ ] Rollback plan documented
- [ ] Monitoring and alerts configured
- [ ] Load testing completed (if applicable)
- [ ] Security review completed
- [ ] Changelog updated
- [ ] Release notes prepared

## Automated PR Review Workflow

Create a GitHub Actions workflow:

```yaml
# .github/workflows/pr-review.yml
name: PR Review

on:
  pull_request:
    branches: [main, develop]

jobs:
  review:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - uses: actions/setup-go@v5
        with:
          go-version: "1.22"

      - name: Format check
        run: |
          if [ "$(gofmt -l . | wc -l)" -gt 0 ]; then
            echo "❌ Code is not formatted. Run: gofmt -w ."
            gofmt -l .
            exit 1
          fi

      - name: Lint
        uses: golangci/golangci-lint-action@v4
        with:
          version: latest
          args: --timeout=5m

      - name: Tests
        run: |
          go test ./... -race -coverprofile=coverage.out
          go tool cover -func=coverage.out -o=coverage.txt
          echo "Coverage Report:"
          cat coverage.txt

          # Check coverage threshold
          COVERAGE=$(go tool cover -func=coverage.out | grep total | awk '{print $3}' | sed 's/%//')
          if (( $(echo "$COVERAGE < 70" | bc -l) )); then
            echo "❌ Coverage $COVERAGE% is below 70%"
            exit 1
          fi
          echo "✅ Coverage: $COVERAGE%"

      - name: Security scan
        run: |
          go install github.com/securego/gosec/v2/cmd/gosec@latest
          gosec -fmt=json -out=gosec-report.json ./...

      - name: Vulnerability check
        run: |
          go install golang.org/x/vuln/cmd/govulncheck@latest
          govulncheck ./...

      - name: Docker build
        run: docker build -t test-image .

      - name: Comment on PR
        if: always()
        uses: actions/github-script@v7
        with:
          script: |
            const fs = require('fs');
            const coverage = fs.readFileSync('coverage.txt', 'utf8');

            github.rest.issues.createComment({
              issue_number: context.issue.number,
              owner: context.repo.owner,
              repo: context.repo.repo,
              body: `## 🔍 PR Review Results\n\n### Coverage\n\`\`\`\n${coverage}\n\`\`\``
            });
```

## Common Issues Found in Reviews

### Top 10 Issues

1. **Ignored errors** - `_, _ = something()` without handling
2. **SQL injection** - String concatenation in queries
3. **Hardcoded secrets** - API keys, passwords in code
4. **No tests** - Critical functions without tests
5. **Poor error messages** - Generic "error occurred" messages
6. **Race conditions** - Unprotected shared state
7. **Goroutine leaks** - Goroutines that never exit
8. **N+1 queries** - Database queries in loops
9. **Missing validation** - User input not validated
10. **No documentation** - Exported functions without comments

## Summary

**Before every merge:**

1. Run automated checks
2. Review code manually using this guide
3. Check all 8 categories
4. Verify pre-merge checklist
5. Get peer review

**Before production deploy:**

1. Complete pre-merge checks
2. Test migrations
3. Verify monitoring
4. Prepare rollback plan
5. Update documentation

**Remember:** Catching issues in review is 10x cheaper than fixing them in production!
