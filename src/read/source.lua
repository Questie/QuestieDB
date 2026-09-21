-- src/read/source.lua
--
-- Source mode: entity reads resolve from raw entity data, with Static Corrections applied
-- live, because no generated TOC metadata store is present.
--
-- A fresh clone junctioned into `AddOns` is a working development environment with no
-- download and no Lua toolchain. Generating or bootstrapping a suffixed TOC switches the same
-- folder to Baked mode with no code change, because the client searches for flavour-suffixed
-- TOCs first and falls back to the base one only if none are found.
--
-- This file and src/read/baked.lua are the only two places the modes diverge. Both provide
-- exactly `readField(id, fieldIndex)` and `getAllIds()`.
--
-- ## Why this file loads before the data
--
-- Native file conditions select the payloads before Lua runs. This shim captures their
-- deferred strings without materializing tables until a consumer reads them.

local _, LibQuestieDB = ...

local config = LibQuestieDB.config
local normalize = LibQuestieDB.Meta.normalize

local source = {}

--------------------------------------------------------------------------------------------
-- Flavor detection
--------------------------------------------------------------------------------------------

source.flavor = assert(LibQuestieDB.flavor, "QuestieDB: no native Source flavor selected")
source.expansion = source.flavor.expansion

--------------------------------------------------------------------------------------------
-- Payload capture
--------------------------------------------------------------------------------------------

--- entityTypeName -> the `[[return {...}]]` payload string for the running client
source.payloads = {}

---Native-selected data files assign both their key enum and their deferred payload.
local capture = setmetatable({}, {
  __newindex = function(tbl, key, value)
    for _, entityType in ipairs(config.entityTypes) do
      if key == entityType.dataField then
        source.payloads[entityType.name] = value
        return
      end
    end
    -- Key enums and anything else a data file assigns are harmless and small; keep them so a
    -- file that reads back what it wrote still works.
    rawset(tbl, key, value)
  end,
})

--- Install the shim, remembering whatever was there so it can be handed back. QuestieDB
--- loads before its consumer, so squatting on `QuestieLoader` for the duration of the data
--- block is safe as long as it is given up afterwards.
function source.InstallLoaderShim()
  source.previousQuestieLoader = rawget(_G, "QuestieLoader")
  local modules = { QuestieDB = capture }
  _G.QuestieLoader = {
    ImportModule = function(_, name)
      modules[name] = modules[name] or {}
      return modules[name]
    end,
    CreateModule = function(_, name)
      modules[name] = modules[name] or {}
      return modules[name]
    end,
  }
end

--- Hand `QuestieLoader` back. Called by the marker file that closes the data block.
function source.RemoveLoaderShim()
  _G.QuestieLoader = source.previousQuestieLoader
  source.previousQuestieLoader = nil
end

source.InstallLoaderShim()

--------------------------------------------------------------------------------------------
-- Backend
--------------------------------------------------------------------------------------------

--- entityTypeName -> decoded id -> field array. Populated on first read.
source.entities = {}

--- Decode one entity type's payload and fold in Static Corrections.
---
--- Generation applies Static Corrections through this same path, which is what makes "what I
--- see in dev is what ships" a property of shared code rather than of a test — and why
--- *deleting* a correction is observable here, which an overlay-based dev addon could never
--- manage.
local function materialize(entityTypeName)
  local existing = source.entities[entityTypeName]
  if existing then return existing end

  local payload = source.payloads[entityTypeName]
  local entities
  if payload == nil then
    entities = {}
  elseif type(payload) == "table" then
    entities = payload
  else
    local chunk = loadstring(payload, "QuestieDB:" .. entityTypeName .. "Data")
    entities = chunk and chunk() or {}
  end

  source.entities[entityTypeName] = entities
  source.payloads[entityTypeName] = nil -- release the string

  local corrections = LibQuestieDB.Corrections
  if corrections and corrections.ApplyStaticToEntities then
    corrections.ApplyStaticToEntities(entityTypeName, entities, source.flavor)
  end

  -- Derived Passes, on corrected raw values and before the read path normalizes them. This is
  -- the same point Generation runs them (generator/flavor.lua), which is what keeps the two
  -- modes equivalent by construction rather than by test. A pass that reads another entity
  -- type gets it through `materialize` here, so the dependency resolves lazily; the assignment
  -- to `source.entities` above is the re-entrancy guard that makes that safe.
  local derived = LibQuestieDB.Derived
  if derived then
    derived.Run(entityTypeName, {
      flavor = source.flavor,
      entities = materialize,
      meta = function(name) return LibQuestieDB.Meta and LibQuestieDB.Meta[name] end,
      support = function(name)
        local support = LibQuestieDB.Support
        return support and support.Get and support.Get(name) or nil
      end,
    })
  end

  -- Base data is frozen after load, so neither a Correction nor a consumer can corrupt it.
  if LibQuestieDB.shared and LibQuestieDB.shared.Freeze then
    LibQuestieDB.shared.Freeze(entities)
  end

  return entities
end

source.Materialize = materialize

--- Build the Source-mode backend for one entity type.
function source.CreateBackend(meta)
  local backend = { mode = "source" }
  local idList, idMap

  function backend.readField(id, fieldIndex)
    local row = materialize(meta.entity)[id]
    if row == nil then return nil end
    -- Normalization runs here rather than in shared.lua so that both modes reach the same
    -- value by construction: Generation encodes through the same function, so an empty table
    -- or a {0,0} pair is nil in exactly the same places.
    return normalize.field(meta, fieldIndex, row[fieldIndex])
  end

  function backend.getAllIds()
    if not idList then
      local entities = materialize(meta.entity)
      idList, idMap = {}, {}
      for id in pairs(entities) do
        if type(id) == "number" then
          idList[#idList + 1] = id
          idMap[id] = true
        end
      end
      table.sort(idList)
    end
    return idList, idMap
  end

  return backend
end

LibQuestieDB.read = LibQuestieDB.read or {}
LibQuestieDB.read.source = source
LibQuestieDB.mode = "source"

return source
