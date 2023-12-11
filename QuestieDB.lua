-- Dump all functions in the global namespace

QuestieItemFixes = QuestieItemFixes or {}
QuestieNPCFixes = QuestieNPCFixes or {}
QuestieDB = QuestieDB or {}

QuestieDB.itemKeys = {
  ['name'] = 1,           -- string
  ['npcDrops'] = 2,       -- table or nil, NPC IDs
  ['objectDrops'] = 3,    -- table or nil, object IDs
  ['itemDrops'] = 4,      -- table or nil, item IDs
  ['startQuest'] = 5,     -- int or nil, ID of the quest started by this item
  ['questRewards'] = 6,   -- table or nil, quest IDs
  ['flags'] = 7,          -- int or nil, see: https://github.com/cmangos/issues/wiki/Item_template#flags
  ['foodType'] = 8,       -- int or nil, see https://github.com/cmangos/issues/wiki/Item_template#foodtype
  ['itemLevel'] = 9,      -- int, the level of this item
  ['requiredLevel'] = 10, -- int, the level required to equip/use this item
  ['ammoType'] = 11,      -- int,
  ['class'] = 12,         -- int,
  ['subClass'] = 13,      -- int,
  ['vendors'] = 14,       -- table or nil, NPC IDs
  ['relatedQuests'] = 15, -- table or nil, IDs of quests that are related to this item
}

QuestieDB.npcKeys = {
  ['name'] = 1,               -- string
  ['minLevelHealth'] = 2,     -- int
  ['maxLevelHealth'] = 3,     -- int
  ['minLevel'] = 4,           -- int
  ['maxLevel'] = 5,           -- int
  ['rank'] = 6,               -- int, see https://github.com/cmangos/issues/wiki/creature_template#rank
  ['spawns'] = 7,             -- table {[zoneID(int)] = {coordPair(floatVector2D),...},...}
  ['waypoints'] = 8,          -- table {[zoneID(int)] = {coordPair(floatVector2D),...},...}
  ['zoneID'] = 9,             -- guess as to where this NPC is most common
  ['questStarts'] = 10,       -- table {questID(int),...}
  ['questEnds'] = 11,         -- table {questID(int),...}
  ['factionID'] = 12,         -- int, see https://github.com/cmangos/issues/wiki/FactionTemplate.dbc
  ['friendlyToFaction'] = 13, -- string, Contains "A" and/or "H" depending on NPC being friendly towards those factions. nil if hostile to both.
  ['subName'] = 14,           -- string, The title or function of the NPC, e.g. "Weapon Vendor"
  ['npcFlags'] = 15,          -- int, Bitmask containing various flags about the NPCs function (Vendor, Trainer, Flight Master, etc.).
  -- For flag values see https://github.com/cmangos/mangos-classic/blob/172c005b0a69e342e908f4589b24a6f18246c95e/src/game/Entities/Unit.h#L536
}
DevTools_Dump(QuestieDB.npcKeys)

function QuestieItemFixes:LoadFactionFixes()
  local itemKeys = QuestieDB.itemKeys

  local itemFixesHorde = {
    [15882] = {
      [itemKeys.objectDrops] = { 177790 },
    },
    [15883] = {
      [itemKeys.objectDrops] = { 177794 },
    },
    [3713] = {
      [itemKeys.relatedQuests] = { 7321, 1218 },
      [itemKeys.npcDrops] = { 2397, 8307 },
      [itemKeys.objectDrops] = {},
    },
    -- TBC
    [25911] = {
      [itemKeys.objectDrops] = { 182936 },
    },
    [25912] = {
      [itemKeys.objectDrops] = { 182937, 182938 },
    },
  }

  local itemFixesAlliance = {
    [15882] = {
      [itemKeys.objectDrops] = { 177844 },
    },
    [15883] = {
      [itemKeys.objectDrops] = { 177792 },
    },
    [3713] = {
      [itemKeys.name] = "Soothing Spices",
      [itemKeys.relatedQuests] = { 555, 1218 },
      [itemKeys.npcDrops] = { 2381, 4897 },
      [itemKeys.objectDrops] = {},
    },
    -- TBC
    [25911] = {
      [itemKeys.objectDrops] = { 182799 },
    },
    [25912] = {
      [itemKeys.objectDrops] = { 182798, 182797 },
    },
  }
  QuestieItemFixes.LoadFactionFixes = nil
  if UnitFactionGroup("Player") == "Horde" then
    return itemFixesHorde
  else
    return itemFixesAlliance
  end
