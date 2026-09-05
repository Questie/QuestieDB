-- Complete pinned-source fidelity plus focused import and static-correction semantics.
local config = dofile("src/config.lua")
local lib = dofile("generator/lib.lua")
local inputs = dofile("generator/l10n-inputs.lua")
-- Earlier suites can leave a LibStub mock that cannot register LibDeflate. Load this
-- offline dependency without that mock, restoring the caller's binding even on failure.
local savedLibStub = rawget(_G, "LibStub")
_G.LibStub = nil
local generatorLoaded, generator = pcall(dofile, "generator/l10n.lua")
_G.LibStub = savedLibStub
assert(generatorLoaded, generator)
local fidelity = dofile("tools/localization-overrides.lua")

---@param check fun(condition: boolean, message: string)
---@param questiePath string
---@return nil
return function(check, questiePath)
  check(rawget(_G, "LibStub") == savedLibStub, "dependency loading restores the incoming LibStub binding")
  -- A following emulator load must work without repairing this suite's mocks. Preserve
  -- nested caller state too: the entity loader normally mutates an existing Questie table.
  local savedQuestie, savedStub = rawget(_G, "Questie"), rawget(_G, "LibStub")
  local callerQuestie = { IsClassic = "caller", db = { profile = { marker = true } } }
  _G.Questie, _G.LibStub = callerQuestie, nil
  local beforeLoader, beforeLocale = rawget(_G, "QuestieLoader"), rawget(_G, "GetLocale")
  local ok, err = pcall(function()
    fidelity.run(check, questiePath)
    check(rawget(_G, "Questie") == callerQuestie and lib.deepEqual(callerQuestie,
      { IsClassic = "caller", db = { profile = { marker = true } } }),
      "fidelity sweep leaves caller Questie table and nested state untouched")
    check(rawget(_G, "QuestieLoader") == beforeLoader and rawget(_G, "GetLocale") == beforeLocale and
      rawget(_G, "LibStub") == nil, "fidelity sweep does not leave generator globals installed")
    check(pcall(dofile, "emulator/client.lua"), "emulator loads immediately after fidelity sweep")

    local failed, failure = pcall(fidelity.run, function() error("injected comparison failure", 0) end, questiePath)
    check(not failed and tostring(failure):find("injected comparison failure", 1, true) ~= nil,
      "comparison failure escapes the fidelity sweep")
    check(rawget(_G, "Questie") == callerQuestie and callerQuestie.IsClassic == "caller" and
      callerQuestie.db.profile.marker == true and rawget(_G, "QuestieLoader") == beforeLoader and
      rawget(_G, "GetLocale") == beforeLocale and rawget(_G, "LibStub") == nil,
      "failed fidelity sweep also leaves caller state untouched")
    check(pcall(dofile, "emulator/client.lua"), "emulator loads immediately after failed fidelity sweep")
  end)
  _G.Questie, _G.LibStub = savedQuestie, savedStub
  if not ok then error(err, 0) end

  -- Keep named assertions as review landmarks, in addition to the complete independent
  -- comparison. These values cover every ID listed in the work package, not just one locale.
  local zhCN, zhCorrections = inputs.load(questiePath, config.flavorByName.Wrath, "Quest", "zhCN")
  for _, rows in ipairs(zhCorrections) do generator.applyStaticCorrections(zhCN, rows) end
  local names = {
    [63866] = "驾驭圣光", [64319] = "掌握力量",
    [78752] = "死亡证明：泰坦符文协议伽马", [78753] = "死亡证明：艾泽拉斯的威胁",
    [83713] = "死亡证明：泰坦符文协议阿尔法", [83714] = "死亡证明：艾泽拉斯的威胁",
    [83717] = "死亡证明：泰坦符文协议贝塔", [87379] = "死亡证明：艾泽拉斯的威胁",
    [93975] = "拉格纳罗斯必须死！", [94577] = "凯尔萨斯必须死！", [94579] = "消灭帕奇维克！",
  }
  for id, name in pairs(names) do check(zhCN[id].name == name, "pinned zhCN quest name " .. id) end
  check(lib.deepEqual(zhCN[63866].objectivesText,
    { "对穆鲁使用微光容器以装满它，然后向银月城的骑士领主布拉德瓦罗复命。" }),
    "quest 63866 has the authored objectives")
  check(lib.deepEqual(zhCN[78752].objectivesText,
    { "达拉然的大法师兰达洛克要你从任意地下城的最终首领处取回污染者的勋章。", "", "该任务必须在泰坦符文协议伽马难度的地下城中完成。" }),
    "quest 78752 preserves the empty line inside its objective list")

  local deDE, deCorrections = inputs.load(questiePath, config.flavorByName.TBC, "Quest", "deDE")
  for _, rows in ipairs(deCorrections) do generator.applyStaticCorrections(deDE, rows) end
  for id, name in pairs({
    [95158] = "Aktuelle Wertung zurücksetzen - 2vs2",
    [95251] = "Aktuelle Wertung zurücksetzen - 3vs3",
    [95252] = "Aktuelle Wertung zurücksetzen - 5vs5",
  }) do check(deDE[id].name == name, "pinned deDE quest name " .. id) end
  local items, itemCorrections = inputs.load(questiePath, config.flavorByName.TBC, "Item", "deDE")
  for _, rows in ipairs(itemCorrections) do generator.applyStaticCorrections(items, rows) end
  check(items[185956].name == "Schimmerndes Gefäß", "pinned item 185956 name")

  -- A small import fixture exercises a future name-only override. Pinned rows currently
  -- include objectives, so a real-data-only suite would not catch accidental field merging.
  local root = ".out/test-localization-overrides"
  local flavor = config.flavorByName.Wrath
  for _, locale in ipairs(config.locales) do
    local file = inputs.lookupPath(root, flavor, inputs.types.Quest, locale)
    lib.mkdirp(file:match("^(.*)/[^/]+$"))
    lib.writeAll(file, ('local m = QuestieLoader:ImportModule("l10n")\nm.questLookup[%q] = function() return {\n' ..
      '[1] = {"Base", {"Old objectives"}}, [2] = {"Untouched", {"Keep me"}},\n' ..
      '[3] = {"  Clean\\n", "One objective"}, [4] = {"Other"},\n} end\n'):format(locale))
  end
  local override = root .. "/Localization/lookups/lookupOverrides.lua"
  os.remove(override)
  local ok, err = pcall(generator.assertInputs, root, { flavor }, { Quest = true })
  check(not ok and tostring(err):find("lookupOverrides.lua", 1, true) ~= nil,
    "preflight requires selected static translation sources")
  lib.writeAll(override, 'if GetLocale() == "deDE" then\n' ..
    'QuestieLoader:ImportModule("l10n").questLookupOverrides = function() return {\n' ..
    '[1] = {"Override"}, [9] = {"Absent", {"Not an entity"}} } end\nend\n')
  check(pcall(generator.assertInputs, root, { flavor }, { Quest = true }),
    "complete base and static translation inputs pass preflight")
  local values = generator.extract(root, flavor, "Quest", { [1] = true, [2] = true, [3] = true, [4] = true })
  local deIndex, frIndex
  for index, locale in ipairs(config.locales) do
    if locale == "deDE" then deIndex = index end
    if locale == "frFR" then frIndex = index end
  end
  check(values[1][1][deIndex] == "Override", "static translated name replaces base translation")
  check(values[1][2][deIndex] == nil, "omitted override objectives do not survive from the ordinary row")
  check(values[1][1][frIndex] == "Base" and values[1][2][frIndex][1] == "Old objectives",
    "a locale without overrides retains both ordinary fields")
  check(values[2][1][deIndex] == "Untouched" and values[2][2][deIndex][1] == "Keep me",
    "an unaffected row retains its fields")
  check(values[3][1][deIndex] == "Clean" and values[3][2][deIndex][1] == "One objective",
    "import retains existing scalar cleanup and bare-objective normalization")
  check(values[9] == nil, "an authored override cannot add an entity absent from generation")
  local base = { [1] = { name = "Base", objectivesText = { "Retained" } } }
  generator.applyStaticCorrections(base, { [1] = { name = "Local authored name" } })
  check(base[1].name == "Local authored name" and base[1].objectivesText[1] == "Retained",
    "native static corrections merge fields, independent of upstream row replacement")
  generator.applyStaticCorrections(base, { [1] = { objectivesText = false } })
  check(base[1].objectivesText == nil, "explicit static clearing removes a translation")

  -- Keep the oracle fixed while changing the actual executable inputs. These admitted IDs
  -- pass through extraction, normalization, entity filtering and the same block comparator
  -- used by the full sweep; each mutation must identify exactly its changed entity.
  lib.writeAll(root .. "/Questie-WOTLKC.toc", "Localization\\lookups\\lookupOverrides.lua\n")
  for _, locale in ipairs(config.locales) do
    local file = inputs.lookupPath(root, flavor, inputs.types.Item, locale)
    lib.mkdirp(file:match("^(.*)/[^/]+$"))
    lib.writeAll(file, ('local m = QuestieLoader:ImportModule("l10n")\n' ..
      'm.itemLookup[%q] = function() return { [1] = "Item base", [2] = "Unchanged item" } end\n'):format(locale))
  end
  local original = [[
local m = QuestieLoader:ImportModule("l10n")
if GetLocale() == "deDE" then
  m.questLookupOverrides = function() return { [1] = {"Override", {"New objectives"}} } end
  m.itemLookupOverrides = function() return { [1] = "Item override" } end
end
function Questie.LoadTitanQuestLookupOverrides() return {} end
]]
  lib.writeAll(override, original)
  local expected = {
    Quest = fidelity.lookup(root, flavor, "Quest", "deDE"),
    Item = fidelity.lookup(root, flavor, "Item", "deDE"),
  }
  local admitted, ids = { [1] = true, [2] = true, [3] = true, [4] = true }, { 1, 2, 3, 4 }
  local controls = {
    { name = "Quest addition", datatype = "Quest", field = "questLookupOverrides",
      write = 'rows[2] = {"Added", {"Objective"}}', differences = { "2" } },
    { name = "Quest removal", datatype = "Quest", field = "questLookupOverrides",
      write = 'rows[1] = nil', differences = { "1" } },
    { name = "Quest change", datatype = "Quest", field = "questLookupOverrides",
      write = 'rows[1][1] = "Changed"', differences = { "1" } },
    { name = "Quest omitted objectives", datatype = "Quest", field = "questLookupOverrides",
      write = 'rows[1][2] = nil', differences = { "1" } },
    { name = "Quest formatting", datatype = "Quest", field = "questLookupOverrides",
      write = '-- same effective rows', differences = {} },
    { name = "Quest normalized name", datatype = "Quest", field = "questLookupOverrides",
      write = 'rows[1][1] = "  Override  "', differences = {} },
    { name = "Item addition", datatype = "Item", field = "itemLookupOverrides",
      write = 'rows[2] = "Added item"', differences = { "2" } },
    { name = "Item removal", datatype = "Item", field = "itemLookupOverrides",
      write = 'rows[1] = nil', differences = { "1" } },
    { name = "Item change", datatype = "Item", field = "itemLookupOverrides",
      write = 'rows[1] = "Changed item"', differences = { "1" } },
    { name = "Item formatting", datatype = "Item", field = "itemLookupOverrides",
      write = '-- same effective rows', differences = {} },
  }
  for _, control in ipairs(controls) do
    local changed = original .. ('\nif GetLocale() == "deDE" then\nlocal previous = m.%s\n' ..
      'm.%s = function() local rows = previous(); %s\nreturn rows end\nend\n')
      :format(control.field, control.field, control.write)
    lib.writeAll(override, changed)
    local actual = generator.extract(root, flavor, control.datatype, admitted)
    local differences = fidelity.compare(generator, control.datatype, actual, expected[control.datatype], ids, deIndex)
    check(lib.deepEqual(differences, control.differences),
      control.name .. " source-to-block self-proof: " .. table.concat(differences, ", "))
  end
  lib.writeAll(override, original .. '\nm.questLookupOverrides = nil\n')
  local withoutOverrides = generator.extract(root, flavor, "Quest", admitted)
  check(lib.deepEqual(fidelity.compare(generator, "Quest", withoutOverrides, expected.Quest, ids, deIndex), { "1" }),
    "missing override source contribution is detected by the source-to-block comparison")
  lib.writeAll(override, original)

  local beforeQuestie, beforeLoader, beforeLocale = rawget(_G, "Questie"), rawget(_G, "QuestieLoader"), rawget(_G, "GetLocale")
  inputs.load(root, flavor, "Quest", "deDE")
  check(rawget(_G, "Questie") == beforeQuestie and rawget(_G, "QuestieLoader") == beforeLoader and
    rawget(_G, "GetLocale") == beforeLocale, "translation imports leave caller globals untouched")

  -- The expected Titan set is derived from the complete pinned function and the intersection
  -- of ordinary zhCN overrides with pinned Titan-added quests. Runtime tests can reuse it.
  local titan = fidelity.titan(questiePath)
  check(titan[93975].name == "拉格纳罗斯必须死！" and titan[94577].name == "凯尔萨斯必须死！" and
    titan[94579].name == "消灭帕奇维克！", "Titan oracle includes translated seasonal additions")
  check(lib.deepEqual(titan[6805].objectivesText,
    { "消灭15个大型灰尘风暴和15个大型沙漠奔行者，然后回到艾萨拉的海达克西斯公爵那儿。" }),
    "Titan oracle retains authored 6805 objectives")
end
