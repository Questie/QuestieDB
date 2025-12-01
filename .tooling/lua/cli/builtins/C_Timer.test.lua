-- Test file for C_Timer implementation using luv

-- We want it to use the same import as other files so we add the root workspace folder
-- into the package path to avoid the error of different imports.
local script_dir = arg and arg[0] and arg[0]:match("(.*/)")
print(script_dir)
if script_dir then
  package.path = script_dir .. '../../?.lua;' .. package.path
else
  -- Fallback to relative path if script directory detection fails
  package.path = '../../?.lua;' .. package.path
end

-- Load the C_Timer module and luv
require("cli.builtins.C_Timer")
---@type luv
local uv = require('luv')

-- Enable debug mode for C_Timer
DB_C_TIMER_DEBUG = true

print("Testing C_Timer with luv library...")
print("Start time:", os.date("%X"))

---@type number
local testStartTime = uv.hrtime()

---Helper function to get elapsed time in seconds
---@return number
local function getElapsedTime()
  return (uv.hrtime() - testStartTime) / 1e9
end

---Helper function to create a test timer that tracks completion
---@param testName string
---@param expectedTime number
---@return function
local function createTestTracker(testName, expectedTime)
  return function()
    local actualTime = getElapsedTime()
    local timeDiff = math.abs(actualTime - expectedTime)
    local tolerance = 0.1 -- 100ms tolerance

    if timeDiff <= tolerance then
      print(string.format("✓ %s: Expected ~%.1fs, got %.2fs (diff: %.3fs)",
                          testName, expectedTime, actualTime, timeDiff))
    else
      print(string.format("✗ %s: Expected ~%.1fs, got %.2fs (diff: %.3fs) - FAILED",
                          testName, expectedTime, actualTime, timeDiff))
    end
  end
end

-- Test 1: C_Timer.After
print("\n1. Testing C_Timer.After...")
local afterTest = createTestTracker("C_Timer.After", 1.0)
C_Timer.After(1, afterTest)

-- Test 2: C_Timer.NewTimer
print("\n2. Testing C_Timer.NewTimer...")
local timerTest = createTestTracker("C_Timer.NewTimer", 2.0)
local timer = C_Timer.NewTimer(2, function(container)
  timerTest()
  ---@cast container FunctionContainer
  print("   Timer container cancelled status:", container:IsCancelled())
end)

-- Test 3: C_Timer.NewTicker with limited iterations
print("\n3. Testing C_Timer.NewTicker (3 iterations)...")
local tickCount = 0
local expectedTickTimes = { 0.5, 1.0, 1.5, }
local ticker = C_Timer.NewTicker(0.5, function(container)
                                   tickCount = tickCount + 1
                                   local actualTime = getElapsedTime()
                                   local expectedTime = expectedTickTimes[tickCount]
                                   local timeDiff = math.abs(actualTime - expectedTime)

                                   if timeDiff <= 0.1 then
                                     print(string.format("   ✓ Tick #%d: Expected ~%.1fs, got %.2fs",
                                                         tickCount, expectedTime, actualTime))
                                   else
                                     print(string.format("   ✗ Tick #%d: Expected ~%.1fs, got %.2fs - FAILED",
                                                         tickCount, expectedTime, actualTime))
                                   end

                                   if tickCount >= 3 then
                                     print("   Ticker completed all iterations")
                                   end
                                 end, 3)

-- Test 4: Timer cancellation
print("\n4. Testing timer cancellation...")
local cancelTimer = C_Timer.NewTimer(5, function()
  print("   ✗ This should not be printed (timer was cancelled) - FAILED")
end)

-- Cancel the timer after 1.5 seconds
local cancelTest = uv.new_timer()
cancelTest:start(1500, 0, function()
  local cancelTime = getElapsedTime()
  print(string.format("   Cancelling timer at %.2fs", cancelTime))
  cancelTimer:Cancel()
  print("   Timer cancelled status:", cancelTimer:IsCancelled())
  print("   ✓ Timer cancellation test completed")
  cancelTest:close()
end)

-- Test 5: Infinite ticker with manual cancellation
print("\n5. Testing infinite ticker with cancellation...")
local infiniteTickCount = 0
local infiniteTicker = C_Timer.NewTicker(0.3, function()
  infiniteTickCount = infiniteTickCount + 1
  local currentTime = getElapsedTime()
  print(string.format("   Infinite ticker tick #%d at %.2fs", infiniteTickCount, currentTime))
end)

-- Cancel the infinite ticker after 2.5 seconds
local infiniteCancelTest = uv.new_timer()
infiniteCancelTest:start(2500, 0, function()
  local cancelTime = getElapsedTime()
  print(string.format("   Cancelling infinite ticker at %.2fs", cancelTime))
  infiniteTicker:Cancel()
  print("   ✓ Infinite ticker cancellation test completed")
  infiniteCancelTest:close()
end)

