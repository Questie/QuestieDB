-- Contributor-facing explanations, not validation decisions.
-- Read by domain: rule wording, labels/values, spawn findings, entity relationships, report assembly.
-- Stable baseline keys remain owned by validators/run.lua.
local serialize = dofile("generator/serialize.lua")
local config = dofile("src/config.lua")
local diagnostics = {}

--------------------------------------------------------------------------------------------
-- Rule explanations: checked fields and their meaning stay together
--------------------------------------------------------------------------------------------

local rules = {
  -- Reciprocal quest starts and finishes.
  npcQuestStarts = {
    fields = {"questStarts"},
    why = "NPC.questStarts and Quest.startedBy[1] must name each other.",
    relatedQuestField = "startedBy",
  },
  npcQuestEnds = {
    fields = {"questEnds"},
    why = "NPC.questEnds and Quest.finishedBy[1] must name each other.",
    relatedQuestField = "finishedBy",
  },
  objectQuestStarts = {
    fields = {"questStarts"},
    why = "Object.questStarts and Quest.startedBy[2] must name each other.",
    relatedQuestField = "startedBy",
  },
  objectQuestEnds = {
    fields = {"questEnds"},
    why = "Object.questEnds and Quest.finishedBy[2] must name each other.",
    relatedQuestField = "finishedBy",
  },

  -- Referenced entities must exist in the same database.
  questStarters = {
    fields = {"startedBy"},
    why = "Every quest starter must exist in this database. NPC starters also need a name.",
  },
  questFinishers = {
    fields = {"finishedBy"},
    why = "Every quest finisher must exist in this database.",
  },
  objectives = {
    fields = {"objectives"},
    why = "Every NPC, object, item and kill-credit NPC named by a quest objective " ..
      "must exist in this database.",
  },

  -- Prerequisites, eligibility and quest hierarchy.
  requiredSourceItems = {
    fields = {"requiredSourceItems", "sourceItemId", "objectives"},
    why = "requiredSourceItems lists additional prerequisite items; " ..
      "it must not repeat sourceItemId or item-objective IDs.",
  },
  requiredRaces = {
    fields = {"requiredRaces"},
    why = "requiredRaces must be present and must not exceed this flavor's configured race-mask limit. " ..
      "Neutral 0 is allowed.",
  },
  preQuestExclusiveness = {
    fields = {"preQuestSingle", "preQuestGroup"},
    why = "A quest cannot use both prerequisite modes: preQuestSingle means any listed quest; " ..
      "preQuestGroup means all listed quests.",
  },
  parentChildQuestRelations = {
    fields = {"parentQuest", "childQuests"},
    why = "Parent and child quests must exist and their parentQuest/childQuests entries must agree.",
  },

  -- Coordinate containers differ; their routing explanation is shared below.
  npcSpawnAreaIds = {fields = {"spawns"}},
  objectSpawnAreaIds = {fields = {"spawns"}},
  questExtraObjectiveSpawnAreaIds = {fields = {"extraObjectives"}},
  questTriggerEndSpawnAreaIds = {fields = {"triggerEnd"}},
}

--------------------------------------------------------------------------------------------
-- Shared display mechanics: names, values and owning input paths
--------------------------------------------------------------------------------------------

local entityNames = {Npc = "NPC", Object = "Object", Item = "Item", Quest = "Quest"}
local referenceTypes = {
  npc = "Npc", object = "Object", item = "Item", quest = "Quest", queststart = "Quest", questend = "Quest",
}

local function entityLabel(context, entityType, id)
  local entry = context.loaded[entityType]
  local row = entry and entry.entities[id]
  local name = row and row[entry.meta.keys.name]
  local label = (entityNames[entityType] or entityType) .. " " .. id
  if not row then return label .. " (missing from this database)" end
  if not name then return label .. " (name is missing)" end
  if type(name) ~= "string" then return label .. " (name has unexpected type " .. type(name) .. ")" end
  return label .. " " .. serialize.quote(name)
end

local function areaLabel(context, area)
  local symbol
  for name, id in pairs(context.zoneIDs or {}) do
    if id == area and (not symbol or name < symbol) then symbol = name end
  end
  if not symbol then return "area " .. area .. " (no named zone constant)" end
  local name = symbol:lower():gsub("_", " "):gsub("(%a)([%w']*)", function(first, rest)
    return first:upper() .. rest
  end)
  name = name:gsub(" Of ", " of "):gsub(" The ", " the "):gsub(" And ", " and "):gsub(" In ", " in ")
  return name .. " (area " .. area .. ")"
