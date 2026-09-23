-- Run from the repository root: lua5.1 src/support/eraToForever.test.lua
local db = {}
assert(loadfile("src/support/eraToForever.lua"))("QuestieDB", db)

local function nearPoint(x, y, expectedX, expectedY, label)
  assert(math.abs(x - expectedX) < 1e-10, label .. ": X differs")
  assert(math.abs(y - expectedY) < 1e-10, label .. ": Y differs")
end

-- Fixed projections from the reviewed DBC comparison, not the helper's coefficient table.
local cases = {
  { "Mulgore", 215, 1412, 20, 80, 23.703457245288803, 79.94921908105827 },
  { "Mulgore", 215, 1412, 80, 20, 73.79146965494468, 29.852709728196075 },
  { "Eastern Plaguelands", 139, 1423, 20, 80, 16.348662780165114, 68.25581926146657 },
  { "Eastern Plaguelands", 139, 1423, 80, 20, 70.33412903539187, 14.229667715562108 },
  { "Redridge", 44, 1433, 20, 80, 14.913618667939275, 80 },
  { "Redridge", 44, 1433, 80, 20, 74.91359842442257, 20 },
  { "Stormwind", 1519, 1453, 20, 80, 35.154034416632925, 86.33943716593319 },
  { "Stormwind", 1519, 1453, 80, 20, 81.57478872773687, 39.90982514711585 },
  { "Hawkwind", 215, 1412, 44.18, 76.06, 43.888926246380116, 76.65954830022032 },
}
for _, case in ipairs(cases) do
  local x, y = db.EraToForever(case[2], case[4], case[5])
  nearPoint(x, y, case[6], case[7], case[1] .. " AreaID")
  x, y = db.EraToForeverByUiMapId(case[3], case[4], case[5])
  nearPoint(x, y, case[6], case[7], case[1] .. " UiMapID")
end

local function unchanged(convert, id, x, y)
  local actualX, actualY = convert(id, x, y)
  assert(actualX == x and actualY == y, "Expected exact passthrough for " .. id)
end
unchanged(db.EraToForever, 12, 12.3456789, 98.7654321) -- Elwynn
unchanged(db.EraToForeverByUiMapId, 1429, 12.3456789, 98.7654321)
unchanged(db.EraToForever, 999999, 12.3456789, 98.7654321)
unchanged(db.EraToForeverByUiMapId, 999999, 12.3456789, 98.7654321)
unchanged(db.EraToForever, 220, 20, 80) -- Red Cloud Mesa is not a declared point frame.
unchanged(db.EraToForever, 1412, 20, 80) -- Never guess the other ID namespace.
unchanged(db.EraToForeverByUiMapId, 215, 20, 80)
unchanged(db.EraToForever, 215, -1, -1)
unchanged(db.EraToForeverByUiMapId, 1412, -1, -1)
unchanged(db.EraToForever, 1581, -1, -1) -- Instance presence outside the changed maps.

local x, y = db.EraToForever(44, 0, 0)
nearPoint(x, y, -5.086374584221827, 0, "Real zero point is transformed without clamping")
assert(not pcall(db.EraToForever, 215, -1, 20), "Partial X sentinel must fail")
assert(not pcall(db.EraToForeverByUiMapId, 1412, 20, -1), "Partial Y sentinel must fail")
assert(not pcall(db.EraToForever, 12, -1, 20), "Unchanged maps still reject partial sentinels")

-- The helper must ship in both modes, regardless of the active client flavor.
local config = dofile("src/config.lua")
local function includesHelper(files)
  local count = 0
  for _, path in ipairs(files) do
    if path == "src/support/eraToForever.lua" then count = count + 1 end
  end
  assert(count == 1, "Addon file list must load the coordinate helper exactly once")
end
for _, flavor in ipairs(config.flavors) do
  includesHelper(config.sourceFileList(flavor))
  includesHelper(config.bakedFileList(flavor))
end
print("Era-to-Forever coordinate helpers passed")
