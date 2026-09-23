-- Executes the shipped helper against DBC-derived points, not a second Lua coefficient table.
local helperPath, planPath = ...
local plan = assert(loadfile(planPath))()
local db = {}
local areaEntries, uiMapEntries = assert(loadfile(helperPath))("QuestieDB", db)
assert(type(areaEntries) == "table" and type(uiMapEntries) == "table",
  "Runtime helper lacks its generated inventory; regenerate it with --write-runtime-helper")
assert(type(db.EraToForever) == "function" and type(db.EraToForeverByUiMapId) == "function",
  "Runtime helper is missing a public conversion function")

local failures = 0
local function problem(message)
  failures = failures + 1
  print(message)
end
local function near(actual, expected)
  return type(actual) == "number" and math.abs(actual - expected) <= 1e-10
end

local areas, maps = {}, {}
for _, row in ipairs(plan) do
  local area, map = row[1], row[2]
  areas[area], maps[map] = true, true
  -- Three non-collinear points expose both scale and offset, including identity maps.
  for _, point in ipairs({{0, 0}, {100, 0}, {0, 100}, {44.18, 76.06}}) do
    local expectedX, expectedY = point[1] * row[3] + row[4], point[2] * row[5] + row[6]
    for _, api in ipairs({{db.EraToForever, area, "AreaID"}, {db.EraToForeverByUiMapId, map, "UiMapID"}}) do
      local ok, x, y = pcall(api[1], api[2], point[1], point[2])
      if not ok or not near(x, expectedX) or not near(y, expectedY) then
        problem(("%s %d at (%g, %g): expected (%.12g, %.12g), got (%s, %s)")
          :format(api[3], api[2], point[1], point[2], expectedX, expectedY, tostring(x), tostring(y)))
      end
      local sentinelOk, sx, sy = pcall(api[1], api[2], -1, -1)
      if not sentinelOk or sx ~= -1 or sy ~= -1 then
        problem(api[3] .. " " .. api[2] .. ": instance sentinel changed")
      end
    end
  end
end

-- An old transformed map may be absent or unsupported in the new comparison entirely.
for area in pairs(areaEntries) do
  if not areas[area] then problem("AreaID " .. tostring(area) .. ": helper entry has no supported DBC transform") end
end
for map in pairs(uiMapEntries) do
  if not maps[map] then problem("UiMapID " .. tostring(map) .. ": helper entry has no supported DBC transform") end
end
for _, convert in ipairs({db.EraToForever, db.EraToForeverByUiMapId}) do
  local x, y = convert(0, 12.3456789, 98.7654321)
  if x ~= 12.3456789 or y ~= 98.7654321 then problem("Unknown IDs must pass through exactly") end
  if pcall(convert, 0, -1, 20) or pcall(convert, 0, 20, -1) then
    problem("Partial instance sentinels must be rejected")
  end
end
if failures > 0 then os.exit(1) end
print(("Runtime helper matches DBC geometry for %d maps (AreaID and UiMapID)."):format(#plan))
