--* C_Timer

---Should debug timers print out creation and execution information?
DB_C_TIMER_DEBUG = DB_C_TIMER_DEBUG ~= nil and DB_C_TIMER_DEBUG or false
DB_C_TIMER_QUIET_TIMERS = DB_C_TIMER_QUIET_TIMERS ~= nil and DB_C_TIMER_QUIET_TIMERS or false

-- Import luv library for real timer functionality
---@type luv
local uv = require('luv')

-- Contains the handle as key and the creation print as value
---@type table<uv_handle_t, debuginfo>
local timerLookup = {}

---@class FunctionContainer
---@field package _timer uv_timer_t
---@field package _cancelled boolean
---@field package callback function?
local FunctionContainer = {}
---@package
FunctionContainer.__index = FunctionContainer

---@package
---@return FunctionContainer
function FunctionContainer:new(timer, callback)
  if not timer then
    error("FunctionContainer:new: timer cannot be nil")
  end
  if callback ~= nil and type(callback) ~= "function" then
    error("FunctionContainer:new: callback must be a function or nil, got " .. type(callback))
  end

  local obj = setmetatable({}, self)
  obj._timer = timer
  obj._cancelled = false
  obj.callback = callback
  return obj
end

---@diagnostic disable-next-line: duplicate-set-field
function FunctionContainer:Cancel()
  if not self._cancelled and self._timer then
    self._timer:stop()
    self._timer:close()
    self._cancelled = true
    timerLookup[self._timer] = nil
  end
end

---@return boolean
---@diagnostic disable-next-line: duplicate-set-field
function FunctionContainer:IsCancelled()
  return self._cancelled
end

---@diagnostic disable-next-line: duplicate-set-field
function FunctionContainer:Invoke()
  -- This method exists in the API but isn't typically used for timers
  -- Implementation would depend on stored callback
  if self.callback then
    self.callback(self)
  end
end

-- Color helper function for terminal output formatting
local function c(text, color)
  if not DB_C_TIMER_DEBUG or DB_C_TIMER_QUIET_TIMERS then
    return
  end
  if color == "green" then
    print("\27[32m[C_Timer] " .. text .. "\27[0m")
  elseif color == "red" then
    print("\27[31m[C_Timer] " .. text .. "\27[0m")
  elseif color == "yellow" then
    print("\27[33m[C_Timer] " .. text .. "\27[0m")
  elseif color == "blue" then
    print("\27[34m[C_Timer] " .. text .. "\27[0m")
  elseif color == "cyan" then
    print("\27[36m[C_Timer] " .. text .. "\27[0m")
  else
    print("[C_Timer] " .. text)
  end
end

