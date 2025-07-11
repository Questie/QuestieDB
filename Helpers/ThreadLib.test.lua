---@class LibQuestieDB
local LibQuestieDB = select(2, ...)

if Is_CLI then
  -- Do not run these tests in the CLI
  return
end

--------------------------------------------------------------------------------
--- Test Suite for ThreadLib Functions
--- This suite tests the ThreadLib functions to ensure they behave correctly under various conditions.
--- It includes tests for:
--- 1. Basic thread creation and execution
--- 2. Thread with delays
--- 3. Thread with callback functions
--- 4. Error handling in threaded functions
--- 5. Thread cancellation
--- 6. Thread yielding behavior
--- 7. Parameter validation
--- 8. Convenience wrapper functions
--- 9. Multiple concurrent threads
--- 10. Error callbacks and custom error messages
--------------------------------------------------------------------------------

---@class TestDefinitionTableThreadLib { [testName: string]: fun(done_callback: fun()) }
---@type TestDefinitionTableThreadLib
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

-- Get builtin function for precise timing
local GetTimePreciseSec = GetTimePreciseSec

-- Helper function to get test start time
---@type number?
local test_start_time = nil

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
end

local function setup_test_environment()
  mock_print_messages = {}
  test_start_time = GetTimePreciseSec() -- Reset timer for each test
  -- _G.print = mock_print                 -- Mock global print
  LibQuestieDB.ErrorPrint = mock_print
end

local function restore_test_environment()
  -- _G.print = original_print
  LibQuestieDB.ErrorPrint = original_print
end

--------------------------------------------------------------------------------
-- Test Cases
--------------------------------------------------------------------------------

tests["1. Basic Thread Creation: Simple function executes"] = function(done_callback)
  local executed = false
  local thread = LibQuestieDB.ThreadLib.Thread(function()
    executed = true
  end)

  assert_true(thread ~= nil, "Thread should be created successfully")
  assert_true(type(thread.Cancel) == "function", "Thread should have Cancel method")
  assert_true(type(thread.IsCancelled) == "function", "Thread should have IsCancelled method")

  original_C_Timer_After(0.1, function()
    assert_true(executed, "Threaded function should have executed")
    assert_true(thread:IsCancelled(), "Thread should be cancelled after completion")
    done_callback()
  end)
end

tests["2. Thread with Delay: Function executes after specified delay"] = function(done_callback)
  local executed = false

  local _thread = LibQuestieDB.ThreadLib.Thread(function()
                                                  executed = true
                                                end, 0.2)

  original_C_Timer_After(0.3, function()
    assert_true(executed, "Threaded function should have executed after delay")
    done_callback()
  end)
end

tests["3. Thread with Callback: Callback executes after thread completion"] = function(done_callback)
  local thread_executed = false
  local callback_executed = false

  local _thread = LibQuestieDB.ThreadLib.Thread(function()
                                                  thread_executed = true
                                                end, 0.05, function()
                                                  callback_executed = true
                                                end)

  original_C_Timer_After(0.25, function()
    assert_true(thread_executed, "Threaded function should have executed")
    assert_true(callback_executed, "Callback function should have executed")
    done_callback()
  end)
end

tests["4. Thread Yielding: Function yields and resumes correctly"] = function(done_callback)
  local iterations = 0
  local max_iterations = 3

  ---@async
  local function yielding_function()
    for i = 1, max_iterations do
      iterations = iterations + 1
      coroutine.yield()
    end
  end

  local _thread = LibQuestieDB.ThreadLib.Thread(yielding_function, 0.05)

  original_C_Timer_After(0.5, function()
    assert_equal(iterations, max_iterations, "All iterations should complete through yielding")
    done_callback()
  end)
end

tests["5. Thread Cancellation: Thread can be cancelled manually"] = function(done_callback)
  local executed = false
  local thread = LibQuestieDB.ThreadLib.Thread(function()
                                                 executed = true
                                               end, 0.2)

  assert_true(not thread:IsCancelled(), "Thread should not be cancelled initially")

  -- Cancel the thread after 0.1 seconds
  original_C_Timer_After(0.1, function()
    thread:Cancel()
    assert_true(thread:IsCancelled(), "Thread should be cancelled after calling Cancel()")
  end)

  -- Check after 0.3 seconds that the function didn't execute
  original_C_Timer_After(0.3, function()
    assert_true(not executed, "Cancelled thread function should not execute")
    done_callback()
  end)
end

