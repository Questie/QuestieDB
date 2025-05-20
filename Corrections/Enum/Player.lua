---@class LibQuestieDB
local LibQuestieDB = select(2, ...)

--*---- Import Module --------
---@class Enum
local Enum = LibQuestieDB.Enum

-- ? The index can be found in ChrRaces.dbc
-- ? https://wago.tools/db2/ChrRaces?build=5.5.0.60802
-- ? Or look at the url id on wowhead https://wowhead.com/races

-- race bitmask data, for easy access
Enum.raceKeys = {
  ALL_ALLIANCE = (function()
    if LibQuestieDB.IsClassic then
      return 77
    elseif LibQuestieDB.IsTBC or LibQuestieDB.IsWotlk then
      return 1101
    elseif LibQuestieDB.IsCata then
      return 2098253
    elseif LibQuestieDB.IsMoP then
      return 18875469
    end
    error("Unknown expansion for ALL_ALLIANCE")
  end)(),
  ALL_HORDE = (function()
    if LibQuestieDB.IsClassic then
      return 178
    elseif LibQuestieDB.IsTBC or LibQuestieDB.IsWotlk then
      return 690
    elseif LibQuestieDB.IsCata then
      return 946
    elseif LibQuestieDB.IsMoP then
      return 33555378
    end
    error("Unknown expansion for ALL_HORDE")
  end)(),
  NONE = 0,

  --[[ 1]] HUMAN = 1,
  --[[ 2]] ORC = 2,
  --[[ 3]] DWARF = 4,
  --[[ 4]] NIGHT_ELF = 8,
  --[[ 5]] UNDEAD = 16,
  --[[ 6]] TAUREN = 32,
  --[[ 7]] GNOME = 64,
  --[[ 8]] TROLL = 128,
  --[[ 9]] GOBLIN = 256,
  --[[10]] BLOOD_ELF = 512,
  --[[11]] DRAENEI = 1024,
  --[[22]] WORGEN = 2097152,      -- lol
  --[[24]] PANDAREN_N = 8388608,  -- Pandaren Neutral
  --[[25]] PANDAREN_A = 16777216, -- Pandaren Alliance
  --[[26]] PANDAREN_H = 33554432, -- Pandaren Horde
}

-- ---@class AllianceRaceKeys
-- local allianceRaceKeys = {
--   --[[ 1]] HUMAN = 2 ^ (1 - 1),
--   --[[ 3]] DWARF = 2 ^ (3 - 1),
--   --[[ 4]] NIGHT_ELF = 2 ^ (4 - 1),
--   --[[ 7]] GNOME = 2 ^ (7 - 1),
--   --[[11]] DRAENEI = WOW_PROJECT_ID >= WOW_PROJECT_BURNING_CRUSADE_CLASSIC and 2 ^ (11 - 1) or nil,
--   --[[22]] WORGEN = WOW_PROJECT_ID >= WOW_PROJECT_CATACLYSM_CLASSIC and 2 ^ (22 - 1) or nil,
--   --[[25]] PANDAREN_A = WOW_PROJECT_ID >= WOW_PROJECT_MISTS_CLASSIC and 2 ^ (25 - 1) or nil, -- Pandaren Alliance
-- }

-- ---@class HordeRaceKeys
-- local hordeRaceKeys = {
--   --[[ 2]] ORC = 2 ^ (2 - 1),
--   --[[ 5]] UNDEAD = 2 ^ (5 - 1),
--   --[[ 6]] TAUREN = 2 ^ (6 - 1),
--   --[[ 8]] TROLL = 2 ^ (8 - 1),
--   --[[ 9]] GOBLIN = WOW_PROJECT_ID >= WOW_PROJECT_CATACLYSM_CLASSIC and 2 ^ (9 - 1) or nil,
--   --[[10]] BLOOD_ELF = WOW_PROJECT_ID >= WOW_PROJECT_BURNING_CRUSADE_CLASSIC and 2 ^ (10 - 1) or nil,
--   --[[26]] PANDAREN_H = WOW_PROJECT_ID >= WOW_PROJECT_MISTS_CLASSIC and 2 ^ (26 - 1) or nil, -- Pandaren Horde
-- }

-- ---@class RaceKeys:AllianceRaceKeys,HordeRaceKeys
-- ---@field ALL_ALLIANCE number A combination of all alliance raceKeys
-- ---@field ALL_HORDE number A combination of all horde raceKeys
-- Enum.raceKeys = {
--   --[[ 0]] NONE = 0,
--   --[[24]] PANDAREN_N = WOW_PROJECT_ID >= WOW_PROJECT_MISTS_CLASSIC and 2 ^ (24 - 1) or nil, -- Pandaren Neutral
-- }
-- Enum.raceKeys.ALL_ALLIANCE = (function()
--   local alliance = 0
--   for race, v in pairs(allianceRaceKeys) do
--     alliance = alliance + v
--     Enum.raceKeys[race] = v
--   end
--   return alliance
-- end)()
-- Enum.raceKeys.ALL_HORDE = (function()
--   local horde = 0
--   for race, v in pairs(hordeRaceKeys) do
--     horde = horde + v
--     Enum.raceKeys[race] = v
--   end
--   return horde
-- end)()

