-- emulator/metadata.lua
--
-- Stands in for the WoW client's addon-metadata API so a generated database can be proven
-- correct without launching the game.
--
-- Written as a library because Questie's test harness consumes it too: the same emulator
-- backs QuestieDB's round-trip verification, the source/baked equivalence test, and Questie's
-- own unit tests against a real generated artifact.
--
-- Chunk reassembly deliberately does NOT happen here. `GetAddOnMetadata` in a live client
-- returns exactly what is on the line, so an emulator that transparently joined chunks would
-- hide the very code path most likely to be wrong. Reassembly is src/read/baked.lua's job and
-- is exercised through it. `emulator.getValue` is available for callers that want the joined
-- form directly.

local emulator = {}

local concat = table.concat

--------------------------------------------------------------------------------------------
-- Parsing
--------------------------------------------------------------------------------------------

--- Parse a generated .toc into a key/value map.
---
--- `map` holds the `## X-...` directives, which is what the storage format uses and what a
--- client returns from `GetAddOnMetadata`. `header` holds every directive including those, so
--- a caller can check `Interface` and `X-Flavor` without knowing which bucket they land in.
--- A value may legitimately be empty, so the pattern accepts one.
---@param path string
---@return table map key -> value, `X-` directives only
---@return table header every `## Key: value` directive
function emulator.parse(path)
  local map, header = {}, {}
  local file = assert(io.open(path, "rb"), "Cannot open: " .. tostring(path))
  local lineNumber = 0

  for line in file:lines() do
    lineNumber = lineNumber + 1
    -- Tolerate CRLF, which a Windows checkout or a naive editor will introduce.
    line = line:gsub("\r$", "")
    local key, value = line:match("^## ([^:]+): ?(.*)$")
    if key then
      header[key] = value
      if key:sub(1, 2) == "X-" then
        if map[key] ~= nil then
          error(("%s:%d duplicate metadata key %s"):format(path, lineNumber, key), 0)
        end
        map[key] = value
      end
    end
  end

  file:close()
  return map, header
end

--------------------------------------------------------------------------------------------
-- Installation
--------------------------------------------------------------------------------------------

--- Install `C_AddOns.GetAddOnMetadata` over a parsed map, matching the client's signature:
--- `GetAddOnMetadata(addonName, key) -> value or nil`.
---
--- Returns a handle so a caller can swap the backing map — which is how the equivalence test
--- and the corruption test drive the same reader over different data.
---@param addonName string
---@param map table
function emulator.install(addonName, map)
  local handle = { addonName = addonName, map = map }

  local function getAddOnMetadata(requestedAddon, key)
    if requestedAddon ~= handle.addonName then return nil end
    return handle.map[key]
  end

  _G.C_AddOns = _G.C_AddOns or {}
  _G.C_AddOns.GetAddOnMetadata = getAddOnMetadata
  _G.GetAddOnMetadata = getAddOnMetadata

  handle.get = getAddOnMetadata
  return handle
end

--- Parse and install in one step.
---@return table handle
---@return table header
function emulator.load(path, addonName)
  local map, header = emulator.parse(path)
  local handle = emulator.install(addonName or "QuestieDB", map)
  handle.header = header
  return handle, header
end

--------------------------------------------------------------------------------------------
-- Direct access
--------------------------------------------------------------------------------------------

--- Read a value with Chunked metadata values joined. For callers that want the stored value
--- without going through the runtime reader.
function emulator.getValue(map, key)
  local value = map[key]
  if value == nil then return nil end
  local parts = value:match("^~(%d+)~$")
  if not parts then return value end
  parts = tonumber(parts)
  local buffer = {}
  for i = 1, parts do
    local part = map[key .. "-" .. i]
    if part == nil then
      return nil, ("key %s declares %d parts but part %d is missing"):format(key, parts, i)
    end
    buffer[i] = part
  end
  return concat(buffer)
end

--------------------------------------------------------------------------------------------
-- Native file selection (only the subset emitted by QuestieDB)
--------------------------------------------------------------------------------------------

---@alias EmulatorGameType "vanilla"|"tbc"|"wrath"|"cata"|"mists"|"forever"
---@alias EmulatorTextLocale "enUS"|"deDE"|"esES"|"esMX"|"frFR"|"itIT"|"koKR"|"ptBR"|"ruRU"|"zhCN"|"zhTW"

---@type table<string, boolean>
local gameTypes = { vanilla = true, tbc = true, wrath = true, cata = true, mists = true, forever = true }

-- The values GetLocale() can return; AllowLoadTextLocale takes the same tokens.
---@type table<string, boolean>
local textLocales = {
  enUS = true, deDE = true, esES = true, esMX = true, frFR = true, itIT = true,
  koKR = true, ptBR = true, ruRU = true, zhCN = true, zhTW = true,
}

---@class EmulatorFileCondition
---@field persona "game-type"|"text-locale" The client fact it tests; one condition per fact.
---@field tokens table<string, boolean> Accepted tokens.
---@field exclude boolean? Select when the persona is NOT listed.

---@type table<string, EmulatorFileCondition>
local conditions = {
  AllowLoadGameType = { persona = "game-type", tokens = gameTypes },
  ExcludeLoadGameType = { persona = "game-type", tokens = gameTypes, exclude = true },
  AllowLoadTextLocale = { persona = "text-locale", tokens = textLocales },
}

