#!/usr/bin/env lua
-- validators/report-incomplete.lua
--
-- Informational report, never fails (findings surface as GitHub warning annotations):
-- entities without a name, and quests whose zoneOrSort is nil or 0.
--
-- Usage: lua validators/report-incomplete.lua [Flavor]   (default: Forever)

local config = dofile("src/config.lua")
local flavorLoader = dofile("generator/flavor.lua")
local incomplete = dofile("validators/incomplete.lua")

local flavor = config.flavorByName[arg[1] or "Forever"]
if not flavor then error("Unknown flavor: " .. tostring(arg[1]), 0) end

-- Before loading data: the loader leaves a LibStub global behind that the client emulator rejects.
local dynamicRows = incomplete.dynamicQuestRows(flavor.name)
local loaded = flavorLoader.load(flavor, nil, true)

---@param entities table
---@return integer[] ids
local function sortedIds(entities)
  local ids = {}
  for id in pairs(entities) do ids[#ids + 1] = id end
  table.sort(ids)
  return ids
end

---@param title string
---@param lines string[]
local function section(title, lines)
  print(("%s: %d"):format(title, #lines))
  if #lines > 0 then
    -- GitHub Actions turns this line into a warning annotation without failing the step.
    print(("::warning title=%s::%d found, see the step log for the list"):format(title, #lines))
  end
  for _, line in ipairs(lines) do print("  " .. line) end
end

for _, kind in ipairs({ "Npc", "Object", "Item", "Quest" }) do
  local nameKey = loaded[kind].meta.keys.name
  local lines = {}
  for _, id in ipairs(sortedIds(loaded[kind].entities)) do
    local name = loaded[kind].entities[id][nameKey]
    if name == nil or name == "" then lines[#lines + 1] = tostring(id) end
  end
  section(flavor.name .. " " .. kind .. "s without a name", lines)
end

local keys = loaded.Quest.meta.keys
for _, field in ipairs({ "zoneOrSort" }) do
  local missing = {}
  for _, id in ipairs(sortedIds(loaded.Quest.entities)) do
    if incomplete.isMissing(loaded.Quest.entities[id][keys[field]]) then missing[#missing + 1] = id end
  end
  -- Dynamic Corrections can fill the field per faction, so only what they leave open is reported.
  local lines = {}
  for _, item in ipairs(incomplete.unresolved(missing, dynamicRows, keys[field])) do
    local line = ("%d (%s)"):format(item.id, tostring(loaded.Quest.entities[item.id][keys.name]))
    if #item.factions < #incomplete.factions then line = line .. " " .. table.concat(item.factions, ",") end
    lines[#lines + 1] = line
  end
  section(flavor.name .. " quests with " .. field .. " nil or 0", lines)
end
