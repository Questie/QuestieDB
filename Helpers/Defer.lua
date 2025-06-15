---@class LibQuestieDB
local LibQuestieDB = select(2, ...)
-- This file contains the Defer function, which allows you to schedule a function to be executed
-- Inspired by golangs defer function
local l_C_After = C_Timer.After
-- C_After = C_Timer.After

-- The old Defer function (lines 8-12 in the original selection) should be replaced by the following block:
do
  ---@type fun()[]
  local deferred_queue = {}
  ---@type boolean
  local is_processing_scheduled = false -- True if a C_After call is pending or processing

  ---@package
  local function process_deferred_queue()
    -- This function is called by C_After.
    -- Take a snapshot of the current queue.
    local q_to_process = deferred_queue
    -- Reset the main queue to collect new Defer calls that might happen
    -- during the execution of functions in q_to_process.
    deferred_queue = {}

    for i = 1, #q_to_process do
      local success, err = pcall(q_to_process[i])
      if not success then
        -- You can customize error handling, e.g., log to a specific addon channel
        print("Error in deferred function: " .. tostring(err))
      end
    end

    -- After processing the snapshot, check if new items were added to deferred_queue
    -- (e.g., by one of the functions in q_to_process calling Defer).
    if #deferred_queue > 0 then
      -- New items exist, schedule another C_After for them.
      -- is_processing_scheduled remains true as we are ensuring the chain continues.
      l_C_After(0, process_deferred_queue)
    else
      -- The queue (that collected items *during* processing) is empty.
      -- No more processing needed for now from this chain, so mark as not scheduled.
      is_processing_scheduled = false
    end
  end

  --- ! WARNING THIS IS RACE CONDITION HEAVEN, MAKE SURE THAT A DELAY IS SAFE
  --- Execute the provided function on the next frame.
  --- Functions are executed in FIFO (First-In, First-Out) order.
  ---@param func fun() The function to execute. It should take no arguments.
  Defer = function(func)
    if type(func) ~= "function" then
      print("Defer Error: Argument must be a function. Got type: " .. type(func))
      return
    end

    table.insert(deferred_queue, func)

    if not is_processing_scheduled then
      is_processing_scheduled = true
      l_C_After(0, process_deferred_queue)
    end
  end
  LibQuestieDB.Defer = Defer -- Expose Defer in the global LibQuestieDB table
end



--------------------------------------------------------------------------------
--- Test Suite for Defer Function
--- This suite tests the Defer function to ensure it behaves correctly under various conditions.
--- It includes tests for:
--- 1. Basic deferral of a single function.
--- 2. Order of execution (FIFO).
--- 3. Argument validation (ensuring only functions are accepted).
--- 4. Nested Defer calls.
--- 5. Error handling in deferred functions.
--- 6. Rapid succession of Defer calls.
--- 7. Defer called from within a C_Timer.After callback.
--- 8. Complex nested Defer with multiple levels.
--- 9. Ensure queue is empty before new Defer schedules processing.
--- 10. Indirectly test is_processing_scheduled logic.
--- 11. Complex nested Defer with multiple levels and outer deferrals.
--- 12. Ensure queue is empty before new Defer schedules processing.
--- --- Note: This test suite uses a mock for the print function to capture output messages.
--- --- It also uses C_Timer.After to simulate delays and ensure deferred functions execute correctly.
--- --------------------------------------------------------------------------------

---@class TestDefinitionTableDefer { [testName: string]: fun(done_callback: fun()) }
---@type TestDefinitionTableDefer
local tests = {}
---@type string
local current_test_name = ""
---@type number
local assertions_made = 0
---@type number
local assertions_failed = 0

-- Store original functions to mock and restore
local original_C_Timer_After = C_Timer.After
local original_print = print --[[@as fun(...:any)]]
---@type string[]
local mock_print_messages = {}

---@param actual any
---@param expected any
---@param message string
---@return boolean
local function assert_equal(actual, expected, message)
  assertions_made = assertions_made + 1
  if actual ~= expected then
    original_print(string.format("Test '%s' FAILED: %s. Expected '%s', got '%s'", current_test_name, message, tostring(expected), tostring(actual)))
    assertions_failed = assertions_failed + 1
    return false
  end
  -- original_print(string.format("Test '%s' PASSED assertion: %s.", current_test_name, message)) -- Optional: for verbose pass messages
  return true
end

