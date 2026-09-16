-- Localized Generation and Reconstruction without any external Questie checkout.
-- Uses real entity data and encoders, with tiny owned translation inputs in a temporary root.
-- Usage: lua5.1 tools/localization-inputs.test.lua

local lib = dofile("generator/lib.lua")
local config = dofile("src/config.lua")

---@param value string
---@return string quoted
local function quote(value)
  return "'" .. value:gsub("'", "'\\''") .. "'"
end

---@param command string
---@return boolean succeeded
local function succeeds(command)
  local status = os.execute(command)
  return status == 0 or status == true
end

local pwd = assert(io.popen("pwd -P", "r"))
local repo = pwd:read("*l")
pwd:close()
local temp = assert(io.popen("mktemp -d /tmp/questiedb-localization-XXXXXX", "r"))
local root = temp:read("*l")
temp:close()
assert(root and root:match("^/tmp/questiedb%-localization%-%w+$"))
local lua = quote(os.getenv("LUA") or "lua5.1")
local log = root .. "/command.log"
local sourcePath = root .. "/QuestieDB.toc"
local bakedPath = root .. "/QuestieDB_TBC.toc"

---@param arguments string
---@return boolean succeeded
local function run(arguments)
  return succeeds("cd " .. quote(root) .. " && env QUESTIE_PATH=" .. quote(root .. "/missing-questie") ..
    " QUESTIEDB_RELEASE=false SOURCE_DATE_EPOCH=1700000000 PATH=" .. quote(root .. "/bin") ..
    ":\"$PATH\" " .. lua .. " " .. arguments .. " > " .. quote(log) .. " 2>&1")
end

local ok, err = pcall(function()
  for _, path in ipairs({ "generator", "src", "data", "support", "generate.lua", "reconstruct.lua" }) do
    assert(succeeds("ln -s " .. quote(repo .. "/" .. path) .. " " .. quote(root .. "/" .. path)))
  end
  lib.mkdirp(root .. "/bin")
  -- Any external Git operation fails. Producer provenance is the only permitted Git read.
  lib.writeAll(root .. "/bin/git", "#!/bin/sh\n" ..
    "[ \"$*\" = 'rev-parse HEAD' ] || { touch \"" .. root .. "/external-git-attempt\"; exit 9; }\n" ..
    "printf '%s\\n' '" .. string.rep("b", 40) .. "'\n")
  assert(succeeds("chmod +x " .. quote(root .. "/bin/git")))
  lib.writeAll(root .. "/QUESTIE_COMMIT", string.rep("a", 40) .. "\n")
  lib.writeAll(sourcePath, "## Version: 1.2.3\n")
  local lookupDir = root .. "/l10n/TBC/lookupQuests"
  lib.mkdirp(lookupDir)
  for _, locale in ipairs(config.locales) do
    lib.writeAll(lookupDir .. "/" .. locale .. ".lua",
      ('QuestieLoader:ImportModule("l10n").questLookup[%q] = function()\n' ..
       'return { [2] = { "Owned translation", { "Owned objective" } } } end\n'):format(locale))
  end
  local overrides = root .. "/l10n/lookupOverrides.lua"
  lib.writeAll(overrides, 'QuestieLoader:ImportModule("l10n").questLookupOverrides = function()\n' ..
    'return { [2] = { "Owned override" } } end\n')

  assert(run("generate.lua TBC --types=Quest --quiet"), lib.readAll(log))
  local source, baked = lib.readAll(sourcePath), lib.readAll(bakedPath)
  assert(baked:find("## X-l10n-deDE-Quest:", 1, true), "localized block must be generated")
  assert(baked:find("## X-QUESTIE-COMMIT: " .. string.rep("a", 40), 1, true),
    "legacy baseline provenance comes from the pin, not an external checkout")
  assert(run("reconstruct.lua TBC --types=Quest --quiet"), lib.readAll(log))
  assert(not lib.fileExists(root .. "/.cache/questie"), "local generation must not fetch Questie")
  assert(not lib.fileExists(root .. "/external-git-attempt"), "local gates must not inspect external Git state")

  -- Missing local inputs must fail before either existing TOC is replaced.
  local missingLocale = lookupDir .. "/deDE.lua"
  local translation = lib.readAll(missingLocale)
  os.remove(missingLocale)
  assert(not run("generate.lua TBC --types=Quest --quiet"), "missing locale must fail")
  assert(lib.readAll(log):find("deDE.lua", 1, true), "missing locale error names its file")
  assert(lib.readAll(sourcePath) == source and lib.readAll(bakedPath) == baked,
    "missing locale must preserve both outputs")
  assert(not run("reconstruct.lua TBC --types=Quest --quiet"), "reconstruction must require local locales")
  lib.writeAll(missingLocale, translation)

  os.remove(overrides)
  assert(not run("generate.lua TBC --types=Quest --quiet"), "missing applicable override must fail")
  assert(lib.readAll(log):find("lookupOverrides.lua", 1, true), "override error names its file")
  assert(lib.readAll(sourcePath) == source and lib.readAll(bakedPath) == baked,
    "missing override must preserve both outputs")
  assert(not run("reconstruct.lua TBC --types=Quest --quiet"), "reconstruction must require applicable overrides")
end)
assert(succeeds("rm -rf -- " .. quote(root)))
if not ok then error(err, 0) end
print("PASS local localization: Generation, Reconstruction, and missing-input protection")
