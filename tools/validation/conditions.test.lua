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
  local Evaluate, Explain = Conditions.Evaluate, Conditions.Explain

  -- Builder: canonical strings, minimal parentheses, and errors instead of permissive guesses.
  equal(C.Not(C.All(C.IsTeam("Alliance"), C.QuestRewarded(1))), 'not (IsTeam("Alliance") and QuestRewarded(1))',
    "Not wraps a compound condition")
  equal(C.All(C.Any(C.QuestInLog(1), C.QuestInLog(2)), C.Not(C.HasItem(3, 2))),
    "(QuestInLog(1) or QuestInLog(2)) and not HasItem(3, 2)", "All wraps Any; Not binds tighter than and")
  equal(C.IsRace(2 ^ 33 + 1), "IsRace(8589934593)", "race masks above 32 bits keep every digit")
  equal(C.HasItem(5), "HasItem(5)", "optional arguments can be omitted")
  equal(C.HasRep(1105, C.standing.HONORED), "HasRep(1105, 5)", "standing names map to condition ranks")
  equal({ C.standing.HATED, C.standing.NEUTRAL, C.standing.EXALTED }, { 0, 3, 7 },
    "condition ranks start at Hated = 0, one below the client's standing IDs")
  for _, case in ipairs({
    { "IsTeam", function() return C.IsTeam(469) end },
    { "IsTeam", function() return C.IsTeam("alliance") end },
    { "HasRep", function() return C.HasRep(1105, 8) end },
    { "QuestRewarded", function() return C.QuestRewarded(1.5) end },
    { "QuestRewarded", function() return C.QuestRewarded(1, 2) end },
    { "All", function() return C.All("QuestRewarded(999999)", C.QuestInLog(2)) end },
    { "All", function() return C.All(C.QuestInLog(2)) end },
    { "Not", function() return C.Not(C.QuestRewarded(1), C.QuestRewarded(2)) end },
    { "Not", function() return C.Not(C.QuestRewarded(1), nil) end },
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
  equal(Evaluate("IsRace(4294967297)"), true, "a race bit above 32 bits matches")
  equal(Evaluate("IsRace(1)"), false, "another race's bit does not match")
  equal(Evaluate("IsRace(0) and IsClass(0)"), true, "zero masks match every character")
  equal(Evaluate("IsClass(2) and IsClass(3) and not IsClass(1)"), true, "class 2 is bit 2")

  -- Auras: unreadable state makes the whole expression unknown, through `not` and `or`.
  rawset(_G, "C_Secrets", { ShouldAurasBeSecret = function() return true end })
  equal(Evaluate("HasAura(1)"), nil, "secret auras are unknown")
  equal(Evaluate("not HasAura(1)"), nil, "negating an unknown stays unknown")
  equal(Evaluate("HasRep(1105, 4) or HasAura(1)"), true, "short-circuited unknowns are never read")
  equal(Evaluate("HasRep(1105, 5) or HasAura(1)"), nil, "an unknown that decides the result is unknown")
  equal(Evaluate("HasAura(1) and HasRep(1105, 5)"), false, "a false operand decides and, even after an unknown")
  equal(Evaluate("HasAura(1) or HasRep(1105, 4)"), true, "a true operand decides or, even after an unknown")
  -- Evaluate stops at the deciding operand and Explain reads every leaf; the results still agree.
  for _, expression in ipairs({
    "HasAura(1) and HasRep(1105, 5)", "HasRep(1105, 5) and HasAura(1)", "HasAura(1) or HasRep(1105, 4)",
    "not (HasAura(1) or HasRep(1105, 5))", "not HasAura(1) and (HasRep(1105, 4) or HasAura(2))",
  }) do
    equal(Explain(expression).result, Evaluate(expression), "Explain agrees with Evaluate: " .. expression)
  end
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

  -- Defined permissive results for expressions outside the grammar and runtime errors.
  local reports = {}
  rawset(_G, "geterrorhandler", function() return function(message) reports[#reports + 1] = message end end)
  equal(Evaluate("NotAFunction(1) and IsLevel(200)"), true, "an unknown function name makes the expression permissive")
  equal(Evaluate("QuestRewarded("), true, "an expression that does not parse is permissive")
  equal(Evaluate("QuestRewarded("), true, "evaluating it again stays permissive")
  equal(#reports, 2, "each broken expression is reported once")
  rawset(_G, "UnitLevel", function() return 60 end)
  equal(Evaluate("IsLevel()"), true, "a raising function is permissive")
  equal(#reports, 3, "a runtime failure is reported")
  equal(Evaluate("IsLevel() or IsLevel(1)"), true, "another expression hitting the same failure is permissive")
  equal(#reports, 3, "the same failure is reported once across expressions")
  equal(Evaluate("IsLevel(1) or IsLevel()"), true, "a raising function after the deciding operand is never called")
  equal(Explain("IsLevel()"), nil, "Explain has no tree for an expression that raises")
  rawset(_G, "geterrorhandler", function() return function() error("handler failed") end end)
  equal(Evaluate("IsLevel(1, 2) and IsLevel()"), true, "a failing error handler does not escape Evaluate")

  -- Publishing: the trusted owner only; overrides reach composite base functions; nil withdraws.
  rawset(_G, "IsQuestFlaggedCompleted", function() return false end)
  rawset(_G, "GetQuestLogIndexByID", function() return 0 end)
  check(not pcall(Conditions.SetFunctions, "SomeAddon", {}), "untrusted owners cannot publish")
  check(not pcall(Conditions.SetFunctions, "Questie", { QuestRewarded = true }),
    "published values must be functions")
  equal(Evaluate("QuestNone(5)"), true, "base QuestNone reads the client")
  local functions = { QuestRewarded = function(questId) return questId == 5 end }
  Conditions.SetFunctions("Questie", functions)
  functions.QuestRewarded = function() return false end
  equal(Evaluate("QuestNone(5)"), false, "composite functions follow published overrides, copied at publication")
  Conditions.SetFunctions("Questie", { QuestInLog = function() return nil end })
  equal(Evaluate("QuestNone(5)"), nil, "a composite function passes an unknown part through")
  equal(Explain("QuestNone(5)").result, nil, "Explain agrees on the unknown composite")
  rawset(_G, "IsQuestFlaggedCompleted", function() return true end)
  equal(Evaluate("QuestNone(5)"), false, "a decided part outweighs an unknown one in a composite")
  rawset(_G, "IsQuestFlaggedCompleted", function() return false end)
  Conditions.SetFunctions("Questie", nil)
  equal(Evaluate("QuestNone(5)"), true, "withdrawal restores the base function")

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
  equal(Evaluate("HasAura(1) or QuestAvailable(9)"), true,
    "a nested evaluation that decides the result outweighs the caller's earlier unknown")
  Conditions.SetFunctions("Questie", nil)

  -- Explain: the builder's grammar parses back into a tree with every leaf evaluated.
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
    'IsTeam("Alli\\"ance")', "(QuestRewarded(1)", "QuestRewarded(1,)", "QuestRewarded(,1)",
    "HasItem(1 2)", "" }) do
    equal(Explain(expression), nil, "Explain rejects input outside the grammar: " .. expression)
  end

  for _, name in ipairs(stubbed) do rawset(_G, name, saved[name]) end

  -- Gates on the shipped expressions, read from each flavor's composed Source data so every
  -- correction file that writes `conditions` is covered. QuestAvailable cycles have no stable
  -- answer. Race masks may only use bits of races playable in the flavor. On Forever,
  -- Era's literal faction masks 77 and 178 are rejected: they miss Skyborne. Written with
  -- `raceIDs.ALL_ALLIANCE`, the mask resolves per flavor and includes Skyborne.
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
  local keywords = { ["and"] = true, ["or"] = true, ["not"] = true }

  -- Every function answers true, so Explain only fails for expressions outside the grammar.
  local answerAll = {}
  for name in pairs(vocabulary) do answerAll[name] = function() return true end end
  Conditions.SetFunctions("Questie", answerAll)
  local loaded = {}
  for _, flavor in ipairs(config.flavors) do
    client.reset()
    client.install({ expansion = flavor.expansion })
    _G.WOW_PROJECT_ID = -1
    local source = emulator.loadAddon(config.addonName .. ".toc", config.addonName)
    loaded[flavor.name] = source
    local raceKeys = enum.byExpansion[flavor.expansion].raceKeys
    local count, problems, availableEdges = 0, {}, {}
    for _, questId in ipairs(source.Quest.GetAllIds()) do
      local expression = source.Quest.conditions(questId)
      if expression ~= nil then
        count = count + 1
        if type(expression) ~= "string" or not Explain(expression) then
          problems[#problems + 1] = questId
        else
          for name in expression:gmatch("([%a_][%w_]*)%s*%(") do
            if not keywords[name] and not vocabulary[name] then problems[#problems + 1] = questId .. ":" .. name end
          end
          for mask in expression:gmatch("IsRace%a*%(%s*(%d+)") do
            mask = tonumber(mask)
            local eraMaskOnForever = flavor.name == "Forever" and eraFactionMasks[mask]
            if eraMaskOnForever or unknownBits(mask, raceKeys.ALL_ALLIANCE + raceKeys.ALL_HORDE) then
              problems[#problems + 1] = questId .. ":IsRace(" .. mask .. ")"
            end
          end
          for target in expression:gmatch("QuestAvailable%((%d+)%)") do
            availableEdges[questId] = availableEdges[questId] or {}
            table.insert(availableEdges[questId], tonumber(target))
          end
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
    equal(problems, {}, flavor.name .. " conditions (" .. count .. ") compile, use the vocabulary, and valid race masks")
  end

  Conditions.SetFunctions("Questie", nil)

  -- Conditions are ordinary correction values: Forever's authored fixes carry them, Era's do not.
  equal(loaded.Forever.Conditions.Get(1318), "HasAura(22799)", "Forever reads Unfinished Gordok Business's condition")
  equal(loaded.Vanilla.Conditions.Get(1318), nil, "Vanilla does not inherit Forever's condition")
  client.reset()
end
