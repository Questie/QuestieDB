-- Full-addon seasonal admission and locale lifecycle, independently of generator fixtures.
---@param check fun(condition: boolean, message: string)
---@param equal fun(actual: any, expected: any, message: string)
---@param questiePath string Pinned Questie checkout used by the independent translation oracle.
---@return nil
return function(check, equal, questiePath)
  local lib = dofile("generator/lib.lua")
  lib.assertQuestiePin(questiePath)
  local oracle = dofile("tools/localization-overrides.lua").titan(questiePath)
  local meta = dofile("src/meta/questMeta.lua")

  -- Capture the complete declaration through its public interface in a private environment.
  -- Expected IDs and fields come from upstream, not from the literal spot checks below.
  local declarations = {}
  local db = { flavor = { expansion = "Wotlk" }, Meta = { Quest = meta }, l10n = {} }
  ---@param owner string
  ---@param locale string
  ---@param datatype string
  ---@param name string
  ---@param rows table
  ---@return nil
  function db.l10n.SetCorrection(owner, locale, datatype, name, rows)
    local namedRows = {}
    for id, fields in pairs(rows) do
      local namedFields = {}
      for key, value in pairs(fields) do namedFields[meta.names[key] or key] = value end
      namedRows[id] = namedFields
    end
    declarations[#declarations + 1] = {
      owner = owner, locale = locale, datatype = datatype, name = name, rows = namedRows,
    }
  end
  local env = setmetatable({
    C_Seasons = { GetActiveSeason = function() return 109 end },
  }, { __index = _G })
  env._G = env
  local declaration = assert(loadfile("src/l10n/Titan/zhCN.lua"))
  setfenv(declaration, env)
  declaration("QuestieTDB", db)
  equal(declarations, {
    { owner = "QuestieTDB", locale = "zhCN", datatype = "Quest", name = "Titan:zhCN", rows = oracle },
  }, "complete Titan declaration matches every pinned translated ID and field")

  local emulator = dofile("emulator/metadata.lua")
  local savedLibStub = rawget(_G, "LibStub")
  _G.LibStub = nil
  local ok, client = pcall(dofile, "emulator/client.lua")
  _G.LibStub = savedLibStub
  assert(ok, client)
  local expected = {
    [6805] = "大雷暴和巨磐石", [7787] = "昔日的传奇", [8184] = "愤怒预言",
    [8185] = "调和预言", [8186] = "死亡预言", [8187] = "猎鹰化身",
    [8188] = "巫毒预言", [8189] = "奥术师预言", [8190] = "妖术预言",
    [8191] = "光晕预言", [8192] = "万灵预言", [93975] = "拉格纳罗斯必须死！",
    [94577] = "凯尔萨斯必须死！", [94579] = "消灭帕奇维克！",
  }
  local modes = { { name = "Source", toc = "QuestieTDB.toc" } }
  if lib.fileExists("QuestieTDB_Wrath.toc") and
      lib.readAll("QuestieTDB_Wrath.toc"):gsub("\\", "/"):find("src/l10n/Titan/zhCN.lua", 1, true) then
    modes[#modes + 1] = { name = "Baked", toc = "QuestieTDB_Wrath.toc" }
  else
    io.write("  SKIP titan-translations Baked: Wrath artifact absent or needs new runtime file list\n")
  end
  for _, mode in ipairs(modes) do
    for _, initialLocale in ipairs({ "enUS", "zhCN" }) do
      client.reset()
      client.install({ expansion = "Wotlk", season = "TitanReforged", locale = initialLocale })
      emulator.install("QuestieTDB", emulator.parse(mode.toc))
      local db = emulator.loadAddon(mode.toc, "QuestieTDB")
      local label = mode.name .. " initially " .. initialLocale .. ": "
      if mode.name == "Source" then
        check(db.read.source.entities.Quest == nil and db.read.source.entities.Npc == nil,
          label .. "translation registration preserves lazy Source entity initialization")
      end
      equal(db.l10n.currentLocale, initialLocale, label .. "client locale selected")
      db.l10n.SetLocale("enUS")
      local english = db.Quest.name(6805)
      check(english ~= nil and english ~= expected[6805], label .. "English Titan correction remains English")
      db.l10n.SetLocale("zhCN")
      for id, fields in pairs(oracle) do
        for field, value in pairs(fields) do
          equal(db.Quest.Get(id, field), value, label .. "pinned Titan field " .. id .. "." .. field)
        end
      end
      for id, name in pairs(expected) do
        equal(db.Quest.name(id), name, label .. "Titan translation " .. id)
        equal(db.GetProvenance("Quest", id, "name"), "QuestieTDB", label .. "Titan provenance " .. id)
      end
      equal(db.Quest.objectivesText(6805),
        { "消灭15个大型灰尘风暴和15个大型沙漠奔行者，然后回到艾萨拉的海达克西斯公爵那儿。" }, label .. "6805 objectives")
      equal(db.Quest.objectivesText(7787), { "寻找对休眠之刃有所了解的人。" }, label .. "7787 objectives")
      equal(db.Quest.objectivesText(93975), { "团队消灭拉格纳罗斯。" }, label .. "93975 objectives")
      equal(db.Quest.objectivesText(94577), { "消灭风暴要塞的凯尔萨斯逐日者。" }, label .. "94577 objectives")
      equal(db.Quest.objectivesText(94579), { "消灭纳克萨玛斯的帕奇维克。" }, label .. "94579 objectives")
      -- An ordinary non-English locale must not inherit the previous seasonal translation.
      -- This Titan-added entity has no base block row, so its corrected English text wins.
      db.l10n.SetLocale("enUS")
      local titanEnglish = db.Quest.name(93975)
      db.l10n.SetLocale("deDE")
      equal(db.Quest.name(93975), titanEnglish, label .. "deDE falls back for Titan-only entity")
      equal(db.l10n.GetProvenance("Quest", 93975, "name"), nil, label .. "deDE has no Titan translation owner")
      db.l10n.SetLocale("zhCN")
      equal(db.Quest.name(93975), expected[93975], label .. "returning from deDE restores Titan translation")
      local keys = db.Meta.Quest.keys
      db.l10n.SetCorrection("Consumer", "zhCN", "Quest", "name", { [6805] = { [keys.name] = "Consumer translation" } })
      db.l10n.SetLocale("enUS")
      equal(db.Quest.name(6805), english, label .. "leaving zhCN restores English Titan value")
      db.l10n.SetLocale("zhCN")
      equal(db.Quest.name(6805), "Consumer translation", label .. "consumer priority survives locale switch")
      db.l10n.SetCorrection("Consumer", "zhCN", "Quest", "name", nil)
      equal(db.Quest.name(6805), expected[6805], label .. "withdrawal restores built-in translation")
      db.l10n.SetCorrection("QuestieTDB", "zhCN", "Quest", "Titan:zhCN", nil)
      check(db.Quest.name(6805) ~= expected[6805], label .. "withdrawing Titan translation reveals fallback")
      db.l10n.SetLocale("enUS")
      db.l10n.SetLocale("zhCN")
      check(db.Quest.name(6805) ~= expected[6805], label .. "locale callbacks do not resurrect withdrawn translation")
    end
  end

  -- Check registration directly for every inapplicable persona, without loading whole datasets.
  -- The declaration's only dependency is the public translation interface and character facts.
  local personas = {
    { expansion = "Classic", season = 109 }, { expansion = "TBC", season = 109 },
    { expansion = "Wotlk", season = 0 }, { expansion = "Wotlk", season = 2 },
    { expansion = "Wotlk", season = 99 }, { expansion = "Cata", season = 109 },
    { expansion = "MoP", season = 109 },
  }
  for _, persona in ipairs(personas) do
    client.reset()
    client.install(persona)
    C_Seasons.GetActiveSeason = function() return persona.season end
    local calls = 0
    local db = { flavor = { expansion = persona.expansion },
      l10n = { SetCorrection = function() calls = calls + 1 end } }
    assert(loadfile("src/l10n/Titan/zhCN.lua"))("QuestieTDB", db)
    equal(calls, 0, persona.expansion .. " season " .. persona.season .. " rejects Titan translations")
  end
  client.reset()
end
