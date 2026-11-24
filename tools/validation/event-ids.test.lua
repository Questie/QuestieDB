-- Event membership (ADR 0017): the signed `eventIds` list on quests and NPCs, through both
-- real readers and through real Classic data in Source mode.
return function(check, equal)
  local saved = {}
  for key, value in pairs(_G) do saved[key] = value end
  local files = dofile("tools/validation/test-files.lua")
  local root = files.temporaryDirectory()
  local ok, err = pcall(function()
    _G.LibStub, _G.Enum = nil, nil
    local client = dofile("emulator/client.lua")
    local emulator = dofile("emulator/metadata.lua")
    local config = dofile("src/config.lua")
    client.install({ expansion = "Classic" })
    local fixture = dofile("tools/validation/storage-fixture.lua")
    local namespace = fixture.namespace()
    local questKeys, npcKeys = namespace.Meta.Quest.keys, namespace.Meta.Npc.keys
    local events = namespace.Enum.eventKeys

    local entities = {
      Quest = {
        [1] = { [questKeys.name] = "Holiday quest", [questKeys.eventIds] = { events.HALLOWS_END } },
        [2] = { [questKeys.name] = "Hidden during a holiday", [questKeys.eventIds] = { -events.HALLOWS_END } },
        [3] = { [questKeys.name] = "Two faire locations", [questKeys.eventIds] = { events.DARKMOON_FAIRE_ELWYNN, events.DARKMOON_FAIRE_TEROKKAR } },
        [4] = { [questKeys.name] = "Ordinary quest" },
        [5] = { [questKeys.name] = "Empty list", [questKeys.eventIds] = {} },
      },
      Npc = { [1] = { [npcKeys.name] = "Holiday vendor", [npcKeys.eventIds] = { events.WINTER_VEIL } } },
      Item = {}, Object = {},
    }
    local metadata = fixture.write(root .. "/fixture.toc", entities, {})

    for _, mode in ipairs({ "source", "baked" }) do
      local db = fixture.load(mode, entities, metadata)
      local quest, label = db.Quest, mode .. ": "
      equal(quest.eventIds(1), { 324 }, label .. "a positive event ID reads back")
      equal(quest.eventIds(2), { -324 }, label .. "a negative event ID keeps its sign")
      equal(quest.eventIds(3), { 374, 376 }, label .. "several events keep their order")
      equal(quest.eventIds(4), nil, label .. "a quest without events reads nil")
      equal(quest.eventIds(5), nil, label .. "an empty list reads nil")
      equal(db.Npc.eventIds(1), { 141 }, label .. "NPCs carry event IDs too")

      -- How a consumer evaluates the rule with the events it considers active.
      local hallowsEnd, mulgore = db.Set(events.HALLOWS_END), db.Set(events.DARKMOON_FAIRE_MULGORE)
      check(quest.HasAny(1, "eventIds", hallowsEnd) == true, label .. "an active required event matches")
      check(quest.HasAny(2, "eventIds", hallowsEnd) == false, label .. "the positive set does not match an exclusion")
      check(quest.HasAny(2, "eventIds", db.Set(-events.HALLOWS_END)) == true, label .. "the negated set matches an exclusion")
      check(quest.HasAny(3, "eventIds", mulgore) == false, label .. "a faire location the quest omits does not match")
      check(quest.HasAny(3, "eventIds", db.Set(events.DARKMOON_FAIRE_TEROKKAR)) == true, label .. "one of several locations is enough")
    end

    -- Real Classic data in Source mode.
    client.reset()
    client.install({ expansion = "Classic" })
    local source = emulator.loadAddon(config.addonName .. ".toc", config.addonName)
    equal(source.Quest.eventIds(1658), { 324 }, "source: a Hallow's End quest carries the Holidays ID")
    equal(source.Quest.eventIds(7905), { 374, 376 }, "source: the Alliance faire announcement omits Mulgore")
    equal(source.Quest.eventIds(7926), { 375, 376 }, "source: the Horde faire announcement omits Elwynn")
    equal(source.Quest.eventIds(8792), { 100001 }, "source: a war effort quest carries the QuestieDB-defined event")
    equal(source.Quest.eventIds(2), nil, "source: an ordinary quest carries no event")
    equal(source.Npc.eventIds(13418), { 141 }, "source: a Winter Veil vendor carries the event")
    equal(source.Npc.eventIds(14844), { 374, 375, 376 }, "source: a faire vendor follows every location")
    equal(source.Quest.eventIds(79501), nil, "source: a Season of Discovery quest is absent outside the season")

    -- Season of Discovery quests exist only in the season's Dynamic set.
    client.reset()
    client.install({ expansion = "Classic", season = "SoD" })
    local sod = emulator.loadAddon(config.addonName .. ".toc", config.addonName)
    equal(sod.Quest.eventIds(79501), { 141 }, "SoD: a seasonal Winter Veil quest carries the event")
    equal(sod.Quest.eventIds(79588), { 374, 375, 376 }, "SoD: a seasonal faire quest follows every location")
    client.reset()
  end)
  files.removeTree(root)
  for key in pairs(_G) do if saved[key] == nil then _G[key] = nil end end
  for key, value in pairs(saved) do _G[key] = value end
  assert(ok, err)
end
