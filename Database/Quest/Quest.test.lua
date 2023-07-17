Quest.testGetFunctions = function()
  local glob = Quest.glob
  for id in pairs(glob) do
    print("Testing Quest " .. id)
    local data = {}

    -- Test Quest.name
    table.insert(data, "Name: " .. (Quest.name(id) or "nil"))

    -- Test Quest.startedBy
    local startedBy = Quest.startedBy(id)
    if startedBy then
      table.insert(data, "Started By:")
      for i, entity in ipairs(startedBy) do
        table.insert(data, "  group: " .. i)
        for _, entity in ipairs(entity) do
          table.insert(data, "    Entity: " .. entity)
        end
      end
    else
      table.insert(data, "Started By: nil")
    end

    -- Test Quest.finishedBy
    local finishedBy = Quest.finishedBy(id)
    if finishedBy then
      table.insert(data, "Finished By:")
      for i, entity in ipairs(finishedBy) do
        table.insert(data, "  group: " .. i)
        for _, entity in ipairs(entity) do
          table.insert(data, "    Entity: " .. entity)
        end
      end
    else
      table.insert(data, "Finished By: nil")
    end

    -- Test Quest.requiredLevel
    table.insert(data, "Required Level: " .. (Quest.requiredLevel(id) or "nil"))

    -- Test Quest.questLevel
    table.insert(data, "Quest Level: " .. (Quest.questLevel(id) or "nil"))

    -- Test Quest.requiredRaces
    table.insert(data, "Required Races: " .. (Quest.requiredRaces(id) or "nil"))

    -- Test Quest.requiredClasses
    table.insert(data, "Required Classes: " .. (Quest.requiredClasses(id) or "nil"))

    -- Test Quest.objectivesText
    local objectivesText = Quest.objectivesText(id)
    if objectivesText then
      table.insert(data, "Objectives Text:")
      for _, objective in ipairs(objectivesText) do
        table.insert(data, "  Objective: " .. objective)
      end
    else
      table.insert(data, "Objectives Text: nil")
    end

    -- Test Quest.triggerEnd
    local triggerEnd = Quest.triggerEnd(id)
    if triggerEnd then
      table.insert(data, "Trigger End:")
      table.insert(data, "  Text: " .. triggerEnd[1])
      for zoneID, coords in pairs(triggerEnd[2]) do
        table.insert(data, "  Zone " .. zoneID .. " Coords:")
        for _, coord in ipairs(coords) do
          table.insert(data, "    X: " .. coord[1] .. ", Y: " .. coord[2])
        end
      end
    else
      table.insert(data, "Trigger End: nil")
    end

    -- Test Quest.objectives
    local objectives = Quest.objectives(id)
    if objectives then
      table.insert(data, "Objectives:")
      for i, objective in ipairs(objectives) do
        table.insert(data, "  Objective group: " .. i)
        for _, objective in ipairs(objective) do
          table.insert(data, "    Objective: " .. objective[1] .. tostring(objective[2]))
        end
      end
    else
      table.insert(data, "Objectives: nil")
    end

    -- Test Quest.sourceItemId
    table.insert(data, "Source Item ID: " .. (Quest.sourceItemId(id) or "nil"))

    -- Test Quest.preQuestGroup
    local preQuestGroup = Quest.preQuestGroup(id)
    if preQuestGroup then
      table.insert(data, "Pre-Quest Group:")
      for _, questID in ipairs(preQuestGroup) do
        table.insert(data, "  Quest ID: " .. questID)
      end
    else
      table.insert(data, "Pre-Quest Group: nil")
    end

    -- Test Quest.preQuestSingle
    local preQuestSingle = Quest.preQuestSingle(id)
    if preQuestSingle then
      table.insert(data, "Pre-Quest Single:")
      for _, questID in ipairs(preQuestSingle) do
        table.insert(data, "  Quest ID: " .. questID)
      end
    else
      table.insert(data, "Pre-Quest Single: nil")
    end

    -- Test Quest.childQuests
    local childQuests = Quest.childQuests(id)
    if childQuests then
      table.insert(data, "Child Quests:")
      for _, questID in ipairs(childQuests) do
        table.insert(data, "  Quest ID: " .. questID)
      end
    else
      table.insert(data, "Child Quests: nil")
    end

    -- Test Quest.inGroupWith
    local inGroupWith = Quest.inGroupWith(id)
    if inGroupWith then
      table.insert(data, "In Group With:")
      for _, questID in ipairs(inGroupWith) do
        table.insert(data, "  Quest ID: " .. questID)
      end
    else
      table.insert(data, "In Group With: nil")
    end

    -- Test Quest.exclusiveTo
    local exclusiveTo = Quest.exclusiveTo(id)
    if exclusiveTo then
      table.insert(data, "Exclusive To:")
      for _, questID in ipairs(exclusiveTo) do
        table.insert(data, "  Quest ID: " .. questID)
      end
    else
      table.insert(data, "Exclusive To: nil")
    end

    -- Test Quest.zoneOrSort
    table.insert(data, "Zone or Sort: " .. (Quest.zoneOrSort(id) or "nil"))

    -- Test Quest.requiredSkill
    local requiredSkill = Quest.requiredSkill(id)
    if requiredSkill then
      table.insert(data, "Required Skill:")
      table.insert(data, "  Skill ID: " .. requiredSkill[1])
      table.insert(data, "  Skill Level: " .. requiredSkill[2])
    else
      table.insert(data, "Required Skill: nil")
    end

    -- Test Quest.requiredMinRep
    local requiredMinRep = Quest.requiredMinRep(id)
    if requiredMinRep then
      table.insert(data, "Required Min Reputation:")
      table.insert(data, "  Faction ID: " .. requiredMinRep[1])
      table.insert(data, "  Reputation Level: " .. requiredMinRep[2])
    else
      table.insert(data, "Required Min Reputation: nil")
    end

    -- Test Quest.requiredMaxRep
    local requiredMaxRep = Quest.requiredMaxRep(id)
    if requiredMaxRep then
      table.insert(data, "Required Max Reputation:")
      table.insert(data, "  Faction ID: " .. requiredMaxRep[1])
      table.insert(data, "  Reputation Level: " .. requiredMaxRep[2])
    else
      table.insert(data, "Required Max Reputation: nil")
    end

    -- Test Quest.requiredSourceItems
    local requiredSourceItems = Quest.requiredSourceItems(id)
    if requiredSourceItems then
      table.insert(data, "Required Source Items:")
      for _, itemID in ipairs(requiredSourceItems) do
        table.insert(data, "  Item ID: " .. itemID)
      end
    else
      table.insert(data, "Required Source Items: nil")
    end

    -- Test Quest.nextQuestInChain
    table.insert(data, "Next Quest in Chain: " .. (Quest.nextQuestInChain(id) or "nil"))

    -- Test Quest.questFlags
    table.insert(data, "Quest Flags: " .. (Quest.questFlags(id) or "nil"))

    -- Test Quest.specialFlags
    table.insert(data, "Special Flags: " .. (Quest.specialFlags(id) or "nil"))

    -- Test Quest.parentQuest
    table.insert(data, "Parent Quest: " .. (Quest.parentQuest(id) or "nil"))

    -- Test Quest.rewardReputation
    local rewardReputation = Quest.rewardReputation(id)
    if rewardReputation then
      table.insert(data, "Reward Reputation:")
      for _, repPair in ipairs(rewardReputation) do
        table.insert(data, "  Faction ID: " .. repPair[1])
        table.insert(data, "  Reputation Level: " .. repPair[2])
      end
    else
      table.insert(data, "Reward Reputation: nil")
    end

    -- Test Quest.extraObjectives
    local extraObjectives = Quest.extraObjectives(id)
    if extraObjectives then
      table.insert(data, "Extra Objectives:")
      for i, objective in ipairs(extraObjectives) do
        table.insert(data, "  Objective: " .. tostring(objective))
      end
    else
      table.insert(data, "Extra Objectives: nil")
    end

    -- Test Quest.requiredSpell
    table.insert(data, "Required Spell: " .. (Quest.requiredSpell(id) or "nil"))

    -- Test Quest.requiredSpecialization
    table.insert(data, "Required Specialization: " .. (Quest.requiredSpecialization(id) or "nil"))

    table.insert(data, "--------------------------------------------------")
    print(table.concat(data, "\n"))
  end

  print("Quest Test Done")
end
