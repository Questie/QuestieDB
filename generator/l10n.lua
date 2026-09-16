-- generator/l10n.lua
--
-- Entity localization: reads the owned per-locale lookup tables and emits one compressed
-- CBOR column block per locale and entity type.
--
-- This removes Questie's recompile-on-locale-change. A non-enUS client decodes its available
-- entity-type blocks and keeps those translations in memory; enUS uses base data and decodes
-- no localization blocks.
--
-- ## Reading every locale in one run
--
-- Each of the 180 lookup files opens with a client-locale guard:
--
--     if GetLocale() ~= "deDE" then
--         return
--     end
--
-- byte-identical across all of them. So one generation run reads every locale by re-stubbing
-- `GetLocale()` between files — which is exactly what the mocked-environment loader is for.
--
-- ## Memory
--
-- The lookup tree is 214 MB of Lua across 180 files. Entity types are processed one at a time
-- and their metadata written before the next begins, so peak cost is one type's nine locales
-- rather than all four types at once.

local config = dofile("src/config.lua")
local lib = dofile("generator/lib.lua")
local inputs = dofile("generator/l10n-inputs.lua")
local encode = dofile("generator/encode.lua")

local l10n = {}

--------------------------------------------------------------------------------------------
-- Layout
--------------------------------------------------------------------------------------------

-- Input formats and source applicability belong to the import adapter. Keep these aliases
-- for generation tooling that enumerates translated fields or constructs fixture paths.
l10n.types = inputs.types
l10n.lookupPath = inputs.lookupPath

