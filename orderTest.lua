--------------------------------------------------------------------------------
--  Minimal test harness for QuestFunctions.orderedObjectives
--  ---------------------------------------------------------
--  • Provides dummy versions of QuestMeta, QuestFunctions.objectives and
--    orderedObjectivesGetter.
--  • Runs two quests: one with a custom order spec and one without.
--  • Prints the triples {typeKey, subIndex, objectiveId} in the order returned.
--------------------------------------------------------------------------------
---@alias QuestId integer
local emptyTable = {}

--------------------------------------------------------------------------------
--  Fake data & helpers
--------------------------------------------------------------------------------
local QuestMeta = {
  objectiveKeys = {
    CREATURE   = 1,
    OBJECT     = 2,
    ITEM       = 3,
    REPUTATION = 4,
    KILLCREDIT = 5,
    SPELL      = 6,
  },
}
-- Reverse lookup for keys
local reverse = {}
for key, idx in pairs(QuestMeta.objectiveKeys) do
  print(("QuestMeta.objectiveKeys[%s] = %d"):format(key, idx))
  reverse[idx] = key
end
for idx, key in pairs(reverse) do
  QuestMeta.objectiveKeys[idx] = key
end

local Corrections = { QuestMeta = QuestMeta, }

--------------------------------------------------------------------------------
--  Ordered-objective specs
--------------------------------------------------------------------------------
---@type table<QuestId, ObjectiveOrderSpec>
local orderedObjectivesSpec = {
  -- Quest 1: show ITEM #1 first, then CREATURE #2
  [1] = {
    { QuestMeta.objectiveKeys.ITEM,     1, 1, },
    { QuestMeta.objectiveKeys.CREATURE, 2, 2, },
  },

  -- Quest 3: (object only) explicit slot just to exercise the code path
  [3] = {
    { QuestMeta.objectiveKeys.OBJECT, 1, 1, },
  },

  -- Quest 5: kill-credit listed first even though it’s the only one :)
  [5] = {
    { QuestMeta.objectiveKeys.KILLCREDIT, 1, 1, },
  },

  -- Quest 7: shuffle all objectives and subIndexes
  [7] = {
    -- OBJECT #2 first
    { QuestMeta.objectiveKeys.OBJECT,     2, 1, },
    -- ITEM #1 second
    { QuestMeta.objectiveKeys.ITEM,       1, 2, },
    -- CREATURE #2 third
    { QuestMeta.objectiveKeys.CREATURE,   2, 3, },
    -- REPUTATION #1 fourth
    { QuestMeta.objectiveKeys.REPUTATION, 1, 4, },
    -- SPELL #2 fifth
    { QuestMeta.objectiveKeys.SPELL,      2, 5, },
    -- KILLCREDIT #1 sixth
    { QuestMeta.objectiveKeys.KILLCREDIT, 1, 6, },
    -- OBJECT #1 seventh
    { QuestMeta.objectiveKeys.OBJECT,     1, 7, },
    -- CREATURE #1 eighth
    { QuestMeta.objectiveKeys.CREATURE,   1, 8, },
    -- SPELL #1 ninth
    { QuestMeta.objectiveKeys.SPELL,      1, 9, },
    -- ITEM #2 tenth
    { QuestMeta.objectiveKeys.ITEM,       2, 10, },
  },
}

