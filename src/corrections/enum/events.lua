-- World event constants (ADR 0017).

local _, LibQuestieDB = ...
local constants = LibQuestieDB.Enum

-- Values of the signed `eventIds` list field. A positive ID means "available only during this
-- event"; the negated ID means "unavailable during this event".
--
-- IDs below 100000 are Blizzard Holidays IDs (Holidays.db2, checked against the Mists Classic
-- export), used as-is. Classic Era's client has no Holidays rows for these events; the same IDs
-- serve as stable keys there. QuestieDB defines its own IDs from 100000 upward for events
-- without a Holidays row. Never renumber an ID: stored data and consumers hold these values.
constants.eventKeys = {
  -- Blizzard Holidays IDs
  FIREWORKS_SPECTACULAR = 62,
  WINTER_VEIL = 141,
  NOBLEGARDEN = 181,
  CHILDRENS_WEEK = 201,
  STRANGLETHORN_FISHING_EXTRAVAGANZA = 301,
  HARVEST_FESTIVAL = 321,
  HALLOWS_END = 324,
  LUNAR_FESTIVAL = 327,
  LOVE_IS_IN_THE_AIR = 335,
  MIDSUMMER = 341,
  BREWFEST = 372,
  -- Darkmoon Faire has one Holidays ID per location. The location order is inferred from the
  -- calendar texture order (Elwynn, Mulgore, Terokkar) and is not confirmed in game. From
  -- Cataclysm the faire is on Darkmoon Island under its own ID.
  DARKMOON_FAIRE_ELWYNN = 374,
  DARKMOON_FAIRE_MULGORE = 375,
  DARKMOON_FAIRE_TEROKKAR = 376,
  PIRATES_DAY = 398,
  PILGRIMS_BOUNTY = 404,
  DAY_OF_THE_DEAD = 409,
  KALUAK_FISHING_DERBY = 424,
  DARKMOON_FAIRE_ISLAND = 479,

  -- QuestieDB-defined events: no Holidays row exists.
  AHN_QIRAJ_WAR_EFFORT = 100001,
  SCOURGE_INVASION = 100002,
}
