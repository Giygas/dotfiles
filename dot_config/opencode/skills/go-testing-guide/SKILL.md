---
name: go-testing-guide
description: Guide for writing effective Go tests and mocks. Use when creating tests, mocks, or test infrastructure in Go. Covers unit tests, table-driven tests, mocking strategies, test helpers, and common pitfalls to avoid.
licence: MIT
compatibility: opencode
metadata:
  audience: developers, ai-agents
  workflow: testing, development
  language: go
---

# Go Testing Guide

A comprehensive guide for writing high-quality tests and mocks in Go. This skill helps you avoid common pitfalls and write tests that actually verify correct behavior.

## Core Principles

### 1. Tests Should Verify Real Behavior

Tests exist to give you confidence that your code works correctly. They should:

- Test actual business logic and behavior
- Use real implementations when possible
- Mock only external dependencies (databases, APIs, file systems)
- Fail when the code is broken
- Pass when the code is correct

### 2. Mocks Should Mirror Reality

When you must mock, the mock should behave identically to the real implementation:

- Same return values for the same inputs
- Same error conditions
- Same side effects
- If the real implementation always returns X, the mock should always return X

**Anti-pattern**: Configurable mocks that let you set arbitrary return values
**Better approach**: Mocks that faithfully reproduce real behavior

## When to Mock (and When Not To)

### DO Mock:

- External HTTP APIs
- Databases and data stores
- File system operations
- Time-dependent operations (time.Now())
- Random number generation
- External services (email, SMS, payment processors)

### DON'T Mock:

- Pure functions (math, string manipulation, data transformations)
- Simple in-memory data structures
- Business logic
- Your own internal packages (test them directly)
- Anything that's fast and deterministic

### Example: What to Mock

```go
// DON'T mock - just test it directly
type Calculator struct{}
func (c *Calculator) Add(a, b int) int { return a + b }

// DO mock - external dependency
type PaymentGateway interface {
    Charge(amount int) error
}

// Your business logic should use the interface
type OrderService struct {
    gateway PaymentGateway
}

func (s *OrderService) ProcessOrder(amount int) error {
    return s.gateway.Charge(amount)
}

// In tests, provide a mock gateway
type MockPaymentGateway struct {
    shouldFail bool
}

func (m *MockPaymentGateway) Charge(amount int) error {
    if m.shouldFail {
        return errors.New("payment failed")
    }
    return nil
}
```

## Table-Driven Tests

Table-driven tests are Go's idiomatic way to test multiple scenarios.

### Basic Structure

```go
func TestUserValidation(t *testing.T) {
    tests := []struct {
        name    string
        user    User
        wantErr bool
        errMsg  string
    }{
        {
            name: "valid user",
            user: User{Email: "test@example.com", Age: 25},
            wantErr: false,
        },
        {
            name: "missing email",
            user: User{Age: 25},
            wantErr: true,
            errMsg: "email is required",
        },
        {
            name: "underage",
            user: User{Email: "test@example.com", Age: 15},
            wantErr: true,
            errMsg: "must be 18 or older",
        },
    }

    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            err := ValidateUser(tt.user)

            if tt.wantErr {
                if err == nil {
                    t.Errorf("ValidateUser() expected error, got nil")
                }
                if err != nil && !strings.Contains(err.Error(), tt.errMsg) {
                    t.Errorf("ValidateUser() error = %v, want error containing %q", err, tt.errMsg)
                }
            } else {
                if err != nil {
                    t.Errorf("ValidateUser() unexpected error: %v", err)
                }
            }
        })
    }
}
```

### When to Use Table-Driven Tests

**Use table-driven tests when:**

- Testing the same function with different inputs
- Testing edge cases and error conditions
- The test structure is repetitive

**Don't use table-driven tests when:**

- Each test requires significantly different setup
- Tests have complex interactions or state
- The test logic differs substantially between cases
- You're testing a workflow or integration

## HTTP Handler Testing

### Use httptest Package

