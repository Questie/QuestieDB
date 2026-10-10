-- validators/zones.lua
--
-- Area-to-UiMap resolution over the support data QuestieDB owns.
--
-- Four of the fifteen invariant checks ask "does this spawn's area ID resolve to a map?", and
-- in Questie that question is answered by `ZoneDB:GetUiMapIdByAreaId` — a module that stays
-- with the consumer. Re-deriving the lookup here is what lets validation run with **no consumer
-- checkout required**, which is the whole point of moving the job.
--
-- No-map instance markers also need the owned dungeon entrance table. This is validation,
-- not the consumer's coordinate projection, parent-zone walking or map-change handling.

local runtime = dofile("generator/runtime.lua")
local client = dofile("emulator/client.lua")

local zones = {}

--- The support-data files store their big tables as Lua long strings that the consuming module
--- `loadstring`s. Doing the same here keeps the data files byte-identical to Questie's.
local function materialize(value)
  if type(value) == "table" then return value end
  if type(value) ~= "string" then return {} end
  local chunk = loadstring(value)
  if not chunk then return {} end
  return chunk()
end

---Accept existing map handling, or pure instance markers with usable outdoor entrances.
---@param lookup fun(areaId: number): number?
---@param dungeons table
---@return fun(areaId: number, points: table): boolean
function zones.BuildSpawnAreaValidator(lookup, dungeons)
  local entrances = {}
  for area, dungeon in pairs(dungeons) do entrances[area] = dungeon[4] end
  for _, dungeon in pairs(dungeons) do
    for _, alias in ipairs(dungeon[2] or {}) do
      entrances[alias] = entrances[alias] or dungeon[4]
    end
  end
  return function(area, points)
    if lookup(area) ~= nil then return true end -- Preserve existing map and 0-suppression policy.
    if #points == 0 then return false end
    for _, point in ipairs(points) do
      if point[1] ~= -1 or point[2] ~= -1 then return false end
    end
    local locations = entrances[area]
    if not locations or #locations == 0 then return false end
    for _, entrance in ipairs(locations) do
      local map = lookup(entrance[1])
      local x, y = entrance[2], entrance[3]
      if not map or map <= 0 or type(x) ~= "number" or type(y) ~= "number" or
          not (x >= 0 and x <= 100 and y >= 0 and y <= 100) then return false end
    end
    return true
  end
end

---Load one flavor's map lookup and spawn-area validation predicate.
---
--- Override first, then the generated table — the order `ZoneDB` uses, and the reason the
--- hand-authored override table exists at all.
function zones.BuildAreaLookup(flavor)
  local config = dofile("src/config.lua")
  local LibQuestieDB = { config = config, flavor = flavor }

  for _, path in ipairs(config.enumFiles) do
    runtime.execute(path, "QuestieDB", LibQuestieDB)
  end
  runtime.execute("src/support/data.lua", "QuestieDB", LibQuestieDB)

  -- `dungeons.lua` reads `UnitFactionGroup` at load time to pick faction-specific entry
  -- coordinates, so the client stubs have to be in place even for a pure data load.
  client.install({ expansion = flavor and flavor.expansion or "Classic" })

  local support = LibQuestieDB.Support
  support.Install(flavor)
  for _, file in ipairs(config.supportFiles(flavor)) do
    if file:match("/Zones/") then
      runtime.execute(file, "QuestieDB", LibQuestieDB)
    end
  end
  support.Remove()

  local ZoneDB = support.Get("ZoneDB") or { private = {} }
  local override = materialize(ZoneDB.private.areaIdToUiMapIdOverride)
  local generated = materialize(ZoneDB.private.areaIdToUiMapId)

  zones.lastCounts = { override = 0, generated = 0 }
  for _ in pairs(override) do zones.lastCounts.override = zones.lastCounts.override + 1 end
  for _ in pairs(generated) do zones.lastCounts.generated = zones.lastCounts.generated + 1 end

  local function lookup(areaId)
    local uiMapId = override[areaId]
    if uiMapId ~= nil then return uiMapId end
    return generated[areaId]
  end
  return lookup, zones.BuildSpawnAreaValidator(lookup, ZoneDB.private.dungeons or {})
end

return zones
