-- tools/object-models/objects.lua
--
-- Lists every object of the composed view, for the Python object-model tools.
-- Run from the QuestieDB root: lua tools/object-models/objects.lua [flavor ...]
--
-- Reads through the public API of the shipped Source-mode addon, so base data, Static and
-- Dynamic Corrections compose exactly as they do for a consumer. Output is one tab-separated
-- line per flavor and object, ascending: flavor, object ID, role, English name (may be empty).

local config = dofile("src/config.lua")
local emulator = dofile("emulator/metadata.lua")
local client = dofile("emulator/client.lua")

-- Seasonal sets only register on their own realm, and add objects of their own.
local SEASONS = { Vanilla = { "SoD" }, Wrath = { "TitanReforged" } }

-- Strongest relation to a quest wins across personas.
local RANK = { other = 1, drop = 2, objective = 3, quest = 4 }

---@class ComposedObject
---@field name string?
---@field role "quest"|"objective"|"drop"|"other"

---@param objects table<ObjectId, ComposedObject>
---@param id ObjectId
---@param role "quest"|"objective"|"drop"
local function raise(objects, id, role)
  local object = objects[id]
  if object and RANK[role] > RANK[object.role] then object.role = role end
end

---Objects that drop one item, when a quest wants that item or it starts a quest.
local function raiseDrops(objects, itemId)
  for _, id in pairs(ItemDB.objectDrops(itemId) or {}) do raise(objects, id, "drop") end
end

---Merge one client persona's composed view into `objects`.
---@param objects table<ObjectId, ComposedObject>
---@param flavor table
---@param persona table emulator/client.lua options.
local function collect(objects, flavor, persona)
  persona.expansion = flavor.expansion
  client.reset()
  client.install(persona)
  emulator.loadAddon(config.addonName .. ".toc", config.addonName)

  for _, id in ipairs(ObjectDB.GetAllIds()) do
    local object = objects[id]
    if not object then
      object = { role = "other" }
      objects[id] = object
    end
    object.name = object.name or ObjectDB.name(id)
    if ObjectDB.questStarts(id) or ObjectDB.questEnds(id) then raise(objects, id, "quest") end
  end

  for _, questId in ipairs(QuestDB.GetAllIds()) do
    -- Givers and enders. Reference tables hold NPCs at 1 and objects at 2.
    for _, reference in ipairs({ QuestDB.startedBy(questId) or {}, QuestDB.finishedBy(questId) or {} }) do
      for _, id in pairs(reference[2] or {}) do raise(objects, id, "quest") end
    end

    -- Objectives: objects at 2, items at 3.
    local objectives = QuestDB.objectives(questId) or {}
    for _, objective in pairs(objectives[2] or {}) do raise(objects, objective[1], "objective") end
    for _, objective in pairs(objectives[3] or {}) do raiseDrops(objects, objective[1]) end
    for _, itemId in pairs(QuestDB.requiredSourceItems(questId) or {}) do raiseDrops(objects, itemId) end

    -- Extra objectives may point at objects through their reference list.
    for _, extra in pairs(QuestDB.extraObjectives(questId) or {}) do
      for _, reference in pairs(extra[5] or {}) do
        if reference[1] == "object" then raise(objects, reference[2], "objective") end
      end
    end
  end

  for _, itemId in ipairs(ItemDB.GetAllIds()) do
    if (ItemDB.startQuest(itemId) or 0) ~= 0 then raiseDrops(objects, itemId) end
  end
end

local selected = {}
for _, name in ipairs(arg) do
  selected[#selected + 1] = config.flavorByName[name] or error("Unknown flavor: " .. name, 0)
end

for _, flavor in ipairs(#selected > 0 and selected or config.flavors) do
  ---@type table<ObjectId, ComposedObject>
  local objects = {}
  for _, faction in ipairs({ "Alliance", "Horde" }) do
    collect(objects, flavor, { faction = faction })
    for _, season in ipairs(SEASONS[flavor.name] or {}) do
      collect(objects, flavor, { faction = faction, season = season })
    end
  end

  local ids = {}
  for id in pairs(objects) do ids[#ids + 1] = id end
  table.sort(ids)
  for _, id in ipairs(ids) do
    local name = (objects[id].name or ""):gsub("%s", " ")
    io.write(flavor.name, "\t", id, "\t", objects[id].role, "\t", name, "\n")
  end
end