---@param condition any
---@param message string
---@return boolean
local function assert_true(condition, message)
  assertions_made = assertions_made + 1
  if not condition then
    original_print(string.format("Test '%s' FAILED: %s. Condition was false.", current_test_name, message))
    assertions_failed = assertions_failed + 1
    return false
  end
  -- original_print(string.format("Test '%s' PASSED assertion: %s.", current_test_name, message)) -- Optional: for verbose pass messages
  return true
end

---@param ... any
local function mock_print(...)
  local args = { ..., }
  local message_parts = {}
  for i = 1, #args do
    table.insert(message_parts, tostring(args[i]))
  end
  table.insert(mock_print_messages, table.concat(message_parts, "\t"))
  -- original_print("[MOCK_PRINT]", table.concat(message_parts, "\t")) -- For debugging the mock itself
end

local function setup_test_environment()
  mock_print_messages = {}
  _G.print = mock_print -- Mock global print
end

local function restore_test_environment()
  _G.print = original_print
end

--------------------------------------------------------------------------------
-- Test Cases
--------------------------------------------------------------------------------

tests["1. Basic Deferral: Single function executes"] = function(done_callback)
  local executed = false
  Defer(function()
    executed = true
  end)

  original_C_Timer_After(0.05, function() -- Wait a bit for the deferred function
    assert_true(executed, "Deferred function should have executed")
    done_callback()
  end)
end

