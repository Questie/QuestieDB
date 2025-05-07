---@type LibQuestieDB
local LibQuestieDB = select(2, ...)

---@class (exact) Quest
---@field RunGetTest fun(fast: boolean)
---@field package testGetFunctions fun(fast: boolean)
---@field package lastTestedID QuestId
---@field package lastTestedData string
local Quest = LibQuestieDB.Quest

Quest.RunGetTest = function(fast)
  local success, err = pcall(Quest.testGetFunctions, fast)
  if not success then
    print("Quest test failed: " .. err)
    print("Last tested Quest: " .. tostring(Quest.lastTestedID))
    print("Last tested Quest function: " .. tostring(Quest.lastTestedData))
    error("Quest test failed: " .. err)
  end
end

local tInsert = table.insert
Quest.testGetFunctions = function(fast)
  debugprofilestart()
  local functions = 0
  for _, _ in pairs(LibQuestieDB.Corrections.QuestMeta.questKeys) do
    functions = functions + 1
  end

  local count = 0
  -- for id in pairs(glob) do
  for id in pairs(Quest.GetAllIds()) do
    Quest.lastTestedID = id
    Quest.lastTestedData = ""
    count = count + 1
    local data = {}
    tInsert(data, "Testing Quest " .. id)

    -- Test Quest.name
    Quest.lastTestedData = "name"
    tInsert(data, "Name: " .. (Quest.name(id) or "nil"))

    -- Test Quest.startedBy
    Quest.lastTestedData = "startedBy"
    local startedBy = Quest.startedBy(id)
    if startedBy then
      tInsert(data, "Started By:")
      for i, entity in ipairs(startedBy) do
        tInsert(data, "  group: " .. i)
        for _, entity in ipairs(entity) do
          tInsert(data, "    Entity: " .. entity)
        end
      end
    else
      tInsert(data, "Started By: nil")
    end

    -- Test Quest.finishedBy
    Quest.lastTestedData = "finishedBy"
    local finishedBy = Quest.finishedBy(id)
    if finishedBy then
      tInsert(data, "Finished By:")
      for i, entity in ipairs(finishedBy) do
        tInsert(data, "  group: " .. i)
        for _, entity in ipairs(entity) do
          tInsert(data, "    Entity: " .. entity)
        end
      end
    else
      tInsert(data, "Finished By: nil")
    end

    -- Test Quest.requiredLevel
    Quest.lastTestedData = "requiredLevel"
    tInsert(data, "Required Level: " .. (Quest.requiredLevel(id) or "nil"))

    -- Test Quest.questLevel
    Quest.lastTestedData = "questLevel"
    tInsert(data, "Quest Level: " .. (Quest.questLevel(id) or "nil"))

    -- Test Quest.requiredRaces
    Quest.lastTestedData = "requiredRaces"
    tInsert(data, "Required Races: " .. (Quest.requiredRaces(id) or "nil"))

    -- Test Quest.requiredClasses
    Quest.lastTestedData = "requiredClasses"
    tInsert(data, "Required Classes: " .. (Quest.requiredClasses(id) or "nil"))

    -- Test Quest.objectivesText
    Quest.lastTestedData = "objectivesText"
    local objectivesText = Quest.objectivesText(id)
    if objectivesText then
      tInsert(data, "Objectives Text:")
      for _, objective in ipairs(objectivesText) do
        tInsert(data, "  Objective: " .. objective)
      end
    else
      tInsert(data, "Objectives Text: nil")
    end

    -- Test Quest.triggerEnd
    Quest.lastTestedData = "triggerEnd"
    local triggerEnd = Quest.triggerEnd(id)
    if triggerEnd then
      tInsert(data, "Trigger End:")
      tInsert(data, "  Text: " .. triggerEnd[1])
      for zoneID, coords in pairs(triggerEnd[2] or {}) do
        tInsert(data, "  Zone " .. zoneID .. " Coords:")
        for _, coord in ipairs(coords) do
          tInsert(data, "    X: " .. coord[1] .. ", Y: " .. coord[2])
        end
      end
    else
      tInsert(data, "Trigger End: nil")
    end

    -- Test Quest.objectives
    Quest.lastTestedData = "objectives"
    local objectives = Quest.objectives(id)
    if objectives then
      tInsert(data, "Objectives:")
      for i, objective in ipairs(objectives) do
        tInsert(data, "  Objective group: " .. i)
        for _, objective in ipairs(objective) do
          tInsert(data, "    Objective: " .. objective[1] .. tostring(objective[2]))
        end
      end
    else
      tInsert(data, "Objectives: nil")
    end

    -- Test Quest.sourceItemId
    Quest.lastTestedData = "sourceItemId"
    tInsert(data, "Source Item ID: " .. (Quest.sourceItemId(id) or "nil"))

    -- Test Quest.preQuestGroup
    Quest.lastTestedData = "preQuestGroup"
    local preQuestGroup = Quest.preQuestGroup(id)
    if preQuestGroup then
      tInsert(data, "Pre-Quest Group:")
      for _, questID in ipairs(preQuestGroup) do
        tInsert(data, "  Quest ID: " .. questID)
      end
    else
      tInsert(data, "Pre-Quest Group: nil")
    end

    -- Test Quest.preQuestSingle
    Quest.lastTestedData = "preQuestSingle"
    local preQuestSingle = Quest.preQuestSingle(id)
    if preQuestSingle then
      tInsert(data, "Pre-Quest Single:")
      for _, questID in ipairs(preQuestSingle) do
        tInsert(data, "  Quest ID: " .. questID)
      end
    else
      tInsert(data, "Pre-Quest Single: nil")
    end

    -- Test Quest.childQuests
    Quest.lastTestedData = "childQuests"
    local childQuests = Quest.childQuests(id)
    if childQuests then
      tInsert(data, "Child Quests:")
      for _, questID in ipairs(childQuests) do
        tInsert(data, "  Quest ID: " .. questID)
      end
    else
      tInsert(data, "Child Quests: nil")
    end

    -- Test Quest.inGroupWith
    Quest.lastTestedData = "inGroupWith"
    local inGroupWith = Quest.inGroupWith(id)
    if inGroupWith then
      tInsert(data, "In Group With:")
      for _, questID in ipairs(inGroupWith) do
        tInsert(data, "  Quest ID: " .. questID)
      end
    else
      tInsert(data, "In Group With: nil")
    end

    -- Test Quest.exclusiveTo
    Quest.lastTestedData = "exclusiveTo"
    local exclusiveTo = Quest.exclusiveTo(id)
    if exclusiveTo then
      tInsert(data, "Exclusive To:")
      for _, questID in ipairs(exclusiveTo) do
        tInsert(data, "  Quest ID: " .. questID)
      end
    else
      tInsert(data, "Exclusive To: nil")
    end

    -- Test Quest.zoneOrSort
    Quest.lastTestedData = "zoneOrSort"
    tInsert(data, "Zone or Sort: " .. (Quest.zoneOrSort(id) or "nil"))

    -- Test Quest.requiredSkill
    Quest.lastTestedData = "requiredSkill"
    local requiredSkill = Quest.requiredSkill(id)
    if requiredSkill then
      tInsert(data, "Required Skill:")
      tInsert(data, "  Skill ID: " .. requiredSkill[1])
      tInsert(data, "  Skill Level: " .. requiredSkill[2])
    else
      tInsert(data, "Required Skill: nil")
    end

    -- Test Quest.requiredMinRep
    Quest.lastTestedData = "requiredMinRep"
    local requiredMinRep = Quest.requiredMinRep(id)
    if requiredMinRep then
      tInsert(data, "Required Min Reputation:")
      tInsert(data, "  Faction ID: " .. requiredMinRep[1])
      tInsert(data, "  Reputation Level: " .. requiredMinRep[2])
    else
      tInsert(data, "Required Min Reputation: nil")
    end

    -- Test Quest.requiredMaxRep
    Quest.lastTestedData = "requiredMaxRep"
    local requiredMaxRep = Quest.requiredMaxRep(id)
    if requiredMaxRep then
      tInsert(data, "Required Max Reputation:")
      tInsert(data, "  Faction ID: " .. requiredMaxRep[1])
      tInsert(data, "  Reputation Level: " .. requiredMaxRep[2])
    else
      tInsert(data, "Required Max Reputation: nil")
    end

    -- Test Quest.requiredSourceItems
    Quest.lastTestedData = "requiredSourceItems"
    local requiredSourceItems = Quest.requiredSourceItems(id)
    if requiredSourceItems then
      tInsert(data, "Required Source Items:")
      for _, itemID in ipairs(requiredSourceItems) do
        tInsert(data, "  Item ID: " .. itemID)
      end
    else
      tInsert(data, "Required Source Items: nil")
    end

    -- Test Quest.nextQuestInChain
    Quest.lastTestedData = "nextQuestInChain"
    tInsert(data, "Next Quest in Chain: " .. (Quest.nextQuestInChain(id) or "nil"))

    -- Test Quest.questFlags
    Quest.lastTestedData = "questFlags"
    tInsert(data, "Quest Flags: " .. (Quest.questFlags(id) or "nil"))

    -- Test Quest.specialFlags
    Quest.lastTestedData = "specialFlags"
    tInsert(data, "Special Flags: " .. (Quest.specialFlags(id) or "nil"))

    -- Test Quest.parentQuest
    Quest.lastTestedData = "parentQuest"
    tInsert(data, "Parent Quest: " .. (Quest.parentQuest(id) or "nil"))

    -- Test Quest.reputationReward
    Quest.lastTestedData = "reputationReward"
    local reputationReward = Quest.reputationReward(id)
    if reputationReward then
      tInsert(data, "Reward Reputation:")
      for _, repPair in ipairs(reputationReward) do
        tInsert(data, "  Faction ID: " .. repPair[1])
        tInsert(data, "  Reputation Level: " .. repPair[2])
      end
    else
      tInsert(data, "Reward Reputation: nil")
    end

    -- Test Quest.extraObjectives
    Quest.lastTestedData = "extraObjectives"
    local extraObjectives = Quest.extraObjectives(id)
    if extraObjectives then
      tInsert(data, "Extra Objectives:")
      for _, objective in ipairs(extraObjectives) do
        tInsert(data, "  Objective: " .. tostring(objective))
      end
    else
      tInsert(data, "Extra Objectives: nil")
    end

    -- Test Quest.requiredSpell
    Quest.lastTestedData = "requiredSpell"
    tInsert(data, "Required Spell: " .. (Quest.requiredSpell(id) or "nil"))

    -- Test Quest.requiredSpecialization
    Quest.lastTestedData = "requiredSpecialization"
    tInsert(data, "Required Specialization: " .. (Quest.requiredSpecialization(id) or "nil"))

    -- Test Quest.requiredMaxLevel
    Quest.lastTestedData = "requiredMaxLevel"
    tInsert(data, "Required Max Level: " .. (Quest.requiredMaxLevel(id) or "nil"))

    tInsert(data, "--------------------------------------------------")
    if not fast then
      print(table.concat(data, "\n"))
    end
  end

  local time = debugprofilestop()
  LibQuestieDB.ColorizePrint("green", "Quest Test Done", time, "ms")
  print("  ", count, "quests tested")
  print("  ", "time per quest:", time / count, "ms")
  print("  ", "avg time per function", time / (count * functions), "ms")
end
