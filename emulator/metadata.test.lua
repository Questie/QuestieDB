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
-- loadAddon takes its text-locale persona from the GetLocale stand-in; restore the caller's.
local savedGetLocale = rawget(_G, "GetLocale")
_G.GetLocale = nil

---@param locale string?
local function installLocale(locale)
  _G.GetLocale = locale and function() return locale end or nil
end

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
  for _, gameType in ipairs({ "vanilla", "tbc", "wrath", "cata", "mists", "forever" }) do
    local ns, files = emulator.loadAddon(toc, "FixtureAddon", baseDir, gameType)
    local middle = gameType == "forever" and "forever" or "legacy"
    assert(table.concat(ns.order, ",") == "first," .. middle .. ",last")
    assert(table.concat(files, ",") == first .. "," .. stem .. "-" .. middle .. ".lua," .. last)
  end

  -- A rejected file neither executes nor needs to exist or contain valid Lua.
  write(toc, rejected .. " [ExcludeLoadGameType vanilla, tbc, wrath, cata, mists]\n" ..
    "missing.lua [ExcludeLoadGameType vanilla, tbc, wrath, cata, mists]\n" .. first .. "\n" .. last)
  local ns = emulator.loadAddon(toc, "FixtureAddon", baseDir, "vanilla")
  assert(table.concat(ns.order, ",") == "first,last")
  assert(_G.NativeTocRejectedSideEffect == nil)
  rejects(function() emulator.loadAddon(toc, "FixtureAddon", baseDir, "forever") end,
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

  -- A text-locale condition needs no game type, and lists any number of locales.
  assert(emulator.selectFile("src/file.lua [AllowLoadTextLocale deDE, frFR]", nil, "frFR") == "src/file.lua")
  assert(emulator.selectFile("src/file.lua [AllowLoadTextLocale deDE, frFR]", nil, "enUS") == nil)
  -- Conditions combine with AND, in either order and with or without a separating space.
  for _, line in ipairs({
    " src\\file.lua [ExcludeLoadGameType vanilla, tbc] [AllowLoadTextLocale deDE] \r",
    "src/file.lua [AllowLoadTextLocale deDE][ExcludeLoadGameType vanilla, tbc]",
  }) do
    assert(emulator.selectFile(line, "forever", "deDE") == "src/file.lua", line)
    assert(emulator.selectFile(line, "forever", "frFR") == nil, line)
    assert(emulator.selectFile(line, "vanilla", "deDE") == nil, line)
    assert(emulator.selectFile(line, "vanilla", "frFR") == nil, line)
  end

  -- loadAddon selects by the GetLocale stand-in; an unselected locale file need not exist.
  write(toc, first .. "\n" .. legacy .. " [AllowLoadGameType vanilla] [AllowLoadTextLocale deDE]\n" ..
    rejected .. " [AllowLoadGameType vanilla] [AllowLoadTextLocale frFR]\n" ..
    "missing.lua [AllowLoadTextLocale frFR]\n" .. last)
  installLocale("deDE")
  ns = emulator.loadAddon(toc, "FixtureAddon", baseDir, "vanilla")
  assert(table.concat(ns.order, ",") == "first,legacy,last")
  installLocale("enUS")
  ns = emulator.loadAddon(toc, "FixtureAddon", baseDir, "vanilla")
  assert(table.concat(ns.order, ",") == "first,last")
  assert(_G.NativeTocRejectedSideEffect == nil)
  installLocale("xxXX")
  rejects(function() emulator.loadAddon(toc, "FixtureAddon", baseDir, "vanilla") end,
    "Unknown TOC text-locale persona")
  -- Only text-locale conditions consult the persona: a condition-free (Baked) list still loads.
  write(toc, first .. "\n" .. last)
  ns = emulator.loadAddon(toc, "FixtureAddon", baseDir)
  assert(table.concat(ns.order, ",") == "first,last")
  write(toc, first .. "\n" .. legacy .. " [AllowLoadGameType vanilla] [AllowLoadTextLocale deDE]\n" .. last)
  installLocale(nil)
  rejects(function() emulator.loadAddon(toc, "FixtureAddon", baseDir, "vanilla") end,
    "explicit text-locale persona")

  local malformed = {
    "[AllowLoadGameType]", "[AllowLoadGameType ]", "[AllowLoadGameType vanilla,]",
    "[AllowLoadGameType ,vanilla]", "[AllowLoadGameType vanilla,,wrath]",
    "[AllowLoadGameType vanilla wrath]", "[AllowLoadGameType vanilla, unknown]",
    "[AllowLoadGameType forever, unknown]", "[AllowLoadGameType Vanilla]",
    "[ExcludeLoadGameType]", "[ExcludeLoadGameType ]", "[ExcludeLoadGameType vanilla,]",
    "[ExcludeLoadGameType ,vanilla]", "[ExcludeLoadGameType vanilla,,wrath]",
    "[ExcludeLoadGameType vanilla wrath]", "[ExcludeLoadGameType vanilla, unknown]",
    "[ExcludeLoadGameType vanilla] trailing", "[AllowLoadGameType vanilla] [ExcludeLoadGameType wrath]",
    "[AllowLoadGameType vanilla", "AllowLoadGameType vanilla]",
    "[AllowLoadGameType vanilla] trailing", "[AllowLoadGameType vanilla] [AllowLoadGameType wrath]",
    "[AllowLoadTextLocale]", "[AllowLoadTextLocale ]", "[AllowLoadTextLocale deDE,]",
    "[AllowLoadTextLocale deDE frFR]", "[AllowLoadTextLocale deDE, xxXX]",
    "[AllowLoadTextLocale deDE] [AllowLoadTextLocale frFR]",
    "[AllowLoadTextLocale deDE] [AllowLoadGameType vanilla] trailing",
    "[AllowLoadGameType vanilla] [AllowLoadTextLocale deDE] [ExcludeLoadGameType wrath]",
    "[ExcludeLoadTextLocale deDE]",
  }
  installLocale("deDE")
  for _, condition in ipairs(malformed) do
    -- A later invalid directive must fail before an earlier file can run.
    write(toc, rejected .. "\n" .. first .. " " .. condition)
    rejects(function() emulator.loadAddon(toc, "FixtureAddon", baseDir, "vanilla") end, toc .. ":2:")
    assert(_G.NativeTocRejectedSideEffect == nil)
  end
  for _, line in ipairs({ "[Game]\\file.lua", "[AllowLoadGameType vanilla]", "[AllowLoadTextLocale deDE] " .. first }) do
    write(toc, line)
    rejects(function() emulator.loadAddon(toc, "FixtureAddon", baseDir, "vanilla") end, "malformed TOC file condition")
  end
  for _, directive in ipairs({ "AllowLoadGameType", "ExcludeLoadGameType" }) do
    write(toc, first .. " [" .. directive .. " vanilla]")
    rejects(function() emulator.loadAddon(toc, "FixtureAddon", baseDir) end, "explicit game-type persona")
    -- A text-locale persona must not stand in for the missing game type.
    write(toc, first .. " [" .. directive .. " vanilla] [AllowLoadTextLocale deDE]")
    rejects(function() emulator.loadAddon(toc, "FixtureAddon", baseDir) end, "explicit game-type persona")
  end
  rejects(function() emulator.loadAddon(toc, "FixtureAddon", baseDir, "unknown") end, "Unknown TOC game-type persona")
end

local ok, err = pcall(run)
for _, path in ipairs(temporaryFiles) do os.remove(path) end
_G.NativeTocRejectedSideEffect = nil
_G.GetLocale = savedGetLocale
assert(ok, err)
print("PASS native TOC file selection")