```go
func TestUserHandler(t *testing.T) {
    tests := []struct {
        name           string
        method         string
        path           string
        body           string
        setupService   func() *UserService
        wantStatus     int
        wantBodyContain string
    }{
        {
            name:   "create user success",
            method: "POST",
            path:   "/users",
            body:   `{"email":"test@example.com","age":25}`,
            setupService: func() *UserService {
                return &UserService{
                    repo: &InMemoryUserRepo{users: make(map[string]User)},
                }
            },
            wantStatus:     http.StatusCreated,
            wantBodyContain: "test@example.com",
        },
        {
            name:   "invalid email",
            method: "POST",
            path:   "/users",
            body:   `{"email":"invalid","age":25}`,
            setupService: func() *UserService {
                return &UserService{
                    repo: &InMemoryUserRepo{users: make(map[string]User)},
                }
            },
            wantStatus:     http.StatusBadRequest,
            wantBodyContain: "invalid email",
        },
    }

    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            // Setup
            service := tt.setupService()
            handler := NewUserHandler(service)

            // Create request
            req := httptest.NewRequest(tt.method, tt.path, strings.NewReader(tt.body))
            req.Header.Set("Content-Type", "application/json")
            w := httptest.NewRecorder()

            // Execute
            handler.ServeHTTP(w, req)

            // Assert
            if w.Code != tt.wantStatus {
                t.Errorf("got status %d, want %d", w.Code, tt.wantStatus)
            }

            body := w.Body.String()
            if !strings.Contains(body, tt.wantBodyContain) {
                t.Errorf("response body %q does not contain %q", body, tt.wantBodyContain)
            }
        })
    }
}
```

### Testing JSON Responses

```go
func TestUserHandlerJSON(t *testing.T) {
    service := &UserService{
        repo: &InMemoryUserRepo{
            users: map[string]User{
                "1": {ID: "1", Email: "test@example.com", Age: 25},
            },
        },
    }
    handler := NewUserHandler(service)

    req := httptest.NewRequest("GET", "/users/1", nil)
    w := httptest.NewRecorder()

    handler.ServeHTTP(w, req)

    if w.Code != http.StatusOK {
        t.Fatalf("got status %d, want %d", w.Code, http.StatusOK)
    }

    var got User
    if err := json.NewDecoder(w.Body).Decode(&got); err != nil {
        t.Fatalf("failed to decode response: %v", err)
    }

    want := User{ID: "1", Email: "test@example.com", Age: 25}
    if !reflect.DeepEqual(got, want) {
        t.Errorf("got user %+v, want %+v", got, want)
    }
}
```

## Mock Strategies

### Strategy 1: Interface-Based Mocks (Preferred)

Define interfaces for dependencies and provide test implementations.

```go
// Production code
type UserRepository interface {
    Get(id string) (User, error)
    Save(user User) error
}

type UserService struct {
    repo UserRepository
}

// Test code - in-memory implementation
type InMemoryUserRepo struct {
    users map[string]User
    saveErr error  // Optional: to test error handling
}

func (r *InMemoryUserRepo) Get(id string) (User, error) {
    user, ok := r.users[id]
    if !ok {
        return User{}, ErrUserNotFound
    }
    return user, nil
}

func (r *InMemoryUserRepo) Save(user User) error {
    if r.saveErr != nil {
        return r.saveErr
    }
    r.users[user.ID] = user
    return nil
}

// Test usage
func TestUserService(t *testing.T) {
    repo := &InMemoryUserRepo{
        users: map[string]User{
            "1": {ID: "1", Email: "test@example.com"},
        },
    }
    service := &UserService{repo: repo}

    user, err := service.GetUser("1")
    if err != nil {
        t.Fatalf("unexpected error: %v", err)
    }

    if user.Email != "test@example.com" {
        t.Errorf("got email %q, want %q", user.Email, "test@example.com")
    }
}
```

### Strategy 2: Function Fields for Simple Cases

For simple dependencies, use function fields.

```go
type UserService struct {
    // Instead of interface, use function field
    sendEmail func(to, subject, body string) error
}

func NewUserService() *UserService {
    return &UserService{
        sendEmail: sendEmailViaAPI,  // Real implementation
    }
}

// In tests
func TestUserServiceEmailNotification(t *testing.T) {
    var sentTo, sentSubject, sentBody string

    service := &UserService{
        sendEmail: func(to, subject, body string) error {
            sentTo = to
            sentSubject = subject
            sentBody = body
            return nil
        },
    }

    service.NotifyUser("user@example.com", "Welcome!")

    if sentTo != "user@example.com" {
        t.Errorf("sent to %q, want %q", sentTo, "user@example.com")
    }
}
```

### Strategy 3: Test-Specific Implementations

Create test doubles that implement the full interface behavior.

```go
// Real implementation
type PostgresUserRepo struct {
    db *sql.DB
}

// Test implementation - behaves like Postgres but in-memory
type TestUserRepo struct {
    users    map[string]User
    callLog  []string  // Track method calls
    failNext bool      // Simulate failures
}

func (r *TestUserRepo) Get(id string) (User, error) {
    r.callLog = append(r.callLog, fmt.Sprintf("Get(%s)", id))

    if r.failNext {
        r.failNext = false
        return User{}, errors.New("database error")
    }

    user, ok := r.users[id]
    if !ok {
        return User{}, ErrUserNotFound
    }
    return user, nil
}
```

