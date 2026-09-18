-- Schema-only legacy Questie input resolution. Python owns cache and process mechanics;
-- explicit checkouts remain caller-owned and are never fetched, switched, or cleaned.
local lib = dofile("generator/lib.lua")
local questie = {}

---Validate an explicit checkout, or ask the portable helper for the pinned cache.
---@param path string? Explicit checkout, overriding QUESTIE_PATH.
---@return string path
---@return string commit
function questie.resolve(path)
  path = path or os.getenv("QUESTIE_PATH")
  if path and path ~= "" then return path, lib.assertQuestiePin(path) end

  -- Validate locally too: malformed pins must fail before starting any external program.
  local commit = lib.readQuestiePin()
  local pipe = assert(lib.popen(lib.pythonCommand({ "tools/questie-sync/checkout.py" })))
  local resolved = pipe:read("*l")
  pipe:close()
  assert(resolved == ".cache/questie/" .. commit, "Could not resolve the pinned Questie checkout")
  return resolved, lib.assertQuestiePin(resolved)
end

return questie
