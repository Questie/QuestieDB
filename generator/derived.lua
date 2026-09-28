-- generator/derived.lua
--
-- Runs Derived Passes offline, over the same tables Generation is about to encode.
--
-- Mirrors generator/corrections.lua: the passes themselves live in src/derived/ and are shared
-- with Source mode, so this file only supplies entity tables, schema and flavor.
-- Shared constants already live in the prepared correction namespace.

local corrections = dofile("generator/corrections.lua")

local derived = {}

---Returns the shared Derived Pass registry prepared for one flavor.
---@param flavor table An entry from config.flavors.
---@return table? registry
local function registryFor(flavor)
  local LibQuestieDB = corrections.prepare(flavor).lib
  return LibQuestieDB and LibQuestieDB.Derived
end

---Expands requested output types with the inputs their active Derived Passes need.
---@param typeFilter table<string, boolean>? Requested output entity types; nil means all types.
---@param flavor table An entry from config.flavors.
---@return table<string, boolean>? expanded Independent working-set filter, or nil for all types.
function derived.expandReadDependencies(typeFilter, flavor)
  local registry = registryFor(flavor)
  if not registry then return typeFilter end
  return registry.ExpandReadDependencies(typeFilter, flavor)
end

--- Run every Derived Pass over one flavor's loaded tables.
---
--- Called from generator/flavor.lua after Static Corrections, which puts it in the pipeline
--- for generate.lua, verify.lua and reconstruct.lua at once — they all route through
--- flavorLoader.load, so they cannot disagree about what the stored bytes should be.
---@param loaded table entityTypeName -> { meta, entities, path }
---@param flavor table An entry from config.flavors
---@return number ran How many passes executed
function derived.run(loaded, flavor)
  local registry = registryFor(flavor)
  if not registry then return 0 end

  return registry.Run(nil, {
    flavor = flavor,
    entities = function(name)
      local entry = loaded[name]
      return entry and entry.entities or nil
    end,
    meta = function(name)
      local entry = loaded[name]
      return entry and entry.meta or nil
    end,
  })
end

return derived
