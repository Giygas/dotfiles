# Essential Development Patterns - Core Knowledge Base

## Error Handling Pattern

**ALWAYS** handle errors gracefully:

**TypeScript:**
```typescript
try {
  const result = await riskyOperation();
  return { success: true, data: result };
} catch (error) {
  console.error("Operation failed:", error);
  return { success: false, error: error.message };
}
```

**Python:**
```python
try:
    result = await risky_operation()
    return {"success": True, "data": result}
except Exception as error:
    print(f"Operation failed: {error}")
    return {"success": False, "error": str(error)}
```

**Go:**
```go
result, err := riskyOperation()
if err != nil {
    log.Printf("Operation failed: %v", err)
    return Response{Success: false, Error: err.Error()}
}
return Response{Success: true, Data: result}
```

## Validation Pattern

**ALWAYS** validate input data:

**TypeScript:**
```typescript
function validateInput(input: any): { valid: boolean; errors?: string[] } {
  const errors: string[] = [];

  if (!input) errors.push("Input is required");
  if (typeof input !== "string") errors.push("Input must be a string");
  if (input.length < 3) errors.push("Input must be at least 3 characters");

  return {
    valid: errors.length === 0,
    errors: errors.length > 0 ? errors : undefined,
  };
}
```

**Python:**
```python
def validate_input(input_data: any) -> dict:
    errors = []
    
    if not input_data:
        errors.append("Input is required")
    if not isinstance(input_data, str):
        errors.append("Input must be a string")
    if len(input_data) < 3:
        errors.append("Input must be at least 3 characters")
    
    return {
        "valid": len(errors) == 0,
        "errors": errors if errors else None
    }
```

**Go:**
```go
type ValidationResult struct {
    Valid  bool
    Errors []string
}

func validateInput(input interface{}) ValidationResult {
    var errors []string
    
    if input == nil {
        errors = append(errors, "Input is required")
    }
    
    if str, ok := input.(string); ok {
        if len(str) < 3 {
            errors = append(errors, "Input must be at least 3 characters")
        }
    } else {
        errors = append(errors, "Input must be a string")
    }
    
    return ValidationResult{
        Valid:  len(errors) == 0,
        Errors: errors,
    }
}
```

## Logging Pattern

**USE** consistent logging levels:

**TypeScript:**
```typescript
// Debug information (development only)
console.debug("Processing request:", requestId);

// Info for important events
console.info("User authenticated:", userId);

// Warning for potential issues
console.warn("Rate limit approaching for user:", userId);

// Error for failures
console.error("Database connection failed:", error);
```

**Python:**
```python
import logging

logger = logging.getLogger(__name__)

# Debug information (development only)
logger.debug("Processing request: %s", request_id)

# Info for important events
logger.info("User authenticated: %s", user_id)

# Warning for potential issues
logger.warning("Rate limit approaching for user: %s", user_id)

# Error for failures
logger.error("Database connection failed: %s", error)
```

**Go:**
```go
import "log"

// Debug information (development only)
log.Printf("DEBUG: Processing request: %s", requestID)

// Info for important events
log.Printf("INFO: User authenticated: %s", userID)

// Warning for potential issues
log.Printf("WARNING: Rate limit approaching for user: %s", userID)

// Error for failures
log.Printf("ERROR: Database connection failed: %v", err)
```

## Security Pattern

**NEVER** expose sensitive information:

**TypeScript:**
```typescript
// ❌ BAD: Exposing internal errors
return { error: "Internal server error: " + error.message };

// ✅ GOOD: Generic error message
return { error: "An unexpected error occurred. Please try again." };
```

**Python:**
```python
# ❌ BAD: Exposing internal errors
return {"error": f"Internal server error: {str(error)}"}

# ✅ GOOD: Generic error message
return {"error": "An unexpected error occurred. Please try again."}
```

**Go:**
```go
// ❌ BAD: Exposing internal errors
return Response{Error: "Internal server error: " + err.Error()}

// ✅ GOOD: Generic error message
return Response{Error: "An unexpected error occurred. Please try again."}
```

## File System Safety Pattern

**ALWAYS** validate file paths:

**TypeScript:**
```typescript
import path from "path";

function safeReadFile(userPath: string): string | null {
  const resolvedPath = path.resolve(userPath);
  const allowedDir = path.resolve("./allowed-directory");

  // Ensure path is within allowed directory
  if (!resolvedPath.startsWith(allowedDir)) {
    throw new Error("Access denied: Invalid path");
  }

  return fs.readFileSync(resolvedPath, "utf8");
}
```

**Python:**
```python
import os
from pathlib import Path

def safe_read_file(user_path: str) -> str:
    resolved_path = Path(user_path).resolve()
    allowed_dir = Path("./allowed-directory").resolve()
    
    # Ensure path is within allowed directory
    try:
        resolved_path.relative_to(allowed_dir)
    except ValueError:
        raise PermissionError("Access denied: Invalid path")
    
    return resolved_path.read_text()
```