--------------------------------------------------------------------------------
--  Raw-objective DB covering every type
--------------------------------------------------------------------------------
---@type table<QuestId, RawObjectives>
local rawObjectivesDB = {
  ------------------------------------------------------------------------------
  -- Quest 1 & 2 – creature + item
  ------------------------------------------------------------------------------
  [1] = {
    [QuestMeta.objectiveKeys.CREATURE] = {
      { 199, "Kill 8 Young Stranglethorn Tigers", },
      { 200, "Kill 10 Stranglethorn Tigers", },
    },
    [QuestMeta.objectiveKeys.ITEM] = {
      { 3879, "Collect 5 Tiger Pelts", },
    },
  },
  [2] = { -- same objectives, *no* ordered spec
    [QuestMeta.objectiveKeys.CREATURE] = {
      { 199, "Kill 8 Young Stranglethorn Tigers", },
      { 200, "Kill 10 Stranglethorn Tigers", },
    },
    [QuestMeta.objectiveKeys.ITEM] = {
      { 3879, "Collect 5 Tiger Pelts", },
    },
  },

  ------------------------------------------------------------------------------
  -- Quest 3 – object objective
  ------------------------------------------------------------------------------
  [3] = {
    [QuestMeta.objectiveKeys.OBJECT] = {
      { 1001, "Activate Control Console", },
    },
  },

  ------------------------------------------------------------------------------
  -- Quest 4 – reputation objective (single table, not array)
  ------------------------------------------------------------------------------
  [4] = {
    [QuestMeta.objectiveKeys.REPUTATION] = { 47, 500, }, -- ↑500 Stormwind rep
  },

  ------------------------------------------------------------------------------
  -- Quest 5 – kill-credit objective
  ------------------------------------------------------------------------------
  [5] = {
    [QuestMeta.objectiveKeys.KILLCREDIT] = {
      { { 301, 302, }, 300, "Gain credit for Warsong Grunts", },
    },
  },

  ------------------------------------------------------------------------------
  -- Quest 6 – spell objective
  ------------------------------------------------------------------------------
  [6] = {
    [QuestMeta.objectiveKeys.SPELL] = {
      { 12345, "Use Arcane Disruption on Rift", },
    },
  },

  ------------------------------------------------------------------------------
  -- Quest 7 – all objective types, multiple subIndexes each
  ------------------------------------------------------------------------------
  [7] = {
    [QuestMeta.objectiveKeys.CREATURE] = {
      { 7001, "Defeat Jungle Panther", },
      { 7002, "Defeat Shadowmaw Panther", },
    },
    [QuestMeta.objectiveKeys.OBJECT] = {
      { 7101, "Activate Ancient Device", },
      { 7102, "Disable Security Console", },
    },
    [QuestMeta.objectiveKeys.ITEM] = {
      { 7201, "Collect Panther Fang", },
      { 7202, "Collect Panther Hide", },
    },
    [QuestMeta.objectiveKeys.REPUTATION] = { 7301, 250, }, -- ↑250 Example Faction rep
    [QuestMeta.objectiveKeys.KILLCREDIT] = {
      { { 7401, 7402, }, 7400, "Gain credit for Panther Allies", },
    },
    [QuestMeta.objectiveKeys.SPELL] = {
      { 7501, "Use Jungle Elixir", },
      { 7502, "Use Shadow Elixir", },
    },
  },
}

--------------------------------------------------------------------------------
--  Stubs that your production code normally provides
--------------------------------------------------------------------------------
local QuestFunctions = {}

-- Pretend-DB getter that your original code expects
---@param id QuestId
---@return ObjectiveOrderSpec
local function orderedObjectivesGetter(id)
  return orderedObjectivesSpec[id] or emptyTable
end

-- Stub for the real QuestFunctions.objectives
---@param id QuestId
---@return RawObjectives?
function QuestFunctions.objectives(id)
  return rawObjectivesDB[id]
end

