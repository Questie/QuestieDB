-- Stands in for generator/lib.lua only in the command-flow fixture. This proves the
-- runner forwards the chosen checkout before launching generation or readers.
local lib = {}

---@param path string
---@return nil
function lib.assertQuestiePin(path)
  local log = assert(io.open("events.log", "a"))
  log:write("pin:" .. path .. "\n")
  log:close()
end

return lib
