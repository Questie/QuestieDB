-- Tiny generator substitute for orchestration tests. The driver copies this into a
-- temporary checkout; these files record phase ordering, not database semantics.
local flavor = assert(arg[1])
if os.getenv("FAIL_GENERATE") == flavor then os.exit(7) end

local path = flavor == "toc" and "QuestieDB.toc" or "QuestieDB_" .. flavor .. ".toc"
local previous = io.open(path, "r")
local value = previous and os.getenv("CHANGE_ARTIFACT") == "1" and "changed" or "artifact"
if previous then previous:close() end
local output = assert(io.open(path, "w"))
output:write(value)
output:close()
if flavor == "Forever" then
  local alias = assert(io.open("QuestieDB_Camelot.toc", "w"))
  alias:write(os.getenv("CHANGE_ALIAS") == "1" and "changed alias" or value)
  alias:close()
end

local log = assert(io.open("events.log", "a"))
log:write("generate:" .. flavor .. "\n")
log:close()
