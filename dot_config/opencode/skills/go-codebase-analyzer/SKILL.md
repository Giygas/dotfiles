---
name: go-codebase-analyzer
description: Analyze Go codebases for unused code, duplicated code, tech debt, and refactoring opportunities. Produces a prioritized summary of issues and fixes. Use for codebase audits, cleanup, and optimization.
license: MIT
compatibility: opencode
metadata:
  audience: developers, tech-leads, maintainers
  workflow: refactoring, code-quality, maintenance
  language: go
---

# Go Codebase Analyzer

Comprehensive codebase analysis tool for Go projects. Identifies unused code, duplicates, tech debt, and refactoring opportunities. Produces actionable reports with prioritized fixes.

## Quick Start

```
Use the go-codebase-analyzer skill to audit my codebase and find issues
```

Or for specific analysis:

```
Use go-codebase-analyzer to find all unused code and dead imports
```

```
Use go-codebase-analyzer to identify code duplication in my project
```

## What It Analyzes

The analyzer checks for 7 types of issues:

1. **Unused Code** - Dead functions, variables, imports, types
2. **Code Duplication** - Similar code blocks, copy-paste code
3. **Tech Debt** - TODOs, FIXMEs, deprecated usage, old patterns
4. **Complexity Issues** - Overly complex functions, god objects
5. **Package Structure** - Circular dependencies, poor organization
6. **Performance Opportunities** - Common inefficiencies, allocations
7. **Modernization** - Outdated patterns, available Go features

## Analysis Process

### Phase 1: Automated Detection

Run these tools to gather raw data:

```bash
# 1. Find unused code
go install honnef.co/go/tools/cmd/staticcheck@latest
staticcheck -f json ./... > analysis/staticcheck.json

# 2. Detect unused exports
go install github.com/kisielk/deadcode@latest
deadcode ./... > analysis/deadcode.txt

# 3. Find code duplication
go install github.com/mibk/dupl@latest
dupl -threshold 50 -files ./... > analysis/dupl.txt

# 4. Check complexity
go install github.com/fzipp/gocyclo/cmd/gocyclo@latest
gocyclo -over 15 . > analysis/gocyclo.txt

# 5. Find TODOs and FIXMEs
grep -r "TODO\|FIXME\|HACK\|XXX" --include="*.go" . > analysis/todos.txt

# 6. Check for deprecated usage
staticcheck -checks SA1019 ./... > analysis/deprecated.txt

# 7. Analyze package dependencies
go mod graph > analysis/deps.txt
```

### Phase 2: Manual Analysis

After gathering data, the AI agent will:

1. Parse all tool outputs
2. Categorize findings
3. Identify patterns
4. Prioritize by impact
5. Suggest specific fixes
6. Estimate effort for each fix

## 1. Unused Code Detection

### What to Look For

**Unused imports:**

```go
// ❌ Import not used anywhere
import (
    "fmt"     // Used
    "strings" // Not used - can be removed
)
```

**Unused variables:**

```go
func processData() {
    result := calculate() // Assigned but never used
    return
}
```

**Unused functions:**

```go
// Nobody calls this function in the entire codebase
func oldHelperFunction() string {
    return "unused"
}
```

**Unused types:**

```go
// Type defined but never instantiated
type ObsoleteConfig struct {
    Setting string
}
```

**Unused constants:**

```go
const (
    ActiveStatus   = "active"   // Used
    PendingStatus  = "pending"  // Used
    ObsoleteStatus = "obsolete" // Never referenced
)
```

### Detection Commands

```bash
# Find unused code
staticcheck ./...

# Find unused exports (public functions/types)
deadcode -test ./...

# Find unused function parameters
go install github.com/mvdan/unparam@latest
unparam ./...

# Check all unused in one go
go install golang.org/x/tools/cmd/godep@latest
godep -u ./...
```

### Analysis Output Format

