-- Central authoring policy, in registration sequence. Provider files contain Correction data
-- and lazy exports; this manifest decides which files load and how each export registers.
--
-- For a data-only edit, change the provider. To add a file, publish its provider key near the
-- file header, then add one block below in the intended expansion/order group. Declare every
-- exported function here with its category, stable identity, and load-order position. Regenerate
-- the committed Source TOC and run the shared plus affected-flavor checks after file-list changes.
local _, LibQuestieDB = ...

---@class CorrectionFunctionSpec
---@field category 'static'|'dynamic'
---@field method string Exported zero-argument function name.
---@field name string Stable registry identity.
---@field order string Registry load-order window.
---@field offset integer Position within that window.
---@field minExpansionOrder integer? Registry-entry applicability inherited from this source expansion.
---@field sourceExpansionOrder integer? Source expansion used by inherited Static merge policy.
---@field expansions table<string, boolean>? Registry-entry expansion allowlist.
---@field options table<string, boolean>? Static merge options.

---@class CorrectionFileSpec
---@field file string Path relative to src/corrections/.
---@field provider string Key in CorrectionProviders. Only mutually exclusive Era/Forever files may share one.
---@field datatype string
---@field owned string? Exclusive owning flavor; prevents normal expansion inheritance.
---@field expansions table<string, boolean>? Native file-selection allowlist.
---@field minExpansionOrder integer? Native file-selection floor.
---@field season string? Runtime gate that native file conditions cannot express.
---@field functions CorrectionFunctionSpec[] Ordered registrations, including multiple functions in one file.