## Anti-Patterns to Avoid

### ❌ Anti-Pattern 1: Overly Configurable Mocks

```go
// BAD: Mock that returns anything you configure
type MockUserRepo struct {
    GetReturn User
    GetError  error
    SaveError error
}

func (m *MockUserRepo) Get(id string) (User, error) {
    return m.GetReturn, m.GetError
}
```

**Problem**: Tests can configure behavior that the real implementation could never have. Tests pass with mock but fail in production.

**Fix**: Make mocks behave realistically.

```go
// GOOD: Mock with realistic behavior
type FakeUserRepo struct {
    users map[string]User
}

func (r *FakeUserRepo) Get(id string) (User, error) {
    user, ok := r.users[id]
    if !ok {
        return User{}, ErrUserNotFound
    }
    return user, nil
}
```

### ❌ Anti-Pattern 2: Testing Implementation Details

```go
// BAD: Testing internal state
func TestAddUser(t *testing.T) {
    service := &UserService{users: make(map[string]User)}
    service.AddUser(User{ID: "1"})

    // Don't test internal fields directly
    if len(service.users) != 1 {
        t.Error("expected 1 user in internal map")
    }
}
```

**Fix**: Test observable behavior.

```go
// GOOD: Test public API behavior
func TestAddUser(t *testing.T) {
    service := NewUserService()
    service.AddUser(User{ID: "1", Email: "test@example.com"})

    // Test through public API
    user, err := service.GetUser("1")
    if err != nil {
        t.Fatalf("unexpected error: %v", err)
    }
    if user.Email != "test@example.com" {
        t.Errorf("got email %q, want %q", user.Email, "test@example.com")
    }
}
```

### ❌ Anti-Pattern 3: One Test Per Function

```go
// BAD: Single test doesn't cover edge cases
func TestValidateUser(t *testing.T) {
    user := User{Email: "test@example.com", Age: 25}
    if err := ValidateUser(user); err != nil {
        t.Errorf("unexpected error: %v", err)
    }
}
```

**Fix**: Test multiple scenarios including edge cases.

```go
// GOOD: Comprehensive test coverage
func TestValidateUser(t *testing.T) {
    tests := []struct {
        name    string
        user    User
        wantErr bool
    }{
        {name: "valid user", user: User{Email: "test@example.com", Age: 25}, wantErr: false},
        {name: "missing email", user: User{Age: 25}, wantErr: true},
        {name: "invalid email", user: User{Email: "invalid", Age: 25}, wantErr: true},
        {name: "underage", user: User{Email: "test@example.com", Age: 15}, wantErr: true},
        {name: "edge case age 18", user: User{Email: "test@example.com", Age: 18}, wantErr: false},
    }

    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            err := ValidateUser(tt.user)
            if (err != nil) != tt.wantErr {
                t.Errorf("ValidateUser() error = %v, wantErr %v", err, tt.wantErr)
            }
        })
    }
}
```

### ❌ Anti-Pattern 4: Mocking Too Much

```go
// BAD: Mocking everything including simple functions
type MockStringFormatter struct {
    FormatReturn string
}

func (m *MockStringFormatter) Format(s string) string {
    return m.FormatReturn
}

// Just test the real thing!
```

**Fix**: Only mock external dependencies.

```go
// GOOD: Test pure functions directly
func TestFormatUserName(t *testing.T) {
    tests := []struct {
        input string
        want  string
    }{
        {"john doe", "John Doe"},
        {"JANE SMITH", "Jane Smith"},
        {"", ""},
    }

    for _, tt := range tests {
        got := FormatUserName(tt.input)
        if got != tt.want {
            t.Errorf("FormatUserName(%q) = %q, want %q", tt.input, got, tt.want)
        }
    }
}
```

## Test Helpers

Create helpers to reduce boilerplate, but keep tests readable.

### Good Test Helper

```go
// Helper for creating test users
func newTestUser(t *testing.T, email string, age int) User {
    t.Helper()  // Mark as helper for better error reporting
    return User{
        ID:    uuid.New().String(),
        Email: email,
        Age:   age,
    }
}

// Helper for setting up test database
func setupTestDB(t *testing.T) *sql.DB {
    t.Helper()
    db, err := sql.Open("postgres", "postgres://localhost/test?sslmode=disable")
    if err != nil {
        t.Fatalf("failed to open test db: %v", err)
    }

    // Clean up after test
    t.Cleanup(func() {
        db.Close()
    })

    return db
}

// Usage
func TestUserRepository(t *testing.T) {
    db := setupTestDB(t)
    repo := NewUserRepository(db)

    user := newTestUser(t, "test@example.com", 25)
    if err := repo.Save(user); err != nil {
        t.Fatalf("failed to save user: %v", err)
    }
}
```

