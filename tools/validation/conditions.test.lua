-- Quest Conditions: evaluator semantics with stubbed client reads, gates on the shipped
-- expressions, and per-expansion selection through the actual Source TOC.
return function(check, equal)
  local config = dofile("src/config.lua")
  local client = dofile("emulator/client.lua")
  local emulator = dofile("emulator/metadata.lua")

  -- Client reads the evaluator uses. Each is cleared before the cases, so globals left by other
  -- suites cannot change results; each case sets only what it needs.
  local stubbed = {
    "C_Secrets", "C_UnitAuras", "C_QuestLog", "C_Reputation", "UnitAura", "InCombatLockdown",
    "GetFactionInfoByID", "IsQuestFlaggedCompleted", "GetQuestLogIndexByID", "geterrorhandler",
    "UnitLevel", "UnitRace", "UnitClass", "issecretvalue", "UnitFactionGroup",
  }
  local saved = {}
  for _, name in ipairs(stubbed) do saved[name] = rawget(_G, name) end
  for _, name in ipairs(stubbed) do rawset(_G, name, nil) end

  local lib = {
    Quest = { conditions = function() return nil end },
    Enum = { raceMaskById = { [1] = 1, [2] = 2, [95] = 2 ^ 32 } },
  }
  assert(loadfile("src/corrections/conditionBuilder.lua"))("QuestieDB", lib)
  assert(loadfile("src/conditions.lua"))("QuestieDB", lib)
  local Conditions, C = lib.Conditions, lib.ConditionBuilder
  local Evaluate = Conditions.Evaluate

  -- Builder: canonical strings, minimal parentheses, and errors instead of permissive guesses.
  equal(C.Not(C.All(C.IsTeam("Alliance"), C.QuestRewarded(1))), 'not (IsTeam("Alliance") and QuestRewarded(1))',
    "Not wraps a compound condition")
  equal(C.All(C.Any(C.QuestInLog(1), C.QuestInLog(2)), C.Not(C.HasItem(3, 2))),
    "(QuestInLog(1) or QuestInLog(2)) and not HasItem(3, 2)", "All wraps Any; Not binds tighter than and")
  equal(C.IsRace(2 ^ 33 + 1), "IsRace(8589934593)", "race masks above 32 bits keep every digit")
  equal(C.HasItem(5), "HasItem(5)", "optional arguments can be omitted")
  for _, case in ipairs({
    { "IsTeam", function() return C.IsTeam(469) end },
    { "IsTeam", function() return C.IsTeam("alliance") end },
    { "HasRep", function() return C.HasRep(1105, 8) end },
    { "QuestRewarded", function() return C.QuestRewarded(1.5) end },
    { "QuestRewarded", function() return C.QuestRewarded(1, 2) end },
    { "All", function() return C.All("QuestRewarded(999999)", C.QuestInLog(2)) end },
    { "All", function() return C.All(C.QuestInLog(2)) end },
    { "unknown", function() return C.QuestRewardd(1) end },
  }) do
    check(not pcall(case[2]), "the builder rejects an invalid " .. case[1] .. " condition")
  end

  equal(Evaluate(nil), true, "a missing expression is available")
  equal(Evaluate(""), true, "an empty expression is available")

  -- Reputation: client reactions start at 1 (Hated); condition ranks start at 0.
  rawset(_G, "GetFactionInfoByID", function() return "Faction", "", 5 end)
  equal(Evaluate("HasRep(1105, 4)"), true, "legacy Friendly meets rank 4")
  equal(Evaluate("HasRep(1105, 5)"), false, "legacy Friendly does not meet Honored")
  equal(Evaluate("RepBelow(1105, 4)"), true, "legacy Friendly is at or below rank 4")
  equal(Evaluate("RepBelow(1105, 3)"), false, "legacy Friendly is above Neutral")
  local reaction = 6
  rawset(_G, "C_Reputation", { GetFactionDataByID = function() return { reaction = reaction } end })
  equal(Evaluate("HasRep(1105, 5) and not HasRep(1105, 6)"), true, "modern Honored is rank 5")
  rawset(_G, "issecretvalue", function(value) return value == reaction end)
  equal(Evaluate("HasRep(1105, 5)"), nil, "a secret reaction is unknown")
  rawset(_G, "issecretvalue", nil)
  rawset(_G, "C_Reputation", nil)

  rawset(_G, "UnitFactionGroup", function() return "Horde", "Horde" end)
  equal(Evaluate('IsTeam("Horde") and not IsTeam("Alliance")'), true, "IsTeam compares the faction tag")

  -- Character: race masks exceed 32 bits; class flags are 2^(classId - 1).
  rawset(_G, "UnitRace", function() return "Skyborne", "Skyborne", 95 end)
  rawset(_G, "UnitClass", function() return "Paladin", "PALADIN", 2 end)
  equal(Evaluate("IsRace(2^32 + 1)"), true, "a race bit above 32 bits matches")
  equal(Evaluate("IsRace(1)"), false, "another race's bit does not match")
  equal(Evaluate("IsRace(0) and IsClass(0)"), true, "zero masks match every character")
  equal(Evaluate("IsClass(2) and IsClass(3) and not IsClass(1)"), true, "class 2 is bit 2")

  -- Auras: unreadable state makes the whole expression unknown, through `not` and `or`.
  rawset(_G, "C_Secrets", { ShouldAurasBeSecret = function() return true end })
  equal(Evaluate("HasAura(1)"), nil, "secret auras are unknown")
  equal(Evaluate("not HasAura(1)"), nil, "negating an unknown stays unknown")
  equal(Evaluate("HasRep(1105, 4) or HasAura(1)"), true, "short-circuited unknowns are never read")
  equal(Evaluate("HasRep(1105, 5) or HasAura(1)"), nil, "an unknown that decides the result is unknown")
  rawset(_G, "InCombatLockdown", function() return true end)
  rawset(_G, "UnitAura", function(_, index)
    if index == 1 then return "Aura", nil, nil, nil, nil, nil, nil, nil, nil, 7 end
  end)
  rawset(_G, "C_Secrets", { ShouldAurasBeSecret = function() return false end })
  equal(Evaluate("HasAura(7) and not HasAura(8)"), true,
    "the client's aura-secrecy answer is trusted, even in combat")
  rawset(_G, "C_Secrets", {})
  equal(Evaluate("HasAura(7)"), nil, "without that answer, secret-value clients hide auras in combat")
  rawset(_G, "C_Secrets", nil)
  equal(Evaluate("HasAura(7) and not HasAura(8)"), true, "legacy clients scan the player's auras")
  rawset(_G, "InCombatLockdown", nil)

  -- Defined permissive results for unknown names, compile errors, and runtime errors.
  local reports = {}
  rawset(_G, "geterrorhandler", function() return function(message) reports[#reports + 1] = message end end)
  equal(Evaluate("NotAFunction(1)"), true, "unknown function names are permissive")
  equal(Evaluate("NotAFunction(1) and false"), false, "a permissive name is only one operand")
  equal(Evaluate("QuestRewarded("), true, "an expression that does not compile is permissive")
  equal(Evaluate("QuestRewarded("), true, "evaluating it again stays permissive")
  equal(#reports, 1, "a broken expression is reported once")
  rawset(_G, "UnitLevel", function() return 60 end)
  equal(Evaluate("IsLevel()"), true, "a raising function is permissive")
  equal(#reports, 2, "a runtime failure is reported")
  equal(Evaluate("IsLevel() or false"), true, "another expression hitting the same failure is permissive")
  equal(#reports, 2, "the same failure is reported once across expressions")
  rawset(_G, "geterrorhandler", function() return function() error("handler failed") end end)
  equal(Evaluate("IsLevel(nil, 1)"), true, "a failing error handler does not escape Evaluate")

  -- Publishing: the trusted owner only; overrides reach composite base functions; nil withdraws.
  rawset(_G, "IsQuestFlaggedCompleted", function() return false end)
  rawset(_G, "GetQuestLogIndexByID", function() return 0 end)
  check(not pcall(Conditions.SetFunctions, "SomeAddon", {}), "untrusted owners cannot publish")
  check(not pcall(Conditions.SetFunctions, "Questie", { QuestRewarded = true }),
    "published values must be functions")
  equal(Evaluate("QuestNone(5)"), true, "base QuestNone reads the client")
  local functions = {
    QuestRewarded = function(questId) return questId == 5 end,
    QuestieOnly = function() return false end,
  }
  Conditions.SetFunctions("Questie", functions)
  functions.QuestieOnly = "not a function"
  equal(Evaluate("QuestNone(5)"), false, "composite functions follow published overrides")
  equal(Evaluate("QuestieOnly()"), false, "published functions add names, copied at publication")
  Conditions.SetFunctions("Questie", nil)
  equal(Evaluate("QuestNone(5)"), true, "withdrawal restores the base function")
  equal(Evaluate("QuestieOnly()"), true, "withdrawn names become permissive again")

  -- Nested evaluation: a published QuestAvailable may evaluate conditions itself.
  local depth = 0
  Conditions.SetFunctions("Questie", {
    QuestAvailable = function()
      depth = depth + 1
      return Evaluate("QuestAvailable(9) and HasRep(1105, 5)")
    end,
  })
  equal(Evaluate("QuestAvailable(9) and HasRep(1105, 5)"), false,
    "re-entering an expression returns instead of recursing")
  equal(depth, 1, "the re-entered expression ran once")
  rawset(_G, "C_Secrets", { ShouldAurasBeSecret = function() return true end })
  Conditions.SetFunctions("Questie", { QuestAvailable = function() return Evaluate("HasAura(1)") end })
  equal(Evaluate("QuestAvailable(9)"), nil, "a nested unknown propagates through its caller")
  Conditions.SetFunctions("Questie", { QuestAvailable = function() return Evaluate("HasRep(1105, 4)") end })
  equal(Evaluate("HasAura(1) or QuestAvailable(9)"), nil,
    "a determinate nested evaluation keeps the caller's unknown")
  Conditions.SetFunctions("Questie", nil)

  -- Explain: the builder's grammar parses back into a tree with every leaf evaluated.
  local Explain = Conditions.Explain
  rawset(_G, "UnitFactionGroup", function() return "Alliance", "Alliance" end)
  rawset(_G, "IsQuestFlaggedCompleted", function(questId) return questId == 1518 end)
  equal(Explain(C.All(C.IsTeam("Alliance"), C.Not(C.QuestRewarded(1518)))), {
    op = "and", result = false, children = {
      { call = "IsTeam", args = { "Alliance" }, result = true },
      { op = "not", result = false, children = { { call = "QuestRewarded", args = { 1518 }, result = true } } },
    },
  }, "Explain annotates every node")
  equal(Explain(C.Any(C.QuestRewarded(1518), C.QuestRewarded(1))).children[2].result, false,
    "leaves after the deciding one are still evaluated")
  equal(Explain(C.IsRace(2 ^ 33)).children, nil, "a leaf has no children")
  equal(Explain(C.IsRace(2 ^ 33)).args, { 2 ^ 33 }, "large masks parse back exactly")
  equal(Explain(C.WorldState(1, -1)).args, { 1, -1 }, "every builder argument parses back, negatives included")
  rawset(_G, "C_Secrets", { ShouldAurasBeSecret = function() return true end })
  equal(Explain(C.Any(C.HasAura(1), C.IsTeam("Alliance"))).result, true, "a true operand decides or")
  equal(Explain(C.All(C.HasAura(1), C.IsTeam("Alliance"))).result, nil, "an unknown operand leaves and unknown")
  equal(Explain(C.All(C.HasAura(1), C.IsTeam("Horde"))).result, false, "a false operand decides and")
  equal(Explain(C.Not(C.HasAura(1))).result, nil, "not of unknown is unknown")
  rawset(_G, "C_Secrets", nil)
  Conditions.SetFunctions("Questie", { QuestRewarded = function() return false end })
  equal(Explain(C.QuestRewarded(1518)).result, false, "Explain uses published functions")
  Conditions.SetFunctions("Questie", nil)
  for _, expression in ipairs({ "QuestRewarded(", "NotAFunction(1)", "QuestRewarded(1) ; x", "QuestRewarded(1.5)",
    'IsTeam("Alli\\"ance")', "(QuestRewarded(1)", "" }) do
    equal(Explain(expression), nil, "Explain rejects input outside the grammar: " .. expression)
  end

  for _, name in ipairs(stubbed) do rawset(_G, name, saved[name]) end

  -- Gates on the shipped expressions. Base stubs are true, so a negated stub would hide its
  -- quest for every consumer without Questie, and QuestAvailable cycles have no stable answer.
  -- Race masks may only use bits of races playable in every flavor the file applies to, and a
  -- faction-wide mask must be IsTeam: a mask cannot follow Forever adding Skyborne to Era's
  -- factions, so an inherited IsRace(77) would exclude Skyborne Alliance players.
  local vocabulary = C.vocabulary
  local enum = dofile("src/corrections/enum/constants.lua")
  local raceBits = {}
  for _, bit in pairs(enum.raceMaskById) do raceBits[#raceBits + 1] = bit end
  table.sort(raceBits, function(a, b) return a > b end)
  ---Arithmetic, like the runtime: Forever's Skyborne bits exceed the client's 32-bit `bit`.
  local function unknownBits(mask, allowed)
    for _, bit in ipairs(raceBits) do
      local inMask, inAllowed = mask % (bit * 2) >= bit, allowed % (bit * 2) >= bit
      if inMask then mask = mask - bit end
      if inAllowed then allowed = allowed - bit end
      if inMask and not inAllowed then return true end
    end
    return mask ~= 0
  end
  local eraFactionMasks = { [77] = true, [178] = true }
  local stubs = { QuestAvailable = true, HasSkill = true, EventActive = true, HolidayActive = true,
    WorldState = true }
  local keywords = { ["and"] = true, ["or"] = true, ["not"] = true }
  for _, spec in ipairs(dofile("src/corrections/manifest.lua")) do
    if spec.file:find("QuestConditions%.lua$") then
      local questKeys = { conditions = 37 }
      local module = {}
      local loader = { CreateModule = function() return module end,
        ImportModule = function(_, name) return name == "ConditionBuilder" and C or { questKeys = questKeys } end }
      local chunk = assert(loadfile("src/corrections/" .. spec.file))
      setfenv(chunk, setmetatable({ QuestieLoader = loader }, { __index = _G }))
      chunk()
      local count, problems, availableEdges = 0, {}, {}
      local flavors = {}
      for _, flavor in ipairs(config.flavors) do
        if config.correctionApplies(spec, flavor) then flavors[#flavors + 1] = flavor end
      end
      for questId, row in pairs(module:Load()) do
        local expression = row[questKeys.conditions]
        count = count + 1
        if type(expression) ~= "string" or not loadstring("return " .. expression) or not Explain(expression) then
          problems[#problems + 1] = questId
        else
          for name in expression:gmatch("([%a_][%w_]*)%s*%(") do
            if not keywords[name] and not vocabulary[name] then problems[#problems + 1] = questId .. ":" .. name end
          end
          for name in expression:gmatch("not%s+([%a_][%w_]*)%s*%(") do
            if stubs[name] then problems[#problems + 1] = questId .. ":not " .. name end
          end
          for mask in expression:gmatch("IsRace%a*%(%s*(%d+)") do
            mask = tonumber(mask)
            for _, flavor in ipairs(flavors) do
              local raceKeys = enum.byExpansion[flavor.expansion].raceKeys
              local factionWide = mask == raceKeys.ALL_ALLIANCE or mask == raceKeys.ALL_HORDE or
                (flavor.name == "Forever" and eraFactionMasks[mask])
              if factionWide or unknownBits(mask, raceKeys.ALL_ALLIANCE + raceKeys.ALL_HORDE) then
                problems[#problems + 1] = questId .. ":IsRace(" .. mask .. ") on " .. flavor.name
              end
            end
          end
          for target in expression:gmatch("QuestAvailable%((%d+)%)") do
            availableEdges[questId] = availableEdges[questId] or {}
            table.insert(availableEdges[questId], tonumber(target))
          end
        end
      end
      local function reachesItself(origin, current, seen)
        for _, target in ipairs(availableEdges[current] or {}) do
          if target == origin then return true end
          if not seen[target] then
            seen[target] = true
            if reachesItself(origin, target, seen) then return true end
          end
        end
        return false
      end
      for questId in pairs(availableEdges) do
        if reachesItself(questId, questId, {}) then problems[#problems + 1] = questId .. ":cycle" end
      end
      check(count > 0, spec.file .. " provides expressions")
      check(#flavors > 0, spec.file .. " applies to a flavor")
      equal(problems, {}, spec.file .. " expressions compile, use the vocabulary, valid race masks, and stable stubs")
    end
  end

  -- Each table applies to exactly one expansion. Quest 558 has a Classic expression but none
  -- in the WotLK table, so Wrath must not inherit it.
  local quest558 = "QuestRewarded(1687) and QuestRewarded(1558) and QuestRewarded(1479)"
  for _, case in ipairs({
    { flavor = "Vanilla", expected = quest558 },
    { flavor = "Wrath", expected = nil },
  }) do
    client.reset()
    client.install({ expansion = config.flavorByName[case.flavor].expansion })
    _G.WOW_PROJECT_ID = -1
    local source = emulator.loadAddon(config.addonName .. ".toc", config.addonName)
    equal(source.Conditions.Get(558), case.expected, case.flavor .. " reads its own quest 558 condition")
  end
  client.reset()
end
