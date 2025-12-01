---@type LibQuestieDB
local LibQuestieDB = select(2, ...)

---@class (exact) Item
---@field FastTest fun()
local Item = LibQuestieDB.Item

local Database = LibQuestieDB.Database

-- Test data for Item ID 117 (Tough Jerky)
-- <!-- 117 -->
-- <p>1,2,3,6,7,8</p>
-- <p>Tough Jerky</p>
-- <p>{38,43,46,60,79,80,94,97,99,100,103,116,285,327,448,471,472,473,474,475,476,478,706,707,708,724,732,808,880,881,946,1115,1116,1117,1118,1119,1120,1121,1122,1123,1124,1134,1135,1137,1196,1211,1260,1271,1388,1397,1505,1506,1507,1520,1522,1523,1529,1534,1537,1718,1753,1934,1936,1941,1984,1985,1986,1988,1989,1993,1994,2002,2003,2004,2005,2006,2007,2009,2010,2011,2015,2017,2018,2019,2020,2021,2038,2949,2950,2951,2954,2959,2960,2962,2963,2964,2965,2966,2967,2968,2975,2976,2977,2978,2979,2989,2990,3051,3098,3101,3103,3104,3106,3111,3112,3113,3114,3115,3116,3117,3118,3119,3120,3121,3122,3129,3130,3131,3183,3192,3195,3196,3197,3198,3199,3203,3204,3205,3206,3207,3566,5426,5429,5785,5786,5787,5808,5809,5822,5824,6113,6123,6124,6128,6846,6866,6911,6927,7318,14431,14432}</p>
-- <p>{2843,2844,2845,2847,106318,106319}</p>
-- <p>{815,2160}</p>
-- <p>0;0;5;1;0;0;0</p>
-- <p>{982,1464,2365,2388,2814,3025,3089,3312,3368,3411,3489,3621,3705,3881,3882,3933,3935,3960,4084,4169,4255,4782,4875,4879,4891,4894,4954,4963,5111,5124,5611,5620,5870,6928,6929,6930,7485,7731,7733,7736,7941,8125,9356,10367,11118,11187,12196,12794,12959,14624,15174}</p>

-- This function is a quick sanity check to run on startup.
-- It verifies that the database is returning reasonable values for a known Item (ID 117).
function Item.FastTest()
  local id = 117

  local name = Item.name(id)
  assert(type(name) == "string" and name == "Tough Jerky", "[Item.test.simple] Name should be 'Tough Jerky'")

  local npcDrops = Item.npcDrops(id)
  assert(type(npcDrops) == "table", "[Item.test.simple] npcDrops should be a table")
  assert(#npcDrops > 0, "[Item.test.simple] npcDrops should not be empty")

  local objectDrops = Item.objectDrops(id)
  assert(type(objectDrops) == "table", "[Item.test.simple] objectDrops should be a table")
  assert(#objectDrops > 0, "[Item.test.simple] objectDrops should not be empty")

  local itemDrops = Item.itemDrops(id)
  assert(itemDrops == nil, "[Item.test.simple] itemDrops should be nil")

  local startQuest = Item.startQuest(id)
  assert(startQuest == 0, "[Item.test.simple] startQuest should be 0 (default)")

  local questRewards = Item.questRewards(id)
  assert(type(questRewards) == "table", "[Item.test.simple] questRewards should be a table")
  assert(#questRewards > 0, "[Item.test.simple] questRewards should not be empty")

  local flags = Item.flags(id)
  assert(type(flags) == "number" and flags == 0, "[Item.test.simple] flags should be 0")

  local foodType = Item.foodType(id)
  assert(type(foodType) == "number" and foodType == 0, "[Item.test.simple] foodType should be 0")

  local itemLevel = Item.itemLevel(id)
  assert(type(itemLevel) == "number" and itemLevel == 5, "[Item.test.simple] itemLevel should be 5")

  local requiredLevel = Item.requiredLevel(id)
  assert(type(requiredLevel) == "number" and requiredLevel == 1, "[Item.test.simple] requiredLevel should be 1")

  local ammoType = Item.ammoType(id)
  assert(type(ammoType) == "number" and ammoType == 0, "[Item.test.simple] ammoType should be 0")

  local class = Item.class(id)
  assert(type(class) == "number" and class == 0, "[Item.test.simple] class should be 0")

  local subClass = Item.subClass(id)
  assert(type(subClass) == "number" and subClass == 0, "[Item.test.simple] subClass should be 0")

  local vendors = Item.vendors(id)
  assert(type(vendors) == "table", "[Item.test.simple] vendors should be a table")
  assert(#vendors > 0, "[Item.test.simple] vendors should not be empty")

  local relatedQuests = Item.relatedQuests(id)
  assert(relatedQuests == nil, "[Item.test.simple] relatedQuests should be nil")

  local teachesSpell = Item.teachesSpell(id)
  assert(teachesSpell == 0, "[Item.test.simple] teachesSpell should be 0 (default)")

  if Database.debugPrintEnabled or Database.debugEnabled then
    LibQuestieDB.ColorizePrint("green", "  [Item.test.simple] TestItem passed for ID " .. id)
  end
end
