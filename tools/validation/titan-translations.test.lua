-- Full-addon seasonal admission and locale lifecycle with two representative translations.
return function(check, equal, modeScope)
  local lib = dofile("generator/lib.lua")
  local emulator = dofile("emulator/metadata.lua")
  local savedLibStub = rawget(_G, "LibStub")
  _G.LibStub = nil
  local ok, client = pcall(dofile, "emulator/client.lua")
  _G.LibStub = savedLibStub
  assert(ok, client)
  local expected = { [6805] = "大雷暴和巨磐石", [93975] = "拉格纳罗斯必须死！" }
  local modes = modeScope == "Baked" and {} or { { name = "Source", toc = "QuestieDB.toc" } }
  if modeScope ~= "Source" then
    if lib.fileExists("QuestieDB_Wrath.toc") then
      assert(lib.readAll("QuestieDB_Wrath.toc"):gsub("\\", "/"):find("src/l10n/Titan/zhCN.lua", 1, true),
        "Wrath artifact needs the Titan translation runtime file")
      modes[#modes + 1] = { name = "Baked", toc = "QuestieDB_Wrath.toc" }
    else
      io.write("  SKIP titan-translations Baked: Wrath artifact absent or needs new runtime file list\n")
    end
  end
  for _, mode in ipairs(modes) do
    for _, initialLocale in ipairs({ "enUS", "zhCN" }) do
      client.reset()
      client.install({ expansion = "Wotlk", season = "TitanReforged", locale = initialLocale })
      emulator.install("QuestieDB", emulator.parse(mode.toc))
      local db = emulator.loadAddon(mode.toc, "QuestieDB")
      local label = mode.name .. " initially " .. initialLocale .. ": "
      if mode.name == "Source" then
        check(db.read.source.entities.Quest == nil and db.read.source.entities.Npc == nil and
          db.read.source.entities.Item == nil and db.read.source.entities.Object == nil,
          label .. "translation registration preserves lazy Source entity initialization")
      end
      equal(db.l10n.currentLocale, initialLocale, label .. "client locale selected")
      db.l10n.SetLocale("enUS")
      local english = db.Quest.name(6805)
      check(english ~= nil and english ~= expected[6805], label .. "English Titan correction remains English")
      db.l10n.SetLocale("zhCN")
      for id, name in pairs(expected) do
        equal(db.Quest.name(id), name, label .. "Titan translation " .. id)
        equal(db.GetProvenance("Quest", id, "name"), "QuestieDB", label .. "Titan provenance " .. id)
      end
      equal(db.Quest.objectivesText(6805),
        { "消灭15个大型灰尘风暴和15个大型沙漠奔行者，然后回到艾萨拉的海达克西斯公爵那儿。" }, label .. "6805 objectives")
      equal(db.Quest.objectivesText(93975), { "团队消灭拉格纳罗斯。" }, label .. "93975 objectives")
      equal(db.Quest.name(8184), "愤怒预言", label .. "8184 authored Titan name")
      -- Every translatable entity type registers from the same seasonal zhCN set.
      local npcExpected = { [80007] = "？", [256887] = "大型灰尘风暴", [257012] = "观察者奥尔加隆" }
      for id, name in pairs(npcExpected) do
        equal(db.Npc.name(id), name, label .. "Titan NPC " .. id)
        equal(db.GetProvenance("Npc", id, "name"), "QuestieDB", label .. "Titan NPC provenance " .. id)
      end
      -- Titan remaps items 268145/274994, so their names follow the Titan English text.
      local itemExpected = { [264272] = "天界信函", [268145] = "打孔的巫毒人偶", [274994] = "原始哈卡莱神像" }
      for id, name in pairs(itemExpected) do
        equal(db.Item.name(id), name, label .. "Titan Item " .. id)
        equal(db.GetProvenance("Item", id, "name"), "QuestieDB", label .. "Titan Item provenance " .. id)
      end
      equal(db.Object.name(420002), "血之祭坛", label .. "Titan Object name")
      equal(db.GetProvenance("Object", 420002, "name"), "QuestieDB", label .. "Titan Object provenance")
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
      db.l10n.SetCorrection("QuestieDB", "zhCN", "Quest", "Titan:zhCN", nil)
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
  -- The declaration's only dependencies are the public translation interface, the schema keys,
  -- and character facts. Stub those so registration can be counted without loading datasets.
  local stubKeys = { name = 1, objectivesText = 2, subName = 3 }
  local stubMeta = { Quest = { keys = stubKeys }, Npc = { keys = stubKeys },
    Item = { keys = stubKeys }, Object = { keys = stubKeys } }
  local function registrations(persona)
    client.reset()
    client.install(persona)
    C_Seasons.GetActiveSeason = function() return persona.season end
    local seen = {}
    local db = { flavor = { expansion = persona.expansion }, Meta = stubMeta,
      l10n = { SetCorrection = function(_, _, datatype) seen[#seen + 1] = datatype end } }
    assert(loadfile("src/l10n/Titan/zhCN.lua"))("QuestieDB", db)
    return seen
  end
  for _, persona in ipairs(personas) do
    equal(#registrations(persona), 0,
      persona.expansion .. " season " .. persona.season .. " rejects Titan translations")
  end
  local active = registrations({ expansion = "Wotlk", season = 109 })
  equal(#active, 4, "Titan season 109 registers one slot per entity type")
  equal(table.concat(active, ","), "Quest,Npc,Item,Object",
    "Titan season 109 registers all four entity types")
  client.reset()
end
