-- Whole-row imported overrides and native field corrections have different clearing rules.
return function(check, equal)
  local config = dofile("src/config.lua")
  local lib = dofile("generator/lib.lua")
  local files = dofile("tools/validation/test-files.lua")
  local inputs = dofile("generator/l10n-inputs.lua")
  local savedStub = rawget(_G, "LibStub")
  _G.LibStub = nil
  local loaded, generator = pcall(dofile, "generator/l10n.lua")
  _G.LibStub = savedStub
  assert(loaded, generator)

  local root = files.temporaryDirectory()
  local ok, err = pcall(function()
    local flavor = config.flavorByName.Wrath
    local localeIndices = {}
    for index, locale in ipairs(config.locales) do
      localeIndices[locale] = index
      local path = inputs.lookupPath(root, flavor, inputs.types.Quest, locale)
      lib.mkdirp(path:match("^(.*)/[^/]+$"))
      lib.writeAll(path, ('local m = QuestieLoader:ImportModule("l10n")\n' ..
        'm.questLookup[%q] = function() return {\n' ..
        '[1] = {"Base", {"Old objectives"}}, [2] = {"Untouched", {"Keep me"}},\n' ..
        '[3] = {"  Clean\\n", "One objective"} } end\n'):format(locale))
    end
    lib.writeAll(root .. "/lookupOverrides.lua", [[
if GetLocale() == "deDE" then
  QuestieLoader:ImportModule("l10n").questLookupOverrides = function()
    return { [1] = {"Override"}, [9] = {"Absent", {"Not an entity"}} }
  end
end
]])
    local beforeQuestie, beforeLoader, beforeLocale = rawget(_G, "Questie"),
      rawget(_G, "QuestieLoader"), rawget(_G, "GetLocale")
    local values = generator.extract(root, flavor, "Quest", { [1] = true, [2] = true, [3] = true })
    local de, fr = localeIndices.deDE, localeIndices.frFR
    equal(values[1][1][de], "Override", "whole-row override replaces the translated name")
    equal(values[1][2][de], nil, "name-only override clears the base row's objectives")
    equal(values[1][1][fr], "Base", "override does not leak into another locale's name")
    equal(values[1][2][fr], { "Old objectives" }, "other locale retains its objectives")
    equal(values[2][1][de], "Untouched", "override leaves other entities' names unchanged")
    equal(values[2][2][de], { "Keep me" }, "override leaves other entities' objectives unchanged")
    equal(values[3][1][de], "Clean", "extraction cleans scalar whitespace and control bytes")
    equal(values[3][2][de], { "One objective" }, "bare objective becomes a list")
    equal(values[9], nil, "translation override cannot create an absent entity")
    check(rawget(_G, "Questie") == beforeQuestie and rawget(_G, "QuestieLoader") == beforeLoader and
      rawget(_G, "GetLocale") == beforeLocale, "extraction restores caller globals")

    local base = { [1] = { name = "Base", objectivesText = { "Retained" } } }
    generator.applyStaticCorrections(base, { [1] = { name = "Authored name" } })
    equal(base, { [1] = { name = "Authored name", objectivesText = { "Retained" } } },
      "native static correction merges fields rather than replacing a whole row")
    generator.applyStaticCorrections(base, { [1] = { objectivesText = false } })
    equal(base, { [1] = { name = "Authored name" } }, "native false explicitly clears a field")
  end)
  files.removeTree(root)
  if not ok then error(err, 0) end
end
