-- Run from the repository root: lua5.1 emulator/metadata.test.lua
-- Real TOCs exercise selection before execution, without loading database payloads.
local emulator = dofile("emulator/metadata.lua")

---@type string[]
local temporaryFiles = {}

---@param path string
---@param contents string
---@return nil
local function write(path, contents)
  temporaryFiles[#temporaryFiles + 1] = path
  local file = assert(io.open(path, "wb"))
  assert(file:write(contents))
  assert(file:close())
end

---@param fn fun()
---@param message string
---@return nil
local function rejects(fn, message)
  local ok, err = pcall(fn)
  assert(not ok, "Expected rejection: " .. message)
  assert(tostring(err):find(message, 1, true), tostring(err))
end

local toc = os.tmpname()
temporaryFiles[#temporaryFiles + 1] = toc
local baseDir, stem = toc:match("^(.*)[/\\]([^/\\]+)$")
baseDir, stem = baseDir or ".", stem or toc

---@return nil
local function run()
  write(toc .. "-first.lua", [[
local name, ns = ...
assert(name == "FixtureAddon")
ns.order = { "first" }
]])
  write(toc .. "-legacy.lua", [[
local _, ns = ...
assert(table.concat(ns.order, ",") == "first")
ns.order[#ns.order + 1] = "legacy"
]])
  write(toc .. "-forever.lua", [[
local _, ns = ...
assert(table.concat(ns.order, ",") == "first")
ns.order[#ns.order + 1] = "forever"
]])
  write(toc .. "-last.lua", [[
local _, ns = ...
ns.order[#ns.order + 1] = "last"
]])
  write(toc .. "-rejected.lua", [[
_G.NativeTocRejectedSideEffect = true
error("rejected file executed")
]])

  local first, legacy = stem .. "-first.lua", stem .. "-legacy.lua"
  local forever, last = stem .. "-forever.lua", stem .. "-last.lua"
  local rejected = stem .. "-rejected.lua"
  write(toc, table.concat({
    "## Interface: 11509", "# ordinary comment", "",
    "  " .. first .. "  ",
    legacy .. " [AllowLoadGameType vanilla, tbc, wrath, cata, mists]",
    forever .. " [ExcludeLoadGameType vanilla, tbc, wrath, cata, mists]",
    last,
  }, "\r\n"))
  for _, gameType in ipairs({ "vanilla", "tbc", "wrath", "cata", "mists", "camelot", "forever" }) do
    local ns, files = emulator.loadAddon(toc, "FixtureAddon", baseDir, gameType)
    local middle = (gameType == "camelot" or gameType == "forever") and "forever" or "legacy"
    assert(table.concat(ns.order, ",") == "first," .. middle .. ",last")
    assert(table.concat(files, ",") == first .. "," .. stem .. "-" .. middle .. ".lua," .. last)
  end

  -- A rejected file neither executes nor needs to exist or contain valid Lua.
  write(toc, rejected .. " [ExcludeLoadGameType vanilla, tbc, wrath, cata, mists]\n" ..
    "missing.lua [ExcludeLoadGameType vanilla, tbc, wrath, cata, mists]\n" .. first .. "\n" .. last)
  local ns = emulator.loadAddon(toc, "FixtureAddon", baseDir, "vanilla")
  assert(table.concat(ns.order, ",") == "first,last")
  assert(_G.NativeTocRejectedSideEffect == nil)
  rejects(function() emulator.loadAddon(toc, "FixtureAddon", baseDir, "camelot") end,
    "rejected file executed")
  assert(_G.NativeTocRejectedSideEffect == true)
  _G.NativeTocRejectedSideEffect = nil

  write(toc, first .. "\nignored.xml\n" .. last)
  ns = emulator.loadAddon(toc, "FixtureAddon", baseDir)
  assert(table.concat(ns.order, ",") == "first,last", "three-argument API remains valid")
  assert(emulator.selectFile(" src\\file.lua [AllowLoadGameType vanilla, wrath] \r", "wrath") == "src/file.lua")
  assert(emulator.selectFile("src/file.lua [AllowLoadGameType vanilla]", "tbc") == nil)
  assert(emulator.selectFile(" src\\file.lua [ExcludeLoadGameType vanilla, wrath] \r", "tbc") == "src/file.lua")
  assert(emulator.selectFile("src/file.lua [ExcludeLoadGameType vanilla, wrath]", "wrath") == nil)

  local malformed = {
    "[AllowLoadGameType]", "[AllowLoadGameType ]", "[AllowLoadGameType vanilla,]",
    "[AllowLoadGameType ,vanilla]", "[AllowLoadGameType vanilla,,wrath]",
    "[AllowLoadGameType vanilla wrath]", "[AllowLoadGameType vanilla, unknown]",
    "[AllowLoadGameType camelot, unknown]", "[AllowLoadGameType Vanilla]",
    "[ExcludeLoadGameType]", "[ExcludeLoadGameType ]", "[ExcludeLoadGameType vanilla,]",
    "[ExcludeLoadGameType ,vanilla]", "[ExcludeLoadGameType vanilla,,wrath]",
    "[ExcludeLoadGameType vanilla wrath]", "[ExcludeLoadGameType vanilla, unknown]",
    "[ExcludeLoadGameType vanilla] trailing", "[AllowLoadGameType vanilla] [ExcludeLoadGameType wrath]",
    "[AllowLoadTextLocale enUS]",
    "[AllowLoadGameType vanilla", "AllowLoadGameType vanilla]",
    "[AllowLoadGameType vanilla] trailing", "[AllowLoadGameType vanilla] [AllowLoadGameType wrath]",
  }
  for _, condition in ipairs(malformed) do
    -- A later invalid directive must fail before an earlier file can run.
    write(toc, rejected .. "\n" .. first .. " " .. condition)
    rejects(function() emulator.loadAddon(toc, "FixtureAddon", baseDir, "vanilla") end, toc .. ":2:")
    assert(_G.NativeTocRejectedSideEffect == nil)
  end
  for _, line in ipairs({ "[Game]\\file.lua", "[AllowLoadGameType vanilla]" }) do
    write(toc, line)
    rejects(function() emulator.loadAddon(toc, "FixtureAddon", baseDir, "vanilla") end, "malformed TOC file condition")
  end
  for _, directive in ipairs({ "AllowLoadGameType", "ExcludeLoadGameType" }) do
    write(toc, first .. " [" .. directive .. " vanilla]")
    rejects(function() emulator.loadAddon(toc, "FixtureAddon", baseDir) end, "explicit game-type persona")
  end
  rejects(function() emulator.loadAddon(toc, "FixtureAddon", baseDir, "unknown") end, "Unknown TOC game-type persona")
end

local ok, err = pcall(run)
for _, path in ipairs(temporaryFiles) do os.remove(path) end
_G.NativeTocRejectedSideEffect = nil
assert(ok, err)
print("PASS native TOC file selection")