```markdown
## Unused Code Report

### High Priority (Remove Immediately)

- `pkg/utils/old_helpers.go:45` - Function `FormatDate()` never called (0 references)
- `internal/models/deprecated.go` - Entire file unused (no imports)
- `pkg/cache/memory.go:120` - Type `CacheConfig` never instantiated

### Medium Priority (Review Before Removing)

- `pkg/api/handlers.go:200` - Function `legacyHandler()` has 1 reference in tests only
- `internal/db/migrations.go:80` - Function `rollbackMigration()` might be needed for rollback

### Low Priority (Keep for Now)

- `pkg/errors/types.go:30` - Type `NetworkError` exported but not used externally (API surface)
```

## 2. Code Duplication Detection

### What to Look For

**Exact duplicates:**

```go
// File: user_service.go
func ValidateEmail(email string) bool {
    if len(email) < 3 { return false }
    if !strings.Contains(email, "@") { return false }
    return true
}

// File: admin_service.go (EXACT DUPLICATE)
func ValidateEmail(email string) bool {
    if len(email) < 3 { return false }
    if !strings.Contains(email, "@") { return false }
    return true
}
```

**Similar code blocks (copy-paste with minor changes):**

```go
// Pattern 1: User creation
func CreateUser(name, email string) error {
    if name == "" { return errors.New("name required") }
    if email == "" { return errors.New("email required") }
    user := &User{Name: name, Email: email}
    return db.Save(user)
}

// Pattern 2: Admin creation (90% same)
func CreateAdmin(name, email string) error {
    if name == "" { return errors.New("name required") }
    if email == "" { return errors.New("email required") }
    admin := &Admin{Name: name, Email: email}
    return db.Save(admin)
}
```

**Repeated logic patterns:**

```go
// Repeated in 5 different handlers
if r.Method != http.MethodPost {
    http.Error(w, "method not allowed", http.StatusMethodNotAllowed)
    return
}

// This pattern should be a middleware
```

### Detection Commands

```bash
# Find code duplication
dupl -threshold 50 -files ./...

# Lower threshold for stricter checking
dupl -threshold 30 -files ./...

# Check specific directory
dupl -threshold 50 ./internal/...

# Format as JSON for parsing
dupl -threshold 50 -files -json ./... > dupl-report.json
```

### Refactoring Strategies

**Strategy 1: Extract to Shared Function**

```go
// Before: Duplicated validation
func CreateUser(name, email string) error {
    if name == "" { return errors.New("name required") }
    if email == "" { return errors.New("email required") }
    // ... create user
}

func CreateAdmin(name, email string) error {
    if name == "" { return errors.New("name required") }
    if email == "" { return errors.New("email required") }
    // ... create admin
}

// After: Shared validation
func validateNameEmail(name, email string) error {
    if name == "" { return errors.New("name required") }
    if email == "" { return errors.New("email required") }
    return nil
}

func CreateUser(name, email string) error {
    if err := validateNameEmail(name, email); err != nil {
        return err
    }
    // ... create user
}

func CreateAdmin(name, email string) error {
    if err := validateNameEmail(name, email); err != nil {
        return err
    }
    // ... create admin
}
```

**Strategy 2: Use Generics (Go 1.18+)**

```go
// Before: Duplicate for each type
func FindUserByID(id int) (*User, error) {
    // Query logic
}

func FindProductByID(id int) (*Product, error) {
    // Same query logic
}

// After: Generic function
func FindByID[T any](id int) (*T, error) {
    var result T
    // Generic query logic
    return &result, nil
}
```

**Strategy 3: Interface-Based Abstraction**

```go
// Before: Duplicate CRUD for each type
type UserRepository struct{}
func (r *UserRepository) Create(user *User) error { /* ... */ }
func (r *UserRepository) Get(id int) (*User, error) { /* ... */ }
func (r *UserRepository) Update(user *User) error { /* ... */ }

type ProductRepository struct{}
func (r *ProductRepository) Create(product *Product) error { /* ... */ }
// ... same pattern repeated

// After: Generic repository
type Repository[T any] interface {
    Create(entity *T) error
    Get(id int) (*T, error)
    Update(entity *T) error
    Delete(id int) error
}

type BaseRepository[T any] struct {
    db *sql.DB
    tableName string
}

func (r *BaseRepository[T]) Create(entity *T) error {
    // Shared implementation
}
```

