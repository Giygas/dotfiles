---
description: Critical rules for creating mocks in go
---

🚨 TESTING RULES - READ BEFORE WRITING ANY TEST CODE
Critical Mock Rule
If your mock can return values that the real implementation could never return, STOP. You're doing it wrong.
Mock Checklist
Before writing a mock, answer these questions:

❓ Is this an external dependency? (database, API, file system)

✅ YES → Mock it
❌ NO → Test the real implementation

❓ Does your mock have configurable return values? (GetReturn, GetError fields)

✅ YES → 🚨 RED FLAG - Redesign it
❌ NO → Good

❓ Does your mock behave identically to the real implementation?

✅ YES → Good
❌ NO → Fix it or use the real implementation

❓ Would a test pass with your mock but fail with the real implementation?

✅ YES → 🚨 CRITICAL PROBLEM - Fix immediately
❌ NO → Good

Test Checklist

✅ Testing behavior (what the function does) not implementation (how it does it)
✅ Using table-driven tests for multiple scenarios
✅ Testing happy path, edge cases, and error cases
✅ Tests are readable and self-documenting
✅ Using real implementations when possible
✅ Test names describe what they test: TestCreateUser_InvalidEmail_ReturnsError

Anti-Patterns to Avoid
❌ NEVER:

Mock that returns arbitrary configured values
Test that accesses private fields
Mock pure functions or simple calculations
Tests that need updating when you refactor
Single test that doesn't cover edge cases

✅ ALWAYS:

Mock interfaces, not concrete types
Make mocks behave like real implementations
Test observable behavior through public APIs
Cover error cases and edge conditions
Use t.Helper() in test helper functions

Example: Good Mock
go// ✅ GOOD: Realistic in-memory implementation
type FakeUserRepo struct {
users map[string]User
}

func (r \*FakeUserRepo) Get(id string) (User, error) {
user, ok := r.users[id]
if !ok {
return User{}, ErrUserNotFound // Same error as real implementation
}
return user, nil
}
Example: Bad Mock
go// ❌ BAD: Can return anything you configure
type MockUserRepo struct {
GetReturn User
GetError error
}

func (m \*MockUserRepo) Get(id string) (User, error) {
return m.GetReturn, m.GetError // Can return impossible states!
}
Quick Fix Workflow
If you realize your mock is wrong:

Identify what the real implementation ACTUALLY does
Make the mock do exactly that
If you need to test error cases, make the mock fail the same way the real implementation fails

Example:
go// Real implementation always returns 400 with specific JSON
// Mock should do the SAME THING, not return configurable responseCode/responseBody

// ❌ WRONG
func (m *MockHandler) ServeError(w http.ResponseWriter, r *http.Request) {
w.WriteHeader(m.responseCode) // Configurable - WRONG!
w.Write([]byte(m.responseBody))
}

// ✅ CORRECT
func (m *MockHandler) ServeError(w http.ResponseWriter, r *http.Request) {
w.WriteHeader(http.StatusBadRequest) // Always 400 - matches real implementation
json.NewEncoder(w).Encode(map[string]interface{}{
"error": "Bad Request",
"message": "CIP path parameter is required",
"code": 400,
})
}

TL;DR for AI Agents
When you're about to write test code, STOP and ask:

Should I mock this? (Only if external dependency)
Does my mock mirror reality? (Must behave identically)
Am I testing behavior? (Not implementation details)

If any answer is wrong, fix it before proceeding.
