--* C_Timer

-- Import luv library for real timer functionality
---@type luv
local uv = require('luv')

-- Contains all timers created by C_Timer
local timerList = {}

---@class TimerContainer
---@field _timer any
---@field _cancelled boolean
local TimerContainer = {}
TimerContainer.__index = TimerContainer

---@return TimerContainer
function TimerContainer:new(timer)
  local obj = setmetatable({}, self)
  obj._timer = timer
  obj._cancelled = false
  return obj
end

function TimerContainer:Cancel()
  if not self._cancelled and self._timer then
    self._timer:stop()
    self._timer:close()
    self._cancelled = true
  end
  if timerList[self._timer] then
    timerList[self._timer] = nil -- Remove from global timer list
  end
end

---@return boolean
function TimerContainer:IsCancelled()
  return self._cancelled
end

function TimerContainer:Invoke()
  -- This method exists in the API but isn't typically used for timers
  -- Implementation would depend on stored callback
end

C_Timer = {
  --- Wait for all running timers to complete
  ---@param timeToWait number -- Time in seconds to wait for all timers to complete
  WaitForAllTimers = function(timeToWait)
    local timer = uv.new_timer()
    timer:start(timeToWait * 1000, 0, function()
      print("C_Timer.WaitForAllTimers completed after " .. timeToWait .. " seconds")
      uv.stop()
    end)
    uv.run()
  end,



  ---@param seconds number
  ---@param callback function
  ---@return TimerContainer
  After = function(seconds, callback)
    local caller = debug.getinfo(2)
    print("C_Timer.After created a timer for " .. seconds .. " seconds",
          "at " .. (caller.source or "") .. ":" .. (caller.currentline or 0))
    -- print(debug.traceback("After", 2))
    local timer = uv.new_timer()
    local container = TimerContainer:new(timer)


    timer:start(seconds * 1000, 0, function()
      if not container._cancelled then
        container:Cancel() -- Stop the timer after it runs once
        if type(callback) == "function" then
          print("Calling callback for After ", (caller.source or "") .. ":" .. (caller.currentline or 0))
          callback()
        end
      end
    end)

    return container
  end,

  ---@param seconds number
  ---@param callback function
  ---@param iterations? number
  ---@return TimerContainer
  NewTicker = function(seconds, callback, iterations)
    local caller = debug.getinfo(2)
    print("C_Timer.NewTicker created a timer for " .. seconds .. " seconds with iterations: " .. tostring(iterations),
          "at " .. (caller.source or "") .. ":" .. (caller.currentline or 0))
    -- print(debug.traceback("NewTicker", 2))
    local timer = uv.new_timer()
    timerList[timer] = timer -- Store the timer in the global list
    local container = TimerContainer:new(timer)
    local count = 0

    timer:start(seconds * 1000, seconds * 1000, function()
      if not container._cancelled then
        count = count + 1

        if type(callback) == "function" then
          print("Calling callback for NewTicker " .. (caller.source or "") .. ":" .. (caller.currentline or 0))
          callback(container)
        end

        -- Stop after specified iterations
        if iterations and count >= iterations then
          container:Cancel()
        end
      end
    end)

    return container
  end,

  ---@param seconds number
  ---@param callback function
  ---@return TimerContainer
  NewTimer = function(seconds, callback)
    local caller = debug.getinfo(2)
    print("C_Timer.NewTimer created a timer for " .. seconds .. " seconds",
          "at " .. (caller.source or "") .. ":" .. (caller.currentline or 0))
    local timer = uv.new_timer()
    timerList[timer] = timer -- Store the timer in the global list
    local container = TimerContainer:new(timer)

    timer:start(seconds * 1000, math.huge, function()
      if not container._cancelled then
        container:Cancel() -- Stop the timer after it runs once
        if type(callback) == "function" then
          print("Calling callback for NewTimer " .. (caller.source or "") .. ":" .. (caller.currentline or 0))
          callback(container)
        end
      end
    end)

    return container
  end,

  CancelAllTimers = function()
    for timer in pairs(timerList) do
      if timer and type(timer.Cancel) == "function" then
        timer:Cancel()
      end
    end
    timerList = {}
    print("All timers cancelled")
  end,


  -- Old simple functions, Do not remove!
  -- local timerList = {}
  -- drainTimerList = function()
  --   for _, f in ipairs(timerList) do
  --     f()
  --   end
  --   timerList = {}
  -- end,
  -- After = function(_, f)
  --   timerList[#timerList + 1] = f
  -- end,
  -- NewTicker = function(_, f, times)
  --   if times then
  --     for _ = 1, times do
  --       timerList[#timerList + 1] = f
  --     end
  --   end
  -- end,
  -- ---@diagnostic disable-next-line: undefined-doc-name
  -- ---@return FunctionContainer
  -- NewTimer = function(_, f)
  --   timerList[#timerList + 1] = f
  --   ---@diagnostic disable-next-line: return-type-mismatch
  --   return nil
  -- end,
}
