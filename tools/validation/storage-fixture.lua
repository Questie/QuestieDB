-- Installs small authored rows through the production storage components and real readers.
-- This does not run generate.lua orchestration or production correction/Derived Pass sets.
local lib = dofile("generator/lib.lua")
local encode = dofile("generator/encode.lua")
local rows = dofile("generator/rows.lua")
local l10n = dofile("generator/l10n.lua")
local emulator = dofile("emulator/metadata.lua")
local config = dofile("src/config.lua")
local fixture = {}

local function copy(value)
  if type(value) ~= "table" then return value end
  local result = {}
  for key, child in pairs(value) do result[key] = copy(child) end
  return result
end

function fixture.namespace()
  local db = { Meta = {} }
  for _, path in ipairs(config.runtimeFiles.head) do assert(loadfile(path))("QuestieDB", db) end
  return db
end

---Write actual rows, presence masks, compressed IDs, table fields and localization columns.
---@param translations table Entity type -> ID -> compact field index -> locale slots, as in l10n.extract.
function fixture.write(path, entities, translations)
  local db = fixture.namespace()
  local out = assert(io.open(path, "wb"))
  local ok, err = pcall(function()
    local function emit(key, value)
      lib.writeMetadata(out, key, value, config.maxValueLength)
    end
    emit("X-Flavor", "Vanilla")
    for _, entity in ipairs(config.entityTypes) do
      local meta = db.Meta[entity.name]
      local data = entities[entity.name]
      local prefix = "X-" .. meta.metaPrefix
      emit(prefix .. "IDS", encode.idList(lib.sortedIds(data)))
      for _, id in ipairs(lib.sortedIds(data)) do
        local scalar = rows.build(meta, data[id])
        if scalar then emit(prefix .. id .. "-S", encode.row(scalar)) end
        for index, kind in ipairs(meta.types) do
          if kind == "table" then
            local value = encode.field(meta, index, data[id][index])
            if value then emit(prefix .. id .. "-" .. index, value) end
          end
        end
      end
    end
    l10n.writeHeader(out)
    for _, entity in ipairs(config.entityTypes) do
      l10n.writeMetadata(out, entity.name, translations[entity.name] or {}, lib.sortedIds(entities[entity.name]))
    end
  end)
  out:close()
  assert(ok, err)
  return emulator.parse(path)
end

---Each load owns fresh Source payloads, registry state and read caches.
function fixture.load(mode, entities, metadata)
  local db = fixture.namespace()
  assert(loadfile("src/read/shared.lua"))("QuestieDB", db)
  assert(loadfile("src/corrections/registry.lua"))("QuestieDB", db)
  if mode == "source" then
    assert(loadfile(config.runtimeFiles.sourceReader))("QuestieDB", db)
    db.read.source.payloads = copy(entities)
    db.read.source.RemoveLoaderShim()
  else
    -- Do not mutate the caller's metadata API table when installing the emulator.
    _G.C_AddOns = nil
    emulator.install("QuestieDB", metadata)
    assert(loadfile(config.runtimeFiles.bakedReader))("QuestieDB", db)
  end
  assert(loadfile("src/l10n/overlay.lua"))("QuestieDB", db)
  assert(loadfile("src/api.lua"))("QuestieDB", db)
  return db
end

return fixture
