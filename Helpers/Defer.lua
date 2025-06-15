---@class LibQuestieDB
local LibQuestieDB = select(2, ...)
-- This file contains the Defer function, which allows you to schedule a function to be executed
-- Inspired by golangs defer function
local l_C_After = C_Timer.After
-- C_After = C_Timer.After

-- The old Defer function (lines 8-12 in the original selection) should be replaced by the following block:
do
  ---@type fun()[]
  local deferred_queue = {}
  ---@type boolean
  local is_processing_scheduled = false -- True if a C_After call is pending or processing

  ---@package
  local function process_deferred_queue()
    -- This function is called by C_After.
    -- Take a snapshot of the current queue.
    local q_to_process = deferred_queue
    -- Reset the main queue to collect new Defer calls that might happen
    -- during the execution of functions in q_to_process.
    deferred_queue = {}

    for i = 1, #q_to_process do
      local success, err = pcall(q_to_process[i])
      if not success then
        -- You can customize error handling, e.g., log to a specific addon channel
        print("Error in deferred function: " .. tostring(err))
      end
    end

    -- After processing the snapshot, check if new items were added to deferred_queue
    -- (e.g., by one of the functions in q_to_process calling Defer).
    if #deferred_queue > 0 then
      -- New items exist, schedule another C_After for them.
      -- is_processing_scheduled remains true as we are ensuring the chain continues.
      l_C_After(0, process_deferred_queue)
    else
      -- The queue (that collected items *during* processing) is empty.
      -- No more processing needed for now from this chain, so mark as not scheduled.
      is_processing_scheduled = false
    end
  end

  --- ! WARNING THIS IS RACE CONDITION HEAVEN, MAKE SURE THAT A DELAY IS SAFE
  --- Execute the provided function on the next frame.
  --- Functions are executed in FIFO (First-In, First-Out) order.
  ---@param func fun() The function to execute. It should take no arguments.
  Defer = function(func)
    if type(func) ~= "function" then
      print("Defer Error: Argument must be a function. Got type: " .. type(func))
      return
    end

    table.insert(deferred_queue, func)

    if not is_processing_scheduled then
      is_processing_scheduled = true
      l_C_After(0, process_deferred_queue)
    end
  end
  LibQuestieDB.Defer = Defer -- Expose Defer in the global LibQuestieDB table
end
