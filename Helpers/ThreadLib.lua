---@class ThreadLib
ThreadLib = {}

--Coroutine functions
local coStatus, coResume, coCreate = coroutine.status, coroutine.resume, coroutine.create
local lType = type
-- local cTimer = C_Timer
local newTicker = C_Timer.NewTicker


---Thread a function, callback function is called when the thread is done.
---@param threadFunction function @The function to thread
---@param delay integer @Anything below 0.05 is each frame
---@param errorMessage string? @What is the "Prepend" of the error message
---@param callbackFunction function? @Function to call when the thread is done
---@return Ticker Timer @The WoW timer, run Timer:Cancel() and let the handle of the thread become orphaned to cancel
---@return thread Thread @The coroutine thread
function ThreadLib.Thread(threadFunction, delay, errorMessage, callbackFunction)
  if lType(threadFunction) ~= "function" then
    error("ThreadLib:Thread: threadFunction is not a function")
  end
  if lType(delay) ~= "number" then
    error("ThreadLib:Thread: delay is not a number")
  end
  if errorMessage and lType(errorMessage) ~= "string" then
    error("ThreadLib:Thread: errorMessage is not a string")
  end
  if callbackFunction and lType(callbackFunction) ~= "function" then
    error("ThreadLib:Thread: callbackFunction is not a function")
  end

  local thread = coCreate(threadFunction)

  local timer
  timer = newTicker(delay or 0, function()
    if (coStatus(thread) == "suspended") then  --It's faster not to lookup the value but instead have it here
      local success, ret = coResume(thread)
      -- Something in the coroutine went wrong, print the error and stop the timer
      if not success then
        timer:Cancel();
      end
    elseif (coStatus(thread) == "dead") then   --It's faster not to lookup the value but instead have it here
      timer:Cancel();
      if (callbackFunction) then
        callbackFunction()
      end

      --? Is this needed?
      timer = nil
      ---@diagnostic disable-next-line: cast-local-type
      thread = nil
    end
  end)
  coResume(thread)
  return timer, thread
end

---Thread a function, callback function is called when the thread is done.
---@param threadFunction function @The function to thread
---@param delay integer @Anything below 0.05 is each frame
---@param callbackFunction function @Function to call when the thread is done
---@return Ticker Timer @The WoW timer, run Timer:Cancel() and let the handle of the thread become orphaned to cancel
---@return thread Thread @The coroutine thread
function ThreadLib.ThreadCallback(threadFunction, delay, callbackFunction)
  return ThreadLib.Thread(threadFunction, delay, nil, callbackFunction)
end

---Thread a function, using a specific error message.
---@param threadFunction function @The function to thread
---@param delay integer @Anything below 0.05 is each frame
---@param errorMessage string @What is the "Prepend" of the error message
---@return Ticker Timer @The WoW timer, run Timer:Cancel() and let the handle of the thread become orphaned to cancel
---@return thread Thread @The coroutine thread
function ThreadLib.ThreadError(threadFunction, delay, errorMessage)
  return ThreadLib.Thread(threadFunction, delay, errorMessage)
end

---Thread a function
---@param threadFunction function @The function to thread
---@param delay integer @Anything below 0.05 is each frame
---@return Ticker Timer @The WoW timer, run Timer:Cancel() and let the handle of the thread become orphaned to cancel
---@return thread Thread @The coroutine thread
function ThreadLib.ThreadSimple(threadFunction, delay)
  return ThreadLib.Thread(threadFunction, delay)
end