-- Literal object models read through the public API. The FileDataIDs come from each client's
-- GameObjectDisplayInfo and, where it knows the object, AllTheThings; not from our own files.

local config = dofile("src/config.lua")

-- Flavor and season -> object ID -> expected modelFileId. 0: no model may be shown.
local EXPECTED = {
  { flavor = "Vanilla", models = {
    [31] = 189908, -- Old Lion Statue
    [1941] = 189705, -- Campfire
  } },
  { flavor = "Vanilla", season = "SoD", models = { [31] = 189908, [410020] = 201662 } }, -- Owl Statue
  -- Client caches say 174 for 25328; only CMaNGOS Wrath says otherwise.
  { flavor = "TBC", models = { [31] = 189908, [180055] = 199748, [25328] = 198484 } },
  { flavor = "Wrath", models = { [31] = 189908, [180055] = 199748 } },
  { flavor = "Cata", models = { [31] = 189908, [180055] = 199748 } },
  { flavor = "Mists", models = { [31] = 189908, [180055] = 199748 } },
  { flavor = "Forever", models = {
    [31] = 189908,
    [1941] = 195041, -- Forever gave the Campfire another display than Classic.
    [654846] = 0, -- Displayed as a creature, whose row also carries a FileDataID.
    [457056] = 0, -- Displayed as an item, likewise.
    [652438] = 0, -- Invisible click box.
    [654121] = 0, -- Spell effect.
  } },
}
-- From TBC on, 410020 is an invented cage. It may get a model of its own, but not the statue's.
local OWL_STATUE_FILE = 201662

---@param equal fun(actual: any, expected: any, message: string)
---@param emulator table emulator/metadata.lua
---@param client table emulator/client.lua
return function(equal, emulator, client)
  local load = function(flavorName, season)
    client.reset()
    client.install({ expansion = config.flavorByName[flavorName].expansion, season = season })
    return emulator.loadAddon(config.addonName .. ".toc", config.addonName)
  end

  for _, case in ipairs(EXPECTED) do
    local Lib = load(case.flavor, case.season)
    local where = case.flavor .. " " .. (case.season or "")
    for objectId, fileDataId in pairs(case.models) do
      equal(Lib.Object.modelFileId(objectId), fileDataId, ("%s: model of object %d"):format(where, objectId))
    end
    equal(Lib.Object.modelFileId(999999999), nil, where .. ": an unknown object has no field")
    if case.flavor ~= "Vanilla" then
      equal(Lib.Object.modelFileId(410020) == OWL_STATUE_FILE, false, where .. ": the cage is no statue")
    end
  end

  -- SoD's models are Dynamic rows, which create their object: plain Era must not gain any.
  local Lib = load("Vanilla")
  equal(Lib.Object.Exists(410020), false, "plain Era has no Season of Discovery object")
  equal(Lib.Object.modelFileId(410020), nil, "plain Era has no Season of Discovery model")

  -- Within SoD, every object that has a model also has a name, so none exists for its model alone.
  Lib = load("Vanilla", "SoD")
  local nameless = {}
  for _, objectId in ipairs(Lib.Object.GetAllIds()) do
    if Lib.Object.modelFileId(objectId) ~= 0 and not Lib.Object.name(objectId) then nameless[#nameless + 1] = objectId end
  end
  equal(nameless, {}, "no Season of Discovery object exists only for its model")

  -- Authored Corrections win over generated models, and 0 removes one.
  local registry = Lib.Corrections
  local entities = { [31] = { "Old Lion Statue" }, [32] = { "Sunken Chest", [8] = 111 }, [33] = { "Locked Chest", [8] = 0 } }
  for _, entry in ipairs(registry.Select({ datatype = "Object", dynamic = false })) do
    if entry.name:find("ObjectModels", 1, true) then
      registry.MergeInto(entities, entry.func(), entry.options, entry)
    end
  end
  equal({ entities[31][8], entities[32][8], entities[33][8] }, { 189908, 111, 0 },
    "generated models fill only what no Correction set")
  equal(entities[34], nil, "generated models create no object")
  client.reset()
end