-- -- race bitmask data, for easy access
-- QuestieDB.raceKeys = {
--   ALL_ALLIANCE = (function()
--     if LibQuestieDB.IsClassic then
--       return 77
--     elseif LibQuestieDB.IsCata then
--       return 2098253
--     elseif LibQuestieDB.IsMoP then
--       return 18875469
--     elseif LibQuestieDB.IsTBC or LibQuestieDB.IsWotlk then
--       return 1101
--     end
--     error("Unknown expansion for ALL_ALLIANCE")
--   end)(),
--   ALL_HORDE = (function()
--     if LibQuestieDB.IsClassic then
--       return 178
--     elseif LibQuestieDB.IsCata then
--       return 946
--     elseif LibQuestieDB.IsMoP then
--       return 33555378
--     elseif LibQuestieDB.IsTBC or LibQuestieDB.IsWotlk then
--       return 690
--     end
--     error("Unknown expansion for ALL_HORDE")
--   end)(),
--   NONE = 0,

--   --[[ 1]] HUMAN = 1,
--   --[[ 2]] ORC = 2,
--   --[[ 3]] DWARF = 4,
--   --[[ 4]] NIGHT_ELF = 8,
--   --[[ 5]] UNDEAD = 16,
--   --[[ 6]] TAUREN = 32,
--   --[[ 7]] GNOME = 64,
--   --[[ 8]] TROLL = 128,
--   --[[ 9]] GOBLIN = 256,
--   --[[10]] BLOOD_ELF = 512,
--   --[[11]] DRAENEI = 1024,
--   --[[22]] WORGEN = 2097152,      -- lol
--   --[[24]] PANDAREN_N = 8388608,  -- Pandaren Neutral
--   --[[25]] PANDAREN_A = 16777216, -- Pandaren Alliance
--   --[[26]] PANDAREN_H = 33554432, -- Pandaren Horde
-- }


-- ---@class AllianceRaceKeys
-- local allianceRaceKeys = {
--   --[ 1] HUMAN = 1,
--   --[ 3] DWARF = 4,
--   --[ 4] NIGHT_ELF = 8,
--   --[ 7] GNOME = 64,
--   --[11] DRAENEI = WOW_PROJECT_ID >= WOW_PROJECT_BURNING_CRUSADE_CLASSIC and 1024 or nil,
--   --[22] WORGEN = WOW_PROJECT_ID >= WOW_PROJECT_CATACLYSM_CLASSIC and 2097152 or nil,
--   --[25] PANDAREN_A = WOW_PROJECT_ID >= WOW_PROJECT_MISTS_CLASSIC and 16777216 or nil, -- Pandaren Alliance

--   --[[ 1]] HUMAN = 2 ^ (1 - 1),
--   --[[ 3]] DWARF = 2 ^ (3 - 1),
--   --[[ 4]] NIGHT_ELF = 2 ^ (4 - 1),
--   --[[ 7]] GNOME = 2 ^ (7 - 1),
--   --[[11]] DRAENEI = WOW_PROJECT_ID >= WOW_PROJECT_BURNING_CRUSADE_CLASSIC and 2 ^ (11 - 1) or nil,
--   --[[22]] WORGEN = WOW_PROJECT_ID >= WOW_PROJECT_CATACLYSM_CLASSIC and 2 ^ (22 - 1) or nil,
--   --[[25]] PANDAREN_A = WOW_PROJECT_ID >= WOW_PROJECT_MISTS_CLASSIC and 2 ^ (25 - 1) or nil, -- Pandaren Alliance
-- }

-- ---@class HordeRaceKeys
-- local hordeRaceKeys = {
--   --[ 2]] ORC = 2,
--   --[ 5]] UNDEAD = 16,
--   --[ 6]] TAUREN = 32,
--   --[ 8]] TROLL = 128,
--   --[ 9]] GOBLIN = WOW_PROJECT_ID >= WOW_PROJECT_CATACLYSM_CLASSIC and 256 or nil,
--   --[10]] BLOOD_ELF = WOW_PROJECT_ID >= WOW_PROJECT_BURNING_CRUSADE_CLASSIC and 512 or nil,
--   --[26]] PANDAREN_H = WOW_PROJECT_ID >= WOW_PROJECT_MISTS_CLASSIC and 33554432 or nil, -- Pandaren Horde

--   --[[ 2]] ORC = 2 ^ (2 - 1),
--   --[[ 5]] UNDEAD = 2 ^ (5 - 1),
--   --[[ 6]] TAUREN = 2 ^ (6 - 1),
--   --[[ 8]] TROLL = 2 ^ (8 - 1),
--   --[[ 9]] GOBLIN = WOW_PROJECT_ID >= WOW_PROJECT_CATACLYSM_CLASSIC and 2 ^ (9 - 1) or nil,
--   --[[10]] BLOOD_ELF = WOW_PROJECT_ID >= WOW_PROJECT_BURNING_CRUSADE_CLASSIC and 2 ^ (10 - 1) or nil,
--   --[[26]] PANDAREN_H = WOW_PROJECT_ID >= WOW_PROJECT_MISTS_CLASSIC and 2 ^ (26 - 1) or nil, -- Pandaren Horde
-- }
-- ---@class RaceKeys:AllianceRaceKeys,HordeRaceKeys
-- ---@field ALL_ALLIANCE number A combination of all alliance raceKeys
-- ---@field ALL_HORDE number A combination of all horde raceKeys
-- Enum.raceKeys = {
--   --[[ 0]] NONE = 0,
--   --[[24]] PANDAREN_N = 8388608, -- Pandaren Neutral
-- }
