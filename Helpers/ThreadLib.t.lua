---@meta ThreadLib


---@class TimerThread: FunctionContainer
---@field thread thread The coroutine thread object
---@field errorMessage string? @The error message to prepend to the error message
---@field errorCallback fun(errorMessage: string, error: string, traceback: string)? @Function to call when an error occurs
---@field Cancel fun(self: TimerThread) @Function to cancel the timer<br>`PS this is not the same as the coroutine, this is a timer object`
---@field IsCancelled fun(self: TimerThread): boolean @Function to check if the timer is cancelled
----@field Await fun(self: TimerThread): boolean