## Integration Tests

For integration tests, use real implementations when possible.

```go
// +build integration

func TestUserWorkflow(t *testing.T) {
    if testing.Short() {
        t.Skip("skipping integration test")
    }

    // Use real database
    db := setupTestPostgres(t)
    repo := NewPostgresUserRepo(db)
    service := NewUserService(repo)

    // Test full workflow
    user := User{Email: "test@example.com", Age: 25}

    // Create
    id, err := service.CreateUser(user)
    if err != nil {
        t.Fatalf("CreateUser failed: %v", err)
    }

    // Read
    retrieved, err := service.GetUser(id)
    if err != nil {
        t.Fatalf("GetUser failed: %v", err)
    }

    if retrieved.Email != user.Email {
        t.Errorf("got email %q, want %q", retrieved.Email, user.Email)
    }

    // Update
    retrieved.Age = 26
    if err := service.UpdateUser(retrieved); err != nil {
        t.Fatalf("UpdateUser failed: %v", err)
    }

    // Delete
    if err := service.DeleteUser(id); err != nil {
        t.Fatalf("DeleteUser failed: %v", err)
    }
}
```

## Common Patterns

### Testing Error Handling

```go
func TestServiceHandlesRepoErrors(t *testing.T) {
    tests := []struct {
        name    string
        repoErr error
        wantErr string
    }{
        {
            name:    "not found error",
            repoErr: ErrUserNotFound,
            wantErr: "user not found",
        },
        {
            name:    "database error",
            repoErr: errors.New("connection failed"),
            wantErr: "failed to get user",
        },
    }

    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            repo := &ErrorReturningRepo{err: tt.repoErr}
            service := &UserService{repo: repo}

            _, err := service.GetUser("123")
            if err == nil {
                t.Fatal("expected error, got nil")
            }

            if !strings.Contains(err.Error(), tt.wantErr) {
                t.Errorf("got error %q, want error containing %q", err, tt.wantErr)
            }
        })
    }
}
```

### Testing Concurrent Code

```go
func TestConcurrentAccess(t *testing.T) {
    service := NewUserService()

    // Start multiple goroutines
    var wg sync.WaitGroup
    for i := 0; i < 10; i++ {
        wg.Add(1)
        go func(id int) {
            defer wg.Done()
            user := User{
                ID:    fmt.Sprintf("%d", id),
                Email: fmt.Sprintf("user%d@example.com", id),
            }
            if err := service.AddUser(user); err != nil {
                t.Errorf("AddUser failed: %v", err)
            }
        }(i)
    }

    wg.Wait()

    // Verify all users were added
    for i := 0; i < 10; i++ {
        _, err := service.GetUser(fmt.Sprintf("%d", i))
        if err != nil {
            t.Errorf("GetUser(%d) failed: %v", i, err)
        }
    }
}
```

## Quick Reference: What to Do

### When Writing Tests:

1. **Start with the happy path** - Test that valid inputs produce correct outputs
2. **Add edge cases** - Empty strings, nil values, boundary conditions
3. **Test error cases** - Invalid inputs, missing data, constraint violations
4. **Use table-driven tests** - For multiple scenarios with similar structure
5. **Test behavior, not implementation** - Focus on observable outcomes
6. **Keep tests simple** - Each test should verify one thing clearly
7. **Use descriptive names** - `TestCreateUser_InvalidEmail_ReturnsError` not `TestCreateUser1`

### When Writing Mocks:

1. **Mock interfaces, not concrete types**
2. **Make mocks behave like real implementations**
3. **Only mock external dependencies**
4. **Prefer in-memory implementations over stubs**
5. **Keep mock logic simple**
6. **Document any deviations from real behavior**
7. **Consider using real implementations in integration tests**

### Red Flags:

- ⚠️ Mock has many configuration options (GetReturn, GetError, etc.)
- ⚠️ Test passes with mock but fails with real implementation
- ⚠️ Testing private fields or methods
- ⚠️ Tests that need to be updated when refactoring (testing implementation)
- ⚠️ Mocking pure functions or simple calculations
- ⚠️ Complex mock setup that's harder to understand than the code being tested
- ⚠️ Tests that don't fail when you introduce bugs

## Summary

**Golden Rules:**

1. Tests verify behavior, not implementation
2. Mocks should mirror real implementations
3. Only mock external dependencies
4. Use table-driven tests for multiple scenarios
5. Keep tests simple and readable
6. Test error cases and edge conditions
7. Integration tests should use real implementations

**When in doubt:** If your mock can return values that the real implementation could never return, you're doing it wrong. Fix the mock to be realistic, or better yet, use the real implementation.