end

function QuestieNPCFixes:LoadFactionFixes()
  local npcKeys = QuestieDB.npcKeys
  local zoneIDs = ZoneDB.zoneIDs

  local npcFixesHorde = {
    [13778] = {
      [npcKeys.spawns] = { [zoneIDs.ALTERAC_VALLEY] = { { 52.8, 44 }, { 50.8, 30.8 }, { 45.2, 14.6 }, { 44, 18.1 } } },
      [npcKeys.zoneID] = zoneIDs.ALTERAC_VALLEY,
    },
    [15898] = {
      [npcKeys.spawns] = {
        [zoneIDs.ORGRIMMAR] = { { 41.27, 32.36 } },
        [zoneIDs.THUNDER_BLUFF] = { { 70.56, 27.83 } },
        [zoneIDs.UNDERCITY] = { { 66.45, 36.02 } },
        [zoneIDs.MOONGLADE] = { { 36.58, 58.1 }, { 36.3, 58.53 } },
      },
    },
    [16788] = {
      [npcKeys.spawns] = {
        [zoneIDs.ORGRIMMAR] = { { 42.61, 34.21 } },
        [zoneIDs.UNDERCITY] = { { 65.6, 35.99 } },
        [zoneIDs.THUNDER_BLUFF] = { { 21.55, 26.18 } },
      },
      [npcKeys.zoneID] = zoneIDs.ORGRIMMAR,
    },
  }

  local npcFixesAlliance = {
    [13778] = {
      [npcKeys.spawns] = { [zoneIDs.ALTERAC_VALLEY] = { { 48.5, 58.3 }, { 50.2, 65.3 }, { 49.3, 84.4 }, { 48.3, 84.3 } } },
      [npcKeys.zoneID] = zoneIDs.ALTERAC_VALLEY,
    },
    [15898] = {
      [npcKeys.spawns] = {
        [zoneIDs.STORMWIND_CITY] = { { 22.78, 51.19 } },
        [zoneIDs.IRONFORGE] = { { 29.92, 14.21 } },
        [zoneIDs.MOONGLADE] = { { 36.58, 58.1 }, { 36.3, 58.53 } },
        [zoneIDs.DARNASSUS] = { { 31.56, 13.69 } },
      },
      [npcKeys.zoneID] = zoneIDs.STORMWIND_CITY,
    },
    [16788] = {
      [npcKeys.spawns] = {
        [zoneIDs.TELDRASSIL] = { { 56.56, 91.94 } },
        [zoneIDs.STORMWIND_CITY] = { { 38.4, 61.29 } },
        [zoneIDs.IRONFORGE] = { { 63.54, 24.67 } },
      },
      [npcKeys.zoneID] = zoneIDs.TELDRASSIL,
    },
  }
  QuestieNPCFixes.LoadFactionFixes = nil
  if UnitFactionGroup("Player") == "Horde" then
    return npcFixesHorde
  else
    return npcFixesAlliance
  end
end