### Duplication Report Format

```markdown
## Code Duplication Report

### Critical Duplicates (Exact Matches)

1. **Email Validation** - Duplicated in 4 files
   - `internal/user/service.go:45` (12 lines)
   - `internal/admin/service.go:80` (12 lines)
   - `pkg/auth/validators.go:23` (12 lines)
   - `internal/api/handlers.go:156` (12 lines)
   - **Fix:** Extract to `pkg/validation/email.go`
   - **Effort:** 30 minutes
   - **Impact:** Remove 36 duplicate lines

2. **Database Error Handling** - Duplicated in 8 files
   - Similar pattern in all repository files
   - **Fix:** Create `pkg/db/errors.go` with shared helper
   - **Effort:** 1 hour
   - **Impact:** Remove ~100 duplicate lines

### High Priority (>80% Similar)

3. **HTTP Handler Boilerplate** - 15 similar handlers
   - All follow same pattern: parse, validate, call service, respond
   - **Fix:** Create handler wrapper/middleware
   - **Effort:** 2 hours
   - **Impact:** Reduce handler code by 50%

### Medium Priority (>60% Similar)

4. **Configuration Loading** - 3 similar implementations
   - **Fix:** Consolidate into shared config package
   - **Effort:** 1 hour
```

## 3. Tech Debt Analysis

### What to Look For

**TODO/FIXME comments:**

```go
// TODO: Add proper error handling here
func processPayment() error {
    // FIXME: This is a temporary hack
    amount := getAmount() * 1.05 // HACK: Adding 5% fee

    // XXX: Remove this before production
    log.Println("Debug info:", amount)

    return nil
}
```

**Deprecated API usage:**

```go
// Using deprecated function
result := ioutil.ReadFile(filename) // Deprecated, use os.ReadFile

// Using deprecated package
import "io/ioutil" // Deprecated since Go 1.16
```

**Old patterns (pre-Go 1.18):**

```go
// Old: Using interface{} everywhere
func Process(data interface{}) error {
    // Type assertions everywhere
}

// Modern: Use generics
func Process[T any](data T) error {
    // Type safe
}
```

**Error handling anti-patterns:**

```go
// ❌ Swallowing errors
result, _ := doSomething()

// ❌ Panic in library code
if err != nil {
    panic(err)
}

// ❌ Generic error messages
return errors.New("error")
```

### Detection Strategy

```bash
# Find TODOs with context
grep -n -r "TODO\|FIXME\|HACK\|XXX" --include="*.go" . | \
    awk -F: '{print $1":"$2" - "$3}' > todos-report.txt

# Find deprecated usage
staticcheck -checks SA1019 ./...

# Find old error handling patterns
grep -r "^\s*_\s*=\s*" --include="*.go" .

# Find panic usage
grep -r "panic(" --include="*.go" . | grep -v "_test.go"

# Find interface{} that could be generics
grep -r "interface{}" --include="*.go" .
```

### Tech Debt Report

```markdown
## Tech Debt Report

### Critical (Fix Before Next Release)

1. **Authentication TODOs** (3 instances)
   - `pkg/auth/jwt.go:45` - TODO: Add token refresh logic
   - `pkg/auth/middleware.go:78` - FIXME: Validate token expiry properly
   - **Risk:** Security vulnerability
   - **Effort:** 4 hours

2. **Database Connection HACK** (1 instance)
   - `internal/db/connection.go:23` - HACK: Using global variable
   - **Risk:** Race conditions, not testable
   - **Effort:** 2 hours

### High Priority

3. **Deprecated ioutil Usage** (23 instances)
   - Using deprecated `ioutil` package throughout codebase
   - **Fix:** Replace with `os` and `io` packages
   - **Effort:** 1 hour (automated with sed/awk)

4. **Error Swallowing** (15 instances)
   - Various places ignoring errors with `_`
   - **Risk:** Silent failures
   - **Effort:** 3 hours

### Medium Priority

5. **Generic Opportunities** (45 instances)
   - `interface{}` usage that could be generics
   - **Benefit:** Type safety, better performance
   - **Effort:** 8 hours

### Low Priority

6. **Old TODO Comments** (80+ instances)
   - Many old TODOs from initial development
   - **Action:** Review and either fix or remove
   - **Effort:** Varies
```

