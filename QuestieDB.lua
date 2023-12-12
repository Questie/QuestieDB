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
