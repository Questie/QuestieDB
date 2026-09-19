-- data/_end.lua
--
-- Closes the raw entity data block: stops capturing and hands `QuestieLoader` back to whoever
-- owned it, so the consumer's own loader is untouched.

local _, LibQuestieDB = ...
if LibQuestieDB.read and LibQuestieDB.read.source then
  local source = LibQuestieDB.read.source
  source.RemoveLoaderShim()
  for _, entity in ipairs(LibQuestieDB.config.entityTypes) do
    assert(source.payloads[entity.name] ~= nil,
      "QuestieDB: missing " .. source.flavor.name .. " Source payload: " .. entity.name)
  end
end