## 4. Complexity Analysis

### What to Look For

**High cyclomatic complexity:**

```go
// ❌ Complexity: 25 (too complex)
func ProcessOrder(order Order) error {
    if order.Type == "standard" {
        if order.Amount > 1000 {
            if order.Customer.Premium {
                // ... nested logic
                if order.PaymentMethod == "credit" {
                    // ... more nesting
                }
            } else {
                // ... alternative path
            }
        }
    } else if order.Type == "express" {
        // ... another branch
    }
    // ... continues
}
```

**Long functions (>50 lines):**

```go
// ❌ 150 lines doing multiple things
func HandleUserRequest(w http.ResponseWriter, r *http.Request) {
    // Parse request (20 lines)
    // Validate (30 lines)
    // Check permissions (25 lines)
    // Database operations (40 lines)
    // Format response (35 lines)
}
```

**God objects (structs with too many methods):**

```go
// ❌ One struct doing everything
type UserService struct {
    db *sql.DB
}

func (s *UserService) CreateUser() {}
func (s *UserService) UpdateUser() {}
func (s *UserService) DeleteUser() {}
func (s *UserService) ValidateUser() {}
func (s *UserService) SendEmail() {}
func (s *UserService) GenerateReport() {}
func (s *UserService) ProcessPayment() {}
func (s *UserService) UploadAvatar() {}
// ... 20 more methods
```

### Detection Commands

```bash
# Find complex functions
gocyclo -over 15 -avg .

# Find long functions
find . -name "*.go" -exec wc -l {} \; | sort -rn

# Or use golocc
go install github.com/hhatto/gocloc/cmd/gocloc@latest
gocloc --by-file .

# Function count per file
grep -r "^func " --include="*.go" . | cut -d: -f1 | uniq -c | sort -rn
```

### Refactoring Strategies

**Strategy 1: Extract Methods**

```go
// Before: One complex function
func ProcessOrder(order Order) error {
    // 100 lines of validation
    // 50 lines of calculation
    // 30 lines of database operations
}

// After: Extracted methods
func ProcessOrder(order Order) error {
    if err := validateOrder(order); err != nil {
        return err
    }

    total := calculateTotal(order)

    if err := saveOrder(order, total); err != nil {
        return err
    }

    return nil
}

func validateOrder(order Order) error { /* ... */ }
func calculateTotal(order Order) decimal.Decimal { /* ... */ }
func saveOrder(order Order, total decimal.Decimal) error { /* ... */ }
```

**Strategy 2: Strategy Pattern for Complexity**

```go
// Before: Complex if/else chains
func ProcessPayment(method string, amount decimal.Decimal) error {
    if method == "credit" {
        // 20 lines of credit card logic
    } else if method == "debit" {
        // 20 lines of debit card logic
    } else if method == "paypal" {
        // 20 lines of PayPal logic
    }
}

// After: Strategy pattern
type PaymentProcessor interface {
    Process(amount decimal.Decimal) error
}

type CreditCardProcessor struct{}
func (p *CreditCardProcessor) Process(amount decimal.Decimal) error { /* ... */ }

type PayPalProcessor struct{}
func (p *PayPalProcessor) Process(amount decimal.Decimal) error { /* ... */ }

func ProcessPayment(processor PaymentProcessor, amount decimal.Decimal) error {
    return processor.Process(amount)
}
```

**Strategy 3: Split God Objects**

```go
// Before: God object
type UserService struct {
    // Does everything
}

// After: Separated concerns
type UserService struct {
    repo     UserRepository
    validator UserValidator
    notifier  Notifier
    reporter  Reporter
}

type UserValidator struct{}
func (v *UserValidator) Validate(user User) error { /* ... */ }

type Notifier struct{}
func (n *Notifier) SendEmail(user User) error { /* ... */ }

type Reporter struct{}
func (r *Reporter) GenerateReport(users []User) (*Report, error) { /* ... */ }
```