C_Timer = {
  --- Wait for all running timers to complete
  ---@param timeToWait? number -- Optional time in seconds to wait (acts as timeout when used with checkFunction)
  ---@param checkFunction? function -- Optional function to check if all timers are done
  WaitForAllTimers = function(timeToWait, checkFunction)
    -- Validate parameters
    if timeToWait and (type(timeToWait) ~= "number" or timeToWait <= 0) then
      error("C_Timer.WaitForAllTimers: timeToWait must be a positive number or nil")
    end
    if checkFunction and type(checkFunction) ~= "function" then
      error("C_Timer.WaitForAllTimers: checkFunction must be a function or nil")
    end
    if not timeToWait and not checkFunction then
      error("C_Timer.WaitForAllTimers: must provide either timeToWait, checkFunction, or both")
    end

    local startTime = uv.hrtime()
    c("Waiting to allow timers to execute", "yellow")
    while uv.run("nowait") do
      local elapsed = (uv.hrtime() - startTime) / 1e9 -- Convert nanoseconds to seconds
      if timeToWait and elapsed >= timeToWait then
        c("Timed out after " .. string.format("%.2f", elapsed) .. " seconds", "red")
        return
      elseif checkFunction then
        if checkFunction() then
          c("Condition met after " .. string.format("%.2f", elapsed) .. " seconds", "green")
          return
        end
      end
    end
    c("All timers processed after " .. string.format("%.2f", (uv.hrtime() - startTime) / 1e9) .. " seconds", "green")
  end,

  --- One off timer that runs after the specified seconds<br>
  --- It seems like this is getting replaced by `C_Timer.NewTimer` in the API, but it still exists<br>
  ---[Documentation](https://warcraft.wiki.gg/wiki/API_C_Timer.After)
  ---@param seconds number
  ---@param callback function
  ---@return FunctionContainer
  After = function(seconds, callback)
    -- Validate parameters
    if type(seconds) ~= "number" then
      error("C_Timer.After: seconds must be a number, got " .. type(seconds))
    end
    if seconds < 0 then
      error("C_Timer.After: seconds must be non-negative, got " .. tostring(seconds))
    end
    if type(callback) ~= "function" then
      error("C_Timer.After: callback must be a function, got " .. type(callback))
    end

    local caller = debug.getinfo(2)

    local timer = uv.new_timer()
    if not timer then
      error("C_Timer.After: Failed to create timer")
    end
    local container = FunctionContainer:new(timer, callback)

    local startTime = uv.hrtime()

    timerLookup[timer] = caller
    c("Creating: After for " .. seconds .. " seconds" ..
      " at " .. (caller.source or "") .. ":" .. (caller.currentline or 0), "cyan")

    timer:start(seconds * 1000, 0, function()
      if not container._cancelled then
        container:Cancel() -- Stop the timer after it runs once
        if type(callback) == "function" then
          c("Executing: 'After' (" .. tostring((uv.hrtime() - startTime) / 1e9) .. "s) " .. (caller.source or "") .. ":" .. (caller.currentline or 0), "cyan")
          callback() -- C_Timer.After calls callback with no parameters
        end
      end
    end)

    return container
  end,

  --- Repeated timer that runs every `seconds` seconds for `iterations(forever if nil)` or until it is cancelled<br>
  ---[Documentation](https://warcraft.wiki.gg/wiki/API_C_Timer.NewTicker)
  ---@param seconds number
  ---@param callback fun(cb: FunctionContainer)
  ---@param iterations? number
  ---@return FunctionContainer cbObject
  NewTicker = function(seconds, callback, iterations)
    -- Validate parameters
    if type(seconds) ~= "number" then
      error("C_Timer.NewTicker: seconds must be a number, got " .. type(seconds))
    end
    if seconds <= 0 then
      error("C_Timer.NewTicker: seconds must be positive, got " .. tostring(seconds))
    end
    if type(callback) ~= "function" then
      error("C_Timer.NewTicker: callback must be a function, got " .. type(callback))
    end
    if iterations ~= nil then
      if type(iterations) ~= "number" then
        error("C_Timer.NewTicker: iterations must be a number or nil, got " .. type(iterations))
      end
      if iterations <= 0 or iterations ~= math.floor(iterations) then
        error("C_Timer.NewTicker: iterations must be a positive integer, got " .. tostring(iterations))
      end
    end

    local caller = debug.getinfo(2)

    local timer = uv.new_timer()
    if not timer then
      error("C_Timer.NewTicker: Failed to create timer")
    end
    local container = FunctionContainer:new(timer, callback)
    local count = 0

    local startTime = uv.hrtime()

    timerLookup[timer] = caller
    c("Creating: NewTicker for " ..
      seconds .. " seconds with iterations: " .. tostring(iterations) .. " at " .. (caller.source or "") .. ":" .. (caller.currentline or 0), "cyan")

    timer:start(seconds * 1000, seconds * 1000, function()
      if not container._cancelled then
        count = count + 1

        if type(callback) == "function" then
          c("Executing: 'NewTicker' (" .. tostring((uv.hrtime() - startTime) / 1e9) .. "s) " .. (caller.source or "") .. ":" .. (caller.currentline or 0), "cyan")
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

  --- One off timer that runs once after the specified seconds<br>
  --- [Documentation](https://warcraft.wiki.gg/wiki/API_C_Timer.NewTimer)
  ---@param seconds number
  ---@param callback fun(cb: FunctionContainer)
  ---@return FunctionContainer cbObject
  NewTimer = function(seconds, callback)
    -- Validate parameters
    if type(seconds) ~= "number" then
      error("C_Timer.NewTimer: seconds must be a number, got " .. type(seconds))
    end
    if seconds < 0 then
      error("C_Timer.NewTimer: seconds must be non-negative, got " .. tostring(seconds))
    end
    if type(callback) ~= "function" then
      error("C_Timer.NewTimer: callback must be a function, got " .. type(callback))
    end

    local caller = debug.getinfo(2)
    local timer = uv.new_timer()
    if not timer then
      error("C_Timer.NewTimer: Failed to create timer")
    end
    local container = FunctionContainer:new(timer, callback)

    local startTime = uv.hrtime()

    timerLookup[timer] = caller
    c("Creating: NewTimer for " .. seconds .. " seconds" ..
      " at " .. (caller.source or "") .. ":" .. (caller.currentline or 0), "cyan")

    timer:start(seconds * 1000, 0, function()
      if not container._cancelled then
        container:Cancel() -- Stop the timer after it runs once
        if type(callback) == "function" then
          c("Executing: 'NewTimer' (" .. tostring((uv.hrtime() - startTime) / 1e9) .. "s) " .. (caller.source or "") .. ":" .. (caller.currentline or 0), "cyan")
          callback(container)
        end
      end
    end)

    return container
  end,

  CancelAllTimers = function()
    c("Canceling all timers", "yellow")
    -- Check if any timers are still running and close them
    local handles = {}
    uv.walk(function(handle)
      if not uv.is_closing(handle) then
        table.insert(handles, handle)
      end
    end)

    c(string.format("Remaining active handles: %d", #handles), "yellow")

    -- Force close any remaining handles to ensure clean exit
    for _, handle in ipairs(handles) do
      if not uv.is_closing(handle) then
        if timerLookup[handle] then
          c("Cancelling timer from " .. (timerLookup[handle].source or "") .. ":" .. (timerLookup[handle].currentline or 0), "yellow")
          print("\27[33mWarning: Dangling timer found and cancelled from " ..
            (timerLookup[handle].source or "") .. ":" .. (timerLookup[handle].currentline or 0) .. "\27[0m")
          timerLookup[handle] = nil -- Remove from lookup
        else
          print("\27[33mWarning: Unknown dangling timer found and cancelled.\27[0m")
        end
        uv.close(handle)
      end
    end
    c("All timers cancelled\n", "yellow")
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