-- Register slash command
SlashCmdList["QuestieDB"] = function(args)
  if args == "test" then
    print("Running tests")
    local success, error = pcall(Npc.testGetFunctions, true)
    if not success then
      print("Npc test failed: " .. error)
      print("Last tested NPC: " .. tostring(Npc.lastTestedID))
    end
    success, error = pcall(Object.testGetFunctions, true)
    if not success then
      print("Object test failed: " .. error)
      print("Last tested Object: " .. tostring(Object.lastTestedID))
    end
    success, error = pcall(Quest.testGetFunctions, true)
    if not success then
      print("Quest test failed: " .. error)
      print("Last tested Quest: " .. tostring(Quest.lastTestedID))
    end
    success, error = pcall(Item.testGetFunctions, true)
    if not success then
      print("Item test failed: " .. error)
      print("Last tested Item: " .. tostring(Item.lastTestedID))
    end
  elseif args == "t" then
    local floor = math.floor
    debugprofilestart()
    for i = 1, 1000000 do
      ---@diagnostic disable-next-line: unused-local
      local mid = floor((i + (i+0.5)) / 2)
    end
    local time1 = debugprofilestop()
    debugprofilestart()
    for i = 1, 1000000 do
      local mid = (i + (i + 0.5)) / 2
      mid = mid - mid % 1
    end
    local time2 = debugprofilestop()
    -- Validate
    for i = 1, 1000000 do
      local mid = floor((i + (i+0.5)) / 2)
      local mid2 = (i + (i + 0.5)) / 2
      mid2 = mid2 - mid2 % 1
      if mid ~= mid2 then
        print("Error")
        print(mid, mid2)
        break
      end
    end
    print("Floor Test Done and validated.")
    print("Localized math.floor", time1, "ms")
    print("Modulus to floor", time2, "ms")
  end
end
SLASH_QuestieDB1 = "/QuestieDB"
SLASH_QuestieDB2 = "/qdb"

