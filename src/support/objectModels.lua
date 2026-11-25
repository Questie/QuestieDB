-- src/support/objectModels.lua
--
-- Object ID -> model FileDataID for the active flavor, from support/ObjectModels/<Flavor>.lua.
-- Only plain models ship: objects displayed as a creature or an item, invisible models, and
-- objects without a model all read nil. See docs/support-data.md.

local _, LibQuestieDB = ...

---@type table<ObjectId, integer>?
local fileIdByObject

---The shipped text groups object IDs by model, one `FileDataID:objectId,objectId` line each.
---Inverting it costs several milliseconds and up to about 1.3 MB, so only a first lookup pays.
---@return table<ObjectId, integer>
local function decode()
  local decoded = {}
  local text = LibQuestieDB.Support.Get("ObjectModels").private.objectsByFileId
  for fileId, objectIds in text:gmatch("(%d+):([%d,]+)") do
    fileId = tonumber(fileId)
    for objectId in objectIds:gmatch("%d+") do
      decoded[tonumber(objectId)] = fileId
    end
  end
  return decoded
end

---Model of a game object, for `actor:SetModelByFileID`.
---@param objectId ObjectId
---@return integer? fileDataId Nil when the object has no plain model, or none is known.
function LibQuestieDB.GetObjectModelFileID(objectId)
  if not fileIdByObject then fileIdByObject = decode() end
  return fileIdByObject[objectId]
end