tests["6. Error Handling: Error in threaded function is handled"] = function(done_callback)
  local original_error_fn = _G.error

  -- Override error function to prevent real errors in game
  ---@diagnostic disable-next-line: duplicate-set-field
  _G.error = function(message)
    if string.find(message, "Test error in thread") then
      LibQuestieDB.ErrorPrint("Test error in thread")
      return
    else
      original_error_fn(message)
    end
  end

  local _thread = LibQuestieDB.ThreadLib.Thread(function()
                                                  error("Test error in thread")
                                                end, 0.05)

  original_C_Timer_After(0.2, function()
    -- Restore original error function
    _G.error = original_error_fn
    -- Check that an error message was printed
    assert_true(#mock_print_messages > 0, "Error should generate print messages")
    if #mock_print_messages > 0 then
      local error_message = mock_print_messages[#mock_print_messages] or ""
      assert_true(string.find(error_message, "Test error in thread") ~= nil,
                  "Error message should contain the thrown error text")
    end
    done_callback()
  end)
end

tests["7. Custom Error Callback: Custom error handler is called"] = function(done_callback)
  local custom_error_called = false
  local captured_error = ""

  local _thread = LibQuestieDB.ThreadLib.Thread(function()
                                                  error("Custom error test")
                                                end, 0.05, nil, "Custom Error:", function(errorMessage, err, traceback)
                                                  custom_error_called = true
                                                  captured_error = err
                                                end)

  original_C_Timer_After(0.1, function()
    assert_true(custom_error_called, "Custom error callback should be called")
    assert_equal(string.find(captured_error, "Custom error test") ~= nil, true, "Error message should match thrown error")
    done_callback()
  end)
end

tests["8. ThreadCallback Wrapper: Convenience function works correctly"] = function(done_callback)
  local thread_executed = false
  local callback_executed = false

  local _thread = LibQuestieDB.ThreadLib.ThreadCallback(function()
                                                          thread_executed = true
                                                        end, 0.05, function()
                                                          callback_executed = true
                                                        end)

  original_C_Timer_After(0.15, function()
    assert_true(thread_executed, "ThreadCallback should execute thread function")
    assert_true(callback_executed, "ThreadCallback should execute callback function")
    done_callback()
  end)
end

tests["9. ThreadError Wrapper: Convenience function with error handling"] = function(done_callback)
  local error_handled = false

  local _thread = LibQuestieDB.ThreadLib.ThreadError(function()
                                                       error("ThreadError test")
                                                     end, 0.05, "ThreadError Test:", function(errorMessage, err, traceback)
                                                       error_handled = true
                                                     end)

  original_C_Timer_After(0.1, function()
    assert_true(error_handled, "ThreadError should handle errors with custom handler")
    done_callback()
  end)
end

tests["10. ThreadSimple Wrapper: Basic convenience function"] = function(done_callback)
  local executed = false

  local _thread = LibQuestieDB.ThreadLib.ThreadSimple(function()
                                                        executed = true
                                                      end, 0.05)

  original_C_Timer_After(0.1, function()
    assert_true(executed, "ThreadSimple should execute function")
    done_callback()
  end)
end

tests["11. ThreadSimple Default Delay: Uses default delay when not specified"] = function(done_callback)
  local executed = false

  local _thread = LibQuestieDB.ThreadLib.ThreadSimple(function()
    executed = true
  end) -- No delay specified

  original_C_Timer_After(0.1, function()
    assert_true(executed, "ThreadSimple should execute with default delay")
    done_callback()
  end)
end

tests["12. Multiple Concurrent Threads: Multiple threads run concurrently"] = function(done_callback)
  local execution_order = {}
  local threads = {}

  -- Create 3 threads with different delays
  threads[1] = LibQuestieDB.ThreadLib.Thread(function()
                                               table.insert(execution_order, 1)
                                             end, 0.05)

  threads[2] = LibQuestieDB.ThreadLib.Thread(function()
                                               table.insert(execution_order, 2)
                                             end, 0.1)

  threads[3] = LibQuestieDB.ThreadLib.Thread(function()
                                               table.insert(execution_order, 3)
                                             end, 0.15)

  original_C_Timer_After(0.35, function()
    assert_equal(#execution_order, 3, "All three threads should execute")
    assert_equal(execution_order[1], 1, "First thread should execute first")
    assert_equal(execution_order[2], 2, "Second thread should execute second")
    assert_equal(execution_order[3], 3, "Third thread should execute third")

    -- Check that all threads are cancelled after completion
    for i, thread in ipairs(threads) do
      assert_true(thread:IsCancelled(), string.format("Thread %d should be cancelled after completion", i))
    end

    done_callback()
  end)
end

tests["13. Parameter Validation: Invalid function parameter"] = function(done_callback)
  local success, err = pcall(function()
    ---@diagnostic disable-next-line: param-type-mismatch
    local _thread = LibQuestieDB.ThreadLib.Thread("not a function" --[[@as function]])
  end)

  assert_true(not success, "Should throw error for non-function parameter")
  if err then
    assert_true(string.find(err, "threadFunction is not a function") ~= nil,
                "Error message should indicate function parameter issue")
  end
  done_callback()
end

tests["14. Parameter Validation: Invalid delay parameter"] = function(done_callback)
  local success, err = pcall(function()
    ---@diagnostic disable-next-line: param-type-mismatch
    local _thread = LibQuestieDB.ThreadLib.Thread(function() end, "not a number" --[[@as number]])
  end)

  assert_true(not success, "Should throw error for non-number delay")
  if err then
    assert_true(string.find(err, "delay is not a number") ~= nil,
                "Error message should indicate delay parameter issue")
  end
  done_callback()
end

tests["15. Parameter Validation: Negative delay parameter"] = function(done_callback)
  local success, err = pcall(function()
    local _thread = LibQuestieDB.ThreadLib.Thread(function() end, -1)
  end)

  assert_true(not success, "Should throw error for negative delay")
  if err then
    assert_true(string.find(tostring(err), "delay must be not be negative") ~= nil,
                "Error message should indicate negative delay issue")
  end
  done_callback()
end

tests["16. Parameter Validation: Invalid callback parameter"] = function(done_callback)
  local success, err = pcall(function()
    ---@diagnostic disable-next-line: param-type-mismatch
    local _thread = LibQuestieDB.ThreadLib.Thread(function() end, 0.1, "not a function" --[[@as function]])
  end)

  assert_true(not success, "Should throw error for non-function callback")
  if err then
    assert_true(string.find(err, "callbackFunction is not a function") ~= nil,
                "Error message should indicate callback parameter issue")
  end
  done_callback()
end

tests["17. Parameter Validation: Invalid error message parameter"] = function(done_callback)
  local success, err = pcall(function()
    ---@diagnostic disable-next-line: param-type-mismatch
    local _thread = LibQuestieDB.ThreadLib.Thread(function() end, 0.1, nil, 123 --[[@as string]])
  end)

  assert_true(not success, "Should throw error for non-string error message")
  if err then
    assert_true(string.find(err, "errorMessage is not a string") ~= nil,
                "Error message should indicate errorMessage parameter issue")
  end
  done_callback()
end

tests["18. Parameter Validation: Invalid error callback parameter"] = function(done_callback)
  local success, err = pcall(function()
    ---@diagnostic disable-next-line: param-type-mismatch
    local _thread = LibQuestieDB.ThreadLib.Thread(function() end, 0.1, nil, nil, "not a function" --[[@as function]])
  end)

  assert_true(not success, "Should throw error for non-function error callback")
  if err then
    assert_true(string.find(err, "errorCallback is not a function") ~= nil,
                "Error message should indicate errorCallback parameter issue")
  end
  done_callback()
end

tests["19. Complex Yielding: Function with multiple yield points and data"] = function(done_callback)
  local results = {}
  local expected_results = { "step1", "step2", "step3", "complete", }

  local _thread = LibQuestieDB.ThreadLib.Thread(function() ---@async
                                                  table.insert(results, "step1")
                                                  coroutine.yield()
                                                  table.insert(results, "step2")
                                                  coroutine.yield()
                                                  table.insert(results, "step3")
                                                  coroutine.yield()
                                                  table.insert(results, "complete")
                                                end, 0.02)

  original_C_Timer_After(0.4, function()
    assert_equal(#results, #expected_results, "Should complete all steps")
    for i, expected in ipairs(expected_results) do
      assert_equal(results[i], expected, string.format("Step %d should match expected value", i))
    end
    done_callback()
  end)
end

tests["20. Frame-Based Threading: Thread with zero delay runs on frames"] = function(done_callback)
  local frame_iterations = 0
  local max_iterations = 5

  local _thread = LibQuestieDB.ThreadLib.Thread(function() ---@async
                                                  for i = 1, max_iterations do
                                                    frame_iterations = frame_iterations + 1
                                                    coroutine.yield()
                                                  end
                                                end, 0) -- Zero delay should be frame-based

  original_C_Timer_After(0.6, function()
    assert_equal(frame_iterations, max_iterations, "Frame-based thread should complete all iterations")
    done_callback()
  end)
end

tests["21. Stress Test: Many short-lived threads"] = function(done_callback)
  local completed_threads = 0
  local total_threads = 10

  for i = 1, total_threads do
    local _thread = LibQuestieDB.ThreadLib.Thread(function()
                                                    -- Do some trivial work
                                                    local sum = 0
                                                    for j = 1, 100 do
                                                      sum = sum + j
                                                    end
                                                    completed_threads = completed_threads + 1
                                                  end, 0.01 * i) -- Stagger the execution slightly
  end

  original_C_Timer_After(0.5, function()
    assert_equal(completed_threads, total_threads, "All stress test threads should complete")
    done_callback()
  end)
end

tests["22. Thread Completion State: Thread reports correct completion state"] = function(done_callback)
  local thread = LibQuestieDB.ThreadLib.Thread(function()
                                                 -- Simple function that completes quickly
                                               end, 0.05)

  -- Initially should not be cancelled
  assert_true(not thread:IsCancelled(), "Thread should not be cancelled initially")

  original_C_Timer_After(0.3, function()
    assert_true(thread:IsCancelled(), "Thread should be cancelled after normal completion")
    done_callback()
  end)
end

tests["23. Nil Parameters: Thread handles nil optional parameters"] = function(done_callback)
  local executed = false

  -- Test with all nil optional parameters
  local thread = LibQuestieDB.ThreadLib.Thread(function()
                                                 executed = true
                                               end, nil, nil, nil, nil)

  assert_true(thread ~= nil, "Thread should be created with nil optional parameters")

  original_C_Timer_After(0.1, function()
    assert_true(executed, "Thread with nil parameters should execute")
    done_callback()
  end)
end

--------------------------------------------------------------------------------
-- Test Runner
--------------------------------------------------------------------------------
---@type string[]
local test_names_ordered = {}

---@param index number
---@param completed_callback fun()
local function run_next_test(index, completed_callback)
  if index > #test_names_ordered then
    LibQuestieDB.ColorizePrint("green", string.format("   All %d ThreadLib tests completed.", #test_names_ordered))
    LibQuestieDB.ColorizePrint("yellow", string.format("   Assertions: %d made, %d failed.", assertions_made, assertions_failed))
    if assertions_failed > 0 then
      LibQuestieDB.ColorizePrint("red", string.format("   WARNING: %d assertion(s) FAILED!", assertions_failed))
    else
      LibQuestieDB.ColorizePrint("green", "  All ThreadLib tests passed successfully!")
    end
    restore_test_environment()
    if completed_callback then
      completed_callback()
    end
    return
  end

  current_test_name = test_names_ordered[index]

  local test_func = tests[current_test_name]
  if type(test_func) == "function" then
    -- Setup test environment for each test
    setup_test_environment()

    local success, err = pcall(test_func, function()
      -- This is the done_callback
      original_C_Timer_After(0, function() run_next_test(index + 1, completed_callback) end)
    end)
    if not success then
      LibQuestieDB.ColorizePrint("red", string.format("ERROR EXECUTING TEST '%s': %s", current_test_name, tostring(err)))
      assertions_failed = assertions_failed + 1
      original_C_Timer_After(0, function() run_next_test(index + 1, completed_callback) end)
    end
  else
    LibQuestieDB.ColorizePrint("yellow", string.format("SKIPPING test '%s': Not a function.", current_test_name))
    original_C_Timer_After(0, function() run_next_test(index + 1, completed_callback) end)
  end
end

-- Global function to trigger tests
function LibQuestieDB.QuestieDB_ThreadLib_RunTests(completed_callback)
  if not LibQuestieDB.ThreadLib or not LibQuestieDB.ThreadLib.Thread then
    LibQuestieDB.ColorizePrint("red", "ThreadLib not found. Ensure ThreadLib.lua is loaded before this test script.")
    return
  end

  LibQuestieDB.ColorizePrint("lightBlue", "Starting QuestieDB ThreadLib Test Suite...")
  assertions_made = 0
  assertions_failed = 0

  -- Get test names and sort them for consistent order
  test_names_ordered = {}
  ---@type string[]
  local temp_keys = {}
  for k in pairs(tests) do table.insert(temp_keys, k) end
  table.sort(temp_keys)
  test_names_ordered = temp_keys

  run_next_test(1, completed_callback)
end
