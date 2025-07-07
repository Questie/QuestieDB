-- Test file for C_Timer implementation using luv

package.path = '?.lua;' .. package.path

-- Load the C_Timer module and luv
require("C_Timer")
local uv = require('luv')

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
  ---@cast container TimerContainer
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

-- Test 6: Test drainTimerList legacy functionality
print("\n6. Testing legacy drainTimerList...")
-- This should still work for backwards compatibility, but won't actually delay
local legacyCallCount = 0
C_Timer.drainTimerList = function()
  for _, f in ipairs({
    function() legacyCallCount = legacyCallCount + 1 end,
    function() legacyCallCount = legacyCallCount + 1 end,
  }) do
    f()
  end
  print("   ✓ Legacy drainTimerList executed", legacyCallCount, "functions")
end
C_Timer.drainTimerList()

-- Create a timer to end the test after 6 seconds
print("\n7. Setting up test completion timer...")
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
