-- src/l10n/source/_traces.lua
--
-- Separates base lookups from the Forever trace lookups that load next. Both use the same
-- module fields, so the base payloads are set aside before the traces assign theirs.

local _, LibQuestieDB = ...

local capture = LibQuestieDB.__l10nSourceCapture
local module = capture.module
capture.base = {}
for _, field in ipairs({ "questLookup", "npcNameLookup", "itemLookup", "objectLookup" }) do
  capture.base[field] = module[field]
  module[field] = {}
end