**Go:**
```go
import (
    "filepath"
    "os"
    "strings"
)

func safeReadFile(userPath string) (string, error) {
    resolvedPath, err := filepath.Abs(userPath)
    if err != nil {
        return "", err
    }
    
    allowedDir, err := filepath.Abs("./allowed-directory")
    if err != nil {
        return "", err
    }
    
    // Ensure path is within allowed directory
    if !strings.HasPrefix(resolvedPath, allowedDir) {
        return "", fmt.Errorf("access denied: invalid path")
    }
    
    data, err := os.ReadFile(resolvedPath)
    return string(data), err
}
```

## Type Safety Pattern

**ALWAYS** use strict types:

**TypeScript:**
```typescript
interface User {
  id: string;
  name: string;
  email: string;
  createdAt: Date;
}

interface ApiResponse<T> {
  success: boolean;
  data?: T;
  error?: string;
}

// Use generics for type-safe responses
function createUser(
  userData: Omit<User, "id" | "createdAt">,
): ApiResponse<User> {
  // Implementation
}
```

**Python:**
```python
from dataclasses import dataclass
from typing import Optional, Generic, TypeVar
from datetime import datetime

T = TypeVar('T')

@dataclass
class User:
    id: str
    name: str
    email: str
    created_at: datetime

@dataclass
class ApiResponse(Generic[T]):
    success: bool
    data: Optional[T] = None
    error: Optional[str] = None

# Use type hints for type-safe responses
def create_user(user_data: dict) -> ApiResponse[User]:
    # Implementation
    pass
```

**Go:**
```go
type User struct {
    ID        string    `json:"id"`
    Name      string    `json:"name"`
    Email     string    `json:"email"`
    CreatedAt time.Time `json:"created_at"`
}

type ApiResponse[T any] struct {
    Success bool        `json:"success"`
    Data    *T          `json:"data,omitempty"`
    Error   string      `json:"error,omitempty"`
}

// Use generics for type-safe responses (Go 1.18+)
func CreateUser[T any](userData T) ApiResponse[T] {
    // Implementation
    return ApiResponse[T]{Success: true}
}
```

## Async Pattern

**ALWAYS** handle async operations properly:

**TypeScript:**
```typescript
// ❌ BAD: Nested promises
fetchUser().then((user) => {
  return fetchPosts(user.id).then((posts) => {
    return { user, posts };
  });
});

// ✅ GOOD: Async/await with error handling
async function getUserWithPosts(userId: string) {
  try {
    const user = await fetchUser(userId);
    const posts = await fetchPosts(user.id);
    return { user, posts };
  } catch (error) {
    console.error("Failed to fetch user data:", error);
    throw error;
  }
}
```

**Python:**
```python
import asyncio

# ❌ BAD: Nested callbacks
def fetch_user_callback(user):
    def fetch_posts_callback(posts):
        return {"user": user, "posts": posts}
    return fetch_posts(user["id"], callback=fetch_posts_callback)

fetch_user(callback=fetch_user_callback)

# ✅ GOOD: Async/await with error handling
async def get_user_with_posts(user_id: str):
    try:
        user = await fetch_user(user_id)
        posts = await fetch_posts(user["id"])
        return {"user": user, "posts": posts}
    except Exception as error:
        print(f"Failed to fetch user data: {error}")
        raise
```

**Go:**
```go
// ❌ BAD: Nested goroutines without proper error handling
func getUserWithPostsBad(userID string) (*UserWithPosts, error) {
    var user User
    var posts []Post
    
    done := make(chan bool, 2)
    
    go func() {
        var err error
        user, err = fetchUser(userID)
        if err != nil {
            done <- false
            return
        }
        done <- true
    }()
    
    go func() {
        var err error
        posts, err = fetchPosts(userID)
        if err != nil {
            done <- false
            return
        }
        done <- true
    }()
    
    // Missing proper error handling and synchronization
    return &UserWithPosts{User: user, Posts: posts}, nil
}

// ✅ GOOD: Proper goroutine usage with error handling
func getUserWithPosts(userID string) (*UserWithPosts, error) {
    var user User
    var posts []Post
    var userErr, postsErr error
    
    var wg sync.WaitGroup
    wg.Add(2)
    
    go func() {
        defer wg.Done()
        user, userErr = fetchUser(userID)
    }()
    
    go func() {
        defer wg.Done()
        posts, postsErr = fetchPosts(userID)
    }()
    
    wg.Wait()
    
    if userErr != nil {
        return nil, fmt.Errorf("failed to fetch user: %w", userErr)
    }
    if postsErr != nil {
        return nil, fmt.Errorf("failed to fetch posts: %w", postsErr)
    }
    
    return &UserWithPosts{User: user, Posts: posts}, nil
}
```

