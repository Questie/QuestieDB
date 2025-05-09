---@class LibQuestieDB
local LibQuestieDB = select(2, ...)

--? Copied from https://github.com/Questie/Questie/blob/master/Modules/VersionCheck.lua

-- In the CLI this is not set
if not Enum then
  Enum = {}
  ---@type Enum.SeasonID
  ---@diagnostic disable-next-line: assign-type-mismatch
  Enum.SeasonID = {
    NoSeason = 0,
    SeasonOfMastery = 1,
    SeasonOfDiscovery = 2,
    Hardcore = 3,
    Fresh = 11,
    FreshHardcore = 12,
  }
end

-- --- Addon is running on Classic MoP client
-- ---@type boolean
-- LibQuestieDB.IsMop = WOW_PROJECT_ID == WOW_PROJECT_MIST_OF_PANDARIA_CLASSIC

--- Addon is running on Classic MoP client
---@type boolean
LibQuestieDB.IsMoP = WOW_PROJECT_ID == WOW_PROJECT_MISTS_CLASSIC

--- Addon is running on Classic Cata client
---@type boolean
LibQuestieDB.IsCata = WOW_PROJECT_ID == WOW_PROJECT_CATACLYSM_CLASSIC

--- Addon is running on Classic Wotlk client
---@type boolean
LibQuestieDB.IsWotlk = WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC

--- Addon is running on Classic TBC client
---@type boolean
LibQuestieDB.IsTBC = WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC

--- Addon is running on Classic "Vanilla" client: Means Classic Era and its seasons like SoM
---@type boolean
LibQuestieDB.IsClassic = WOW_PROJECT_ID == WOW_PROJECT_CLASSIC

--- Addon is running on Classic "Vanilla" client and on Era realm (non-seasonal)
---@type boolean
LibQuestieDB.IsEra = LibQuestieDB.IsClassic and (not C_Seasons.HasActiveSeason())

--- Addon is running on Classic "Vanilla" client and on any Seasonal realm (see: https://wowpedia.fandom.com/wiki/API_C_Seasons.GetActiveSeason )
---@type boolean
LibQuestieDB.IsEraSeasonal = LibQuestieDB.IsClassic and C_Seasons.HasActiveSeason()

--- Addon is running on Classic "Vanilla" client and on Season of Mastery realm specifically
---@type boolean
LibQuestieDB.IsSoM = LibQuestieDB.IsClassic and C_Seasons.HasActiveSeason() and
    (C_Seasons.GetActiveSeason() == Enum.SeasonID.SeasonOfMastery)

--- Addon is running on Classic "Vanilla" client and on Season of Discovery realm specifically
---@type boolean
LibQuestieDB.IsSoD = LibQuestieDB.IsClassic and C_Seasons.HasActiveSeason() and
    (C_Seasons.GetActiveSeason() == Enum.SeasonID.SeasonOfDiscovery)

--- Addon is running on Classic "Vanilla" client and on Classic Anniversary realm ( )
--- TODO: Use Enum or new API if there will be one
---@type boolean
LibQuestieDB.IsAnniversary = LibQuestieDB.IsClassic and C_Seasons.HasActiveSeason() and
    (C_Seasons.GetActiveSeason() == Enum.SeasonID.Fresh)

--- Addon is running on Classic "Vanilla" client and on Classic Anniversary Hardcore realm
--- TODO: Use Enum or new API if there will be one
---@type boolean
LibQuestieDB.IsAnniversaryHardcore = LibQuestieDB.IsClassic and C_Seasons.HasActiveSeason() and
    (C_Seasons.GetActiveSeason() == Enum.SeasonID.FreshHardcore)

--- Addon is running on a HardCore realm specifically
---@type boolean
LibQuestieDB.IsHardcore = C_GameRules and C_GameRules.IsHardcoreActive()
