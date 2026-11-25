#!/usr/bin/env lua
-- validators/report-incomplete.lua
--
-- Informational report, never fails (findings surface as GitHub warning annotations): entities without a name, and quests whose requiredLevel
-- or zoneOrSort is nil or 0.
--
-- Usage: lua validators/report-incomplete.lua [Flavor]   (default: Forever)

local config = dofile("src/config.lua")
local flavorLoader = dofile("generator/flavor.lua")

local flavor = config.flavorByName[arg[1] or "Forever"]
if not flavor then error("Unknown flavor: " .. tostring(arg[1]), 0) end

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
for _, field in ipairs({ "requiredLevel", "zoneOrSort" }) do
  local lines = {}
  for _, id in ipairs(sortedIds(loaded.Quest.entities)) do
    local quest = loaded.Quest.entities[id]
    local value = quest[keys[field]]
    if value == nil or value == 0 then
      lines[#lines + 1] = ("%d (%s)"):format(id, tostring(quest[keys.name]))
    end
  end
  section(flavor.name .. " quests with " .. field .. " nil or 0", lines)
end