tests["2. Order of Execution (FIFO)"] = function(done_callback)
  ---@type number[]
  local execution_order = {}
  Defer(function() table.insert(execution_order, 1) end)
  Defer(function() table.insert(execution_order, 2) end)
  Defer(function() table.insert(execution_order, 3) end)

  original_C_Timer_After(0.05, function()
    assert_equal(#execution_order, 3, "Should be 3 functions executed")
    if #execution_order == 3 then
      assert_equal(execution_order[1], 1, "First function executed first")
      assert_equal(execution_order[2], 2, "Second function executed second")
      assert_equal(execution_order[3], 3, "Third function executed third")
    end
    done_callback()
  end)
end

tests["3. Argument Validation: Non-function argument (string)"] = function(done_callback)
  mock_print_messages = {} -- Clear before test
  ---@diagnostic disable-next-line: param-type-mismatch
  Defer("not a function")

  original_C_Timer_After(0.05, function()
    assert_equal(#mock_print_messages, 1, "Should be one print message for error")
    if #mock_print_messages > 0 then
      assert_true(string.find(mock_print_messages[1], "Defer Error: Argument must be a function. Got type: string") ~= nil,
                  "Error message for non-function (string) argument is incorrect. Got: " .. (mock_print_messages[1] or "nil"))
    end
    done_callback()
  end)
end

tests["4. Argument Validation: Nil argument"] = function(done_callback)
  mock_print_messages = {}
  ---@diagnostic disable-next-line: param-type-mismatch
  Defer(nil) --[[@as any]]

  original_C_Timer_After(0.05, function()
    assert_equal(#mock_print_messages, 1, "Should be one print message for nil error")
    if #mock_print_messages > 0 then
      assert_true(string.find(mock_print_messages[1], "Defer Error: Argument must be a function. Got type: nil") ~= nil,
                  "Error message for nil argument is incorrect. Got: " .. (mock_print_messages[1] or "nil"))
    end
    done_callback()
  end)
end

tests["5. Nested Defer Calls"] = function(done_callback)
  ---@type string[]
  local execution_order = {}
  Defer(function()
    table.insert(execution_order, "outer1_start")
    Defer(function()
      table.insert(execution_order, "inner1")
    end)
    table.insert(execution_order, "outer1_end")
  end)
  Defer(function()
    table.insert(execution_order, "outer2")
  end)

  -- Expected order: outer1_start, outer1_end, outer2, then inner1 (processed in a subsequent cycle)
  original_C_Timer_After(0.1, function()
    assert_equal(#execution_order, 4, "Nested: Should be 4 entries in execution_order")
    if #execution_order == 4 then
      assert_equal(execution_order[1], "outer1_start", "Nested: Step 1")
      assert_equal(execution_order[2], "outer1_end", "Nested: Step 2")
      assert_equal(execution_order[3], "outer2", "Nested: Step 3")
      assert_equal(execution_order[4], "inner1", "Nested: Step 4 - inner function runs after current batch")
    end
    done_callback()
  end)
end

tests["6. Error Handling: Error in one deferred function"] = function(done_callback)
  ---@type table<string, boolean>
  local execution_flags = {
    before_error = false,
    after_error = false,
  }
  mock_print_messages = {}

  Defer(function()
    execution_flags.before_error = true
  end)
  Defer(function()
    error("Simulated error in deferred function")
  end)
  Defer(function()
    execution_flags.after_error = true
  end)

  original_C_Timer_After(0.1, function()
    assert_true(execution_flags.before_error, "Function before error should execute")
    assert_true(execution_flags.after_error, "Function after error should execute")
    assert_equal(#mock_print_messages, 1, "Should be one print message for the error")
    if #mock_print_messages > 0 then
      -- Lua 5.1 error messages might be slightly different from modern Lua.
      -- The important part is "Error in deferred function:" and the "Simulated error" part.
      assert_true(string.find(mock_print_messages[1], "Error in deferred function:") ~= nil,
                  "Error prefix not found. Got: " .. (mock_print_messages[1] or "nil"))
      assert_true(string.find(mock_print_messages[1], "Simulated error in deferred function") ~= nil,
                  "Simulated error message not found. Got: " .. (mock_print_messages[1] or "nil"))
    end
    done_callback()
  end)
end

tests["7. No arguments to deferred function"] = function(done_callback)
  local executed = false
  local function my_func_no_args()
    executed = true
  end
  Defer(my_func_no_args)

  original_C_Timer_After(0.05, function()
    assert_true(executed, "Function with no args should execute")
    done_callback()
  end)
end

tests["8. Rapid Defer Calls (Many functions)"] = function(done_callback)
  local count = 0
  local num_to_defer = 50 -- Keep reasonable to avoid WoW timer limits/issues
  for _ = 1, num_to_defer do
    Defer(function()
      count = count + 1
    end)
  end

  original_C_Timer_After(0.25, function() -- Longer delay for more functions
    assert_equal(count, num_to_defer, "All rapidly deferred functions should execute")
    done_callback()
  end)
end

tests["9. Defer called from within a C_Timer.After callback"] = function(done_callback)
  ---@type string[]
  local execution_order = {}
  table.insert(execution_order, "start")

  original_C_Timer_After(0.01, function()
    table.insert(execution_order, "timer_fires")
    Defer(function()
      table.insert(execution_order, "deferred_from_timer")
    end)
    table.insert(execution_order, "after_defer_in_timer")
  end)

  -- Expected: start, timer_fires, after_defer_in_timer, then deferred_from_timer
  original_C_Timer_After(0.1, function()
    assert_equal(#execution_order, 4, "Defer from C_Timer.After: Correct number of execution steps")
    if #execution_order == 4 then
      assert_equal(execution_order[1], "start", "Defer from C_Timer.After: Step 1")
      assert_equal(execution_order[2], "timer_fires", "Defer from C_Timer.After: Step 2")
      assert_equal(execution_order[3], "after_defer_in_timer", "Defer from C_Timer.After: Step 3")
      assert_equal(execution_order[4], "deferred_from_timer", "Defer from C_Timer.After: Step 4")
    end
    done_callback()
  end)
end

tests["10. Indirectly test is_processing_scheduled logic"] = function(done_callback)
  -- This test indirectly checks if `is_processing_scheduled` prevents multiple C_After calls
  -- by ensuring that a rapid succession of Defer calls still processes everything correctly and in order.
  ---@type string[]
  local results = {}

  Defer(function() table.insert(results, "func1") end)
  Defer(function() table.insert(results, "func2") end)
  Defer(function() table.insert(results, "func3") end)

  original_C_Timer_After(0.1, function()
    assert_equal(#results, 3, "All three functions should have executed")
    if #results == 3 then
      assert_equal(results[1], "func1", "is_processing_scheduled check: func1 order")
      assert_equal(results[2], "func2", "is_processing_scheduled check: func2 order")
      assert_equal(results[3], "func3", "is_processing_scheduled check: func3 order")
    end
    done_callback()
  end)
end

tests["11. Complex Nested Defer with Multiple Levels and Outer Deferrals"] = function(done_callback)
  ---@type string[]
  local execution_order = {}

  Defer(function()     -- Batch 1, Item 1
    table.insert(execution_order, "A")
    Defer(function()   -- Batch 2, Item 1 (from A)
      table.insert(execution_order, "A1")
      Defer(function() -- Batch 3, Item 1 (from A1)
        table.insert(execution_order, "A1a")
      end)
    end)
  end)

  Defer(function() -- Batch 1, Item 2
    table.insert(execution_order, "B")
  end)

  -- Expected order: A, B (Batch 1), then A1 (Batch 2), then A1a (Batch 3)
  original_C_Timer_After(0.2, function() -- Needs enough time for all batches
    assert_equal(#execution_order, 4, "Complex Nested: Correct number of executions. Got: " .. table.concat(execution_order, ", "))
    if #execution_order == 4 then
      assert_equal(execution_order[1], "A", "Complex Nested: Step 1 (A)")
      assert_equal(execution_order[2], "B", "Complex Nested: Step 2 (B)")
      assert_equal(execution_order[3], "A1", "Complex Nested: Step 3 (A1)")
      assert_equal(execution_order[4], "A1a", "Complex Nested: Step 4 (A1a)")
    else
      original_print("Actual order for Complex Nested:")
      for i, v_item in ipairs(execution_order) do
        original_print(tostring(i) .. ": " .. tostring(v_item))
      end
    end
    done_callback()
  end)
end

tests["12. Ensure queue is empty before new Defer schedules processing"] = function(done_callback)
  local first_run_done = false
  local second_run_done = false

  -- First batch
  Defer(function()
    -- This function runs, and its batch completes.
    -- is_processing_scheduled should become false.
    first_run_done = true
  end)

  -- Wait for the first batch to clear
  original_C_Timer_After(0.1, function()
    assert_true(first_run_done, "First batch should have run")

    -- Now, Defer again. This should schedule a new C_After because the previous one finished.
    Defer(function()
      second_run_done = true
    end)

    original_C_Timer_After(0.1, function()
      assert_true(second_run_done, "Second batch after a pause should have run")
      done_callback()
    end)
  end)
end


--------------------------------------------------------------------------------
-- Test Runner
--------------------------------------------------------------------------------
---@type string[]
local test_names_ordered = {}

---@param index number
local function run_next_test(index)
  if index > #test_names_ordered then
    original_print("----------------------------------------------------")
    original_print(string.format("All %d tests completed.", #test_names_ordered))
    original_print(string.format("Assertions: %d made, %d failed.", assertions_made, assertions_failed))
    original_print("----------------------------------------------------")
    if assertions_failed > 0 then
      original_print(string.format("WARNING: %d assertion(s) FAILED!", assertions_failed))
    else
      original_print("All tests passed successfully!")
    end
    restore_test_environment()
    return
  end

  current_test_name = test_names_ordered[index]
  original_print(string.format("Running test [%d/%d]: %s", index, #test_names_ordered, current_test_name))

  local test_func = tests[current_test_name]
  if type(test_func) == "function" then
    -- Clear mock prints for the current test
    mock_print_messages = {}
    local success, err = pcall(test_func, function()
      -- This is the done_callback
      original_C_Timer_After(0, function() run_next_test(index + 1) end) -- Schedule next test on next frame
    end)
    if not success then
      original_print(string.format("ERROR EXECUTING TEST '%s': %s", current_test_name, tostring(err)))
      assertions_failed = assertions_failed + 1                          -- Count test execution error as a failure
      original_C_Timer_After(0, function() run_next_test(index + 1) end) -- Continue to next test
    end
  else
    original_print(string.format("SKIPPING test '%s': Not a function.", current_test_name))
    original_C_Timer_After(0, function() run_next_test(index + 1) end)
  end
end

-- Global function to trigger tests
function LibQuestieDB.QuestieDB_Defer_RunTests()
  if not _G.Defer then
    original_print("Defer function not found. Ensure Defer.lua is loaded before this test script.")
    return
  end

  original_print("Starting QuestieDB Defer Test Suite...")
  assertions_made = 0
  assertions_failed = 0

  setup_test_environment()

  test_names_ordered = {}
  -- Get keys and sort them for consistent order
  ---@type string[]
  local temp_keys = {}
  for k in pairs(tests) do table.insert(temp_keys, k) end
  table.sort(temp_keys)
  test_names_ordered = temp_keys

  run_next_test(1)
end

C_Timer.After(1, function()
  print("QuestieDB Defer Test Suite is starting...")
  if LibQuestieDB.Database.debugEnabled and LibQuestieDB.Database.debugPrintEnabled then
    -- TODO: Add a settings panel where all the test outputs are printed to.
    LibQuestieDB.QuestieDB_Defer_RunTests()
  end
end)
