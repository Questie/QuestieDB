-- src/l10n/source/_begin.lua
--
-- Opens the Source-mode lookup block. The raw l10n/ files keep their Questie format and
-- locale guards, so only the client locale's payloads are captured. A scoped `QuestieLoader`
-- and `Questie` stand-in exist only until _end.lua hands the previous globals back.

local _, LibQuestieDB = ...

local capture = {
  locale = GetLocale(),
  previousLoader = rawget(_G, "QuestieLoader"),
  previousQuestie = rawget(_G, "Questie"),
  module = { questLookup = {}, npcNameLookup = {}, itemLookup = {}, objectLookup = {} },
}
LibQuestieDB.__l10nSourceCapture = capture

local modules = { l10n = capture.module, QuestieDB = {} }
_G.QuestieLoader = { ImportModule = function(_, name)
  modules[name] = modules[name] or {}
  return modules[name]
end }
_G.Questie = {}
