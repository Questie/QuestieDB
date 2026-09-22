-- Correction constants. Source origins and extraction history: PROVENANCE.md.
-- Keep field-key tables aligned with the canonical schema in src/meta/.
-- Forever [uses the same shared schema keys; no flavor-specific field indices]

local _, LibQuestieDB = ...
local constants = LibQuestieDB.Enum

constants.questKeys = {
  name = 1,
  startedBy = 2,
  finishedBy = 3,
  requiredLevel = 4,
  questLevel = 5,
  requiredRaces = 6,
  requiredClasses = 7,
  objectivesText = 8,
  triggerEnd = 9,
  objectives = 10,
  sourceItemId = 11,
  preQuestGroup = 12,
  preQuestSingle = 13,
  childQuests = 14,
  inGroupWith = 15,
  exclusiveTo = 16,
  zoneOrSort = 17,
  requiredSkill = 18,
  requiredMinRep = 19,
  requiredMaxRep = 20,
  requiredSourceItems = 21,
  nextQuestInChain = 22,
  questFlags = 23,
  specialFlags = 24,
  parentQuest = 25,
  reputationReward = 26,
  breadcrumbForQuestId = 27,
  breadcrumbs = 28,
  extraObjectives = 29,
  requiredSpell = 30,
  requiredSpecialization = 31,
  requiredMaxLevel = 32,
  availableUntilCompleted = 33,
  availableStartingWith = 34,
  requiredRanks = 35,
  disabledByQuest = 36,
}

constants.npcKeys = {
  name = 1,
  minLevelHealth = 2,
  maxLevelHealth = 3,
  minLevel = 4,
  maxLevel = 5,
  rank = 6,
  spawns = 7,
  waypoints = 8,
  zoneID = 9,
  questStarts = 10,
  questEnds = 11,
  factionID = 12,
  friendlyToFaction = 13,
  subName = 14,
  npcFlags = 15,
}

constants.itemKeys = {
  name = 1,
  npcDrops = 2,
  objectDrops = 3,
  itemDrops = 4,
  startQuest = 5,
  questRewards = 6,
  flags = 7,
  foodType = 8,
  itemLevel = 9,
  requiredLevel = 10,
  ammoType = 11,
  class = 12,
  subClass = 13,
  vendors = 14,
  relatedQuests = 15,
  teachesSpell = 16,
}

constants.objectKeys = {
  name = 1,
  questStarts = 2,
  questEnds = 3,
  spawns = 4,
  zoneID = 5,
  factionID = 6,
  waypoints = 7,
}
