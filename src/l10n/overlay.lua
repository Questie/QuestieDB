-- src/l10n/overlay.lua
--
-- The optional localization layer for selected composed entity fields in the active locale.
--
-- Baked artifacts store one compressed CBOR column block per locale and entity type, plus one
-- ascending localization ID list per entity type. Columns index the localization ID list, not
-- the backend's base ID list, so a translation survives for an entity the baked database does
-- not contain (issue #70). A non-enUS client eagerly decodes its available type blocks during
-- addon load and keeps those translations in memory; enUS decodes none.
--
-- Locale changes replace the active blocks and invalidate entity caches. Translations outrank entity
-- Corrections for translatable fields; translated tables pass through shared.lua's copy
-- producer so every caller receives a fresh mutable value.

local _, LibQuestieDB = ...

local overlay = {}

local config = LibQuestieDB.config
local Encoding = C_EncodingUtil

--------------------------------------------------------------------------------------------
-- Locale and field coverage
--------------------------------------------------------------------------------------------

overlay.locales = config.locales
overlay.localeIndex = {}
for index, locale in ipairs(config.locales) do overlay.localeIndex[locale] = index end

overlay.currentLocale = "enUS"
overlay.currentIndex = nil
overlay.onLocaleChanged = {}
overlay.available = false

-- Compact field indices match generator/l10n.lua. They are intentionally separate from entity
-- field indices, which differ by schema.
overlay.fields = {
  Quest = { { name = "name" }, { name = "objectivesText", list = true } },
  Npc = { { name = "name" }, { name = "subName" } },
  Item = { { name = "name" } },
  Object = { { name = "name" } },
}

--------------------------------------------------------------------------------------------
-- Dynamic Translation Corrections
--------------------------------------------------------------------------------------------

-- Owner rank is fixed on its first successful write, independently of entity Corrections.
-- Withdrawn slots retain their position but release their data, so reactivation cannot hoist
-- an earlier translation above a later consumer. Composed rows are indexed by locale and type.
local owners, ownerOrder = {}, {}
local translations, translationOwners = {}, {}
local providers = {}

---Canonicalize the four entity datatype spellings without depending on Corrections.
---@param datatype any
---@return string?
local function canonicalDatatype(datatype)
  if type(datatype) ~= "string" then return nil end
  local canonical = datatype:sub(1, 1):upper() .. datatype:sub(2):lower()
  return overlay.fields[canonical] and canonical or nil
end

---Replace a named translation slot. Nil withdraws it; writes snapshot caller-owned data.
---Any non-empty locale other than enUS is accepted, including locales without Baked blocks.
---Rows may contain only translatable entity field indices.
---@param owner string
---@param locale string
---@param datatype string
---@param name string
---@param rows table? Entity ID -> entity field index -> string or string list.
---@return boolean changed
function overlay.SetCorrection(owner, locale, datatype, name, rows)
  if type(owner) ~= "string" or owner == "" then error("l10n.SetCorrection: owner must be non-empty", 2) end
  if type(locale) ~= "string" or locale == "" or locale == "enUS" then
    error("l10n.SetCorrection: expected a non-empty locale other than enUS", 2)
  end
  local canonical = canonicalDatatype(datatype)
  if not canonical then error("l10n.SetCorrection: unknown entity datatype", 2) end
  if type(name) ~= "string" or name == "" then error("l10n.SetCorrection: name must be non-empty", 2) end
  if rows ~= nil and (type(rows) ~= "table" or getmetatable(rows) ~= nil) then
    error("l10n.SetCorrection: rows must be a plain table or nil", 2)
  end

  -- Validate and copy the complete replacement before changing rank, slots, or caches.
  local snapshot
  if rows then
    snapshot = {}
    local meta = LibQuestieDB.Meta[canonical]
    local allowed = {}
    for _, field in ipairs(overlay.fields[canonical]) do
      allowed[meta.keys[field.name]] = field.list and "list" or "string"
    end
    for id, fields in pairs(rows) do
      if type(id) ~= "number" or id <= 0 or id == math.huge or id % 1 ~= 0 then
        error("l10n.SetCorrection: entity IDs must be positive integers", 2)
      end
      if type(fields) ~= "table" or getmetatable(fields) ~= nil then
        error("l10n.SetCorrection: each entity row must be a plain table", 2)
      end
      local copied = {}
      for key, value in pairs(fields) do
        local shape = allowed[key]
        if not shape then error("l10n.SetCorrection: field is not translatable", 2) end
        if shape == "string" then
          if type(value) ~= "string" or value == "" then
            error("l10n.SetCorrection: translated scalar must be a non-empty string", 2)
          end
          copied[key] = value
        else
          if type(value) ~= "table" or getmetatable(value) ~= nil or next(value) == nil then
            error("l10n.SetCorrection: translated list must be a non-empty string array", 2)
          end
          local list, count = {}, 0
          for index, text in pairs(value) do
            if type(index) ~= "number" or index < 1 or index % 1 ~= 0 or
                index == math.huge or type(text) ~= "string" then
              error("l10n.SetCorrection: translated list must be a string array", 2)
            end
            list[index], count = text, count + 1
          end
          for index = 1, count do
            if list[index] == nil then error("l10n.SetCorrection: translated list must be dense", 2) end
          end
          copied[key] = list
        end
      end
      snapshot[id] = copied
    end
  end

  local record, slot = owners[owner]
  if record then
    for _, candidate in ipairs(record) do
      if candidate.locale == locale and candidate.datatype == canonical and candidate.name == name then
        slot = candidate
        break
      end
    end
  end
  if not snapshot and (not slot or slot.rows == nil) then return false end
  if not record then
    record = {}
    owners[owner] = record
    ownerOrder[#ownerOrder + 1] = owner
  end
  if not slot then
    slot = { locale = locale, datatype = canonical, name = name }
    record[#record + 1] = slot
  end
  slot.rows = snapshot

  -- Only the written locale/type is recomposed. Locale selection does not rerun providers or
  -- touch entity Correction state; inactive-locale writes leave active read caches alone.
  local composed, provenance = {}, {}
  for _, rankedOwner in ipairs(ownerOrder) do
    for _, entry in ipairs(owners[rankedOwner]) do
      if entry.locale == locale and entry.datatype == canonical and entry.rows then
        for id, fields in pairs(entry.rows) do
          local row, ownerRow = composed[id] or {}, provenance[id] or {}
          composed[id], provenance[id] = row, ownerRow
          for key, value in pairs(fields) do row[key], ownerRow[key] = value, rankedOwner end
        end
      end
    end
  end
  translations[locale] = translations[locale] or {}
  translationOwners[locale] = translationOwners[locale] or {}
  translations[locale][canonical] = composed
  translationOwners[locale][canonical] = provenance
  local entity = LibQuestieDB[canonical]
  if locale == overlay.currentLocale and entity then entity.InvalidateCache(nil) end
  return true
end

---Translation-only provenance. Nil means normal entity resolution supplies the value.
---@param datatype string
---@param id number
---@param key string|number
---@return string?
function overlay.GetProvenance(datatype, id, key)
  if type(id) ~= "number" then return nil end
  local canonical = canonicalDatatype(datatype)
  local meta = canonical and LibQuestieDB.Meta[canonical]
  local field = meta and (meta.keys[key] or (type(key) == "number" and key))
  local provider = canonical and providers[canonical]
  local entity = canonical and LibQuestieDB[canonical]
  if entity and not entity.HasL10nProvider() then return nil end
  if not field or not provider or overlay.currentLocale == "enUS" then return nil end
  local _, owner = provider(id, field)
  return owner
end

--------------------------------------------------------------------------------------------
-- Block loading
--------------------------------------------------------------------------------------------

-- Providers close over this variable, not a block snapshot. Locale replacement can therefore
-- release the old blocks after entity-cache invalidation.
local activeBlocks = {}
local availableTypes = {}

--- Localization ID lists, decoded once per entity type and shared by that type's nine locale
--- columns. Lazily built: enUS and an unused type never pay for a decode.
local localizationIds = {}

---@param key string
---@return string? value
local function readStored(key)
  local baked = LibQuestieDB.read and LibQuestieDB.read.baked
  if not baked then return nil end
  return baked.getStored(key)
end

---@param encoded string Base64 zlib CBOR.
---@return table block
local function decodeBlock(encoded)
  return Encoding.DeserializeCBOR(
    Encoding.DecompressString(Encoding.DecodeBase64(encoded), 1))
end

---Decode one entity type's ascending localization ID list, once.
---The list is shared by every locale of that type. It is decoded while a stored locale loads,
---so a missing or corrupt list fails the locale switch atomically rather than surfacing on the
---first translated read; enUS loads no blocks and therefore decodes none.
---A missing list is corruption for an artifact that declares localization.
---@param typeName string
---@return number[] ids
local function getLocalizationIds(typeName)
  local ids = localizationIds[typeName]
  if ids then return ids end

  local key = config.l10nIdsKey(typeName)
  local encoded = readStored(key)
  if not encoded then error("QuestieDB: missing localization ID list " .. key, 0) end
  ids = decodeBlock(encoded)
  if type(ids) ~= "table" then
    error("QuestieDB: localization ID list " .. key .. " did not decode to a table", 0)
  end
  localizationIds[typeName] = ids
  return ids
end

---Decode every selected entity type for one configured locale.
---The caller does not publish the result until this function completes.
---@param locale string
---@return table<string, table> blocks
local function loadLocaleBlocks(locale)
  local blocks = {}
  if not overlay.available or not overlay.localeIndex[locale] then return blocks end

  -- Decode into a temporary table first. A corrupt or incomplete locale must leave the
  -- currently active blocks and entity caches untouched.
  for _, entityType in ipairs(config.entityTypes) do
    local typeName = entityType.name
    if availableTypes[typeName] then
      local key = config.l10nBlockKey(typeName, locale)
      local encoded = readStored(key)
      if not encoded then error("QuestieDB: missing localization block " .. key, 0) end
      local block = decodeBlock(encoded)
      if type(block) ~= "table" then
        error("QuestieDB: localization block " .. key .. " did not decode to a table", 0)
      end
      blocks[typeName] = block
      -- Validate the columns' index here too, so a missing or corrupt ID list fails a locale
      -- switch atomically instead of on the first translated read. Memoized per type, so this
      -- is one decode per session and enUS still pays nothing.
      getLocalizationIds(typeName)
    end
  end
  return blocks
end

--------------------------------------------------------------------------------------------
-- Provider
--------------------------------------------------------------------------------------------

---Build one entity type's provider over the replaceable active block table.
---@param meta table Entity metadata.
---@param entity table Entity global owning the backend ID list.
---@return function? provider `(id, fieldIndex) -> translated | nil`.
---@return table<number, boolean>? scalarFields Translatable scalar field indices.
---@return function? isActive Whether base or Dynamic translations are active.
function overlay.CreateProvider(meta, entity)
  local typeName = meta.entity
  local typeFields = overlay.fields[typeName]
  if not typeFields then return nil end

  local columnByEntityField = {}
  local scalarFields = {}
  for columnIndex, fieldConfig in ipairs(typeFields) do
    local entityFieldIndex = meta.keys[fieldConfig.name]
    if entityFieldIndex then
      columnByEntityField[entityFieldIndex] = columnIndex
      if not fieldConfig.list then scalarFields[entityFieldIndex] = true end
    end
  end

  -- Source startup must stay lazy; the localization ID list is needed only for an active
  -- stored block, and is decoded on first use rather than at load.
  local lastId, lastPosition

  ---Resolve a translated entity ID to the column position Generation used.
  ---Positions index the type's localization ID list, not the backend's base ID list, so an ID
  ---absent from baked entities still has a position when any locale translates it. Name/subname
  ---pairs reuse the same ID, and initialization sweeps advance in ID order; random reads fall
  ---back to binary search.
  ---@param id number
  ---@return integer? position
  local function findPosition(id)
    if id == lastId then return lastPosition end

    local ids = getLocalizationIds(typeName)
    local position
    if lastPosition and ids[lastPosition + 1] == id then
      position = lastPosition + 1
    else
      local low, high = 1, #ids
      while low <= high do
        local middle = math.floor((low + high) / 2)
        local found = ids[middle]
        if found == id then
          position = middle
          break
        elseif found < id then
          low = middle + 1
        else
          high = middle - 1
        end
      end
    end

    lastId, lastPosition = id, position
    return position
  end

  ---Resolve only translations. Entity fallback belongs to shared.lua, not this module.
  ---@param id number
  ---@param entityFieldIndex integer
  ---@return any value
  ---@return string? owner
  local function provider(id, entityFieldIndex)
    if overlay.currentLocale == "enUS" or not columnByEntityField[entityFieldIndex] then return nil end

    local byLocale = translations[overlay.currentLocale]
    local byType = byLocale and byLocale[typeName]
    local row = byType and byType[id]
    local block = activeBlocks[typeName]
    -- Neither layer can answer, so return before the existence probe below. This is what keeps
    -- Source mode's lazy entity initialization intact: it has no stored blocks and usually no
    -- Dynamic rows, so a translated read never forces the composed id union to be built.
    if not row and not block then return nil end

    -- Storage membership never implies entity existence. Positions come from the localization
    -- ID list, which deliberately retains IDs the baked database lacks, so this is the single
    -- place that keeps a retained translation from creating an entity or exposing a
    -- seasonal-only one. A withdrawn Dynamic entity loses its stored translation here too,
    -- without the translation slot or the stored column having to change.
    if not entity.Exists(id) then return nil end

    if row and row[entityFieldIndex] ~= nil then
      return row[entityFieldIndex], translationOwners[overlay.currentLocale][typeName][id][entityFieldIndex]
    end
    if not block then return nil end
    local column = block[columnByEntityField[entityFieldIndex]]
    if not column then return nil end
    local position = findPosition(id)
    local value = position and column[position] or nil
    if value ~= nil then return value, "QuestieDB" end
  end

  providers[typeName] = provider
  return provider, scalarFields, function()
    if overlay.currentLocale == "enUS" then return false end
    local byLocale = translations[overlay.currentLocale]
    return activeBlocks[typeName] ~= nil or (byLocale ~= nil and byLocale[typeName] ~= nil)
  end
end

--------------------------------------------------------------------------------------------
-- Lifecycle
--------------------------------------------------------------------------------------------

---Attach providers and load the client's active locale.
---enUS reads only the format header; non-empty base ID headers identify the types a filtered
---artifact selected, so a missing locale block remains corruption rather than disabling a type.
function overlay.Initialize()
  overlay.available = readStored(config.l10nHeaderKey) == tostring(config.l10nVersion)
  availableTypes = {}

  if overlay.available then
    -- Type-filtered artifacts already publish empty base ID headers for omitted types. Use
    -- those headers as the source of truth so enUS never probes another locale's block data.
    for _, entityType in ipairs(config.entityTypes) do
      local entity = LibQuestieDB[entityType.name]
      local ids = entity and entity.backend.getAllIds()
      availableTypes[entityType.name] = ids ~= nil and #ids > 0
    end
  end

  for _, entityType in ipairs(config.entityTypes) do
    local entity = LibQuestieDB[entityType.name]
    local meta = LibQuestieDB.Meta[entityType.name]
    if entity and meta and entity.SetL10nProvider then
      local provider, scalarFields, isActive = overlay.CreateProvider(meta, entity)
      entity.SetL10nProvider(provider, scalarFields, isActive)
    end
  end

  overlay.SetLocale(overlay.DetectLocale())
end

---The client's UI locale, or enUS when no client function is present.
function overlay.DetectLocale()
  local getLocale = rawget(_G, "GetLocale")
  if type(getLocale) == "function" then return getLocale() end
  return "enUS"
end

---Select a locale atomically; selecting the current locale is a no-op.
---Replacement blocks finish decoding before the old blocks or entity caches are changed.
---@param locale string?
---@return string activeLocale
function overlay.SetLocale(locale)
  locale = locale or "enUS"
  if locale == overlay.currentLocale then return locale end

  local nextBlocks = loadLocaleBlocks(locale)
  activeBlocks = nextBlocks
  overlay.currentLocale = locale
  overlay.currentIndex = overlay.localeIndex[locale]

  -- enUS and a locale with no stored blocks resolve no position, so their ID lists must not
  -- stay resident: ADR 0011's promise is that such a client retains no localization at all.
  -- They are re-decoded on the next switch into a stored locale, exactly like the blocks.
  if next(nextBlocks) == nil then localizationIds = {} end

  for _, entityType in ipairs(config.entityTypes) do
    local entity = LibQuestieDB[entityType.name]
    if entity then entity.InvalidateCache(nil) end
  end

  for _, callback in ipairs(overlay.onLocaleChanged) do callback(locale) end
  return locale
end

---Report whether the artifact declares the supported localization-block format.
---@return boolean available
function overlay.IsAvailable()
  return overlay.available
end

LibQuestieDB.l10n = overlay

return overlay
