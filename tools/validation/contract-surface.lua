-- tools/validation/contract-surface.lua
--
-- Public names each consumer contract promises, checked by the `contract-surface` suite.
-- Paths resolve from the client's global table.
--
-- Rules:
--   * A new contract appends entries with `since` set to that contract.
--   * Never edit or delete a promised entry. To drop one, set `removedIn` to the first
--     contract without it, and raise config.minSupportedContract to at least that contract.
--   * The `since = 1` baseline was recorded at contract 4; earlier history is not split out.

local entries = {}

local function add(since, kind, paths)
  for _, path in ipairs(paths) do
    entries[#entries + 1] = { path = path, kind = kind, since = since }
  end
end

add(1, "table", { "LibQuestieDB", "QuestDB", "NpcDB", "ItemDB", "ObjectDB" })

add(1, "table", {
  "LibQuestieDB.Quest", "LibQuestieDB.Npc", "LibQuestieDB.Item", "LibQuestieDB.Object",
  "LibQuestieDB.Corrections", "LibQuestieDB.Meta", "LibQuestieDB.Enum", "LibQuestieDB.ObjectiveFirst",
  "LibQuestieDB.l10n", "LibQuestieDB.Support", "LibQuestieDB.ModeIndicator",
})
add(1, "number", { "LibQuestieDB.contractVersion", "LibQuestieDB.minSupportedContract" })
add(1, "string", { "LibQuestieDB.addonName", "LibQuestieDB.readMode" })
add(1, "function", {
  "LibQuestieDB.RequireContract", "LibQuestieDB.InvalidateCache",
  "LibQuestieDB.ApplyRegisteredCorrections", "LibQuestieDB.RegisterCorrection",
  "LibQuestieDB.RegisterRuntimeCorrection", "LibQuestieDB.SetCorrection",
  "LibQuestieDB.GetRegistrar", "LibQuestieDB.GetProvenance", "LibQuestieDB.GetOwners",
  "LibQuestieDB.EraToForever", "LibQuestieDB.EraToForeverByUiMapId",
})

local fields = {
  Quest = {
    "name", "startedBy", "finishedBy", "requiredLevel", "questLevel", "requiredRaces",
    "requiredClasses", "objectivesText", "triggerEnd", "objectives", "sourceItemId",
    "preQuestGroup", "preQuestSingle", "childQuests", "inGroupWith", "exclusiveTo", "zoneOrSort",
    "requiredSkill", "requiredMinRep", "requiredMaxRep", "requiredSourceItems", "nextQuestInChain",
    "questFlags", "specialFlags", "parentQuest", "reputationReward", "breadcrumbForQuestId",
    "breadcrumbs", "extraObjectives", "requiredSpell", "requiredSpecialization", "requiredMaxLevel",
    "availableUntilCompleted", "availableStartingWith", "requiredRanks", "disabledByQuest",
  },
  Npc = {
    "name", "minLevelHealth", "maxLevelHealth", "minLevel", "maxLevel", "rank", "spawns",
    "waypoints", "zoneID", "questStarts", "questEnds", "factionID", "friendlyToFaction", "subName",
    "npcFlags",
  },
  Item = {
    "name", "npcDrops", "objectDrops", "itemDrops", "startQuest", "questRewards", "flags",
    "foodType", "itemLevel", "requiredLevel", "ammoType", "class", "subClass", "vendors",
    "relatedQuests", "teachesSpell",
  },
  Object = { "name", "questStarts", "questEnds", "spawns", "zoneID", "factionID", "waypoints" },
}
local entityMethods = {
  "Get", "GetByIndex", "GetAll", "GetAllIds", "GetRaw", "Exists", "InvalidateCache",
  "BuildNameIndex", "BuildNameIndexAsync", "IdsByName",
}
local metaKeys = { Quest = "questKeys", Npc = "npcKeys", Item = "itemKeys", Object = "objectKeys" }
for _, entity in ipairs({ "Quest", "Npc", "Item", "Object" }) do
  local prefix = "LibQuestieDB." .. entity .. "."
  for _, method in ipairs(entityMethods) do
    add(1, "function", { prefix .. method })
  end
  for _, field in ipairs(fields[entity]) do
    add(1, "function", { prefix .. field })
  end
  add(1, "table", {
    "LibQuestieDB.Meta." .. entity .. "Meta." .. metaKeys[entity],
    "LibQuestieDB.Meta." .. entity .. ".names", "LibQuestieDB.Meta." .. entity .. ".types",
    "LibQuestieDB.Meta." .. entity .. ".keys",
  })
  add(1, "number", { "LibQuestieDB.Meta." .. entity .. ".fieldCount" })
end

add(1, "string", { "LibQuestieDB.Corrections.OWNER" })
add(1, "boolean", { "LibQuestieDB.Corrections.debug" })
add(1, "function", {
  "LibQuestieDB.Support.Get", "LibQuestieDB.Support.GetAll",
  "LibQuestieDB.ModeIndicator.GetText", "LibQuestieDB.ModeIndicator.GetStatus",
})
add(1, "function", {
  "LibQuestieDB.Corrections.CanonicalDatatype", "LibQuestieDB.Corrections.RegisterCorrection",
  "LibQuestieDB.Corrections.RegisterRuntimeCorrection", "LibQuestieDB.Corrections.UnregisterCorrection",
  "LibQuestieDB.Corrections.GetRegistrar", "LibQuestieDB.Corrections.ApplyRegisteredCorrections",
  "LibQuestieDB.Corrections.Set", "LibQuestieDB.Corrections.GetProvenance",
  "LibQuestieDB.Corrections.GetOwners",
})

add(1, "table", {
  "LibQuestieDB.l10n.locales", "LibQuestieDB.l10n.localeIndex", "LibQuestieDB.l10n.onLocaleChanged",
  "LibQuestieDB.l10n.fields",
})
add(1, "string", { "LibQuestieDB.l10n.currentLocale" })
add(1, "boolean", { "LibQuestieDB.l10n.available" })
add(1, "function", {
  "LibQuestieDB.l10n.CreateProvider", "LibQuestieDB.l10n.Initialize", "LibQuestieDB.l10n.DetectLocale",
  "LibQuestieDB.l10n.SetLocale", "LibQuestieDB.l10n.IsAvailable", "LibQuestieDB.l10n.SetCorrection",
  "LibQuestieDB.l10n.GetProvenance",
})

add(1, "table", {
  "LibQuestieDB.ObjectiveFirst.killCreditObjectiveFirst", "LibQuestieDB.ObjectiveFirst.objectObjectiveFirst",
  "LibQuestieDB.ObjectiveFirst.itemObjectiveFirst", "LibQuestieDB.ObjectiveFirst.eventObjectiveFirst",
  "LibQuestieDB.ObjectiveFirst.spellObjectiveFirst",
})

add(1, "table", {
  "LibQuestieDB.Enum.zoneIDs", "LibQuestieDB.Enum.questKeys", "LibQuestieDB.Enum.npcKeys",
  "LibQuestieDB.Enum.itemKeys", "LibQuestieDB.Enum.objectKeys", "LibQuestieDB.Enum.phases",
})
add(3, "table", {
  "LibQuestieDB.Enum.raceMaskById", "LibQuestieDB.Enum.factionRaceMasks", "LibQuestieDB.Enum.factionIDs",
})
add(3, "number", { "LibQuestieDB.Enum.factionRaceMasks.Alliance", "LibQuestieDB.Enum.factionRaceMasks.Horde" })
add(4, "table", { "LibQuestieDB.Enum.classKeys", "LibQuestieDB.Enum.npcFlags" })

return entries
