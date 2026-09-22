---@diagnostic disable: unused-local

-- Consumers can inspect the complete supported range before checking a requirement.
---@type integer
local contractVersion = LibQuestieDB.contractVersion
---@type integer
local minimumContract = LibQuestieDB.minSupportedContract
local supported, mismatch = LibQuestieDB.RequireContract(minimumContract)
---@type boolean
local contractSupported = supported
---@type string?
local contractMessage = mismatch

-- Literal arguments must select one concrete GetAllIds result shape.
---@type QuestId
local questId = QuestDB.GetAllIds()[1]
---@type QuestId
local questIdFromFalse = QuestDB.GetAllIds(false)[1]
---@type true
local questPresent = QuestDB.GetAllIds(true)[1]

---@type NpcId
local npcId = NpcDB.GetAllIds()[1]
---@type NpcId
local npcIdFromFalse = NpcDB.GetAllIds(false)[1]
---@type true
local npcPresent = NpcDB.GetAllIds(true)[1]

---@type ItemId
local itemId = ItemDB.GetAllIds()[1]
---@type ItemId
local itemIdFromFalse = ItemDB.GetAllIds(false)[1]
---@type true
local itemPresent = ItemDB.GetAllIds(true)[1]

---@type ObjectId
local objectId = ObjectDB.GetAllIds()[1]
---@type ObjectId
local objectIdFromFalse = ObjectDB.GetAllIds(false)[1]
---@type true
local objectPresent = ObjectDB.GetAllIds(true)[1]

-- Representative reads cover nilability and nested tuple aliases.
---@type string?
local questName = QuestDB.name(2)
---@type QuestieDBExtraObjective[]?
local extraObjectives = QuestDB.extraObjectives(2)
---@type QuestieDBReference
local itemReference = { "item", 6948 }

-- Correction methods are dot-called. Registrar methods already bind their owner.
---@type QuestieDBCorrectionProvider
local correctionProvider = function()
  return { [2] = { [1] = "Sharptalon's Claw" } }
end

local registrar = LibQuestieDB.GetRegistrar("ConsumerAddon")
---@type QuestieDBCorrectionEntry
local correctionEntry = registrar.RegisterRuntimeCorrection(
  "quest", "rename-quest", correctionProvider, 10)
---@type integer
local registrationSequence = correctionEntry.sequence
---@type integer
local applied = registrar.Apply()
---@type boolean
local removed = LibQuestieDB.Corrections.UnregisterCorrection(
  "ConsumerAddon", "Quest", "rename-quest")
---@type QuestieDBCanonicalDatatype?
local canonical = LibQuestieDB.Corrections.CanonicalDatatype("quest")
LibQuestieDB.Corrections.debug = true

-- The Name index answers in the entity's own ID alias, or nil when no entity has the name.
---@type ObjectId[]?
local objectIdsByName = ObjectDB.IdsByName("Old Lion Statue")
---@type QuestId[]?
local questIdsByName = QuestDB.IdsByName("Sharptalon's Claw")
ObjectDB.BuildNameIndex()

-- Data-shaped write-through corrections publish immediately; nil removes the slot.
---@type boolean
local setChanged = registrar.Set("Npc", "darkmoon-location", { [14828] = { [1] = "Gelvas Grimegate" } })
---@type boolean
local setRemoved = LibQuestieDB.SetCorrection("ConsumerAddon", "Npc", "darkmoon-location", nil)

-- Phase constants include Blizzard IDs and Questie-defined fake visibility IDs.
---@type integer
local blizzardPhase = LibQuestieDB.Enum.phases.HYJAL_CHAPTER_1
---@type integer
local questiePhase = LibQuestieDB.Enum.phases.HYJAL_IAN_AND_TARIK_NOT_IN_CAGE

-- Schema and objective-hint reads stay typed, and localization controls stay dot-called.
---@type integer
local npcNameField = LibQuestieDB.Meta.NpcMeta.npcKeys.name
---@type true?
local spellObjectiveFirst = LibQuestieDB.ObjectiveFirst.spellObjectiveFirst[2]
---@type string
local currentLocale = LibQuestieDB.l10n.currentLocale
---@type string
local selectedLocale = LibQuestieDB.l10n.SetLocale("deDE")

-- Translation corrections are locale-specific, data-shaped slots using entity field indices.
local translated = LibQuestieDB.l10n.SetCorrection("Consumer", "deDE", "Quest", "names", {
  [2] = { [LibQuestieDB.Meta.QuestMeta.questKeys.name] = "Übersetzter Name" },
})
local translationOwner = LibQuestieDB.l10n.GetProvenance("Quest", 2, "name")
LibQuestieDB.l10n.SetCorrection("Consumer", "deDE", "Quest", "names", nil)
---@type boolean
local translationChanged = translated
---@type string?
local translatedBy = translationOwner

-- External translations can target a locale without generated Localization blocks.
---@type QuestieDBTranslationLocale
local customLocale = "ukUA"
LibQuestieDB.l10n.SetCorrection("Consumer", customLocale, "Quest", "names", {
  [2] = { [LibQuestieDB.Meta.QuestMeta.questKeys.name] = "Перекладена назва" },
})
LibQuestieDB.l10n.SetLocale(customLocale)
LibQuestieDB.l10n.SetCorrection("Consumer", customLocale, "Quest", "names", nil)