ZoneDB = {
  zoneIDs = {
    DUN_MOROGH = 1,
    BADLANDS = 3,
    BLASTED_LANDS = 4,
    SWAMP_OF_SORROWS = 8,
    DUSKWOOD = 10,
    WETLANDS = 11,
    ELWYNN_FOREST = 12,
    DUROTAR = 14,
    DUSTWALLOW_MARSH = 15,
    AZSHARA = 16,
    THE_BARRENS = 17,
    WESTERN_PLAGUELANDS = 28,
    STRANGLETHORN_VALE = 33,
    ALTERAC_MOUNTAINS = 36,
    LOCH_MODAN = 38,
    WESTFALL = 40,
    DEADWIND_PASS = 41,
    REDRIDGE_MOUNTAINS = 44,
    ARATHI_HIGHLANDS = 45,
    BURNING_STEPPES = 46,
    THE_HINTERLANDS = 47,
    SEARING_GORGE = 51,
    TIRISFAL_GLADES = 85,
    SILVERPINE_FOREST = 130,
    EASTERN_PLAGUELANDS = 139,
    TELDRASSIL = 141,
    DARKSHORE = 148,
    SHADOWFANG_KEEP = 209,
    MULGORE = 215,
    HILLSBRAD_FOOTHILLS = 267,
    ASHENVALE = 331,
    FERALAS = 357,
    FELWOOD = 361,
    THOUSAND_NEEDLES = 400,
    DESOLACE = 405,
    STONETALON_MOUNTAINS = 406,
    TANARIS = 440,
    UN_GORO_CRATER = 490,
    RAZORFEN_KRAUL = 491,
    MOONGLADE = 493,
    WINTERSPRING = 618,
    THE_STOCKADE = 717,
    WAILING_CAVERNS = 718,
    BLACKFATHOM_DEEPS = 719,
    GNOMEREGAN = 721,
    RAZORFEN_DOWNS = 722,
    SCARLET_MONASTERY = 796,
    ZUL_FARRAK = 1176,
    ULDAMAN = 1337,
    SILITHUS = 1377,
    THE_TEMPLE_OF_ATAL_HAKKAR = 1477,
    UNDERCITY = 1497,
    STORMWIND_CITY = 1519,
    IRONFORGE = 1537,
    THE_DEADMINES = 1581,
    LOWER_BLACKROCK_SPIRE = 1583,
    BLACKROCK_DEPTHS = 1585,
    ORGRIMMAR = 1637,
    THUNDER_BLUFF = 1638,
    DARNASSUS = 1657,
    ZUL_GURUB = 1977,
    STRATHOLME = 2017,
    SCHOLOMANCE = 2057,
    MARAUDON = 2100,
    ONYXIAS_LAIR = 2159,
    DEEPRUN_TRAM = 2257,
    SOUTH_SEAS = 2317,
    THE_BLACK_MORASS = 2366,
    OLD_HILLSBRAD_FOOTHILLS = 2367,
    RAGEFIRE_CHASM = 2437,
    DIRE_MAUL = 2557,
    ALTERAC_VALLEY = 2597,
    BLACKWING_LAIR = 2677,
    MOLTEN_CORE = 2717,
    HALL_OF_LEGENDS = 2917,
    CHAMPIONS_HALL = 2918,
    WARSONG_GULCH = 3277,
    ARATHI_BASIN = 3358,
    AHN_QIRAJ = 3428,
    RUINS_OF_AHN_QIRAJ = 3429,
    NAXXRAMAS = 3456,
    EVERSONG_WOODS = 3430,
    GHOSTLANDS = 3433,
    HELLFIRE_PENINSULA = 3483,
    SILVERMOON_CITY = 3487,
    NAGRAND = 3518,
    TEROKKAR_FOREST = 3519,
    SHADOWMOON_VALLEY = 3520,
    ZANGARMARSH = 3521,
    BLADES_EDGE_MOUNTAINS = 3522,
    NETHERSTORM = 3523,
    AZUREMYST_ISLE = 3524,
    BLOODMYST_ISLE = 3525,
    THE_EXODAR = 3557,
    HELLFIRE_RAMPARTS = 3562,
    HYJAL_SUMMIT = 3606,
    SHATTRATH_CITY = 3703,
    THE_BLOOD_FURNACE = 3713,
    THE_SHATTERED_HALLS = 3714,
    THE_STEAMVAULT = 3715,
    THE_UNDERBOG = 3716,
    THE_SLAVE_PENS = 3717,
    THE_BOTANICA = 3847,
    THE_ARCATRAZ = 3848,
    THE_MECHANAR = 3849,
    SHADOW_LABYRINTH = 3789,
    AUCHENAI_CRYPTS = 3790,
    SETHEKK_HALLS = 3791,
    MANA_TOMBS = 3792,
    TEMPEST_KEEP = 3845,
    ZUL_AMAN = 3805,
    BLACK_TEMPLE = 3959,
    SUNWELL_PLATEAU = 4075,
    ISLE_OF_QUEL_DANAS = 4080,
    MAGISTERS_TERRACE = 4131,
    UPPER_BLACKROCK_SPIRE = 7307,
    DRAGONBLIGHT = 65,
    ZUL_DRAK = 66,
    STORM_PEAKS = 67,
    ICECROWN = 210,
    GRIZZLY_HILLS = 394,
    HOWLING_FJORD = 495,
    CRYSTALSONG_FOREST = 2817,
    BOREAN_TUNDRA = 3537,
    SHOLAZAR_BASIN = 3711,
    WINTERGRASP = 4197,
    THE_NEXUS = 4265,
    ULDUAR = 4273,
    DALARAN = 4395,
    THE_UNDERBELLY = 4560,
    VIOLET_HOLD = 4415,
    UTGARDE_KEEP = 206,
    HALLS_OF_STONE = 4264,
    HALLS_OF_LIGHTNING = 4272,
    PLAGUELANDS_THE_SCARLET_ENCLAVE = 4298,
    THE_ARCHIVUM = 4657,
    TRIAL_OF_THE_CRUSADER = 4722,
    TRIAL_OF_THE_CHAMPION = 4723,
    HROTHGARS_LANDING = 4742,
    -- Fake IDs for Ulduar
    THE_PRISON_OF_YOGG_SARON = 4659,
    THE_SPARK_OF_IMAGINATION = 4660,
    THE_INNER_SANCTUM_OF_ULDUAR = 4661,
  }
}