---Fails before Generation opens an artifact when any required lookup file is absent.
---A missing tree is allowed only through the caller's explicit `--no-l10n` choice.
---@param localizationRoot string Local localization directory.
---@param flavors table[] Flavors selected for Generation.
---@param typeFilter table<string, boolean>? Entity types selected for Generation.
---@return nil
function l10n.assertInputs(localizationRoot, flavors, typeFilter)
  local missing, seen = {}, {}

  for _, flavor in ipairs(flavors) do
    for typeName, typeCfg in pairs(l10n.types) do
      if not typeFilter or typeFilter[typeName] then
        for _, locale in ipairs(config.locales) do
          local path = l10n.lookupPath(localizationRoot, flavor, typeCfg, locale)
          if not lib.fileExists(path) then missing[#missing + 1] = path end
        end
        for _, source in ipairs(inputs.correctionSources(flavor, typeName)) do
          local path = localizationRoot .. "/" .. source.path
          if not seen[path] and not lib.fileExists(path) then missing[#missing + 1] = path end
          seen[path] = true
        end
      end
    end
  end

  if #missing == 0 then return end

  table.sort(missing)
  local shown = {}
  for index = 1, math.min(#missing, 5) do shown[#shown + 1] = "  " .. missing[index] end
  if #missing > #shown then
    shown[#shown + 1] = ("  ... and %d more"):format(#missing - #shown)
  end

  error(("l10n: %d required local lookup files are missing. Restore the localization sources " ..
    "or explicitly generate without localization with " ..
    "--no-l10n:\n%s"):format(#missing, table.concat(shown, "\n")), 0)
end

--------------------------------------------------------------------------------------------
-- Extraction
--------------------------------------------------------------------------------------------

---Fold named Static Translation Correction fields into base translations.
---False explicitly clears a translation; missing fields leave earlier values unchanged.
---Entity existence is checked during extraction, so corrections cannot add database entities.
---@param base table id -> named translated fields
---@param corrections table id -> named translated fields or false
---@return nil
function l10n.applyStaticCorrections(base, corrections)
  for id, fields in pairs(corrections) do
    local row = base[id]
    if not row then row = {}; base[id] = row end
    for field, value in pairs(fields) do
      if value == false then row[field] = nil else row[field] = value end
    end
  end
end

---Load one entity type's base translations and Static Translation Corrections.
---@param localizationRoot string Local localization directory.
---@param flavor table
---@param typeName string
---@param knownIds table id -> true; entries with no main-DB row are dropped
---@return table values id -> compact field index -> locale slots
---@return table stats
function l10n.extract(localizationRoot, flavor, typeName, knownIds)
  local typeCfg = l10n.types[typeName]
  local values = {}
  local stats = { locales = 0, entries = 0, filtered = 0, missingFiles = {} }

  for localeIndex, locale in ipairs(config.locales) do
    local path = l10n.lookupPath(localizationRoot, flavor, typeCfg, locale)
    if not lib.fileExists(path) then
      stats.missingFiles[#stats.missingFiles + 1] = path
    else
      local base, corrections = inputs.load(localizationRoot, flavor, typeName, locale)
      for _, rows in ipairs(corrections) do l10n.applyStaticCorrections(base, rows) end
      stats.locales = stats.locales + 1
      for id, row in pairs(base) do
        if knownIds[id] then
          local byField = values[id] or {}
          for fieldIndex, field in ipairs(typeCfg.fields) do
            local value = row[field.name]
            if value ~= nil then
              byField[fieldIndex] = byField[fieldIndex] or {}
              byField[fieldIndex][localeIndex] = value
            end
          end
          if next(byField) then values[id] = byField end
        else
          stats.filtered = stats.filtered + 1
        end
      end
    end
  end

  for _ in pairs(values) do stats.entries = stats.entries + 1 end
  return values, stats
end

--------------------------------------------------------------------------------------------
-- Column blocks
--------------------------------------------------------------------------------------------

---Build one locale's field columns aligned with the entity backend's ascending ID list.
---A missing translation leaves a nil hole, so the runtime falls back to the base field.
---@param typeName string
---@param values table<number, table> Output from l10n.extract.
---@param ids number[] Exact ascending base entity IDs stored in the artifact.
---@param localeIndex number Index in config.locales.
---@return table block Compact field index -> values by base ID position.
---@return integer translatedEntities
---@return integer translatedValues
function l10n.buildBlock(typeName, values, ids, localeIndex)
  local fieldCount = #l10n.types[typeName].fields
  local block = {}
  for fieldIndex = 1, fieldCount do block[fieldIndex] = {} end

  local translatedEntities, translatedValues = 0, 0
  for position, id in ipairs(ids) do
    local byField = values[id]
    local entityHasTranslation = false
    if byField then
      for fieldIndex = 1, fieldCount do
        local slots = byField[fieldIndex]
        local value = slots and slots[localeIndex]
        if value ~= nil then
          block[fieldIndex][position] = value
          translatedValues = translatedValues + 1
          entityHasTranslation = true
        end
      end
    end
    if entityHasTranslation then translatedEntities = translatedEntities + 1 end
  end

  return block, translatedEntities, translatedValues
end

---Write the localization format marker once before any blocks.
---@param out file*
---@return integer lines
function l10n.writeHeader(out)
  return lib.writeMetadata(out, config.l10nHeaderKey, tostring(config.l10nVersion),
    config.maxValueLength)
end

---Write all locale blocks for one entity type.
---@param out file*
---@param typeName string
---@param values table<number, table> Output from l10n.extract.
---@param ids number[] Exact ascending base entity IDs stored in the artifact.
---@return table stats Block count, translated counts, encoded bytes, and emitted lines.
function l10n.writeMetadata(out, typeName, values, ids)
  local stats = { blocks = 0, translatedEntities = 0, translatedValues = 0, bytes = 0, lines = 0 }

  for localeIndex, locale in ipairs(config.locales) do
    local block, entityCount, valueCount = l10n.buildBlock(typeName, values, ids, localeIndex)
    local encoded = encode.compressedCbor(block)
    stats.lines = stats.lines + lib.writeMetadata(out,
      config.l10nBlockKey(typeName, locale), encoded, config.maxValueLength)
    stats.blocks = stats.blocks + 1
    stats.translatedEntities = stats.translatedEntities + entityCount
    stats.translatedValues = stats.translatedValues + valueCount
    stats.bytes = stats.bytes + #encoded
  end

  return stats
end

return l10n