-- File-level applicability decides whether Lua loads the provider. Function-level applicability
-- is copied onto its registry entry and decides whether that returned Correction table applies.
---@type CorrectionFileSpec[]
local manifest = {
  -- Era: cumulative legacy providers, except the Vanilla-only reputation set.
  {
    file = "Era/classicQuestFixes.lua", provider = "classicQuestFixes", datatype = "Quest",
    functions = {
      { category = "static", method = "Load", name = "Era/classicQuestFixes.lua:Load", order = "EraStatic", offset = 11,
        sourceExpansionOrder = 1 },
      { category = "dynamic", method = "LoadFactionFixes", name = "Era/classicQuestFixes.lua:LoadFactionFixes", order = "EraDynamic", offset = 11 },
    },
  },
  {
    file = "Era/classicNPCFixes.lua", provider = "classicNPCFixes", datatype = "Npc",
    functions = {
      { category = "static", method = "Load", name = "Era/classicNPCFixes.lua:Load", order = "EraStatic", offset = 11,
        sourceExpansionOrder = 1 },
      { category = "dynamic", method = "LoadFactionFixes", name = "Era/classicNPCFixes.lua:LoadFactionFixes", order = "EraDynamic", offset = 11 },
    },
  },
  {
    file = "Era/classicItemFixes.lua", provider = "classicItemFixes", datatype = "Item",
    functions = {
      { category = "static", method = "Load", name = "Era/classicItemFixes.lua:Load", order = "EraStatic", offset = 11,
        sourceExpansionOrder = 1 },
      { category = "dynamic", method = "LoadFactionFixes", name = "Era/classicItemFixes.lua:LoadFactionFixes", order = "EraDynamic", offset = 11 },
    },
  },
  {
    file = "Era/classicObjectFixes.lua", provider = "classicObjectFixes", datatype = "Object",
    functions = {
      { category = "static", method = "Load", name = "Era/classicObjectFixes.lua:Load", order = "EraStatic", offset = 11,
        sourceExpansionOrder = 1 },
      { category = "dynamic", method = "LoadFactionFixes", name = "Era/classicObjectFixes.lua:LoadFactionFixes", order = "EraDynamic", offset = 11 },
    },
  },
  {
    file = "Era/classicQuestReputationFixes.lua", expansions = { ["Classic"] = true }, provider = "classicQuestReputationFixes", datatype = "Quest",
    functions = {
      { category = "static", method = "Load", name = "Era/classicQuestReputationFixes.lua:Load", order = "EraStatic", offset = 2,
        expansions = { ["Classic"] = true } },
    },
  },
  -- TBC: inherited by every later legacy expansion.
  {
    file = "Tbc/tbcQuestFixes.lua", minExpansionOrder = 2, provider = "tbcQuestFixes", datatype = "Quest",
    functions = {
      { category = "static", method = "Load", name = "Tbc/tbcQuestFixes.lua:Load", order = "TbcStatic", offset = 11,
        minExpansionOrder = 2, sourceExpansionOrder = 2 },
      { category = "dynamic", method = "LoadFactionFixes", name = "Tbc/tbcQuestFixes.lua:LoadFactionFixes", order = "TbcDynamic", offset = 11,
        minExpansionOrder = 2 },
    },
  },
  {
    file = "Tbc/tbcNPCFixes.lua", minExpansionOrder = 2, provider = "tbcNPCFixes", datatype = "Npc",
    functions = {
      { category = "static", method = "Load", name = "Tbc/tbcNPCFixes.lua:Load", order = "TbcStatic", offset = 11,
        minExpansionOrder = 2, sourceExpansionOrder = 2 },
      { category = "dynamic", method = "LoadFactionFixes", name = "Tbc/tbcNPCFixes.lua:LoadFactionFixes", order = "TbcDynamic", offset = 11,
        minExpansionOrder = 2 },
    },
  },
  {
    file = "Tbc/tbcItemFixes.lua", minExpansionOrder = 2, provider = "tbcItemFixes", datatype = "Item",
    functions = {
      { category = "static", method = "Load", name = "Tbc/tbcItemFixes.lua:Load", order = "TbcStatic", offset = 11,
        minExpansionOrder = 2, sourceExpansionOrder = 2 },
      { category = "dynamic", method = "LoadFactionFixes", name = "Tbc/tbcItemFixes.lua:LoadFactionFixes", order = "TbcDynamic", offset = 11,
        minExpansionOrder = 2 },
    },
  },
  {
    file = "Tbc/tbcObjectFixes.lua", minExpansionOrder = 2, provider = "tbcObjectFixes", datatype = "Object",
    functions = {
      { category = "static", method = "Load", name = "Tbc/tbcObjectFixes.lua:Load", order = "TbcStatic", offset = 11,
        minExpansionOrder = 2, sourceExpansionOrder = 2 },
      { category = "dynamic", method = "LoadFactionFixes", name = "Tbc/tbcObjectFixes.lua:LoadFactionFixes", order = "TbcDynamic", offset = 11,
        minExpansionOrder = 2 },
    },
  },
  -- Wrath: inherited by Cata and Mists. NPC automatics apply before hand-authored fixes.
  {
    file = "Wotlk/wotlkQuestFixes.lua", minExpansionOrder = 3, provider = "wotlkQuestFixes", datatype = "Quest",
    functions = {
      { category = "static", method = "Load", name = "Wotlk/wotlkQuestFixes.lua:Load", order = "WotlkStatic", offset = 11,
        minExpansionOrder = 3, sourceExpansionOrder = 3 },
      { category = "dynamic", method = "LoadFactionFixes", name = "Wotlk/wotlkQuestFixes.lua:LoadFactionFixes", order = "WotlkDynamic", offset = 11,
        minExpansionOrder = 3 },
    },
  },
  {
    file = "Wotlk/wotlkNPCFixes.lua", minExpansionOrder = 3, provider = "wotlkNPCFixes", datatype = "Npc",
    functions = {
      { category = "static", method = "LoadAutomatics", name = "Wotlk/wotlkNPCFixes.lua:LoadAutomatics", order = "WotlkStatic", offset = 11,
        minExpansionOrder = 3, sourceExpansionOrder = 3 },
      { category = "static", method = "Load", name = "Wotlk/wotlkNPCFixes.lua:Load", order = "WotlkStatic", offset = 12,
        minExpansionOrder = 3, sourceExpansionOrder = 3 },
      { category = "dynamic", method = "LoadFactionFixes", name = "Wotlk/wotlkNPCFixes.lua:LoadFactionFixes", order = "WotlkDynamic", offset = 11,
        minExpansionOrder = 3 },
    },
  },
  {
    file = "Wotlk/wotlkItemFixes.lua", minExpansionOrder = 3, provider = "wotlkItemFixes", datatype = "Item",
    functions = {
      { category = "static", method = "Load", name = "Wotlk/wotlkItemFixes.lua:Load", order = "WotlkStatic", offset = 11,
        minExpansionOrder = 3, sourceExpansionOrder = 3 },
      { category = "dynamic", method = "LoadFactionFixes", name = "Wotlk/wotlkItemFixes.lua:LoadFactionFixes", order = "WotlkDynamic", offset = 11,
        minExpansionOrder = 3 },
    },
  },
  {
    file = "Wotlk/wotlkObjectFixes.lua", minExpansionOrder = 3, provider = "wotlkObjectFixes", datatype = "Object",
    functions = {
      { category = "static", method = "Load", name = "Wotlk/wotlkObjectFixes.lua:Load", order = "WotlkStatic", offset = 11,
        minExpansionOrder = 3, sourceExpansionOrder = 3 },
      { category = "dynamic", method = "LoadFactionFixes", name = "Wotlk/wotlkObjectFixes.lua:LoadFactionFixes", order = "WotlkDynamic", offset = 11,
        minExpansionOrder = 3 },
    },
  },
  -- Titan Reforged: Dynamic seasonal overlay over Wrath only.
  {
    file = "Titan/titanReforgedQuestFixes.lua", expansions = { ["Wotlk"] = true }, provider = "titanReforgedQuestFixes", datatype = "Quest",
    season = "TitanReforged",
    functions = {
      { category = "dynamic", method = "LoadQuests", name = "Titan/titanReforgedQuestFixes.lua:LoadQuests", order = "TitanDynamic", offset = 11,
        expansions = { ["Wotlk"] = true } },
      { category = "dynamic", method = "LoadQuestOverrides", name = "Titan/titanReforgedQuestFixes.lua:LoadQuestOverrides", order = "TitanDynamic", offset = 12,
        expansions = { ["Wotlk"] = true } },
    },
  },
  {
    file = "Titan/titanReforgedNPCFixes.lua", expansions = { ["Wotlk"] = true }, provider = "titanReforgedNPCFixes", datatype = "Npc",
    season = "TitanReforged",
    functions = {
      { category = "dynamic", method = "LoadNPCs", name = "Titan/titanReforgedNPCFixes.lua:LoadNPCs", order = "TitanDynamic", offset = 11,
        expansions = { ["Wotlk"] = true } },
      { category = "dynamic", method = "LoadNPCOverrides", name = "Titan/titanReforgedNPCFixes.lua:LoadNPCOverrides", order = "TitanDynamic", offset = 12,
        expansions = { ["Wotlk"] = true } },
      { category = "dynamic", method = "LoadFactionNPCOverrides", name = "Titan/titanReforgedNPCFixes.lua:LoadFactionNPCOverrides", order = "TitanDynamic", offset = 13,
        expansions = { ["Wotlk"] = true } },
    },
  },
  {
    file = "Titan/titanReforgedItemFixes.lua", expansions = { ["Wotlk"] = true }, provider = "titanReforgedItemFixes", datatype = "Item",
    season = "TitanReforged",
    functions = {
      { category = "dynamic", method = "LoadItems", name = "Titan/titanReforgedItemFixes.lua:LoadItems", order = "TitanDynamic", offset = 11,
        expansions = { ["Wotlk"] = true } },
      { category = "dynamic", method = "LoadItemOverrides", name = "Titan/titanReforgedItemFixes.lua:LoadItemOverrides", order = "TitanDynamic", offset = 12,
        expansions = { ["Wotlk"] = true } },
    },
  },
  {
    file = "Titan/titanReforgedObjectFixes.lua", expansions = { ["Wotlk"] = true }, provider = "titanReforgedObjectFixes", datatype = "Object",
    season = "TitanReforged",
    functions = {
      { category = "dynamic", method = "LoadObjects", name = "Titan/titanReforgedObjectFixes.lua:LoadObjects", order = "TitanDynamic", offset = 11,
        expansions = { ["Wotlk"] = true } },
    },
  },
  -- Cataclysm: inherited by Mists.
  {
    file = "Cata/cataQuestFixes.lua", minExpansionOrder = 4, provider = "cataQuestFixes", datatype = "Quest",
    functions = {
      { category = "static", method = "Load", name = "Cata/cataQuestFixes.lua:Load", order = "CataStatic", offset = 11,
        minExpansionOrder = 4, sourceExpansionOrder = 4 },
      { category = "dynamic", method = "LoadFactionFixes", name = "Cata/cataQuestFixes.lua:LoadFactionFixes", order = "CataDynamic", offset = 11,
        minExpansionOrder = 4 },
    },
  },
  {
    file = "Cata/cataNPCFixes.lua", minExpansionOrder = 4, provider = "cataNPCFixes", datatype = "Npc",
    functions = {
      { category = "static", method = "Load", name = "Cata/cataNPCFixes.lua:Load", order = "CataStatic", offset = 11,
        minExpansionOrder = 4, sourceExpansionOrder = 4 },
      { category = "dynamic", method = "LoadFactionFixes", name = "Cata/cataNPCFixes.lua:LoadFactionFixes", order = "CataDynamic", offset = 11,
        minExpansionOrder = 4 },
    },
  },
  {
    file = "Cata/cataItemFixes.lua", minExpansionOrder = 4, provider = "cataItemFixes", datatype = "Item",
    functions = {
      { category = "static", method = "Load", name = "Cata/cataItemFixes.lua:Load", order = "CataStatic", offset = 11,
        minExpansionOrder = 4, sourceExpansionOrder = 4 },
      { category = "dynamic", method = "LoadFactionFixes", name = "Cata/cataItemFixes.lua:LoadFactionFixes", order = "CataDynamic", offset = 11,
        minExpansionOrder = 4 },
    },
  },
  {
    file = "Cata/cataObjectFixes.lua", minExpansionOrder = 4, provider = "cataObjectFixes", datatype = "Object",
    functions = {
      { category = "static", method = "Load", name = "Cata/cataObjectFixes.lua:Load", order = "CataStatic", offset = 11,
        minExpansionOrder = 4, sourceExpansionOrder = 4 },
      { category = "dynamic", method = "LoadFactionFixes", name = "Cata/cataObjectFixes.lua:LoadFactionFixes", order = "CataDynamic", offset = 11,
        minExpansionOrder = 4 },
    },
  },
  -- Mists: final legacy expansion layer.
  {
    file = "MoP/mopQuestFixes.lua", minExpansionOrder = 5, provider = "mopQuestFixes", datatype = "Quest",
    functions = {
      { category = "static", method = "Load", name = "MoP/mopQuestFixes.lua:Load", order = "MoPStatic", offset = 11,
        minExpansionOrder = 5, sourceExpansionOrder = 5 },
      { category = "dynamic", method = "LoadFactionFixes", name = "MoP/mopQuestFixes.lua:LoadFactionFixes", order = "MoPDynamic", offset = 11,
        minExpansionOrder = 5 },
    },
  },
  {
    file = "MoP/mopNPCFixes.lua", minExpansionOrder = 5, provider = "mopNPCFixes", datatype = "Npc",
    functions = {
      { category = "static", method = "Load", name = "MoP/mopNPCFixes.lua:Load", order = "MoPStatic", offset = 11,
        minExpansionOrder = 5, sourceExpansionOrder = 5 },
      { category = "dynamic", method = "LoadFactionFixes", name = "MoP/mopNPCFixes.lua:LoadFactionFixes", order = "MoPDynamic", offset = 11,
        minExpansionOrder = 5 },
    },
  },
  {
    file = "MoP/mopItemFixes.lua", minExpansionOrder = 5, provider = "mopItemFixes", datatype = "Item",
    functions = {
      { category = "static", method = "Load", name = "MoP/mopItemFixes.lua:Load", order = "MoPStatic", offset = 11,
        minExpansionOrder = 5, sourceExpansionOrder = 5 },
    },
  },
  {
    file = "MoP/mopObjectFixes.lua", minExpansionOrder = 5, provider = "mopObjectFixes", datatype = "Object",
    functions = {
      { category = "static", method = "Load", name = "MoP/mopObjectFixes.lua:Load", order = "MoPStatic", offset = 11,
        minExpansionOrder = 5, sourceExpansionOrder = 5 },
      { category = "dynamic", method = "LoadFactionFixes", name = "MoP/mopObjectFixes.lua:LoadFactionFixes", order = "MoPDynamic", offset = 11,
        minExpansionOrder = 5 },
    },
  },
  -- Season of Discovery: Dynamic Vanilla providers, admitted only while season 2 is active.
  {
    file = "Sod/sodQuestFixes.lua", expansions = { ["Classic"] = true }, provider = "sodQuestFixes", datatype = "Quest",
    season = "SoD",
    functions = {
      { category = "dynamic", method = "LoadQuests", name = "Sod/sodQuestFixes.lua:LoadQuests", order = "SoDDynamic", offset = 11,
        expansions = { ["Classic"] = true } },
      { category = "dynamic", method = "LoadFactionQuestFixes", name = "Sod/sodQuestFixes.lua:LoadFactionQuestFixes", order = "SoDDynamic", offset = 12,
        expansions = { ["Classic"] = true } },
    },
  },
  {
    file = "Sod/sodNPCFixes.lua", expansions = { ["Classic"] = true }, provider = "sodNPCFixes", datatype = "Npc",
    season = "SoD",
    functions = {
      { category = "dynamic", method = "LoadNPCs", name = "Sod/sodNPCFixes.lua:LoadNPCs", order = "SoDDynamic", offset = 11,
        expansions = { ["Classic"] = true } },
    },
  },
  {
    file = "Sod/sodItemFixes.lua", expansions = { ["Classic"] = true }, provider = "sodItemFixes", datatype = "Item",
    season = "SoD",
    functions = {
      { category = "dynamic", method = "LoadItems", name = "Sod/sodItemFixes.lua:LoadItems", order = "SoDDynamic", offset = 11,
        expansions = { ["Classic"] = true } },
    },
  },
  {
    file = "Sod/sodObjectFixes.lua", expansions = { ["Classic"] = true }, provider = "sodObjectFixes", datatype = "Object",
    season = "SoD",
    functions = {
      { category = "dynamic", method = "LoadObjects", name = "Sod/sodObjectFixes.lua:LoadObjects", order = "SoDDynamic", offset = 11,
        expansions = { ["Classic"] = true } },
    },
  },
  -- Generated and shared baselines. Their lower offsets apply automatic data before the
  -- hand-authored Era/SoD providers even though this list retains the original file sequence.
  {
    file = "Sod/sodBaseQuests.lua", expansions = { ["Classic"] = true }, provider = "sodBaseQuests", datatype = "Quest",
    season = "SoD",
    functions = {
      { category = "dynamic", method = "LoadBaseQuests", name = "Sod/sodBaseQuests.lua:LoadBaseQuests", order = "SoDDynamic", offset = 2,
        expansions = { ["Classic"] = true } },
    },
  },
  {
    file = "Sod/sodBaseNPCs.lua", expansions = { ["Classic"] = true }, provider = "sodBaseNPCs", datatype = "Npc",
    season = "SoD",
    functions = {
      { category = "dynamic", method = "LoadBaseNPCs", name = "Sod/sodBaseNPCs.lua:LoadBaseNPCs", order = "SoDDynamic", offset = 2,
        expansions = { ["Classic"] = true } },
    },
  },
  {
    file = "Sod/sodBaseItems.lua", expansions = { ["Classic"] = true }, provider = "sodBaseItems", datatype = "Item",
    season = "SoD",
    functions = {
      { category = "dynamic", method = "LoadBaseItems", name = "Sod/sodBaseItems.lua:LoadBaseItems", order = "SoDDynamic", offset = 2,
        expansions = { ["Classic"] = true } },
    },
  },
  {
    file = "Sod/sodBaseObjects.lua", expansions = { ["Classic"] = true }, provider = "sodBaseObjects", datatype = "Object",
    season = "SoD",
    functions = {
      { category = "dynamic", method = "LoadBaseObjects", name = "Sod/sodBaseObjects.lua:LoadBaseObjects", order = "SoDDynamic", offset = 2,
        expansions = { ["Classic"] = true } },
    },
  },
  {
    file = "Shared/itemStartFixes.lua", provider = "itemStartFixes", datatype = "Item",
    functions = {
      { category = "static", method = "LoadAutomaticQuestStarts", name = "Shared/itemStartFixes.lua:LoadAutomaticQuestStarts", order = "EraStatic", offset = 2,
        options = { ["noOverwrites"] = true, ["noNewEntries"] = true } },
    },
  },
  -- Forever inherited baseline. These may reuse Era provider keys because `owned` makes the
  -- Era and Forever files mutually exclusive for every flavor.
  {
    file = "Forever/legacy/classicQuestFixes.lua", owned = "Forever", provider = "classicQuestFixes", datatype = "Quest",
    functions = {
      { category = "static", method = "Load", name = "Forever/legacy/classicQuestFixes.lua:Load", order = "EraStatic", offset = 11,
        sourceExpansionOrder = 1 },
      { category = "dynamic", method = "LoadFactionFixes", name = "Forever/legacy/classicQuestFixes.lua:LoadFactionFixes", order = "EraDynamic", offset = 11 },
    },
  },
  {
    file = "Forever/legacy/classicNPCFixes.lua", owned = "Forever", provider = "classicNPCFixes", datatype = "Npc",
    functions = {
      { category = "static", method = "Load", name = "Forever/legacy/classicNPCFixes.lua:Load", order = "EraStatic", offset = 11,
        sourceExpansionOrder = 1 },
      { category = "dynamic", method = "LoadFactionFixes", name = "Forever/legacy/classicNPCFixes.lua:LoadFactionFixes", order = "EraDynamic", offset = 11 },
    },
  },
  {
    file = "Forever/legacy/classicItemFixes.lua", owned = "Forever", provider = "classicItemFixes", datatype = "Item",
    functions = {
      { category = "static", method = "Load", name = "Forever/legacy/classicItemFixes.lua:Load", order = "EraStatic", offset = 11,
        sourceExpansionOrder = 1 },
      { category = "dynamic", method = "LoadFactionFixes", name = "Forever/legacy/classicItemFixes.lua:LoadFactionFixes", order = "EraDynamic", offset = 11 },
    },
  },
  {
    file = "Forever/legacy/classicObjectFixes.lua", owned = "Forever", provider = "classicObjectFixes", datatype = "Object",
    functions = {
      { category = "static", method = "Load", name = "Forever/legacy/classicObjectFixes.lua:Load", order = "EraStatic", offset = 11,
        sourceExpansionOrder = 1 },
      { category = "dynamic", method = "LoadFactionFixes", name = "Forever/legacy/classicObjectFixes.lua:LoadFactionFixes", order = "EraDynamic", offset = 11 },
    },
  },
  {
    file = "Forever/legacy/classicQuestReputationFixes.lua", owned = "Forever", expansions = { ["Forever"] = true }, provider = "classicQuestReputationFixes", datatype = "Quest",
    functions = {
      { category = "static", method = "Load", name = "Forever/legacy/classicQuestReputationFixes.lua:Load", order = "EraStatic", offset = 2,
        expansions = { ["Forever"] = true } },
    },
  },
  {
    file = "Forever/legacy/itemStartFixes.lua", owned = "Forever", provider = "itemStartFixes", datatype = "Item",
    functions = {
      { category = "static", method = "LoadAutomaticQuestStarts", name = "Forever/legacy/itemStartFixes.lua:LoadAutomaticQuestStarts", order = "EraStatic", offset = 2,
        options = { ["noOverwrites"] = true, ["noNewEntries"] = true } },
    },
  },
  -- Forever-authored work follows its inherited baseline in each Static/Dynamic category.
  {
    file = "Forever/foreverQuestFixes.lua", owned = "Forever", provider = "foreverQuestFixes", datatype = "Quest",
    functions = {
      { category = "static", method = "Load", name = "Forever/foreverQuestFixes.lua:Load", order = "ForeverStatic", offset = 11 },
      { category = "dynamic", method = "LoadDynamic", name = "Forever/foreverQuestFixes.lua:LoadDynamic", order = "ForeverDynamic", offset = 11 },
    },
  },
  {
    file = "Forever/foreverNPCFixes.lua", owned = "Forever", provider = "foreverNPCFixes", datatype = "Npc",
    functions = {
      { category = "static", method = "Load", name = "Forever/foreverNPCFixes.lua:Load", order = "ForeverStatic", offset = 11 },
      { category = "dynamic", method = "LoadDynamic", name = "Forever/foreverNPCFixes.lua:LoadDynamic", order = "ForeverDynamic", offset = 11 },
    },
  },
  {
    file = "Forever/foreverItemFixes.lua", owned = "Forever", provider = "foreverItemFixes", datatype = "Item",
    functions = {
      { category = "static", method = "Load", name = "Forever/foreverItemFixes.lua:Load", order = "ForeverStatic", offset = 11 },
      { category = "dynamic", method = "LoadDynamic", name = "Forever/foreverItemFixes.lua:LoadDynamic", order = "ForeverDynamic", offset = 11 },
    },
  },
  {
    file = "Forever/foreverObjectFixes.lua", owned = "Forever", provider = "foreverObjectFixes", datatype = "Object",
    functions = {
      { category = "static", method = "Load", name = "Forever/foreverObjectFixes.lua:Load", order = "ForeverStatic", offset = 11 },
      { category = "dynamic", method = "LoadDynamic", name = "Forever/foreverObjectFixes.lua:LoadDynamic", order = "ForeverDynamic", offset = 11 },
    },
  },
  -- Final SoD overlay: required-race policy intentionally wins last in the SoDDynamic window.
  {
    file = "Sod/sodRequiredRaces.lua", expansions = { Classic = true }, provider = "sodRequiredRaces", datatype = "Quest",
    season = "SoD",
    functions = {
      { category = "dynamic", method = "Load", name = "Sod:sodRequiredRaces", order = "SoDDynamic", offset = 20 },
    },
  },
}

if LibQuestieDB then
  LibQuestieDB.CorrectionManifest = manifest
  LibQuestieDB.CorrectionProviders = {}

  -- Native file conditions cannot select seasons. Seasonal chunks consult this policy
  -- before publishing exports or writing to the five load-time ObjectiveFirst tables.
  ---@param provider string
  ---@return boolean
  function LibQuestieDB.IsCorrectionProviderActive(provider)
    local config = LibQuestieDB.config
    for _, spec in ipairs(LibQuestieDB.CorrectionManifest) do
      if spec.provider == provider and config.correctionApplies(spec, LibQuestieDB.flavor)
          and (LibQuestieDB.mode ~= "baked" or config.hasDynamicCorrections(spec)) then
        if spec.season == "SoD" then return config.isSodActive(LibQuestieDB.flavor) end
        if spec.season == "TitanReforged" then return config.isTitanReforgedActive(LibQuestieDB.flavor) end
        assert(spec.season == nil, "unknown correction season: " .. tostring(spec.season))
        return true
      end
    end
    return false
  end
end
return manifest
