---@class LibQuestieDB
---@field ThreadLib ThreadLib
local LibQuestieDB = select(2, ...)

---@class ThreadLib
local ThreadLib = LibQuestieDB.ThreadLib

--Coroutine functions
local coStatus, coResume, coCreate = coroutine.status, coroutine.resume, coroutine.create
local lType = type

local newTicker = C_Timer.NewTicker


---Thread a function, callback function is called when the thread is done.
---@param threadFunction function @The function to thread
---@param delay number @Anything below 0.05 is each frame
---@param callbackFunction function? @Function to call when the thread is done
---@param errorMessage string? @What is the "Prepend" of the error message, could be something like "Error in thread: ", or "[main.lua:123]"
---@param errorCallback fun(errorMessage: string, error: string, traceback: string)? @Function to call when an error occurs
---@return TickerCallback timer, thread coroutine @The timer and thread objects
---@nodiscard
function ThreadLib.Thread(threadFunction, delay, callbackFunction, errorMessage, errorCallback)
  if lType(threadFunction) ~= "function" then
    error("ThreadLib:Thread: threadFunction is not a function")
  end
  if lType(delay) ~= "number" then
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

  local timer
  timer = newTicker(delay or 0, function()
    if (coStatus(thread) == "suspended") then --It's faster not to lookup the value but instead have it here
      local success, err = coResume(thread)
      -- Something in the coroutine went wrong, print the error and stop the timer
      if not success and timer then
        timer:Cancel();
        if errorCallback then
          errorCallback(errorMessage or "Error In Thread:", err, debug.traceback(errorMessage or err, 4))
        else
          print((errorMessage or "Error In Thread:") .. ": " .. tostring(err) .. "\n" .. debug.traceback(errorMessage or err, 4))
          error((errorMessage or "Error In Thread:") .. ": " .. tostring(err) .. "\n" .. debug.traceback(errorMessage or err, 4))
        end
      end
    elseif (coStatus(thread) == "dead") then --It's faster not to lookup the value but instead have it here
      if timer then
        timer:Cancel();
      end
      if (callbackFunction) then
        callbackFunction()
      end

      --? Is this needed?
      timer = nil
      ---@diagnostic disable-next-line: cast-local-type
      thread = nil
    end
  end)

  -- ? This code is a duplicate of the above, but it is needed to ensure the coroutine starts running
  local success, err = coResume(thread)
  -- Something in the coroutine went wrong, print the error and stop the timer
  if not success and timer then
    timer:Cancel();
    if errorCallback then
      errorCallback(errorMessage or "Error In Thread:", err, debug.traceback(errorMessage or err, 2))
    else
      error((errorMessage or "Error In Thread:") .. ": " .. tostring(err) .. "\n" .. debug.traceback(errorMessage or err, 2))
    end
  end

  return timer, thread
end

---Thread a function, callback function is called when the thread is done.
---@param threadFunction function @The function to thread
---@param delay number @Anything below 0.05 is each frame
---@param callbackFunction function @Function to call when the thread is done
---@return TickerCallback timer, thread coroutine @The timer and thread objects
---@nodiscard
function ThreadLib.ThreadCallback(threadFunction, delay, callbackFunction)
  return ThreadLib.Thread(threadFunction, delay, callbackFunction)
end

---Thread a function, using a specific error message.
---@param threadFunction function @The function to thread
---@param delay number @Anything below 0.05 is each frame
---@param errorMessage string @What is the "Prepend" of the error message
---@param errorFunction fun(errorMessage: string, error: string, traceback: string)? @Function to call when an error occurs
---@return TickerCallback timer, thread coroutine @The timer and thread objects
---@nodiscard
function ThreadLib.ThreadError(threadFunction, delay, errorMessage, errorFunction)
  return ThreadLib.Thread(threadFunction, delay, nil, errorMessage, errorFunction)
end

---Thread a function
---@param threadFunction function @The function to thread
---@param delay number @Anything below 0.05 is each frame
---@return TickerCallback timer, thread coroutine @The timer and thread objects
---@nodiscard
function ThreadLib.ThreadSimple(threadFunction, delay)
  return ThreadLib.Thread(threadFunction, delay)
end
