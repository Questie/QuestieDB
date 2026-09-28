-- generator/corrections.lua
--
-- Static Corrections are folded into the TOC metadata store during Generation and never ship
-- to end users. Source mode applies them to base data through the *same* registry, so "what I
-- see in dev is what ships" follows from shared code rather than from a test.

local runtime = dofile("generator/runtime.lua")

local corrections = {}

--- Per-flavor cache: loading 10 MB of correction files once per flavor is enough.
local prepared = {}

---Stand up the shipped registry and load every correction file this flavor uses.
---@param flavor table An entry from config.flavors.
---@return table context Freshly prepared or cached `{ lib, registered, files }` context.
function corrections.prepare(flavor)
  local key = flavor and flavor.name or "*"
  if prepared[key] then return prepared[key] end

  local LibQuestieDB = runtime.build()
  local registered, files = runtime.loadCorrections(LibQuestieDB, flavor)

  prepared[key] = { lib = LibQuestieDB, registered = registered, files = files }
  return prepared[key]
end

--- Apply every Static Correction owned by QuestieDB to a set of loaded entity tables.
---
--- The generator runs offline with only QuestieDB present, so it can only ever bake
--- corrections owned by QuestieDB — which is why the owner filter is explicit here rather
--- than assumed. Anything Questie or a third party registers is Dynamic by definition.
---@param loaded table entityTypeName -> { meta, entities, path }
---@param flavor table An entry from config.flavors
---@return number applied
---@return table stats
function corrections.applyStatic(loaded, flavor)
  local context = corrections.prepare(flavor)
  local registry = context.lib.Corrections

  local applied = 0
  local stats = { registered = context.registered, files = context.files, byType = {} }

  for name, entry in pairs(loaded) do
    local count = registry.ApplyStaticToEntities(name, entry.entities, flavor, registry.OWNER)
    stats.byType[name] = count
    applied = applied + count
  end

  return applied, stats
end

---The prepared registry, so verification can inspect the exact entries Generation used.
---@param flavor table An entry from config.flavors.
---@return table registry
function corrections.registryFor(flavor)
  return corrections.prepare(flavor).lib.Corrections
end

return corrections