end

local function supportPath(context, filename)
  for _, path in ipairs(config.supportFiles(context.flavor)) do
    if path:sub(-#filename) == filename then return path end
  end
  return "ZoneDB.private." .. filename:gsub("%.lua$", "")
end

local function fieldValue(context, entityType, id, field)
  local entry = context.loaded[entityType]
  local row = entry and entry.entities[id]
  return row and row[entry.meta.keys[field]]
end

-- A malformed display value must not hide the original finding.
local function display(value)
  local ok, shown = pcall(serialize.value, value)
  return ok and shown or ("<cannot display value: " .. tostring(shown) .. ">")
end

--------------------------------------------------------------------------------------------
-- Spawn findings: explain only the failing coordinate entries
--------------------------------------------------------------------------------------------

local function spawnDetails(context, entityType, id, field, areaList)
  local lines = {
    "  Problem: Questie cannot place these spawn locations on a map.",
    "  Why: Ordinary coordinates need an area-to-UiMap route. " ..
      "Dungeon markers {-1,-1} need usable outdoor entrances.",
  }
  local paths = {}
  local value = fieldValue(context, entityType, id, field)
  local describedAreas = {}

  for areaText in areaList:gmatch("%d+") do
    local area = tonumber(areaText)
    if not describedAreas[area] then
      describedAreas[area] = true
      lines[#lines + 1] = "  Location: " .. areaLabel(context, area)
      local function showPoints(points, fieldPath)
        if not points then return end
        local valid, explanation = context.canResolveSpawnArea(area, points)
        if valid then return end -- A neighboring objective may use valid markers in this same area.
        lines[#lines + 1] = "    Actual " .. fieldPath .. " = " .. display(points)
        lines[#lines + 1] = "    Problem: " .. (explanation or "No usable map or dungeon entrance route was found.")
      end

      -- Keep the three coordinate shapes visible at their point of use.
      if field == "spawns" then
        showPoints(value and value[area], "spawns[" .. area .. "]")
      elseif field == "triggerEnd" then
        showPoints(value and value[2] and value[2][area], "triggerEnd[2][" .. area .. "]")
      elseif field == "extraObjectives" then
        for index, objective in ipairs(value or {}) do
          showPoints(objective[1] and objective[1][area], "extraObjectives[" .. index .. "][1][" .. area .. "]")
        end
      end
    end
  end

  paths[supportPath(context, "areaIdToUiMapId.lua")] = true
  paths[supportPath(context, "dungeons.lua")] = true
  lines[#lines + 1] = "  Check: Verify the AreaID and coordinate frame. For dungeon markers, " ..
    "check dungeons[AreaID][4]. Do not invent a UiMap or add 0 to hide a missing route."
  return lines, paths
end

--------------------------------------------------------------------------------------------
-- Entity relationships: show the owner, then the referenced records and reciprocal fields
--------------------------------------------------------------------------------------------

local function entityDetails(context, checkName, entityType, id, rule, reason)
  local lines, paths = {}, {}
  local function inspect(entity)
    local entry = context.loaded[entity]
    if entry then paths[entry.path] = true end
  end
  local function showField(entity, entityId, field)
    lines[#lines + 1] = "  Actual " .. entityLabel(context, entity, entityId) .. "." .. field .. " = " ..
      display(fieldValue(context, entity, entityId, field))
    inspect(entity)
  end

  -- Translate the generic legacy reason without changing its stable finding key.
  local problem = reason == "entity" and "Both preQuestSingle and preQuestGroup contain prerequisites." or reason
  problem = problem:gsub("missing/hidden in the database", "missing from this database")
  lines[#lines + 1] = "  Problem: " .. problem
  if rule.why then lines[#lines + 1] = "  Why: " .. rule.why end
  for _, field in ipairs(rule.fields) do showField(entityType, id, field) end
  if checkName == "requiredRaces" then
    local maximum = 0
    for _, mask in pairs(context.raceKeys or {}) do maximum = maximum + mask end
    lines[#lines + 1] = "  Expected requiredRaces: present and no greater than " .. maximum ..
      " for " .. context.flavor.name
    paths["src/corrections/enum/expansions.lua"] = true
  end

  -- One related record may appear in several reason forms; show it once, never as its own owner.
  local seen = {}
  local function showReference(entity, referenceId)
    local key = entity .. ":" .. referenceId
    if seen[key] or (entity == entityType and referenceId == id) then return end
    seen[key] = true
    lines[#lines + 1] = "  Related: " .. entityLabel(context, entity, referenceId)
    inspect(entity)
    if entity == "Npc" and checkName == "questStarters" and reason:find("has no name", 1, true) then
      showField(entity, referenceId, "name")
    elseif entity == "Quest" and rule.relatedQuestField then
      showField(entity, referenceId, rule.relatedQuestField)
    elseif entity == "Quest" and checkName == "parentChildQuestRelations" then
      showField(entity, referenceId, "parentQuest")
      showField(entity, referenceId, "childQuests")
    end
  end

  -- Existing checks emit both "NPC 42" and "NPC starter 42" reference forms.
  for typeName, referenceId in reason:gmatch("([%a]+)%s+(%d+)") do
    local referenceType = referenceTypes[typeName:lower()]
    if referenceType then showReference(referenceType, tonumber(referenceId)) end
  end
  for typeName, role, referenceId in reason:gmatch("([%a]+)%s+([%a]+)%s+(%d+)") do
    local referenceType = referenceTypes[typeName:lower()]
    if referenceType and (role == "starter" or role == "finisher" or role == "objective") then
      showReference(referenceType, tonumber(referenceId))
    end
  end
  local parentId = reason:match("parentQuest is (%d+)") or reason:match("(%d+) is listing it")
  if parentId then showReference("Quest", tonumber(parentId)) end
  local itemId = checkName == "requiredSourceItems" and reason:match("requiredSourceItems:%s*(%d+)")
  if itemId then showReference("Item", tonumber(itemId)) end

  lines[#lines + 1] = "  Check: Verify the IDs and which relationship is correct before editing the affected fields."
  return lines, paths
end

--------------------------------------------------------------------------------------------
-- Report assembly: stable identity, domain explanation, then data origin and inspection paths
--------------------------------------------------------------------------------------------

---@param fingerprint string Existing check|Type:id|reason baseline key.
---@param context table Loaded entities, flavor, zone IDs, race keys and spawn-area predicate.
---@param status string NEW, KNOWN, or FINDING for console/report headings.
---@return string explanation
function diagnostics.format(fingerprint, context, status)
  local checkName, entityType, idText, reason = fingerprint:match("^([^|]+)|([^:|]+):(%d+)|(.+)$")
  if not checkName then return status .. ": " .. fingerprint end
  local id = tonumber(idText)
  local rule = rules[checkName] or {fields = {}}

  -- Domain-specific details do not interpret or modify the baseline comparison.
  local lines, paths
  local areaList = reason:match("^areaIds (.+)$")
  if areaList then
    lines, paths = spawnDetails(context, entityType, id, rule.fields[1], areaList)
  else
    lines, paths = entityDetails(context, checkName, entityType, id, rule, reason)
  end
  table.insert(lines, 1, status .. ": " .. context.flavor.name .. " " ..
    entityLabel(context, entityType, id) .. " [" .. checkName .. "]")
  local entry = context.loaded[entityType]
  if entry then paths[entry.path] = true end

  -- Corrected values need a raw-data comparison hint; raw-mode output must omit that claim.
  if not context.raw then
    paths[context.flavor.name == "Forever" and "src/corrections/Forever/" or "src/corrections/"] = true
    lines[#lines + 1] = "  These values include Static Corrections and Derived Passes; " ..
      "the raw file may not contain the value shown."
    lines[#lines + 1] = "  Compare raw data: lua5.1 validators/run.lua " .. context.flavor.name .. " --raw"
  end
  local sortedPaths = {}
  for path in pairs(paths) do sortedPaths[#sortedPaths + 1] = path end
  table.sort(sortedPaths)
  lines[#lines + 1] = "  Inspect: " .. table.concat(sortedPaths, ", ")
  lines[#lines + 1] = "  Finding key: " .. fingerprint
  return table.concat(lines, "\n")
end

return diagnostics
