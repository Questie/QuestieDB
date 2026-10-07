-- src/conditions.lua
--
-- Quest Conditions: availability expressions stored in the Quest `conditions` field, and the
-- evaluator that answers them. See docs/adr/0017-quest-conditions.md.
--
-- An expression is a boolean expression over a fixed vocabulary of condition functions, in the
-- grammar `ConditionBuilder` emits: calls with number or string arguments, `and`, `or`, `not`,
-- and parentheses.
--
--   "QuestRewarded(1517) and not QuestRewarded(1518)"
--
-- QuestieDB supplies a base implementation of every function, built only on client APIs, so
-- any addon can evaluate conditions. Functions that need state the client cannot provide are
-- permissive stubs that return true; negating one (`not QuestAvailable(1)`) is therefore false.
-- TRUSTED_OWNER can publish better versions of these functions through `SetFunctions`;
-- everyone then evaluates against them.
--
-- A condition function returns true or false, or nil when it cannot read its state right now
-- (for example, auras hidden behind secret values in combat). `and`, `or`, and `not` combine
-- these with three-valued logic: nil ("unknown") stays unknown unless another operand decides
-- the result. The caller should keep its previous answer for unknown and evaluate again later.
-- Evaluate and Explain parse the same tree and combine it with the same function, so they
-- agree unless a condition function raises an error; Explain then returns nil.

local _, LibQuestieDB = ...

local Conditions = {}

-- The only owner that may publish functions into the environment every consumer shares.
-- Other consumers' variants must not change what Questie, the original consumer, shows.
local TRUSTED_OWNER = "Questie"

--------------------------------------------------------------------------------------------
-- Client reads
--------------------------------------------------------------------------------------------
--
-- Each helper selects the modern namespace when the client has it and falls back to the
-- legacy global. They are resolved per call: other addons may replace globals after load.

local function isSecret(value)
  return issecretvalue ~= nil and issecretvalue(value)
end

local function isQuestFlaggedCompleted(questId)
  if C_QuestLog and C_QuestLog.IsQuestFlaggedCompleted then
    return C_QuestLog.IsQuestFlaggedCompleted(questId)
  end
  return IsQuestFlaggedCompleted(questId)
end

---@return number questLogIndex Zero when the quest is not in the log.
local function questLogIndex(questId)
  if C_QuestLog and C_QuestLog.GetLogIndexForQuestID then
    return C_QuestLog.GetLogIndexForQuestID(questId) or 0
  end
  return GetQuestLogIndexByID(questId) or 0
end

local function isQuestLogComplete(questId)
  if C_QuestLog and C_QuestLog.ReadyForTurnIn then
    return C_QuestLog.ReadyForTurnIn(questId)
  end
  if C_QuestLog and C_QuestLog.IsComplete then
    return C_QuestLog.IsComplete(questId)
  end
  local index = questLogIndex(questId)
  if index == 0 then return false end
  -- Legacy position 6 is 1 for complete, -1 for failed, nil otherwise.
  return select(6, GetQuestLogTitle(index)) == 1
end

---Whether the client currently withholds aura data from addons.
local function aurasRestricted()
  if not C_Secrets then return false end
  if C_Secrets.ShouldAurasBeSecret then return C_Secrets.ShouldAurasBeSecret() end
  -- Without the specific query, assume secret-value clients restrict auras in combat.
  return InCombatLockdown()
end

---@return boolean? hasAura Nil when the aura list cannot be read.
local function playerHasAura(spellId)
  if aurasRestricted() then return nil end
  if C_UnitAuras and C_UnitAuras.GetPlayerAuraBySpellID then
    return C_UnitAuras.GetPlayerAuraBySpellID(spellId) ~= nil
  end
  for _, filter in ipairs({ "HELPFUL", "HARMFUL" }) do
    for index = 1, 255 do
      local auraSpellId
      if C_UnitAuras and C_UnitAuras.GetAuraDataByIndex then
        local aura = C_UnitAuras.GetAuraDataByIndex("player", index, filter)
        auraSpellId = aura and aura.spellId
      else
        auraSpellId = select(10, UnitAura("player", index, filter))
      end
      -- Check for a secret before comparing it with anything.
      if isSecret(auraSpellId) then return nil end
      if auraSpellId == nil then break end
      if auraSpellId == spellId then return true end
    end
  end
  return false
end

local function itemCount(itemId, includeBank)
  if C_Item and C_Item.GetItemCount then
    return C_Item.GetItemCount(itemId, includeBank) or 0
  end
  return GetItemCount(itemId, includeBank) or 0
end

local function isEquippedItem(itemId)
  if C_Item and C_Item.IsEquippedItem then
    return C_Item.IsEquippedItem(itemId)
  end
  return IsEquippedItem(itemId)
end