## Configuration Pattern

**ALWAYS** use environment variables for configuration:

**TypeScript:**
```typescript
// config.ts
export const config = {
  port: parseInt(process.env.PORT || "3000"),
  databaseUrl: process.env.DATABASE_URL,
  jwtSecret: process.env.JWT_SECRET,
  nodeEnv: process.env.NODE_ENV || "development",
};

// Validate required config
if (!config.databaseUrl) {
  throw new Error("DATABASE_URL environment variable is required");
}
```

**Python:**
```python
import os
from typing import Optional

class Config:
    def __init__(self):
        self.port = int(os.getenv("PORT", "3000"))
        self.database_url = os.getenv("DATABASE_URL")
        self.jwt_secret = os.getenv("JWT_SECRET")
        self.node_env = os.getenv("NODE_ENV", "development")
        
        # Validate required config
        if not self.database_url:
            raise ValueError("DATABASE_URL environment variable is required")

config = Config()
```

**Go:**
```go
import (
    "os"
    "strconv"
)

type Config struct {
    Port        int
    DatabaseURL string
    JWTSecret   string
    NodeEnv     string
}

func NewConfig() (*Config, error) {
    databaseURL := os.Getenv("DATABASE_URL")
    if databaseURL == "" {
        return nil, fmt.Errorf("DATABASE_URL environment variable is required")
    }
    
    port, err := strconv.Atoi(os.Getenv("PORT"))
    if err != nil {
        port = 3000 // default
    }
    
    return &Config{
        Port:        port,
        DatabaseURL: databaseURL,
        JWTSecret:   os.Getenv("JWT_SECRET"),
        NodeEnv:     getEnv("NODE_ENV", "development"),
    }, nil
}

func getEnv(key, defaultValue string) string {
    if value := os.Getenv(key); value != "" {
        return value
    }
    return defaultValue
}
```

## Testing Pattern

**ALWAYS** write testable code:

**TypeScript:**
```typescript
// ❌ BAD: Hard to test
export function processPayment(amount: number) {
  const apiKey = process.env.STRIPE_KEY;
  // Direct API call
}

// ✅ GOOD: Dependency injection
export interface PaymentService {
  processPayment(amount: number): Promise<boolean>;
}

export function createPaymentProcessor(service: PaymentService) {
  return {
    async process(amount: number) {
      return service.processPayment(amount);
    },
  };
}
```

**Python:**
```python
# ❌ BAD: Hard to test
def process_payment(amount: float):
    api_key = os.getenv("STRIPE_KEY")
    # Direct API call
    pass

# ✅ GOOD: Dependency injection
from abc import ABC, abstractmethod

class PaymentService(ABC):
    @abstractmethod
    async def process_payment(self, amount: float) -> bool:
        pass

class PaymentProcessor:
    def __init__(self, service: PaymentService):
        self.service = service
    
    async def process(self, amount: float) -> bool:
        return await self.service.process_payment(amount)
```

**Go:**
```go
// ❌ BAD: Hard to test
func ProcessPayment(amount float64) error {
    apiKey := os.Getenv("STRIPE_KEY")
    // Direct API call
    return nil
}

// ✅ GOOD: Dependency injection
type PaymentService interface {
    ProcessPayment(amount float64) error
}

type PaymentProcessor struct {
    service PaymentService
}

func NewPaymentProcessor(service PaymentService) *PaymentProcessor {
    return &PaymentProcessor{service: service}
}

func (p *PaymentProcessor) Process(amount float64) error {
    return p.service.ProcessPayment(amount)
}
```

## Documentation Pattern

**ALWAYS** document complex logic:

**TypeScript:**
```typescript
/**
 * Calculates the total price including tax and discounts
 * @param basePrice - The original price before modifications
 * @param taxRate - Tax rate as decimal (e.g., 0.08 for 8%)
 * @param discountPercent - Discount percentage (0-100)
 * @returns The final price after tax and discount
 */
function calculateTotalPrice(
  basePrice: number,
  taxRate: number = 0.08,
  discountPercent: number = 0,
): number {
  const discountAmount = basePrice * (discountPercent / 100);
  const discountedPrice = basePrice - discountAmount;
  const taxAmount = discountedPrice * taxRate;
  return discountedPrice + taxAmount;
}
```

**Python:**
```python
def calculate_total_price(
    base_price: float,
    tax_rate: float = 0.08,
    discount_percent: float = 0,
) -> float:
    """
    Calculates the total price including tax and discounts.
    
    Args:
        base_price: The original price before modifications
        tax_rate: Tax rate as decimal (e.g., 0.08 for 8%)
        discount_percent: Discount percentage (0-100)
        
    Returns:
        The final price after tax and discount
    """
    discount_amount = base_price * (discount_percent / 100)
    discounted_price = base_price - discount_amount
    tax_amount = discounted_price * tax_rate
    return discounted_price + tax_amount
```

