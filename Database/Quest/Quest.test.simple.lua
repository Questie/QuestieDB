---@type LibQuestieDB
local LibQuestieDB = select(2, ...)

---@class (exact) Quest
---@field FastTest fun()
local Quest = LibQuestieDB.Quest

local Database = LibQuestieDB.Database

-- Test data for Quest ID 2
-- <!-- 2 -->
-- <p>1,2,3,4,5,6,8,11,13,15,17,26</p>
-- <p>Sharptalon's Claw</p>
-- <p>{{12676},nil,{16305}}</p>
-- <p>{{12696}}</p>
-- <p>20</p>
-- <p>30</p>
-- <p>178</p>
-- <p>{'Bring Sharptalon\'s Claw to Senani Thunderheart at Splintertree Post, Ashenvale.'}</p>
-- <p>16305</p>
-- <p>{6383}</p>
-- <p>{23,24}</p>
-- <p>331</p>
-- <p>{{81,100}}</p>

-- This function is a quick sanity check to run on startup.<br>
-- It verifies that the database is returning reasonable values for a known quest (ID 2).
function Quest.FastTest()
  local id = 2

  local name = Quest.name(id)
  assert(type(name) == "string" and string.len(name) > 5, "[Quest.test.simple] Name should be a string longer than 5 characters")

  local startedBy = Quest.startedBy(id)
  assert(type(startedBy) == "table", "[Quest.test.simple] startedBy should be a table")
  local hasStarter = false
  for k, v in pairs(startedBy) do
    if v and #v > 0 then hasStarter = true end
  end
  assert(hasStarter, "[Quest.test.simple] startedBy should have at least one starter")

  local finishedBy = Quest.finishedBy(id)
  assert(type(finishedBy) == "table", "[Quest.test.simple] finishedBy should be a table")
  local hasFinisher = false
  for k, v in pairs(finishedBy) do
    if v and #v > 0 then hasFinisher = true end
  end
  assert(hasFinisher, "[Quest.test.simple] finishedBy should have at least one finisher")

  local requiredLevel = Quest.requiredLevel(id)
  assert(type(requiredLevel) == "number" and requiredLevel > 0, "[Quest.test.simple] requiredLevel should be a number > 0")

  local questLevel = Quest.questLevel(id)
  assert(type(questLevel) == "number" and questLevel > 0, "[Quest.test.simple] questLevel should be a number > 0")

  local requiredRaces = Quest.requiredRaces(id)
  assert(type(requiredRaces) == "number" and requiredRaces > 0, "[Quest.test.simple] requiredRaces should be a number > 0")

  local objectivesText = Quest.objectivesText(id)
  assert(type(objectivesText) == "table" and #objectivesText > 0, "[Quest.test.simple] objectivesText should be a non-empty table")
  assert(type(objectivesText[1]) == "string" and string.len(objectivesText[1]) > 5, "[Quest.test.simple] First objective text should be a string > 5 chars")

  local sourceItemId = Quest.sourceItemId(id)
  assert(type(sourceItemId) == "number" and sourceItemId > 0, "[Quest.test.simple] sourceItemId should be a number > 0")

  local preQuestSingle = Quest.preQuestSingle(id)
  assert(type(preQuestSingle) == "table" and #preQuestSingle > 0, "[Quest.test.simple] preQuestSingle should be a non-empty table")

  local inGroupWith = Quest.inGroupWith(id)
  assert(type(inGroupWith) == "table" and #inGroupWith > 0, "[Quest.test.simple] inGroupWith should be a non-empty table")

  local zoneOrSort = Quest.zoneOrSort(id)
  assert(type(zoneOrSort) == "number" and zoneOrSort ~= 0, "[Quest.test.simple] zoneOrSort should be a number != 0")

  local reputationReward = Quest.reputationReward(id)
  assert(type(reputationReward) == "table" and #reputationReward > 0, "[Quest.test.simple] reputationReward should be a non-empty table")
  for _, rep in pairs(reputationReward) do
    assert(type(rep) == "table", "[Quest.test.simple] Each reputationReward entry should be a table")
    assert(type(rep[1]) == "number" and rep[1] > 0, "[Quest.test.simple] factionID should be a number > 0")
    assert(type(rep[2]) == "number" and rep[2] > 0, "[Quest.test.simple] amount should be a number > 0")
  end

  if Database.debugPrintEnabled or Database.debugEnabled then
    LibQuestieDB.ColorizePrint("green", "  [Quest.test.simple] TestQuest passed for ID " .. id)
  end
end