local function knowsSpell(spellId)
  if C_SpellBook and C_SpellBook.IsSpellKnown then
    return C_SpellBook.IsSpellKnown(spellId)
  end
  -- IsPlayerSpell matches the modern knowledge check; legacy IsSpellKnown only checks the
  -- spellbook and misses profession spells.
  if IsPlayerSpell then return IsPlayerSpell(spellId) end
  return IsSpellKnown(spellId)
end

---@return number? rank 0 (Hated) through 7 (Exalted), or nil when the faction is unknown.
---@return boolean? unreadable True when the client hides the standing.
local function reputationRank(factionId)
  local reaction
  if C_Reputation and C_Reputation.GetFactionDataByID then
    local data = C_Reputation.GetFactionDataByID(factionId)
    reaction = data and data.reaction
  else
    reaction = select(3, GetFactionInfoByID(factionId))
  end
  if isSecret(reaction) then return nil, true end
  if reaction == nil then return nil end
  -- Client reactions run 1 (Hated) to 8 (Exalted); condition ranks start at 0.
  return reaction - 1
end

---Arithmetic bit test; race masks can exceed the 32-bit range of `bit.band`.
local function hasFlag(mask, flag)
  return (mask % (flag * 2)) >= flag
end

--------------------------------------------------------------------------------------------
-- Base condition functions
--------------------------------------------------------------------------------------------

local call -- Forward-declared: composite functions call through the published functions.

local base = {
  -- Quest state
  QuestRewarded = function(questId)
    return isQuestFlaggedCompleted(questId) == true
  end,
  QuestInLog = function(questId)
    return questLogIndex(questId) > 0
  end,
  QuestComplete = function(questId)
    return questLogIndex(questId) > 0 and isQuestLogComplete(questId) == true
  end,
  -- Composite: follows whichever QuestInLog and QuestRewarded are active.
  QuestNone = function(questId)
    local inLog = call("QuestInLog", questId)
    if inLog then return false end
    local rewarded = call("QuestRewarded", questId)
    if rewarded then return false end
    if inLog == nil or rewarded == nil then return nil end
    return true
  end,
  -- Needs the consumer's own availability rules; permissive without them.
  QuestAvailable = function()
    return true
  end,

  -- Auras and inventory
  HasAura = function(spellId)
    return playerHasAura(spellId)
  end,
  HasItem = function(itemId, count)
    return itemCount(itemId, false) >= (count or 1)
  end,
  HasItemOrBank = function(itemId, count)
    return itemCount(itemId, true) >= (count or 1)
  end,
  HasItemEquipped = function(itemId)
    return isEquippedItem(itemId) == true
  end,

  -- Skills, spells and reputation
  -- Legacy clients identify skill lines by localized name only; permissive without a mapping.
  HasSkill = function()
    return true
  end,
  KnowsSpell = function(spellId)
    return knowsSpell(spellId) == true
  end,
  HasRep = function(factionId, minRank)
    local rank, unreadable = reputationRank(factionId)
    if unreadable then return nil end
    return rank ~= nil and rank >= minRank
  end,
  RepBelow = function(factionId, maxRank)
    local rank, unreadable = reputationRank(factionId)
    if unreadable then return nil end
    return rank ~= nil and rank <= maxRank
  end,

  -- Character
  -- "Alliance", "Horde", or "Neutral", as UnitFactionGroup reports it.
  IsTeam = function(factionTag)
    return UnitFactionGroup("player") == factionTag
  end,
  IsRace = function(raceMask)
    local flag = LibQuestieDB.Enum.raceMaskById[select(3, UnitRace("player"))]
    return raceMask == 0 or (flag ~= nil and hasFlag(raceMask, flag))
  end,
  IsClass = function(classMask)
    return classMask == 0 or hasFlag(classMask, 2 ^ (select(3, UnitClass("player")) - 1))
  end,
  IsRaceClass = function(raceMask, classMask)
    local race = call("IsRace", raceMask or 0)
    if race == false then return false end
    local class = call("IsClass", classMask or 0)
    if class == false then return false end
    if race == nil or class == nil then return nil end
    return true
  end,
  IsLevel = function(level)
    return UnitLevel("player") >= level
  end,
  IsLevelExact = function(level)
    return UnitLevel("player") == level
  end,
  IsLevelBelow = function(level)
    return UnitLevel("player") <= level
  end,
  HasAchievement = function(achievementId)
    if not GetAchievementInfo then return true end
    return select(4, GetAchievementInfo(achievementId)) == true
  end,

  -- Future improvement: server state the client cannot see. Disabled in the builder until
  -- Questie can answer them. HolidayActive could map holiday IDs onto QuestieEvent's active
  -- events; EventActive uses emulator event IDs with no client equivalent; WorldState is only
  -- visible for UI widgets.
  -- EventActive = function() return true end,
  -- HolidayActive = function() return true end,
  -- WorldState = function() return true end,
}