---Parse and evaluate a file line; return its normalized path only when selected.
---Blank lines and comments (including metadata) return nil. XML remains ignored by this
---Lua-only loader. A path may be followed by at most one game-type condition
---(AllowLoadGameType or ExcludeLoadGameType) and one AllowLoadTextLocale condition, in either
---order; every condition must hold. Unknown tokens are rejected, not modeled as a particular
---client's recognition set.
---@param line string
---@param gameType EmulatorGameType? Required for game-type conditions; never inferred from paths.
---@param textLocale EmulatorTextLocale? Required, and validated, only for text-locale conditions.
---Condition-free lines never depend on it.
---@return string? path Selected Lua file path.
function emulator.selectFile(line, gameType, textLocale)
  if gameType ~= nil and not gameTypes[gameType] then
    error("Unknown TOC game-type persona: " .. tostring(gameType), 0)
  end
  line = line:match("^%s*(.-)%s*$")
  if line == "" or line:sub(1, 1) == "#" then return nil end

  local path = line
  if line:find("[%[%]]") then
    local rest
    path, rest = line:match("^([^%[%]]-)%s+(%[.*)$")
    if not path or path == "" then error("Unsupported or malformed TOC file condition: " .. line, 0) end

    -- Evaluate every condition before deciding, so a malformed later one cannot hide.
    -- Blizzard's own Classic TOCs separate conditions with and without a space
    -- (Blizzard_Fonts_Shared.toc: `[AllowLoad Glue][AllowLoadGameType classic]`).
    local selected, seen, position = true, {}, 1
    repeat
      local directive, tokens, nextPosition = rest:match("^%[(%a+)%s+([^%[%]]+)%]%s*()", position)
      local condition = conditions[directive]
      if not condition or seen[condition.persona] then
        error("Unsupported or malformed TOC file condition: " .. line, 0)
      end
      seen[condition.persona] = true
      local persona = textLocale
      if condition.persona == "game-type" then
        persona = gameType
      elseif textLocale ~= nil and not textLocales[textLocale] then
        error("Unknown TOC text-locale persona: " .. tostring(textLocale), 0)
      end
      local listed = false
      for token in (tokens .. ","):gmatch("(.-),") do
        token = token:match("^%s*(.-)%s*$")
        if not condition.tokens[token] then
          error("Unknown or malformed " .. directive .. " token: " .. token, 0)
        end
        if token == persona then listed = true end
      end
      if persona == nil then
        error("Conditional TOC file requires an explicit " .. condition.persona .. " persona", 0)
      end
      if condition.exclude then listed = not listed end
      if not listed then selected = false end
      position = nextPosition
    until position > #rest
    if not selected then return nil end
  end

  path = path:gsub("\\", "/")
  if path:find("%.xml$") then return nil end
  return path
end

--------------------------------------------------------------------------------------------
-- Addon bootstrap
--------------------------------------------------------------------------------------------

--- Execute the selected Lua files a Source or Baked TOC lists, in order.
--- This is what makes the offline harness exercise the *shipped* reader rather than a copy of
--- it: the same src/ files the client loads, loaded the same way.
---
--- `baseDir` resolves the listed files against another root — pointing it at an unpacked
--- release zip loads the runtime a user actually installs (with its static correction bodies
--- stripped by tools/distribution/strip-static.lua) instead of the working tree's copies.
---
--- The text-locale persona is whatever the installed `GetLocale` stand-in returns, so native
--- file selection can never disagree with the GetLocale() guards inside the loaded files.
---@param tocPath string
---@param addonName string?
---@param baseDir string? Root the TOC's file list resolves against; default the working dir
---@param gameType EmulatorGameType? Explicit native persona; required for game-type conditions.
---@return table addonTable The addon namespace, i.e. LibQuestieDB
---@return table files Selected file paths, in execution order.
function emulator.loadAddon(tocPath, addonName, baseDir, gameType)
  gameType = gameType or rawget(_G, "QUESTIEDB_EMULATOR_GAME_TYPE")
  local getLocale = rawget(_G, "GetLocale")
  local textLocale = type(getLocale) == "function" and getLocale() or nil
  addonName = addonName or "QuestieDB"
  local addonTable = {}

  local file = assert(io.open(tocPath, "rb"), "Cannot open: " .. tostring(tocPath))
  local files = {}
  local lineNumber = 0
  -- Resolve the whole list before executing anything, and close the TOC on syntax errors.
  for line in file:lines() do
    lineNumber = lineNumber + 1
    local ok, path = pcall(emulator.selectFile, line, gameType, textLocale)
    if not ok then
      file:close()
      error(("%s:%d: %s"):format(tocPath, lineNumber, path), 0)
    end
    if path then files[#files + 1] = path end
  end
  file:close()

  for _, relativePath in ipairs(files) do
    local path = baseDir and (baseDir .. "/" .. relativePath) or relativePath
    local chunk, err = loadfile(path)
    if not chunk then
      error("Cannot load " .. path .. ": " .. tostring(err), 0)
    end
    local ok, execErr = pcall(chunk, addonName, addonTable)
    if not ok then
      error("Error loading " .. path .. ": " .. tostring(execErr), 0)
    end
  end

  return addonTable, files
end

return emulator