**Go:**
```go
// CalculateTotalPrice calculates the total price including tax and discounts.
//
// Parameters:
//   - basePrice: The original price before modifications
//   - taxRate: Tax rate as decimal (e.g., 0.08 for 8%)
//   - discountPercent: Discount percentage (0-100)
//
// Returns:
//   The final price after tax and discount
func CalculateTotalPrice(basePrice, taxRate, discountPercent float64) float64 {
    discountAmount := basePrice * (discountPercent / 100)
    discountedPrice := basePrice - discountAmount
    taxAmount := discountedPrice * taxRate
    return discountedPrice + taxAmount
}
```

## Performance Pattern

**AVOID** unnecessary operations in loops:

**TypeScript:**
```typescript
// ❌ BAD: Repeated calculations
const results = [];
for (let i = 0; i < items.length; i++) {
  results.push(items[i] * calculateTax(items[i])); // calculateTax called repeatedly
}

// ✅ GOOD: Pre-calculate or cache
const results = [];
const taxRate = getCurrentTaxRate(); // Calculate once
for (let i = 0; i < items.length; i++) {
  results.push(items[i] * taxRate);
}
```

**Python:**
```python
# ❌ BAD: Repeated calculations
results = []
for item in items:
    results.append(item * calculate_tax(item))  # calculate_tax called repeatedly

# ✅ GOOD: Pre-calculate or cache
results = []
tax_rate = get_current_tax_rate()  # Calculate once
for item in items:
    results.append(item * tax_rate)
```

**Go:**
```go
// ❌ BAD: Repeated calculations
var results []float64
for _, item := range items {
    results = append(results, item*calculateTax(item)) // calculateTax called repeatedly
}

// ✅ GOOD: Pre-calculate or cache
var results []float64
taxRate := getCurrentTaxRate() // Calculate once
for _, item := range items {
    results = append(results, item*taxRate)
}
```

## Code Organization Pattern

**KEEP** functions focused and small:

**TypeScript:**
```typescript
// ❌ BAD: One function doing too much
function processOrder(orderData) {
  // Validate input
  // Calculate pricing
  // Save to database
  // Send email
  // Log analytics
}

// ✅ GOOD: Separated concerns
function validateOrder(orderData) {
  /* validation logic */
}
function calculatePricing(orderData) {
  /* pricing logic */
}
function saveOrder(orderData) {
  /* database logic */
}
function sendConfirmation(orderData) {
  /* email logic */
}
function logAnalytics(orderData) {
  /* analytics logic */
}

async function processOrder(orderData) {
  validateOrder(orderData);
  const pricing = calculatePricing(orderData);
  await saveOrder({ ...orderData, pricing });
  await sendConfirmation(orderData);
  logAnalytics(orderData);
}
```

**Python:**
```python
# ❌ BAD: One function doing too much
def process_order(order_data):
    # Validate input
    # Calculate pricing
    # Save to database
    # Send email
    # Log analytics
    pass

# ✅ GOOD: Separated concerns
def validate_order(order_data):
    """validation logic"""
    pass

def calculate_pricing(order_data):
    """pricing logic"""
    pass

def save_order(order_data):
    """database logic"""
    pass

def send_confirmation(order_data):
    """email logic"""
    pass

def log_analytics(order_data):
    """analytics logic"""
    pass

async def process_order(order_data):
    validate_order(order_data)
    pricing = calculate_pricing(order_data)
    await save_order({**order_data, "pricing": pricing})
    await send_confirmation(order_data)
    log_analytics(order_data)
```

**Go:**
```go
// ❌ BAD: One function doing too much
func processOrder(orderData Order) error {
    // Validate input
    // Calculate pricing
    // Save to database
    // Send email
    // Log analytics
    return nil
}

// ✅ GOOD: Separated concerns
func validateOrder(orderData Order) error {
    // validation logic
    return nil
}

func calculatePricing(orderData Order) Pricing {
    // pricing logic
    return Pricing{}
}

func saveOrder(orderData Order) error {
    // database logic
    return nil
}

func sendConfirmation(orderData Order) error {
    // email logic
    return nil
}

func logAnalytics(orderData Order) {
    // analytics logic
}

func processOrder(orderData Order) error {
    if err := validateOrder(orderData); err != nil {
        return err
    }
    
    pricing := calculatePricing(orderData)
    orderWithPricing := Order{...orderData, Pricing: pricing}
    
    if err := saveOrder(orderWithPricing); err != nil {
        return err
    }
    
    if err := sendConfirmation(orderWithPricing); err != nil {
        return err
    }
    
    logAnalytics(orderWithPricing)
    return nil
}
```
