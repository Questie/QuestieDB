--* C_Timer
local timerList = {}
C_Timer = {
  drainTimerList = function()
    for _, f in ipairs(timerList) do
      f()
    end
    timerList = {}
  end,
  After = function(_, f)
    timerList[#timerList + 1] = f
  end,
  NewTicker = function(_, f, times)
    if times then
      for _ = 1, times do
        timerList[#timerList + 1] = f
      end
    end
  end,
  ---@diagnostic disable-next-line: undefined-doc-name
  ---@return FunctionContainer
  NewTimer = function(_, f)
    timerList[#timerList + 1] = f
    ---@diagnostic disable-next-line: return-type-mismatch
    return nil
  end,
}