--------------------------------------------------------------------------------
--  The orderedObjectives implementation (copied from your module verbatim)
--------------------------------------------------------------------------------
do
  --- {typeKey, subIndex, slot?}
  ---@alias ObjectiveOrderEntry { [1]: integer, [2]: integer, [3]: integer? }
  ---@alias ObjectiveOrderSpec  ObjectiveOrderEntry[]
  ---@alias ObjectiveTriple     { [1]: integer, [2]: integer, [3]: RawObjective }


  -- maxObjectiveType is the highest numeric value in objectiveKeys.
  -- It is used to iterate over all possible objective types in order,
  -- ensuring that all types (CREATURE, OBJECT, ITEM, etc.) are checked
  -- when flattening objectives for a quest.
  ---@type integer
  local maxObjectiveType = (function()
    local m = 0
    for _, idx in pairs(Corrections.QuestMeta.objectiveKeys) do
      if type(idx) == "number" and idx > m then
        m = idx
      end
    end
    return m
  end)()

  -- Reputation objectives are special: they are a single table, not an array.
  ---@type integer
  local reputationObjectiveIndex = Corrections.QuestMeta.objectiveKeys.REPUTATION

  -- Build a LUT:  "<type>:<idx>" → slot
  ---@param orderSpec ObjectiveOrderSpec?
  ---@return table<string, integer>|nil
  local function buildOrderLUT(orderSpec)
    if not orderSpec or #orderSpec == 0 then
      return nil
    end
    local lut = {} ---@type table<string, integer>
    for pos, entry in ipairs(orderSpec) do
      local tKey, subIdx, slot = entry[1], entry[2], entry[3] or pos
      local key = tKey .. ":" .. subIdx
      -- Duplicate-check (comment in to enable warnings)
      -- if lut[key] then
      --   io.stderr:write(("WARN duplicate orderedObjectives %s (keeping %d, ignoring %d)\n")
      --                   :format(key, lut[key], slot))
      -- end
      lut[key] = lut[key] or slot
    end
    return lut
  end

  ---Return objectives in UI order.
  ---@param id QuestId
  ---@return ObjectiveTriple[]
  function QuestFunctions.orderedObjectives(id)
    local objectives = QuestFunctions.objectives(id)
    if not objectives then
      return emptyTable
    end

    -- 1. flatten
    local flat = {} ---@type ObjectiveTriple[]
    for typeKey = 1, maxObjectiveType do
      local objectivesOfType = objectives[typeKey]
      if objectivesOfType then
        if typeKey == reputationObjectiveIndex then
          -- reputation objective is a single table, not an array
          local tbl = objectivesOfType --[[@as RawReputationObjective]]
          flat[#flat + 1] = { typeKey, 1, tbl, }
        else
          for objIdx, objTbl in ipairs(objectivesOfType) do
            local tbl = objTbl --[[@as RawNpcObjective | RawObjectObjective | RawItemObjective | RawKillObjective]]
            flat[#flat + 1] = { typeKey, objIdx, tbl, }
          end
        end
      end
    end

    -- 2. apply custom ordering
    local orderLUT = buildOrderLUT(orderedObjectivesGetter(id))
    if orderLUT then
      table.sort(flat, function(a, b)
        local aKey, bKey = a[1] .. ":" .. a[2], b[1] .. ":" .. b[2]
        local aSlot = orderLUT[aKey] or math.huge
        local bSlot = orderLUT[bKey] or math.huge
        if aSlot ~= bSlot then return aSlot < bSlot end
        if a[1] ~= b[1] then return a[1] < b[1] end
        return a[2] < b[2]
      end)
    end
    return flat
  end
end

--------------------------------------------------------------------------------
--  Simple pretty-printer
--------------------------------------------------------------------------------
local function dump(label, triples)
  print(("== %s ==").format and ("== %s ==").format(label) or ("== " .. label .. " =="))
  for i, t in ipairs(triples) do
    local typeKey, subIdx, data = t[1], t[2], t[3]
    local idShown = typeKey == Corrections.QuestMeta.objectiveKeys.KILLCREDIT and data[2] or data[1] -- NPC / Object / Item / Faction id
    print(("  %d) type=%s sub=%d id=%s"):format(i, Corrections.QuestMeta.objectiveKeys[typeKey], subIdx, tostring(idShown)))
  end
end

--------------------------------------------------------------------------------
--  Run all six quests
--------------------------------------------------------------------------------
for q = 1, 7 do
  local label = ("Quest %d (%s)"):format(
    q,
    orderedObjectivesSpec[q] and "custom order" or "default order")
  dump(label, QuestFunctions.orderedObjectives(q))
end
