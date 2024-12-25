---@meta
--- Busted test framework globals and types

-- Global functions
---@type fun(description: string, func: fun()): nil
describe = nil

---@type fun(description: string, func: fun()): nil
it = nil

---@type fun(func: fun()): nil
setup = nil

---@type fun(func: fun()): nil
teardown = nil

---@type fun(func: fun()): nil
before_each = nil

---@type fun(func: fun()): nil
after_each = nil

-- Assertions
---@class BustedAssert
---@field are BustedAre Assertion group for equality checks.
---@field is BustedIs Assertion group for boolean and nil checks.
---@field has BustedHas Assertion group for error checks.
---@field is_equal fun(actual: any, expected: any): nil Alias for equality assertion.
---@field is_nil fun(value: any): nil Alias for nil assertion.
---@field has_error fun(func: fun(), message: string|nil): nil Alias for error assertion.
---@field is_true fun(condition: boolean|nil): nil Alias for true assertion.
---@field is_false fun(condition: boolean|nil): nil Alias for false assertion.

---@class BustedAre
---@field same fun(actual: any, expected: any): nil Asserts that two values are the same.
---@field equal fun(actual: any, expected: any): nil Asserts that two values are equal.
---@field is_equal fun(actual: any, expected: any): nil Alias for equality assertion.

---@class BustedIs
---@field true fun(condition: boolean): nil Asserts that a condition is true.
---@field false fun(condition: boolean): nil Asserts that a condition is false.
---@field nil fun(value: any): nil Asserts that a value is nil.
---@field not_nil fun(value: any): nil Asserts that a value is not nil.
---@field is_true fun(condition: boolean): nil Alias for true assertion.
---@field is_false fun(condition: boolean): nil Alias for false assertion.
---@field is_nil fun(value: any): nil Alias for nil assertion.

---@class BustedHas
---@field error fun(func: fun()): nil Asserts that a function call throws an error.
---@field errors fun(func: fun()): nil Alias for error assertion.
---@field has_error fun(func: fun()): nil Alias for error assertion.
---@field has_no fun(func: fun()): nil Asserts that a function call does not throw an error.

---@type BustedAssert
assert = nil

-- Spies and mocks
---@class BustedSpy
---@field new fun(func: fun()): table Creates a new spy.

---@class BustedMock
---@field new fun(table: table, methods: string[]): table Creates a new mock object.

---@type BustedSpy
spy = nil

---@type BustedMock
mock = nil