### Complexity Report

```markdown
## Complexity Report

### High Complexity Functions (Cyclomatic > 20)

1. `internal/orders/service.go:ProcessOrder()` - Complexity: 28
   - **Issue:** Too many nested conditions
   - **Fix:** Extract validation, calculation, persistence
   - **Effort:** 3 hours

2. `pkg/api/handlers.go:HandleUserRequest()` - Complexity: 24
   - **Issue:** Doing parsing, validation, business logic, response
   - **Fix:** Use middleware for common concerns
   - **Effort:** 2 hours

### Long Functions (>100 lines)

3. `internal/reports/generator.go:GenerateMonthlyReport()` - 185 lines
   - **Fix:** Break into smaller functions
   - **Effort:** 2 hours

### God Objects

4. `internal/user/service.go:UserService` - 25 methods
   - **Issue:** Handling users, emails, reports, payments
   - **Fix:** Split into UserService, EmailService, ReportService
   - **Effort:** 6 hours
```

## 5. Package Structure Analysis

### What to Look For

**Circular dependencies:**

```
package A imports package B
package B imports package C
package C imports package A  // ❌ Circular dependency!
```

**Poor package organization:**

```
project/
├── utils/           # ❌ Avoid generic "utils" packages
│   ├── helpers.go   # Everything goes here
│   ├── misc.go
│   └── stuff.go
├── common/          # ❌ Avoid "common" packages
│   └── shared.go
```

**Package coupling:**

```go
// ❌ Internal package importing from higher-level package
package internal/db
import "myapp/api/handlers" // Wrong direction!
```

### Detection Commands

```bash
# Visualize dependencies
go mod graph | grep mymodule

# Check for circular dependencies
go list -f '{{.ImportPath}}: {{.Imports}}' ./... | grep -A 5 "circular"

# Count package imports
go list -f '{{.ImportPath}} {{len .Imports}}' ./... | sort -k2 -rn

# Find internal imports of higher packages
grep -r "import.*api" ./internal/ --include="*.go"
```

### Refactoring Strategies

**Strategy 1: Dependency Inversion**

```go
// Before: Circular dependency
// package user imports package order
// package order imports package user

// After: Both depend on shared interface
package contracts

type UserService interface {
    GetUser(id string) (*User, error)
}

// package order
type OrderService struct {
    userService contracts.UserService
}

// package user (implements interface)
type UserServiceImpl struct {}
func (s *UserServiceImpl) GetUser(id string) (*User, error) { /* ... */ }
```

**Strategy 2: Better Package Organization**

```go
// Before:
utils/
  ├── string_helpers.go
  ├── time_helpers.go
  ├── validation.go
  └── formatters.go

// After:
pkg/
  ├── stringutil/
  │   └── helpers.go
  ├── timeutil/
  │   └── helpers.go
  ├── validation/
  │   ├── email.go
  │   ├── phone.go
  │   └── date.go
  └── format/
      ├── json.go
      └── csv.go
```

### Package Structure Report

```markdown
## Package Structure Report

### Critical Issues

1. **Circular Dependency Detected**
   - `internal/user` → `internal/order` → `internal/user`
   - **Risk:** Cannot compile in some scenarios
   - **Fix:** Introduce interface layer
   - **Effort:** 4 hours

### High Priority

2. **Utils Package Anti-pattern**
   - `pkg/utils/` contains 45 unrelated functions
   - **Fix:** Split into focused packages (stringutil, timeutil, etc.)
   - **Effort:** 3 hours

3. **Wrong Dependency Direction**
   - `internal/db` imports `pkg/api/models`
   - Should be: `pkg/api` imports `internal/db`
   - **Fix:** Move models to internal or create shared package
   - **Effort:** 2 hours

### Recommendations

4. **Package Naming**
   - Avoid: `utils`, `common`, `helpers`, `misc`
   - Use: Specific names describing functionality
```

## 6. Performance Opportunities

### What to Look For

**Inefficient string operations:**