-- The builder validates authored expressions against the same vocabulary.
for name in pairs(LibQuestieDB.ConditionBuilder.vocabulary) do
  if not base[name] then error("QuestieDB: condition function " .. name .. " has no implementation", 0) end
end
for name in pairs(base) do
  if not LibQuestieDB.ConditionBuilder.vocabulary[name] then
    error("QuestieDB: condition function " .. name .. " is missing from the builder", 0)
  end
end
--------------------------------------------------------------------------------------------
-- Calls and reports
--------------------------------------------------------------------------------------------

local published = {} -- name -> function, replaced as a whole by SetFunctions.

---Call a condition function by name, published version first.
---@return boolean? result Nil when the function could not read its state.
call = function(name, ...)
  local result = (published[name] or base[name])(...)
  if result == nil then return nil end
  return result and true or false
end

local reported = {} -- report key -> true once it has been reported.

-- Runtime errors are keyed by message, so one broken function used by many expressions is
-- reported once. Parse failures are keyed by expression, since their messages repeat.
local function report(expression, message, key)
  message = tostring(message)
  key = key or message
  if reported[key] then return end
  reported[key] = true
  local handler = geterrorhandler and geterrorhandler()
  -- A failing handler must not break the caller's availability loop.
  if handler then pcall(handler, "QuestieDB condition '" .. expression .. "': " .. message) end
end

--------------------------------------------------------------------------------------------
-- Parsing
--------------------------------------------------------------------------------------------

