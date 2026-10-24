-- src/l10n/source/_end.lua
--
-- Closes the Source-mode lookup block and publishes a lazy per-type row builder for the
-- overlay. Layering matches Generation (generator/l10n-inputs.lua): base lookups, then
-- Forever trace lookups merged per field, then whole-row lookup overrides.

local _, LibQuestieDB = ...

local capture = LibQuestieDB.__l10nSourceCapture
LibQuestieDB.__l10nSourceCapture = nil
_G.QuestieLoader = capture.previousLoader
_G.Questie = capture.previousQuestie

local module, locale = capture.module, capture.locale

local types = {
  Quest = { field = "questLookup", override = "questLookupOverrides",
    fields = { { name = "name", from = 1 }, { name = "objectivesText", from = 2, list = true } } },
  Npc = { field = "npcNameLookup", fields = { { name = "name", from = 1 }, { name = "subName", from = 2 } } },
  Item = { field = "itemLookup", override = "itemLookupOverrides", scalar = true, fields = { { name = "name" } } },
  Object = { field = "objectLookup", scalar = true, fields = { { name = "name" } } },
}

---@param payload any Table or deferred loadstring chunk.
---@return table
local function resolve(payload)
  if type(payload) == "function" then payload = payload() end
  return type(payload) == "table" and payload or {}
end

---Fold one lookup layer into rows keyed by entity field index.
---@param rows table
---@param payload table
---@param cfg table
---@param keys table Entity metadata keys.
---@param replaceRows boolean Clear fields omitted from a row.
local function apply(rows, payload, cfg, keys, replaceRows)
  for id, source in pairs(payload) do
    local row = rows[id] or {}
    for _, field in ipairs(cfg.fields) do
      local value
      if cfg.scalar then value = source else value = source[field.from] end
      if field.list then
        if type(value) == "string" and value ~= "" then value = { value }
        elseif type(value) ~= "table" or next(value) == nil then value = nil end
      elseif type(value) == "string" then
        value = value:gsub("[%z\1-\31\127]", ""):match("^[ \t\r\n]*(.-)[ \t\r\n]*$")
        if value == "" then value = nil end
      end
      local index = keys[field.name]
      if value ~= nil then row[index] = value
      elseif replaceRows then row[index] = nil end
    end
    rows[id] = next(row) and row or nil
  end
end

LibQuestieDB.l10nSource = {
  locale = locale,
  ---Build one entity type's translations for the captured locale.
  ---@param typeName string
  ---@param keys table Entity metadata keys.
  ---@return table rows id -> entity field index -> translated value
  load = function(typeName, keys)
    local cfg = types[typeName]
    local rows = {}
    if not cfg then return rows end
    apply(rows, resolve(capture.base and capture.base[cfg.field][locale]), cfg, keys, false)
    apply(rows, resolve(module[cfg.field][locale]), cfg, keys, false)
    if cfg.override then apply(rows, resolve(module[cfg.override]), cfg, keys, true) end
    return rows
  end,
}
