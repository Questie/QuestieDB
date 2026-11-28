-- validators/incomplete.lua
--
-- Helpers for report-incomplete.lua: a field missing from the corrected data may still be set
-- by a Dynamic Correction, which depends on the player's faction.

local incomplete = {}

incomplete.factions = { "Alliance", "Horde" }

---@param value any
---@return boolean missing
function incomplete.isMissing(value)
  return value == nil or value == 0
end

---Narrows to the entities whose field is still missing for at least one faction.
---@param ids integer[] Entities missing the field in the corrected data.
---@param dynamicRows table<string, table<integer, table<integer, any>>> faction -> id -> field -> value
---@param key integer Field key to look up in the Dynamic rows.
---@return { id: integer, factions: string[] }[] unresolved In `ids` order.
function incomplete.unresolved(ids, dynamicRows, key)
  local result = {}
  for _, id in ipairs(ids) do
    local factions = {}
    for _, faction in ipairs(incomplete.factions) do
      local row = dynamicRows[faction][id]
      if (not row) or incomplete.isMissing(row[key]) then
        factions[#factions + 1] = faction
      end
    end
    if #factions > 0 then result[#result + 1] = { id = id, factions = factions } end
  end
  return result
end

---Runs every Dynamic Quest provider for each faction and keeps the last value per field.
---An empty table is a deletion, so it clears the field.
---@param flavorName string
---@return table<string, table<integer, table<integer, any>>> rows faction -> id -> field -> value
function incomplete.dynamicQuestRows(flavorName)
  local audit = dofile("tools/validation/correction-audit.lua")
  local state = audit.build(flavorName)
  state.runtime.loadCorrections(state.namespace, state.flavor)

  local rows = {}
  for _, faction in ipairs(incomplete.factions) do
    state.env.UnitFactionGroup = function() return faction end
    rows[faction] = {}
    for _, entry in ipairs(state.namespace.Corrections.Select()) do
      if entry.dynamic and entry.datatype == "Quest" then
        for id, fields in pairs(entry.func() or {}) do
          local merged = rows[faction][id] or {}
          rows[faction][id] = merged
          for key, value in pairs(fields) do
            if type(value) == "table" and next(value) == nil then value = nil end
            merged[key] = value
          end
        end
      end
    end
  end
  return rows
end

return incomplete
