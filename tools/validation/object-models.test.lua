-- Literal object models read through the public API. The FileDataIDs come from each client's
-- GameObjectDisplayInfo and, where it knows the object, AllTheThings; not from our own files.

local config = dofile("src/config.lua")
local lib = dofile("generator/lib.lua")

-- Expected FileDataID; false: no model may be shown.
local EXPECTED = {
  Vanilla = {
    [31] = 189908, -- Old Lion Statue
    [1941] = 189705, -- Campfire
    [410020] = 201662, -- Owl Statue: a Season of Discovery object, added by a Dynamic Correction.
  },
  -- Client caches say 174 for this object; only CMaNGOS Wrath says otherwise.
  TBC = { [31] = 189908, [180055] = 199748, [25328] = 198484 },
  Wrath = { [31] = 189908, [180055] = 199748 },
  Cata = { [31] = 189908, [180055] = 199748 },
  Mists = { [31] = 189908, [180055] = 199748 },
  Forever = {
    [31] = 189908,
    [1941] = 195041, -- Forever gave the Campfire another display than Classic.
    [654846] = false, -- Displayed as a creature, whose row also carries a FileDataID.
    [457056] = false, -- Displayed as an item, likewise.
    [652438] = false, -- Invisible click box.
    [654121] = false, -- Spell effect.
  },
}
-- From TBC on, 410020 is an invented cage. It may get a model of its own, but not the statue's.
local OWL_STATUE_FILE = 201662

---@param equal fun(actual: any, expected: any, message: string)
---@param emulator table emulator/metadata.lua
---@param client table emulator/client.lua
return function(equal, emulator, client)
  for _, flavor in ipairs(config.flavors) do
    client.reset()
    client.install({ expansion = flavor.expansion })
    local Lib = emulator.loadAddon(config.addonName .. ".toc", config.addonName)

    for objectId, fileDataId in pairs(EXPECTED[flavor.name]) do
      equal(Lib.GetObjectModelFileID(objectId) or false, fileDataId,
        ("%s: model of object %d"):format(flavor.name, objectId))
    end
    equal(Lib.GetObjectModelFileID(999999999), nil, flavor.name .. ": an unknown ID has no model")
    if flavor.name ~= "Vanilla" then
      equal(Lib.GetObjectModelFileID(410020) == OWL_STATUE_FILE, false, flavor.name .. ": the cage is no statue")
    end

    -- The last object of the last line: decoding must not stop early.
    local fileDataId, objectId = lib.readAll("support/ObjectModels/" .. flavor.name .. ".lua")
      :match("\n(%d+):[%d,]-(%d+)\r?\n%]%]")
    equal(Lib.GetObjectModelFileID(assert(tonumber(objectId), "no last object found")), tonumber(fileDataId),
      flavor.name .. ": the last listed object is readable")
  end
  client.reset()
end