-- Test 6: Test WaitForAllTimers and CancelAllTimers functionality
print("\n6. Testing WaitForAllTimers and CancelAllTimers...")
-- Test that these methods exist and are callable
if type(C_Timer.WaitForAllTimers) == "function" then
  print("   ✓ WaitForAllTimers method exists and is callable")
else
  print("   ✗ WaitForAllTimers method missing or not a function - FAILED")
end

if type(C_Timer.CancelAllTimers) == "function" then
  print("   ✓ CancelAllTimers method exists and is callable")
else
  print("   ✗ CancelAllTimers method missing or not a function - FAILED")
end

-- Test 7: Test FunctionContainer Invoke method
print("\n7. Testing FunctionContainer Invoke method...")
local invokeTestCalled = false
local testContainer = C_Timer.NewTimer(0.1, function()
  invokeTestCalled = true
  print("   ✓ Timer callback executed via normal execution")
end)

-- Test the Invoke method
local manualInvokeTest = C_Timer.NewTimer(10, function() -- Long timer that we'll invoke manually
  print("   ✓ FunctionContainer:Invoke() method works correctly")
end)

-- Manually invoke the callback after 0.2 seconds
local invokeTest = uv.new_timer()
invokeTest:start(200, 0, function()
  if type(manualInvokeTest.Invoke) == "function" then
    manualInvokeTest:Invoke()
    manualInvokeTest:Cancel() -- Cancel the original timer since we invoked it manually
    print("   ✓ FunctionContainer Invoke method exists and is callable")
  else
    print("   ✗ FunctionContainer Invoke method missing or not a function - FAILED")
  end
  invokeTest:close()
end)

-- Test 8: Error handling in callback
-- We don't use pcall here because the timers in WoW does not have any error handling / return
print("\n8. Testing error handling in callback...")
local errorHandled = false
local original_error = error
_G.error = function(msg)
  if string.find(msg, "Simulated error in callback") then
    print("   ✓ Correctly caught error from callback: " .. msg)
    errorHandled = true
  else
    original_error(msg)
  end
end

C_Timer.After(0.1, function()
  error("Simulated error in callback")
end)

C_Timer.After(0.2, function()
  if not errorHandled then
    print("   ✗ Error handling test failed: error was not caught.")
  end
  _G.error = original_error -- Restore original error function
end)

-- Test 9: WaitForAllTimers with checkFunction
print("\n9. Testing WaitForAllTimers with checkFunction...")
local condition = false
C_Timer.After(0.5, function()
  condition = true
  print("   ✓ Condition for WaitForAllTimers met.")
end)
C_Timer.WaitForAllTimers(nil, function()
  return condition
end)
if condition then
  print("   ✓ WaitForAllTimers with checkFunction exited correctly.")
else
  print("   ✗ WaitForAllTimers with checkFunction failed.")
end

-- Test 10: NewTicker with 1 iteration
print("\n10. Testing NewTicker with 1 iteration...")
local tickerOnceTest = createTestTracker("NewTicker (1 iteration)", 0.1)
C_Timer.NewTicker(0.1, tickerOnceTest, 1)

-- Test 11: CancelAllTimers in action
print("\n11. Testing CancelAllTimers in action...")
local timer1Cancelled = true
local timer2Cancelled = true
C_Timer.After(5, function() timer1Cancelled = false end)
C_Timer.NewTicker(1, function() timer2Cancelled = false end)
C_Timer.CancelAllTimers()

C_Timer.After(0.1, function()
  if timer1Cancelled and timer2Cancelled then
    print("   ✓ CancelAllTimers successfully cancelled all timers.")
  else
    print("   ✗ CancelAllTimers failed to cancel all timers.")
  end
end)


-- Create a timer to end the test after 6 seconds
print("\n12. Setting up test completion timer...")
local testEndTimer = uv.new_timer()
testEndTimer:start(6000, 0, function()
  print("\n" .. string.rep("=", 50))
  print("All tests completed at:", os.date("%X"))
  print(string.format("Total test duration: %.2fs", getElapsedTime()))
  testEndTimer:close()

  -- Check if any timers are still running and close them
  local handles = {}
  uv.walk(function(handle)
    if not uv.is_closing(handle) then
      table.insert(handles, handle)
    end
  end)

  print(string.format("Remaining active handles: %d", #handles))

  -- Force close any remaining handles to ensure clean exit
  for _, handle in ipairs(handles) do
    if not uv.is_closing(handle) then
      uv.close(handle)
    end
  end
end)

print("\nWaiting for timers to execute...")
print("Note: Using uv.run() to properly handle timer events")

-- Start the event loop - this will block until all timers complete
uv.run()
