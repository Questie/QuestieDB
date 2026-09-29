-- Canonical values and literal expected unions, independent of TablePatch and normalization.
-- One field per shape is enough except giver/objective groups, which have positional semantics.
local shapes = {
  { shape = "idarray", entity = "Item", field = "relatedQuests",
    a = {11}, b = {22}, combined = {11, 22} },
  { shape = "stringarray", field = "objectivesText",
    a = {"first"}, b = {"second"}, combined = {"first", "second"} },
  { shape = "pair", field = "requiredSkill", atomic = true,
    a = {164, 75}, b = {164, 150} },
  { shape = "pairs", field = "reputationReward",
    a = {{72, 100}}, b = {{72, 200}}, combined = {{72, 100}, {72, 200}} },
  { shape = "questgivers", variant = "npc", field = "startedBy", empty = {},
    a = {[1] = {11}}, b = {[1] = {22}}, combined = {[1] = {11, 22}} },
  { shape = "questgivers", variant = "object", field = "startedBy", empty = {},
    a = {[2] = {11}}, b = {[2] = {22}}, combined = {[2] = {11, 22}} },
  { shape = "questgivers", variant = "item", field = "startedBy", empty = {},
    a = {[3] = {11}}, b = {[3] = {22}}, combined = {[3] = {11, 22}} },
  { shape = "objectives", variant = "creature", field = "objectives", empty = {},
    a = {[1] = {{11, "first", 0}}}, b = {[1] = {{22, "second", 1}}},
    combined = {[1] = {{11, "first", 0}, {22, "second", 1}}} },
  { shape = "objectives", variant = "object", field = "objectives", empty = {},
    a = {[2] = {{11, "first", 0}}}, b = {[2] = {{22, "second", 1}}},
    combined = {[2] = {{11, "first", 0}, {22, "second", 1}}} },
  { shape = "objectives", variant = "item", field = "objectives", empty = {},
    a = {[3] = {{11, "first", 0}}}, b = {[3] = {{22, "second", 1}}},
    combined = {[3] = {{11, "first", 0}, {22, "second", 1}}} },
  { shape = "objectives", variant = "reputation", field = "objectives", atomic = true, empty = {},
    a = {[4] = {72, 3000}}, b = {[4] = {72, 9000}} },
  { shape = "objectives", variant = "kill-credit", field = "objectives", empty = {},
    a = {[5] = {{{11, 12}, 13, "first", 0}}}, b = {[5] = {{{11, 12}, 14, "second", 1}}},
    combined = {[5] = {{{11, 12}, 13, "first", 0}, {{11, 12}, 14, "second", 1}}} },
  { shape = "objectives", variant = "spell", field = "objectives", empty = {},
    a = {[6] = {{11, "first", 0}}}, b = {[6] = {{22, "second", 33}}},
    combined = {[6] = {{11, "first", 0}, {22, "second", 33}}} },
  { shape = "spawnlist", entity = "Npc", field = "spawns",
    a = {[12] = {{1, 2}}}, b = {[12] = {{3, 4, 5}}},
    combined = {[12] = {{1, 2}, {3, 4, 5}}} },
  { shape = "waypointlist", entity = "Object", field = "waypoints",
    a = {[12] = {{{1, 2}, {1, 2}}}}, b = {[12] = {{{3, 4}, {5, 6}}}},
    combined = {[12] = {{{1, 2}, {1, 2}}, {{3, 4}, {5, 6}}}} },
  { shape = "trigger", field = "triggerEnd", atomic = true,
    a = {"first", {[12] = {{1, 2}}}}, b = {"second", {[12] = {{3, 4}}}} },
  { shape = "extraobjectives", field = "extraObjectives",
    a = {{nil, 3, "first", 0, {{"monster", 11}}}},
    b = {{{[12] = {{3, 4}}}, 4, "second", 1, {{"object", 22}, {"item", 33}}}},
    combined = {
      {nil, 3, "first", 0, {{"monster", 11}}},
      {{[12] = {{3, 4}}}, 4, "second", 1, {{"object", 22}, {"item", 33}}},
    } },
}

local cases = {}
for _, shape in ipairs(shapes) do
  -- Expected values reference the literals above, never an operation or normalizer result.
  local scenarios = {
    { name = "add missing", add = shape.a, expected = shape.a },
    { name = "add existing", base = shape.a, add = shape.b,
      expected = shape.atomic and shape.a or shape.combined,
      error = shape.atomic and "different atomic value already exists" or nil },
    { name = "add duplicate", base = shape.a, add = shape.a, expected = shape.a },
    { name = "remove missing field", remove = shape.a, expected = shape.empty },
    { name = "remove absent member", base = shape.a, remove = shape.b, expected = shape.a },
    { name = "remove final member", base = shape.a, remove = shape.a, expected = shape.empty },
    { name = "replace missing", replace = shape.a, expected = shape.a },
    { name = "replace existing", base = shape.a, replace = shape.b, expected = shape.b },
    { name = "clear missing", replace = {}, expected = shape.empty },
    { name = "clear existing", base = shape.a, replace = {}, expected = shape.empty },
    { name = "empty add missing", add = {}, expected = shape.empty },
    { name = "empty add existing", base = shape.a, add = {}, expected = shape.a },
    { name = "empty remove missing", remove = {}, expected = shape.empty },
    { name = "empty remove existing", base = shape.a, remove = {}, expected = shape.a },
  }
  if shape.combined then
    scenarios[#scenarios + 1] = {
      name = "remove member", base = shape.combined, remove = shape.b, expected = shape.a,
    }
  end
  for _, scenario in ipairs(scenarios) do
    scenario.shape, scenario.field, scenario.entity = shape.shape, shape.field, shape.entity
    scenario.label = shape.shape .. (shape.variant and "/" .. shape.variant or "") .. ": " .. scenario.name
    cases[#cases + 1] = scenario
  end
end
return cases
