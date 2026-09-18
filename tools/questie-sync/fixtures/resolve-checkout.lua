-- Resolver assertions for the Python-owned temporary repositories.
local lib = dofile("generator/lib.lua")
local questie = dofile("generator/questie.lua")
local mode = assert(arg[1], "resolver fixture requires cache, explicit, or environment mode")

if mode == "cache" then
  local path, commit = questie.resolve()
  assert(commit == lib.readQuestiePin(), "cache resolved the wrong commit")
  assert(path:find(commit, 1, true), "cache path does not identify its pin")
elseif mode == "explicit" then
  local path = assert(arg[2], "explicit mode requires a checkout path")
  assert(questie.resolve(path) == path, "explicit checkout did not override QUESTIE_PATH")
elseif mode == "environment" then
  local path = assert(os.getenv("QUESTIE_PATH"), "environment mode requires QUESTIE_PATH")
  assert(questie.resolve() == path, "QUESTIE_PATH was not selected")
else
  error("unknown resolver fixture mode: " .. mode, 0)
end