```go
// ❌ Bad: String concatenation in loop
var result string
for _, s := range items {
    result += s + ", " // N allocations
}

// ✅ Good: Use strings.Builder
var b strings.Builder
for _, s := range items {
    b.WriteString(s)
    b.WriteString(", ")
}
result := b.String()
```

**Unnecessary allocations:**

```go
// ❌ Bad: Growing slice without capacity
var items []Item
for i := 0; i < 10000; i++ {
    items = append(items, Item{}) // Multiple reallocations
}

// ✅ Good: Pre-allocate
items := make([]Item, 0, 10000)
for i := 0; i < 10000; i++ {
    items = append(items, Item{})
}
```

**Inefficient loops:**

```go
// ❌ Bad: Repeated calculation
for i := 0; i < len(expensiveFunction()); i++ {
    // expensiveFunction called every iteration
}

// ✅ Good: Calculate once
n := len(expensiveFunction())
for i := 0; i < n; i++ {
    // ...
}
```

### Detection Strategy

```bash
# Run benchmarks
go test -bench=. -benchmem ./...

# Profile CPU usage
go test -cpuprofile=cpu.prof -bench=.
go tool pprof cpu.prof

# Profile memory
go test -memprofile=mem.prof -bench=.
go tool pprof mem.prof

# Check for inefficient assignments
go install github.com/alexkohler/ineffassign@latest
ineffassign ./...

# Find allocations
go build -gcflags='-m -m' ./... 2>&1 | grep "escapes to heap"
```

### Performance Report

```markdown
## Performance Opportunities

### High Impact

1. **String Concatenation in Loop** (5 instances)
   - `pkg/reports/generator.go:BuildCSV()` - Building large CSV
   - **Fix:** Use strings.Builder
   - **Impact:** 10x faster, 90% less memory
   - **Effort:** 15 minutes

2. **Unbounded Slice Growth** (8 instances)
   - **Fix:** Pre-allocate with make([]T, 0, capacity)
   - **Impact:** Reduce allocations by 50%
   - **Effort:** 30 minutes

### Medium Impact

3. **N+1 Database Queries** (3 locations)
   - `internal/user/repository.go:LoadUsers()` - Loads orders in loop
   - **Fix:** Use JOIN or batch load
   - **Impact:** 100x faster for large datasets
   - **Effort:** 1 hour

4. **JSON Marshal in Hot Path** (4 instances)
   - Marshaling on every request
   - **Fix:** Cache or use sync.Pool
   - **Impact:** 30% faster response time
   - **Effort:** 1 hour
```

## 7. Modernization Opportunities

### What to Look For

**Pre-Go 1.18 patterns:**

```go
// Old: Using interface{} and type assertions
func Max(a, b interface{}) interface{} {
    if a.(int) > b.(int) {
        return a
    }
    return b
}

// Modern: Use generics
func Max[T constraints.Ordered](a, b T) T {
    if a > b {
        return a
    }
    return b
}
```

**Not using new standard library features:**

```go
// Old: Manual multiline string
str := "line1\n" +
      "line2\n" +
      "line3"

// Modern: Use backticks
str := `line1
line2
line3`

// Old: ioutil (deprecated)
data, _ := ioutil.ReadFile("file.txt")

// Modern: os package
data, _ := os.ReadFile("file.txt")
```

**Not using context:**

```go
// Old: No context support
func FetchData() ([]byte, error) {
    resp, err := http.Get(url)
    // ...
}

// Modern: Accept context
func FetchData(ctx context.Context) ([]byte, error) {
    req, _ := http.NewRequestWithContext(ctx, "GET", url, nil)
    resp, err := http.DefaultClient.Do(req)
    // ...
}
```

### Modernization Report

