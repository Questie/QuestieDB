---@class LibQuestieDB
---@field ThreadLib ThreadLib
local LibQuestieDB = select(2, ...)

---@class ThreadLib
local ThreadLib = LibQuestieDB.ThreadLib

--Coroutine functions
local coStatus, coResume, coCreate = coroutine.status, coroutine.resume, coroutine.create
local lType = type

local newTicker = C_Timer.NewTicker

-- Coroutine error handler
---@param timer TimerThread
---@param err string
---@param tracebackLevel number?
local function handleThreadError(timer, err, tracebackLevel)
  if timer then
    timer:Cancel()
  end
  if timer.errorCallback then
    timer.errorCallback(timer.errorMessage or "Error In Thread:", err,
                        debug and debug.traceback(timer.errorMessage or err, tracebackLevel or 1) or "No Traceback available")
  else
    local fullError = (timer.errorMessage or "Error In Thread:") ..
        ": " ..
        tostring(err) ..
        -- If debug is enabled, append the traceback
        (debug and ("\n" .. debug.traceback(timer.errorMessage or err, tracebackLevel or 1)) or "")
    LibQuestieDB.ErrorPrint(fullError)
    error(fullError)
  end
end

---Thread a function, callback function is called when the thread is done.
---@param threadFunction async fun() @The function to thread (Can be a function that yields or not)
---@param delay number? @Anything below 0.05 is each frame
---@param callbackFunction function? @Function to call when the thread is done
---@param errorMessage string? @What is the "Prepend" of the error message, could be something like "Error in thread: ", or "[main.lua:123]"
---@param errorCallback fun(errorMessage: string, error: string, traceback: string)? @Function to call when an error occurs
---@return TimerThread Thread @The timer and thread object
---@nodiscard
function ThreadLib.Thread(threadFunction, delay, callbackFunction, errorMessage, errorCallback)
  if lType(threadFunction) ~= "function" then
    error("ThreadLib:Thread: threadFunction is not a function")
  end
  if lType(delay) == "number" then
    if delay < 0 then
      error("ThreadLib:Thread: delay must be not be negative")
    end
  elseif delay then
    error("ThreadLib:Thread: delay is not a number")
  end
  if callbackFunction and lType(callbackFunction) ~= "function" then
    error("ThreadLib:Thread: callbackFunction is not a function")
  end
  if errorMessage and lType(errorMessage) ~= "string" then
    error("ThreadLib:Thread: errorMessage is not a string")
  end
  if errorCallback and lType(errorCallback) ~= "function" then
    error("ThreadLib:Thread: errorCallback is not a function")
  end

  local thread = coCreate(threadFunction)

  ---@type TimerThread?
  local timer
  timer = newTicker(delay or 0, function()
    if (coStatus(thread) == "suspended") then --It's faster not to lookup the value but instead have it here
      local success, err = coResume(thread)
      -- Something in the coroutine went wrong, print the error and stop the timer
      if not success and timer then
        timer:Cancel()
        handleThreadError(timer, err, 4)
      end
    elseif (coStatus(thread) == "dead") then --It's faster not to lookup the value but instead have it here
      if timer then
        timer:Cancel()
      end
      if (callbackFunction) then
        callbackFunction()
      end
    end
  end) --[[@as TimerThread]]

  -- Set the thread in the timer object
  timer.errorMessage = errorMessage
  timer.errorCallback = errorCallback
  timer.thread = thread
  -- timer.Await = Await

  return timer
end

---Thread a function, callback function is called when the thread is done.
---@param threadFunction async fun() @The function to thread (Can be a function that yields or not)
---@param delay number @Anything below 0.05 is each frame
---@param callbackFunction function @Function to call when the thread is done
---@return TimerThread @The timer and thread objects
---@nodiscard
function ThreadLib.ThreadCallback(threadFunction, delay, callbackFunction)
  return ThreadLib.Thread(threadFunction, delay, callbackFunction)
end

---Thread a function, using a specific error message.
---@param threadFunction async fun() @The function to thread (Can be a function that yields or not)
---@param delay number @Anything below 0.05 is each frame
---@param errorMessage string @What is the "Prepend" of the error message
---@param errorFunction fun(errorMessage: string, error: string, traceback: string)? @Function to call when an error occurs
---@return TimerThread @The timer and thread objects
---@nodiscard
function ThreadLib.ThreadError(threadFunction, delay, errorMessage, errorFunction)
  return ThreadLib.Thread(threadFunction, delay, nil, errorMessage, errorFunction)
end

---Thread a function
---@param threadFunction async fun() @The function to thread (Can be a function that yields or not)
---@param delay number? @Anything below 0.05 is each frame
---@return TimerThread @The timer and thread objects
---@nodiscard
function ThreadLib.ThreadSimple(threadFunction, delay)
  return ThreadLib.Thread(threadFunction, delay or 0)
end

-- ? This await function is fully functional but when talking to AI it throught it generally
-- ? Was a bad idea to include this in the library.
-- ? If you ever run into "I want to run this async function syncronously" uncomment this code and use it.
-- -- Await function
-- ---@param self TimerThread @The timer thread object (Use `Thread:Await()` to call this function)
-- ---@return boolean success
-- local function Await(self)
--   local count = 0
--   repeat
--     local status = coStatus(self.thread)
--     if status == "suspended" then
--       -- If the coroutine is suspended, we resume it
--       local success, err = coResume(self.thread)
--       if not success then
--         handleThreadError(self, self.errorMessage, self.errorCallback, err)
--         return false
--       end

--       -- This is to prevent infinite loops
--       if count > 1000 then
--         -- Prevent infinite loops, this is a safety measure
--         handleThreadError(self, self.errorMessage, self.errorCallback, "Await function took too long to complete")
--         return false
--       end
--       count = count + 1
--     end
--   until status == "dead"

--   return true
-- end
