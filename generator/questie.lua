-- generator/questie.lua
-- Generator-owned, per-pin Questie inputs. Explicit checkouts remain caller-owned.

local lib = dofile("generator/lib.lua")
local questie = {}
local REMOTE = "https://github.com/Questie/Questie.git"
local CACHE = ".cache/questie"

---@param value string
---@return string quoted
local function quote(value)
  return "'" .. value:gsub("'", "'\\''") .. "'"
end

---@param command string POSIX shell command.
---@return boolean success
local function succeeds(command)
  local status = os.execute(command)
  return status == 0 or status == true
end

---@param command string POSIX shell command.
---@return nil
local function run(command)
  if not succeeds(command) then
    error("Questie input checkout failed: " .. command ..
      "\nCheck Git/network access and retry, or pass --questie=<pinned-checkout>.", 0)
  end
end

---Resolve an explicit checkout without modifying it, or fetch a full snapshot of the pin.
---Completed cache entries are reused without network access; each pin has its own directory.
---@param path string? Explicit checkout, overriding QUESTIE_PATH.
---@return string path Validated checkout relative to the repository root, or the explicit path.
---@return string commit
function questie.resolve(path)
  path = path or os.getenv("QUESTIE_PATH")
  if path then return path, lib.assertQuestiePin(path) end

  local commit = lib.readQuestiePin()
  path = CACHE .. "/" .. commit
  if succeeds("test -e " .. quote(path) .. " -o -L " .. quote(path)) then
    return path, lib.assertQuestiePin(path)
  end

  -- Publish only a complete checkout. Separate staging directories also let concurrent
  -- generators fetch safely without sharing Git's index or leaving a partial cache entry.
  run("mkdir -p " .. quote(CACHE))
  local pipe = assert(io.popen("mktemp -d " .. quote(CACHE .. "/.fetch-XXXXXX"), "r"))
  local staging = pipe:read("*l")
  pipe:close()
  if not staging or not staging:match("^%.cache/questie/%.fetch%-%w+$") then
    error("Could not create a temporary Questie checkout in " .. CACHE, 0)
  end

  io.stderr:write("Fetching pinned Questie " .. commit .. " into " .. path .. "\n")
  local ok, err = pcall(function()
    local git = "git -C " .. quote(staging) .. " "
    run("git init --quiet " .. quote(staging))
    run(git .. "remote add origin " .. quote(REMOTE))
    -- Fetch the complete pinned snapshot without branch tips, tags, or parent history.
    run(git .. "fetch --quiet --depth=1 --no-tags origin " .. commit)
    run(git .. "-c advice.detachedHead=false checkout --quiet --detach " .. commit)
    lib.assertQuestiePin(staging)
    local published, renameErr = os.rename(staging, path)
    if not published then
      -- Another generator may have published the same pin while this one fetched.
      if not succeeds("test -d " .. quote(path .. "/.git")) then
        error("Cannot publish Questie checkout: " .. tostring(renameErr), 0)
      end
      lib.assertQuestiePin(path)
    end
  end)
  -- This path came from mktemp, never from a caller. Never clean or reset an explicit checkout.
  run("rm -rf -- " .. quote(staging))
  if not ok then error(err, 0) end
  return path, commit
end

return questie
