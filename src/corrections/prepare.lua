-- Resolve constants before any native provider can export functions or write hints.
-- This phase belongs to correction loading, not the standalone enum/support inventory.
local _, LibQuestieDB = ...
local config, enum, flavor = LibQuestieDB.config, LibQuestieDB.Enum, LibQuestieDB.flavor

assert(type(flavor) == "table", "corrections require an explicit flavor")
local configured = config.flavorByName[flavor.name]
assert(configured and configured.expansion == flavor.expansion and configured.rules == flavor.rules,
  "corrections: unsupported flavor")

---Shared invariants win; otherwise require the actual flavor's declared table.
---An empty flavor table is still valid. Never copy, alias another flavor, or fill keys.
---@param name string
---@return table
local function pick(name)
  if enum[name] ~= nil then return enum[name] end
  local expansions = enum.byExpansion
  local selected = expansions and expansions[flavor.expansion]
  assert(type(selected) == "table",
    "corrections: constants are missing expansion data for " .. flavor.expansion)
  local value = selected[name]
  assert(type(value) == "table",
    ("corrections: unknown constant `%s` for expansion `%s`"):format(name, flavor.expansion))
  return value
end

-- Publish only after all required tables resolve. Providers remain lazy, but malformed
-- flavor constants must fail during loading, not on a later entity read.
---@type table<string, table>
local selected = {}
for _, name in ipairs({
  "raceKeys", "classKeys", "npcFlags", "sortKeys", "specialFlags", "factionIDs",
  "questFlags", "itemClasses", "waypointPresets", "zoneIDs", "professionKeys",
  "specializationKeys", "rankNames", "phases",
}) do
  selected[name] = pick(name)
end
enum.corrections = selected