---@return table[]? tokens Nil when the expression contains anything the builder never emits.
local function tokenize(expression)
  local tokens, position = {}, 1
  while position <= #expression do
    local start, stop = expression:find("^%s+", position)
    if start then
      position = stop + 1
    else
      local text = expression:match("^%-?%d+", position)
      local token
      if text then
        token = { kind = "number", value = tonumber(text) }
      else
        text = expression:match('^"[^"\\]*"', position)
        if text then
          token = { kind = "string", value = text:sub(2, -2) }
        else
          text = expression:match("^[%a_][%w_]*", position) or expression:match("^[(),]", position)
          if not text then return nil end
          token = { kind = "word", value = text }
        end
      end
      tokens[#tokens + 1] = token
      position = position + #text
    end
  end
  return tokens
end

---Recursive descent over `or` > `and` > `not` > calls and parentheses; raises on bad input.
local function parse(tokens)
  local index = 1
  local function peek(value)
    local token = tokens[index]
    return token and token.kind == "word" and token.value == value
  end
  local function expect(value)
    if not peek(value) then error("expected " .. value, 0) end
    index = index + 1
  end
  local orExpression
  local function unary()
    if peek("not") then
      index = index + 1
      return { op = "not", children = { unary() } }
    end
    if peek("(") then
      index = index + 1
      local node = orExpression()
      expect(")")
      return node
    end
    local name = tokens[index]
    if not name or name.kind ~= "word" or not base[name.value] then error("expected a condition", 0) end
    index = index + 1
    expect("(")
    local args = {}
    local function argument()
      local token = tokens[index]
      if not token or (token.kind ~= "number" and token.kind ~= "string") then error("expected an argument", 0) end
      args[#args + 1] = token.value
      index = index + 1
    end
    if not peek(")") then
      argument()
      -- Every comma needs an argument after it, as in Lua.
      while peek(",") do
        index = index + 1
        argument()
      end
    end
    expect(")")
    return { call = name.value, args = args }
  end
  local function binary(operator, operand)
    return function()
      local node = operand()
      if not peek(operator) then return node end
      node = { op = operator, children = { node } }
      while peek(operator) do
        index = index + 1
        node.children[#node.children + 1] = operand()
      end
      return node
    end
  end
  orExpression = binary("or", binary("and", unary))
  local tree = orExpression()
  if index <= #tokens then error("unexpected trailing input", 0) end
  return tree
end

local parsed = {} -- expression -> tree, or false when it is outside the builder's grammar.

---@return table? tree Nil, reported once, when the expression is outside the builder's grammar.
local function parsedTree(expression)
  local tree = parsed[expression]
  if tree == nil then
    local tokens = tokenize(expression)
    local ok, result = false, "unexpected character"
    if tokens then ok, result = pcall(parse, tokens) end
    if not ok then report(expression, "does not parse: " .. tostring(result), expression) end
    tree = ok and result or false
    parsed[expression] = tree
  end
  return tree or nil
end

--------------------------------------------------------------------------------------------
-- Evaluation
--------------------------------------------------------------------------------------------

---Combine operand results with three-valued logic. `resultOf(index)` is called in order and
---only until the result is decided, so Evaluate can skip the remaining operands.
---@param op "and"|"or"|"not"
---@param count integer
---@param resultOf fun(index: integer): boolean?
---@return boolean?
local function combine(op, count, resultOf)
  if op == "not" then
    local result = resultOf(1)
    if result == nil then return nil end
    return not result
  end
  local decisive = op == "or" -- The operand value that decides the result on its own.
  local anyUnknown = false
  for index = 1, count do
    local result = resultOf(index)
    if result == decisive then return decisive end
    if result == nil then anyUnknown = true end
  end
  if anyUnknown then return nil end
  return not decisive
end

local function evaluateNode(node)
  if node.call then return call(node.call, unpack(node.args)) end
  return combine(node.op, #node.children, function(index) return evaluateNode(node.children[index]) end)
end

local function explainNode(node)
  if node.call then
    local args = {}
    for index, value in ipairs(node.args) do args[index] = value end
    return { call = node.call, args = args, result = call(node.call, unpack(args)) }
  end
  local children = {}
  for index, child in ipairs(node.children) do children[index] = explainNode(child) end
  local result = combine(node.op, #children, function(index) return children[index].result end)
  return { op = node.op, children = children, result = result }
end

local active = {} -- expression -> true while it is being evaluated or explained.

---Run a walker over an expression's tree with the shared re-entry guard and error handling.
---@return boolean ok False when the expression did not parse, re-entered, or raised.
---@return any result
local function run(expression, walk)
  local tree = parsedTree(expression)
  if not tree then return false end
  -- The same expression always makes the same calls, so re-entering it would never finish.
  -- This happens when a published QuestAvailable evaluates the quest that asked about it.
  -- The answer then depends on which quest was evaluated first, so the shipped data must not
  -- contain QuestAvailable cycles; tools/validation/conditions.test.lua rejects them.
  if active[expression] then return false end
  active[expression] = true
  local ok, result = pcall(walk, tree)
  active[expression] = nil
  if not ok then report(expression, result) end
  return ok, result
end

--------------------------------------------------------------------------------------------
-- Public API
--------------------------------------------------------------------------------------------

---Return a quest's condition expression.
---@param questId QuestId
---@return string? expression Nil when the quest has no condition.
function Conditions.Get(questId)
  return LibQuestieDB.Quest.conditions(questId)
end

---Evaluate a condition expression.
---An empty or nil expression is true. Expressions outside the builder's grammar, or that raise
---an error, are permissive (true) and are reported once through the client's error handler.
---Re-entering an expression that is already being evaluated is also true.
---@param expression string?
---@return boolean? result Nil when unknown: a condition function could not read its state and
---no other operand decides the result.
function Conditions.Evaluate(expression)
  if expression == nil or expression == "" then return true end
  local ok, result = run(expression, evaluateNode)
  if not ok then return true end
  return result
end

---Evaluate a quest's condition expression.
---@param questId QuestId
---@return boolean? result True when the quest has no condition; nil when unknown.
function Conditions.EvaluateQuest(questId)
  return Conditions.Evaluate(Conditions.Get(questId))
end

---Explain an expression as a tree with every leaf evaluated, for display.
---Nodes are `{ call, args, result }` or `{ op = "and"|"or"|"not", children, result }`, where
---result is true, false, or nil when unknown. When Explain returns a tree, its root result equals
---Evaluate's: both combine operands with the same three-valued logic.
---@param expression string?
---@return table? tree Nil without an expression, for one outside the builder's grammar, or
---when a condition function raised an error (Evaluate is then permissive).
function Conditions.Explain(expression)
  if expression == nil or expression == "" then return nil end
  local ok, tree = run(expression, explainNode)
  return ok and tree or nil
end

---Explain a quest's condition expression.
---@param questId QuestId
---@return table? tree
function Conditions.ExplainQuest(questId)
  return Conditions.Explain(Conditions.Get(questId))
end

---Publish condition functions for every consumer, replacing this owner's previous set.
---Functions replace base functions of the same name; other names are rejected, since no
---expression could call them. Passing nil withdraws the set.
---@param owner string Must be the trusted owner.
---@param functions table<string, fun(...): boolean?>?
function Conditions.SetFunctions(owner, functions)
  if owner ~= TRUSTED_OWNER then
    error("QuestieDB: '" .. tostring(owner) .. "' may not publish condition functions", 2)
  end
  -- Copy, so later changes to the caller's table cannot bypass validation.
  local copy = {}
  for name, fn in pairs(functions or {}) do
    if type(name) ~= "string" or type(fn) ~= "function" then
      error("QuestieDB: condition functions must map names to functions", 2)
    end
    if not base[name] then
      error("QuestieDB: '" .. name .. "' is not a condition function", 2)
    end
    copy[name] = fn
  end
  published = copy
end

LibQuestieDB.Conditions = Conditions

return Conditions
