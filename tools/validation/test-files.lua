-- Lua has no standard directory iterator or recursive removal. Offline tests delegate
-- just those filesystem operations to Python; database semantics remain in Lua.
local lib = dofile("generator/lib.lua")
local files = {}

---@param arguments string[]
---@return string[] lines
local function run(arguments)
  table.insert(arguments, 1, "tools/validation/test-files.py")
  local pipe = assert(lib.popen(lib.pythonCommand(arguments)))
  local ok = pipe:read("*l")
  local lines = {}
  for line in pipe:lines() do lines[#lines + 1] = line end
  pipe:close()
  assert(ok == "OK", "Python filesystem operation failed")
  return lines
end

---@param path string
---@param recursive boolean
---@param suffixes string[]
---@return string[] paths
function files.list(path, recursive, suffixes)
  local args = { "list", path }
  if recursive then args[#args + 1] = "--recursive" end
  for _, suffix in ipairs(suffixes) do args[#args + 1] = "--suffix=" .. suffix end
  return run(args)
end

---@return string path
function files.temporaryDirectory()
  return assert(run({ "temp" })[1])
end

---@param path string
---@return nil
function files.removeTree(path)
  run({ "remove", path })
end

return files
