-- Service, class and weapon-skill constants (ADR 0017).

local _, LibQuestieDB = ...
local constants = LibQuestieDB.Enum

-- Values of the `services` list field on NPCs and objects. One ID per service, the same in
-- every flavor. To add a service, append the next free number; never renumber or reuse one,
-- because stored data and consumers hold these values.
constants.serviceKeys = {
  GOSSIP = 1,
  QUEST_GIVER = 2,
  VENDOR = 3,
  VENDOR_AMMO = 4,
  VENDOR_FOOD = 5,
  VENDOR_POISON = 6,
  VENDOR_REAGENT = 7,
  REPAIR = 8,
  FLIGHT_MASTER = 9,
  -- TRAINER is the general flag; the kinds below and later say what is taught, together with
  -- the `trainerClass` and `trainerSkills` fields.
  TRAINER = 10,
  CLASS_TRAINER = 11,
  PROFESSION_TRAINER = 12,
  SPIRIT_HEALER = 13,
  SPIRIT_GUIDE = 14,
  INNKEEPER = 15,
  BANKER = 16,
  PETITIONER = 17,
  TABARD_DESIGNER = 18,
  BATTLEMASTER = 19,
  AUCTIONEER = 20,
  STABLE_MASTER = 21,
  GUILD_BANKER = 22,
  SPELLCLICK = 23,
  BARBER = 24,
  -- Mailbox objects, and the few NPCs that act as one.
  MAILBOX = 25,
  ARCANE_REFORGER = 26,
  TRANSMOGRIFIER = 27,
  VOID_STORAGE = 28,
  BLACK_MARKET = 29,
  -- Trainer kinds no NPC flag expresses.
  WEAPON_MASTER = 30,
  PORTAL_TRAINER = 31,
  PET_TRAINER = 32,
  DEMON_TRAINER = 33,
  BATTLE_PET_TRAINER = 34,
  RIDING_TRAINER = 35,
  -- Object kinds.
  MEETING_STONE = 36,
  ANVIL = 37,
  FORGE = 38,
  ALCHEMY_LAB = 39,
  MOONWELL = 40,
}

-- Class IDs as the client numbers them (ChrClasses), for `trainerClass`. These are plain IDs,
-- unlike `classKeys`, whose values are `requiredClasses` mask bits.
constants.classIDs = {
  WARRIOR = 1,
  PALADIN = 2,
  HUNTER = 3,
  ROGUE = 4,
  PRIEST = 5,
  DEATH_KNIGHT = 6,
  SHAMAN = 7,
  MAGE = 8,
  WARLOCK = 9,
  MONK = 10,
  DRUID = 11,
}

-- Weapon skill line IDs (SkillLine), for `trainerSkills`. Profession and riding skill lines
-- are in `professionKeys`; both share the SkillLine ID space.
constants.weaponSkillKeys = {
  SWORDS = 43,
  AXES = 44,
  BOWS = 45,
  GUNS = 46,
  MACES = 54,
  TWO_HANDED_SWORDS = 55,
  STAVES = 136,
  TWO_HANDED_MACES = 160,
  UNARMED = 162,
  TWO_HANDED_AXES = 172,
  DAGGERS = 173,
  THROWN = 176,
  CROSSBOWS = 226,
  WANDS = 228,
  POLEARMS = 229,
  FIST_WEAPONS = 473,
}