```markdown
## Modernization Opportunities

### Quick Wins (Automated)

1. **Replace deprecated ioutil** (25 instances)
   - `ioutil.ReadFile` → `os.ReadFile`
   - `ioutil.WriteFile` → `os.WriteFile`
   - `ioutil.ReadAll` → `io.ReadAll`
   - **Effort:** 15 minutes (automated with sed)

2. **Update error handling to use errors.Is/As** (40 instances)
   - Still using `err.Error() == "..."`
   - **Fix:** Use `errors.Is()` and `errors.As()`
   - **Effort:** 1 hour

### High Value

3. **Introduce Generics** (15 opportunities)
   - Replace `interface{}` with type parameters
   - **Benefit:** Type safety, no runtime assertions
   - **Effort:** 4 hours

4. **Add Context Support** (30 functions)
   - Many functions don't accept context
   - **Benefit:** Cancellation, timeouts, tracing
   - **Effort:** 3 hours

### Nice to Have

5. **Use sync.Pool for Allocations** (5 opportunities)
   - Frequently allocated objects
   - **Benefit:** Reduce GC pressure
   - **Effort:** 2 hours
```

## Complete Analysis Report

When the AI agent runs a full analysis, it produces a comprehensive report:

```markdown
# Codebase Analysis Report

_Generated: 2024-02-16_
_Project: myapp_
_Total Files: 145 Go files_

## Executive Summary

- **Critical Issues:** 5
- **High Priority:** 12
- **Medium Priority:** 28
- **Low Priority:** 45
- **Estimated Total Effort:** 40 hours
- **Potential Lines Removed:** ~2,500 lines
- **Potential Performance Gain:** 30-50% in key paths

## Prioritized Action Plan

### Week 1 (Critical - 8 hours)

1. Fix authentication TODOs (security risk)
2. Remove circular dependencies (blocking)
3. Fix database connection hack (stability)

### Week 2 (High Priority - 15 hours)

4. Extract duplicated email validation (4 files)
5. Replace deprecated ioutil usage (automated)
6. Fix error swallowing (15 instances)
7. Refactor ProcessOrder complexity

### Week 3 (Medium Priority - 12 hours)

8. Split UserService god object
9. Reorganize utils package
10. Add missing context support
11. Optimize string building in hot paths

### Week 4 (Low Priority - 5 hours)

12. Review and resolve old TODOs
13. Update to use generics where beneficial
14. Add missing documentation

## Detailed Findings

### 1. Unused Code (18 instances)

[Detailed list with file:line references]

### 2. Code Duplication (45 instances)

[Grouped by similarity with refactoring suggestions]

### 3. Tech Debt (90+ instances)

[Categorized by risk level]

### 4. Complexity Issues (12 functions)

[List with cyclomatic complexity scores]

### 5. Package Structure (3 issues)

[Dependency graph and recommended changes]

### 6. Performance (10 opportunities)

[Benchmarks and expected improvements]

### 7. Modernization (25 opportunities)

[Go version features not being used]

## Metrics

### Before

- Total Lines of Code: 15,420
- Cyclomatic Complexity (avg): 8.5
- Duplicate Code: 12%
- Test Coverage: 68%
- Build Time: 45s

### After (Projected)

- Total Lines of Code: 12,900 (-16%)
- Cyclomatic Complexity (avg): 6.2 (-27%)
- Duplicate Code: 3% (-75%)
- Test Coverage: 75% (+7%)
- Build Time: 38s (-15%)

## Next Steps

1. Create GitHub issues for critical items
2. Schedule refactoring sprints
3. Set up automated checks in CI
4. Review progress monthly
```

## Automation Scripts

### Complete Analysis Script

```bash
#!/bin/bash
# codebase-analyzer.sh

echo "🔍 Starting codebase analysis..."

# Create analysis directory
mkdir -p analysis
cd analysis

echo "1️⃣ Finding unused code..."
staticcheck -f json ../... > staticcheck.json 2>&1
deadcode ../... > deadcode.txt 2>&1

echo "2️⃣ Detecting code duplication..."
dupl -threshold 50 -files ../... > dupl.txt 2>&1

echo "3️⃣ Checking complexity..."
gocyclo -over 10 -avg .. > gocyclo.txt 2>&1

echo "4️⃣ Finding tech debt markers..."
grep -r "TODO\|FIXME\|HACK\|XXX" --include="*.go" .. > todos.txt 2>&1

echo "5️⃣ Checking deprecated usage..."
staticcheck -checks SA1019 ../... > deprecated.txt 2>&1

echo "6️⃣ Analyzing dependencies..."
cd ..
go mod graph > analysis/deps.txt
go list -f '{{.ImportPath}}: {{.Imports}}' ./... > analysis/imports.txt

echo "7️⃣ Performance analysis..."
go test -bench=. -benchmem ./... > analysis/benchmarks.txt 2>&1

echo "✅ Analysis complete! Results in ./analysis/"
echo ""
echo "Next steps:"
echo "1. Review critical issues in analysis/staticcheck.json"
echo "2. Check duplicates in analysis/dupl.txt"
echo "3. Address complexity in analysis/gocyclo.txt"
```

