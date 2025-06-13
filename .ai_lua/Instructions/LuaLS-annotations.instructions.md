---
applyTo: '**/*.lua'
---
# Lua Type Annotations

## Overview

Lua type annotations add context and type checking. Prefix annotations with `---` (a comment with an extra dash).

## Basic Example

```lua
---@alias MyCustomType integer

---Calculate a value using MyCustomType
---@param x MyCustomType
function calculate(x) end
```

## Core Annotations

### @param

Defines a function parameter’s type.

```lua
---@param name string Description
function myFunc(name) end
```

### @return

Defines return type(s) for a function.

```lua
---@return boolean # If successful
function myFunc() end
```

### @class

Describes a table as a class with fields. Supports inheritance.

```lua
---@class Person
---@field name string
---@field age number
local Person = {}

---@class Employee : Person
---@field salary number
local Employee = {}
```

#### Example Usage

```lua
---@param p Person
function greet(p)
    print("Hello, " .. p.name)
end

---@param e Employee
function showSalary(e)
    print(e.name .. " earns " .. e.salary)
end

local john = { name = "John", age = 30 }
greet(john)

local alice = { name = "Alice", age = 25, salary = 50000 }
showSalary(alice)
```

### @field

Defines fields within a class.

```lua
---@field key string Description
```

### @alias

Create a custom type or enum.

```lua
---@alias UserID integer
---@alias Mode "r" | "w"
```

### @type

Assigns a type to a variable.

```lua
---@type string[]
local names
```

### @generic

Defines generics for functions and tables. Supports backticks to capture and return types.

```lua
---@generic T
---@param x T
---@return T
function identity(x) end

---@class Vehicle
local Vehicle = {}
function Vehicle:drive() end

---@generic T
---@param class `T` # Captures the type
---@return T
function new(class) end

-- Example
local car = new("Vehicle") -- car is Vehicle
car:drive()
```

### @enum

Marks a table as an enum.

```lua
---@enum Colors
local Colors = { Red = 1, Blue = 2 }
```

### @cast

Casts a variable to a type.

```lua
---@cast x string
```

### @async

Marks a function as asynchronous.

```lua
---@async
function fetchData() end
```

### @nodiscard

Warn if return value is ignored. Only warns if **all return values are discarded**.

```lua
---@nodiscard
---@return string, boolean
function importantCall() end

local a, b = importantCall() -- This is fine
local a = importantCall()    -- This is fine
importantCall()              -- Warning if @nodiscard

local result = importantCall() -- This is fine
importantCall() -- Warning if @nodiscard is applied
```

### @overload

Define multiple function signatures.

```lua
---@overload fun(x: string): boolean
function foo(x) end
```

### @as

Force a type onto an expression.

```lua
local x = nil
doSomething(x --[[@as string]])
```

### @meta

Marks a file as a meta file, used for definitions, not functional Lua code.

```lua
---@meta
```

### @package

Marks a function as private to the file. Cannot be accessed from another file.

```lua
---@package
local function secret() end
```

### @private and @protected

Define access modifiers for class fields or methods.

```lua
---@class Animal
---@field private eyes integer
---@field protected legs integer
```

### @operator

Provides type declarations for metamethod operators like `+`, `-`, `call`, etc.

```lua
---@class Vector
---@operator add(Vector): Vector
```

## Common Type Patterns

| Pattern                    | Description     |
| -------------------------- | --------------- |
| `TYPE_1 \| TYPE_2`         | Union Type      |
| `VALUE_TYPE[]`             | Array           |
| `[TYPE_1, TYPE_2]`         | Tuple           |
| `{[string]: TYPE}`         | Dictionary      |
| `table<K, V>`              | Key-Value Table |
| `{key1: TYPE, ...}`        | Table literal   |
| `fun(PARAM: TYPE): RETURN` | Function Type   |

### Examples for Common Type Patterns

#### Union Type

```lua
---@param value string | number
function printValue(value)
    print(value)
end
```

#### Array

```lua
---@type string[]
local names = {"Alice", "Bob", "Charlie"}
```

#### Tuple

```lua
---@type [string, number]
local person = {"Alice", 30}
```

#### Dictionary

```lua
---@type { [string]: number }
local scores = { Alice = 100, Bob = 90 }
```

#### Key-Value Table

```lua
---@type table<string, boolean>
local isActive = { Alice = true, Bob = false }
```

#### Table Literal

```lua
---@type { name: string, age: number }
local person = { name = "Alice", age = 30 }
```

#### Function Type

```lua
---@type fun(x: number, y: number, z?: string): number
local add = function(x, y, z)
    if z then
        print(z)
    end
    return x + y
end
```

## Advanced Notes

- `?` after a type means `nil` is allowed, e.g., `boolean?` is `boolean | nil`.
- Parentheses sometimes needed for unions: `(string | number)[]`.
