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
    print("Last tested QuestId: " .. tostring(Quest.lastTestedID))
    print("Last tested Quest function: " .. tostring(Quest.lastTestedData))
    error("Quest test failed: " .. err)
  end
end

local tInsert = table.insert
Quest.testGetFunctions = function(fast)
  debugprofilestart()
  local beginTime = debugprofilestop()
  local functions = 0
  for _, _ in pairs(LibQuestieDB.Meta.QuestMeta.questKeys) do
    functions = functions + 1
  end

  local perFunctionPerformance = {}

  local count = 0
  -- for id in pairs(glob) do
  for id in pairs(Quest.GetAllIds()) do
    Quest.lastTestedID = id
    Quest.lastTestedData = ""
    count = count + 1
    local data = {}
    local time = 0
    local runTime = 0
    tInsert(data, "Testing Quest " .. id)

    -- Test Quest.name
    Quest.lastTestedData = "name"
    time = debugprofilestop()
    tInsert(data, "Name: " .. (Quest.name(id) or "nil"))
    runTime = debugprofilestop() - time
    perFunctionPerformance[Quest.lastTestedData] = (perFunctionPerformance[Quest.lastTestedData] or 0) + runTime

    -- Test Quest.startedBy
    Quest.lastTestedData = "startedBy"
    time = debugprofilestop()
    local startedBy = Quest.startedBy(id)
    runTime = debugprofilestop() - time
    perFunctionPerformance[Quest.lastTestedData] = (perFunctionPerformance[Quest.lastTestedData] or 0) + runTime
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
    time = debugprofilestop()
    local finishedBy = Quest.finishedBy(id)
    runTime = debugprofilestop() - time
    perFunctionPerformance[Quest.lastTestedData] = (perFunctionPerformance[Quest.lastTestedData] or 0) + runTime
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
    time = debugprofilestop()
    tInsert(data, "Required Level: " .. (Quest.requiredLevel(id) or "nil"))
    runTime = debugprofilestop() - time
    perFunctionPerformance[Quest.lastTestedData] = (perFunctionPerformance[Quest.lastTestedData] or 0) + runTime

    -- Test Quest.questLevel
    Quest.lastTestedData = "questLevel"
    time = debugprofilestop()
    tInsert(data, "Quest Level: " .. (Quest.questLevel(id) or "nil"))
    runTime = debugprofilestop() - time
    perFunctionPerformance[Quest.lastTestedData] = (perFunctionPerformance[Quest.lastTestedData] or 0) + runTime

    -- Test Quest.requiredRaces
    Quest.lastTestedData = "requiredRaces"
    time = debugprofilestop()
    tInsert(data, "Required Races: " .. (Quest.requiredRaces(id) or "nil"))
    runTime = debugprofilestop() - time
    perFunctionPerformance[Quest.lastTestedData] = (perFunctionPerformance[Quest.lastTestedData] or 0) + runTime

    -- Test Quest.requiredClasses
    Quest.lastTestedData = "requiredClasses"
    time = debugprofilestop()
    tInsert(data, "Required Classes: " .. (Quest.requiredClasses(id) or "nil"))
    runTime = debugprofilestop() - time
    perFunctionPerformance[Quest.lastTestedData] = (perFunctionPerformance[Quest.lastTestedData] or 0) + runTime

    -- Test Quest.objectivesText
    Quest.lastTestedData = "objectivesText"
    time = debugprofilestop()
    local objectivesText = Quest.objectivesText(id)
    runTime = debugprofilestop() - time
    perFunctionPerformance[Quest.lastTestedData] = (perFunctionPerformance[Quest.lastTestedData] or 0) + runTime
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
    time = debugprofilestop()
    local triggerEnd = Quest.triggerEnd(id)
    runTime = debugprofilestop() - time
    perFunctionPerformance[Quest.lastTestedData] = (perFunctionPerformance[Quest.lastTestedData] or 0) + runTime
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
    time = debugprofilestop()
    local objectives = Quest.objectives(id)
    runTime = debugprofilestop() - time
    perFunctionPerformance[Quest.lastTestedData] = (perFunctionPerformance[Quest.lastTestedData] or 0) + runTime
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
    time = debugprofilestop()
    tInsert(data, "Source Item ID: " .. (Quest.sourceItemId(id) or "nil"))
    runTime = debugprofilestop() - time
    perFunctionPerformance[Quest.lastTestedData] = (perFunctionPerformance[Quest.lastTestedData] or 0) + runTime

    -- Test Quest.preQuestGroup
    Quest.lastTestedData = "preQuestGroup"
    time = debugprofilestop()
    local preQuestGroup = Quest.preQuestGroup(id)
    runTime = debugprofilestop() - time
    perFunctionPerformance[Quest.lastTestedData] = (perFunctionPerformance[Quest.lastTestedData] or 0) + runTime
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
    time = debugprofilestop()
    local preQuestSingle = Quest.preQuestSingle(id)
    runTime = debugprofilestop() - time
    perFunctionPerformance[Quest.lastTestedData] = (perFunctionPerformance[Quest.lastTestedData] or 0) + runTime
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
    time = debugprofilestop()
    local childQuests = Quest.childQuests(id)
    runTime = debugprofilestop() - time
    perFunctionPerformance[Quest.lastTestedData] = (perFunctionPerformance[Quest.lastTestedData] or 0) + runTime
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
    time = debugprofilestop()
    local inGroupWith = Quest.inGroupWith(id)
    runTime = debugprofilestop() - time
    perFunctionPerformance[Quest.lastTestedData] = (perFunctionPerformance[Quest.lastTestedData] or 0) + runTime
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
    time = debugprofilestop()
    local exclusiveTo = Quest.exclusiveTo(id)
    runTime = debugprofilestop() - time
    perFunctionPerformance[Quest.lastTestedData] = (perFunctionPerformance[Quest.lastTestedData] or 0) + runTime
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
    time = debugprofilestop()
    tInsert(data, "Zone or Sort: " .. (Quest.zoneOrSort(id) or "nil"))
    runTime = debugprofilestop() - time
    perFunctionPerformance[Quest.lastTestedData] = (perFunctionPerformance[Quest.lastTestedData] or 0) + runTime

    -- Test Quest.requiredSkill
    Quest.lastTestedData = "requiredSkill"
    time = debugprofilestop()
    local requiredSkill = Quest.requiredSkill(id)
    runTime = debugprofilestop() - time
    perFunctionPerformance[Quest.lastTestedData] = (perFunctionPerformance[Quest.lastTestedData] or 0) + runTime
    if requiredSkill then
      tInsert(data, "Required Skill:")
      tInsert(data, "  Skill ID: " .. requiredSkill[1])
      tInsert(data, "  Skill Level: " .. requiredSkill[2])
    else
      tInsert(data, "Required Skill: nil")
    end

    -- Test Quest.requiredMinRep
    Quest.lastTestedData = "requiredMinRep"
    time = debugprofilestop()
    local requiredMinRep = Quest.requiredMinRep(id)
    runTime = debugprofilestop() - time
    perFunctionPerformance[Quest.lastTestedData] = (perFunctionPerformance[Quest.lastTestedData] or 0) + runTime
    if requiredMinRep then
      tInsert(data, "Required Min Reputation:")
      tInsert(data, "  Faction ID: " .. requiredMinRep[1])
      tInsert(data, "  Reputation Level: " .. requiredMinRep[2])
    else
      tInsert(data, "Required Min Reputation: nil")
    end

    -- Test Quest.requiredMaxRep
    Quest.lastTestedData = "requiredMaxRep"
    time = debugprofilestop()
    local requiredMaxRep = Quest.requiredMaxRep(id)
    runTime = debugprofilestop() - time
    perFunctionPerformance[Quest.lastTestedData] = (perFunctionPerformance[Quest.lastTestedData] or 0) + runTime
    if requiredMaxRep then
      tInsert(data, "Required Max Reputation:")
      tInsert(data, "  Faction ID: " .. requiredMaxRep[1])
      tInsert(data, "  Reputation Level: " .. requiredMaxRep[2])
    else
      tInsert(data, "Required Max Reputation: nil")
    end

    -- Test Quest.requiredSourceItems
    Quest.lastTestedData = "requiredSourceItems"
    time = debugprofilestop()
    local requiredSourceItems = Quest.requiredSourceItems(id)
    runTime = debugprofilestop() - time
    perFunctionPerformance[Quest.lastTestedData] = (perFunctionPerformance[Quest.lastTestedData] or 0) + runTime
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
    time = debugprofilestop()
    tInsert(data, "Next Quest in Chain: " .. (Quest.nextQuestInChain(id) or "nil"))
    runTime = debugprofilestop() - time
    perFunctionPerformance[Quest.lastTestedData] = (perFunctionPerformance[Quest.lastTestedData] or 0) + runTime

    -- Test Quest.questFlags
    Quest.lastTestedData = "questFlags"
    time = debugprofilestop()
    tInsert(data, "Quest Flags: " .. (Quest.questFlags(id) or "nil"))
    runTime = debugprofilestop() - time
    perFunctionPerformance[Quest.lastTestedData] = (perFunctionPerformance[Quest.lastTestedData] or 0) + runTime

    -- Test Quest.specialFlags
    Quest.lastTestedData = "specialFlags"
    time = debugprofilestop()
    tInsert(data, "Special Flags: " .. (Quest.specialFlags(id) or "nil"))
    runTime = debugprofilestop() - time
    perFunctionPerformance[Quest.lastTestedData] = (perFunctionPerformance[Quest.lastTestedData] or 0) + runTime

    -- Test Quest.parentQuest
    Quest.lastTestedData = "parentQuest"
    time = debugprofilestop()
    tInsert(data, "Parent Quest: " .. (Quest.parentQuest(id) or "nil"))
    runTime = debugprofilestop() - time
    perFunctionPerformance[Quest.lastTestedData] = (perFunctionPerformance[Quest.lastTestedData] or 0) + runTime

    -- Test Quest.reputationReward
    Quest.lastTestedData = "reputationReward"
    time = debugprofilestop()
    local reputationReward = Quest.reputationReward(id)
    runTime = debugprofilestop() - time
    perFunctionPerformance[Quest.lastTestedData] = (perFunctionPerformance[Quest.lastTestedData] or 0) + runTime
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
    time = debugprofilestop()
    local extraObjectives = Quest.extraObjectives(id)
    runTime = debugprofilestop() - time
    perFunctionPerformance[Quest.lastTestedData] = (perFunctionPerformance[Quest.lastTestedData] or 0) + runTime
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
    time = debugprofilestop()
    tInsert(data, "Required Spell: " .. (Quest.requiredSpell(id) or "nil"))
    runTime = debugprofilestop() - time
    perFunctionPerformance[Quest.lastTestedData] = (perFunctionPerformance[Quest.lastTestedData] or 0) + runTime

    -- Test Quest.requiredSpecialization
    Quest.lastTestedData = "requiredSpecialization"
    time = debugprofilestop()
    tInsert(data, "Required Specialization: " .. (Quest.requiredSpecialization(id) or "nil"))
    runTime = debugprofilestop() - time
    perFunctionPerformance[Quest.lastTestedData] = (perFunctionPerformance[Quest.lastTestedData] or 0) + runTime

    -- Test Quest.requiredMaxLevel
    Quest.lastTestedData = "requiredMaxLevel"
    time = debugprofilestop()
    tInsert(data, "Required Max Level: " .. (Quest.requiredMaxLevel(id) or "nil"))
    runTime = debugprofilestop() - time
    perFunctionPerformance[Quest.lastTestedData] = (perFunctionPerformance[Quest.lastTestedData] or 0) + runTime

    tInsert(data, "--------------------------------------------------")
    if not fast then
      print(table.concat(data, "\n"))
    end
  end

  local time = debugprofilestop() - beginTime
  LibQuestieDB.ColorizePrint("green", "Quest Test Done", time, "ms")
  print("  ", count, "quests tested")
  print("  ", "time per quest:", tostring(time / count):sub(1, 6), "ms")
  print("  ", "avg time per function", tostring(time / (count * functions)):sub(1, 6), "ms")
  for i, functionName in ipairs(LibQuestieDB.Meta.QuestMeta.NameIndexLookupTable) do
    local v = perFunctionPerformance[functionName] or 0
    print("    ", i, functionName, ":", tostring((v / count) * 1000):sub(1, 6), "µs")
  end
end