### CI Integration

```yaml
# .github/workflows/codebase-analysis.yml
name: Codebase Analysis

on:
  schedule:
    - cron: "0 0 * * 0" # Weekly on Sunday
  workflow_dispatch:

jobs:
  analyze:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - uses: actions/setup-go@v5
        with:
          go-version: "1.22"

      - name: Install analysis tools
        run: |
          go install honnef.co/go/tools/cmd/staticcheck@latest
          go install github.com/kisielk/deadcode@latest
          go install github.com/mibk/dupl@latest
          go install github.com/fzipp/gocyclo/cmd/gocyclo@latest

      - name: Run analysis
        run: |
          mkdir -p analysis
          staticcheck ./... > analysis/staticcheck.txt || true
          deadcode ./... > analysis/deadcode.txt || true
          dupl -threshold 50 ./... > analysis/dupl.txt || true
          gocyclo -over 15 . > analysis/gocyclo.txt || true

      - name: Upload analysis results
        uses: actions/upload-artifact@v3
        with:
          name: analysis-results
          path: analysis/

      - name: Create issue if problems found
        if: failure()
        uses: actions/github-script@v7
        with:
          script: |
            github.rest.issues.create({
              owner: context.repo.owner,
              repo: context.repo.repo,
              title: 'Weekly Codebase Analysis Found Issues',
              body: 'Automated analysis detected code quality issues. Check the workflow artifacts for details.',
              labels: ['tech-debt', 'automated']
            });
```

## Best Practices

### When to Run Analysis

- **Weekly:** Automated scan in CI
- **Before Major Release:** Full manual review
- **After Feature Completion:** Check for new tech debt
- **During Refactoring:** Track improvement progress
- **Onboarding:** Help new devs understand codebase

### How to Prioritize Fixes

**Priority Matrix:**

| Impact | Effort | Priority                                   |
| ------ | ------ | ------------------------------------------ |
| High   | Low    | **Critical** - Do immediately              |
| High   | High   | **High** - Plan for next sprint            |
| Low    | Low    | **Medium** - Quick wins, do when available |
| Low    | High   | **Low** - Defer or skip                    |

**Risk Assessment:**

- **Security issues** → Always critical
- **Circular dependencies** → Blocks scalability
- **High complexity** → Hard to maintain/debug
- **Duplication** → Costs time in every change
- **Unused code** → Confuses developers

### Continuous Improvement

1. **Set Baseline** - Run analysis, record metrics
2. **Define Goals** - Target complexity, duplication, coverage
3. **Regular Reviews** - Weekly/monthly checks
4. **Track Progress** - Chart metrics over time
5. **Celebrate Wins** - Acknowledge improvements

## Summary

**What this skill does:**

- Finds unused code (dead imports, functions, types)
- Detects duplicated code and suggests refactoring
- Identifies tech debt (TODOs, deprecated usage)
- Analyzes complexity and suggests simplification
- Reviews package structure and dependencies
- Spots performance opportunities
- Recommends modernization upgrades

**How to use it:**

1. Run automated analysis tools
2. Ask AI agent to parse results
3. Agent categorizes and prioritizes
4. Agent suggests specific fixes
5. Create issues and plan work

**Expected outcomes:**

- 15-20% code reduction
- 50-75% less duplication
- Better organization
- Improved performance
- Cleaner, more maintainable code
