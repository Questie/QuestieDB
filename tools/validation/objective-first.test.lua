-- Native objective hints: flavor selection, early seasonal gates, and stable identities.
local lib = dofile("generator/lib.lua")
local config = dofile("src/config.lua")
config.correctionManifest = dofile("src/corrections/manifest.lua")
local fixture = dofile("tools/validation/correction-block.lua")
local fields = {
  "killCreditObjectiveFirst", "objectObjectiveFirst", "itemObjectiveFirst",
  "eventObjectiveFirst", "spellObjectiveFirst",
}

return function(check, equal)
  local sourceFiles = fixture.tocFiles("QuestieDB.toc")

  -- Real authored witnesses prove expansion inheritance and SoD admission.
  local vanilla, scopedNamespace, env = fixture.loadProvider(sourceFiles, "Vanilla", 0, "source")
  check(vanilla.killCreditObjectiveFirst[52] == nil, "Vanilla excludes Cata quest 52")
  check(vanilla.itemObjectiveFirst[503] == true, "Vanilla retains its own quest 503")
  local sod, sodNamespace = fixture.loadProvider(sourceFiles, "Vanilla", 2, "source")
  check(lib.deepEqual(sodNamespace.Meta.Quest, dofile("src/meta/questMeta.lua")),
    "lightweight correction loading uses the real Quest schema")
  local requiredRacesProvider
  for _, entry in ipairs(sodNamespace.Corrections.Select({ owner = "QuestieDB", datatype = "Quest", dynamic = true })) do
    if entry.name == "Sod:sodRequiredRaces" then requiredRacesProvider = entry.func end
  end
  check(type(requiredRacesProvider) == "function",
    "lightweight correction loading retains authored SoD requiredRaces registration")
  for _, id in ipairs({ 85304, 85386, 89567 }) do
    check(vanilla.eventObjectiveFirst[id] == nil, "plain Vanilla excludes SoD event " .. id)
    check(sod.eventObjectiveFirst[id] == true, "SoD includes event " .. id)
  end
  for _, flavor in ipairs({ "TBC", "Wrath", "Cata" }) do
    local hints = fixture.loadProvider(sourceFiles, flavor, 0, "source")
    for _, id in ipairs({ 10068, 10069, 10070, 10071, 10072, 10073 }) do
      check(hints.spellObjectiveFirst[id] == nil, flavor .. " excludes MoP spell " .. id)
    end
  end

  -- Titan currently has no hints. Insert a witness immediately after the real file's
  -- early guard so the negative cases cannot pass just because its table is empty.
  local cases = {
    { "Vanilla", 0, "Sod/sodQuestFixes.lua", false },
    { "Vanilla", 2, "Sod/sodQuestFixes.lua", true },
    { "Wrath", 2, "Sod/sodQuestFixes.lua", false },
    { "Forever", 2, "Sod/sodQuestFixes.lua", false },
    { "Wrath", 109, "Titan/titanReforgedQuestFixes.lua", true },
    { "Wrath", 0, "Titan/titanReforgedQuestFixes.lua", false },
    { "Vanilla", 109, "Titan/titanReforgedQuestFixes.lua", false },
    { "TBC", 109, "Titan/titanReforgedQuestFixes.lua", false },
    { "Cata", 109, "Titan/titanReforgedQuestFixes.lua", false },
    { "Mists", 109, "Titan/titanReforgedQuestFixes.lua", false },
    { "Forever", 109, "Titan/titanReforgedQuestFixes.lua", false },
  }
  -- Inject one synthetic write after each real early guard. This isolates gate behavior from
  -- the current hint inventory while retaining the provider's native environment.
  local published = scopedNamespace.ObjectiveFirst
  local identities = {}
  for _, field in ipairs(fields) do identities[field] = published[field] end
  for _, case in ipairs(cases) do
    scopedNamespace.flavor = config.flavorByName[case[1]]
    env.C_Seasons.GetActiveSeason = function() return case[2] end
    published.eventObjectiveFirst[2147483647] = nil
    local source = lib.readAll("src/corrections/" .. case[3])
    local replaced
    source, replaced = source:gsub("(then return end\n)",
      "%1LibQuestieDB.ObjectiveFirst.eventObjectiveFirst[2147483647] = true\n", 1)
    assert(replaced == 1, "seasonal file lost its early guard")
    local chunk = assert(loadstring(source, "@" .. case[3]))
    setfenv(chunk, env)("QuestieDB", scopedNamespace)
    equal(published.eventObjectiveFirst[2147483647] == true, case[4],
      case[1] .. " season " .. case[2] .. " gates hints before writes")
    check(published.itemObjectiveFirst[503] == true, "seasonal loading preserves earlier hints")
    for _, field in ipairs(fields) do
      check(published[field] == identities[field], "loading preserves " .. field .. " identity")
    end
  end
end
