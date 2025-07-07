--* C_Timer

-- Import luv library for real timer functionality
local uv = require('luv')

-- Keep the legacy drainTimerList for compatibility
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
    ---@diagnostic disable-next-line: undefined-field
    self._timer:stop()
    ---@diagnostic disable-next-line: undefined-field
    self._timer:close()
    self._cancelled = true
  end
end

---@return boolean
function TimerContainer:IsCancelled()
  return self._cancelled
end

function TimerContainer:Invoke()
  -- This method exists in the API but isn't typically used for timers
  -- Implementation would depend on stored callback, but WoW API doesn't expose this
end

C_Timer = {
  drainTimerList = function()
    for _, f in ipairs(timerList) do
      f()
    end
    timerList = {}
  end,

  ---@param seconds number
  ---@param callback function
  ---@return TimerContainer
  After = function(seconds, callback)
    local timer = uv.new_timer()
    local container = TimerContainer:new(timer)

    ---@diagnostic disable-next-line: undefined-field
    timer:start(seconds * 1000, 0, function()
      if not container._cancelled then
        ---@diagnostic disable-next-line: undefined-field
        timer:stop()
        ---@diagnostic disable-next-line: undefined-field
        timer:close()
        container._cancelled = true
        if type(callback) == "function" then
          callback()
        elseif callback and callback.Invoke then
          -- Handle FunctionContainer callback
          callback:Invoke()
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
    local timer = uv.new_timer()
    local container = TimerContainer:new(timer)
    local count = 0

    ---@diagnostic disable-next-line: undefined-field
    timer:start(seconds * 1000, seconds * 1000, function()
      if not container._cancelled then
        count = count + 1

        if type(callback) == "function" then
          callback(container)
        elseif callback and callback.Invoke then
          -- Handle FunctionContainer callback
          callback:Invoke()
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
    local timer = uv.new_timer()
    local container = TimerContainer:new(timer)

    ---@diagnostic disable-next-line: undefined-field
    timer:start(seconds * 1000, 0, function()
      if not container._cancelled then
        ---@diagnostic disable-next-line: undefined-field
        timer:stop()
        ---@diagnostic disable-next-line: undefined-field
        timer:close()
        container._cancelled = true
        if type(callback) == "function" then
          callback(container)
        elseif callback and callback.Invoke then
          -- Handle FunctionContainer callback
          callback:Invoke()
        end
      end
    end)

    return container
  end,
}
