-- Fixed expectations exercise both real readers, not just agreement between them.
return function(check, equal)
  -- Client installation replaces globals. Preserve the entire caller environment, including
  -- globals absent on entry, and avoid mutating its nested Enum/C_AddOns tables.
  local saved = {}
  for key, value in pairs(_G) do saved[key] = value end
  local files = dofile("tools/validation/test-files.lua")
  local root = files.temporaryDirectory()
  local ok, err = pcall(function()
    _G.LibStub, _G.Enum = nil, nil
    local client = dofile("emulator/client.lua")
    client.install({ expansion = "Classic" })
    local fixture = dofile("tools/validation/storage-fixture.lua")
    local cases = dofile("tools/validation/storage-cases.lua")
    local namespace = fixture.namespace()
    local meta, dbConfig = namespace.Meta, namespace.config
    local entities = { Quest = {}, Npc = {}, Item = {}, Object = {} }
    for id, case in ipairs(cases) do
      local entity = case.entity or "Quest"
      entities[entity][id] = { [meta[entity].keys[case.field]] = case.input }
    end

    -- Fixed synthetic boundaries complement observed data: only-default, scalar-only,
    -- table-only and values large enough to require real TOC chunking.
    local keys = meta.Quest.keys
    local longText = string.rep("Long multilingual text ä中 ", 100)
    local longList = {}
    for index = 1, 500 do longList[index] = index end
    entities.Quest[9001] = {}
    entities.Quest[9002] = { [keys.name] = "Scalar only" }
    entities.Quest[9003] = { [keys.inGroupWith] = {7,8} }
    entities.Quest[9004] = { [keys.name] = longText, [keys.inGroupWith] = longList }
    entities.Quest[9005] = { [keys.name] = "Nested objective", [keys.objectives] = {{{6}}} }
    entities.Item[9000] = { [meta.Item.keys.name] = "English item" }
    entities.Item[9001] = { [meta.Item.keys.name] = "English fallback" }
    -- Translate by entity ID through the real column builder. Neither ID equals its stored
    -- position, so confusing those two addresses cannot accidentally return the right value.
    local deDE
    for index, locale in ipairs(dbConfig.locales) do if locale == "deDE" then deDE = index end end
    local metadata = fixture.write(root .. "/fixture.toc", entities, {
      Item = { [9000] = { [1] = { [deDE] = "Übersetzung" } } },
      Quest = { [9005] = { [1] = { [deDE] = "Übersetzte Quest" }, [2] = { [deDE] = {"Ziel", ""} } } },
    })
    check(metadata["X-Quest-9004-S"]:match("^~%d+~$") ~= nil, "long scalar row actually uses chunks")
    check(metadata["X-Quest-9004-" .. keys.inGroupWith]:match("^~%d+~$") ~= nil, "long table actually uses chunks")
    equal(metadata["X-Quest-9001-S"], nil, "all-default entity has no stored row")

    for _, mode in ipairs({ "source", "baked" }) do
      local db = fixture.load(mode, entities, metadata)
      local label = mode .. ": "
      for id, case in ipairs(cases) do
        local entity = db[case.entity or "Quest"]
        equal(entity.Get(id, case.field), case.expected, label .. case.name)
        equal(entity[case.field](id), case.expected, label .. case.name .. " named getter")
      end

      local quest = db.Quest
      equal(quest.GetByIndex(9002, keys.name), "Scalar only", label .. "positional read")
      equal(quest.GetAll(9002, {"name", "triggerEnd", "requiredLevel"}),
        { [1] = "Scalar only", [3] = 0, n = 3 }, label .. "packed read retains nil holes")
      equal(quest.Exists(9001), true, label .. "default-only entity exists")
      equal(quest.requiredLevel(9001), 0, label .. "known missing number defaults to zero")
      equal(quest.objectives(9001), {}, label .. "known missing structure defaults to a table")
      equal(quest.Exists(999999), false, label .. "unknown entity does not exist")
      equal(quest.requiredLevel(999999), nil, label .. "unknown number is not zero")
      equal(quest.objectives(999999), nil, label .. "unknown structure is not an empty table")
      equal(quest.inGroupWith(9003), {7,8}, label .. "table-only row reads through presence mask")
      equal(quest.name(9004), longText, label .. "chunked scalar round trip")
      equal(quest.inGroupWith(9004), longList, label .. "chunked table round trip")
      local owned = quest.inGroupWith(9004)
      owned[1] = -1
      equal(quest.inGroupWith(9004)[1], 1, label .. "cached table reads remain caller-owned")
      local nested = quest.objectives(9005)
      nested[1][1][1] = -1
      equal(quest.objectives(9005), {{{6,nil,0}}}, label .. "nested objective copies are independent")
      local raw = quest.GetRaw(9005, "objectives")
      raw[1][1][1] = -1
      equal(quest.GetRaw(9005, "objectives"), {{{6,nil,0}}}, label .. "raw nested reads remain caller-owned")
      equal(quest.objectives(9005), {{{6,nil,0}}}, label .. "raw mutation leaves cached reads unchanged")

      -- Warm caches before changing a slot; withdrawal must reveal the untouched base.
      db.SetCorrection("Fixture", "Quest", "change", {
        [9002] = { [keys.name] = {} },
        [9005] = { [keys.objectives] = {} },
        [9100] = { [keys.name] = "Added", [keys.inGroupWith] = {9} },
      })
      equal(quest.name(9002), nil, label .. "correction clears a cached scalar")
      equal(quest.objectives(9005), {}, label .. "clearing populated objectives invalidates the cached structure")
      equal(quest.name(9100), "Added", label .. "correction adds a readable entity")
      equal(quest.GetAllIds(true)[9100], true, label .. "added entity is enumerable")
      local corrected = quest.inGroupWith(9100)
      corrected[1] = -1
      corrected[2] = 10
      equal(quest.inGroupWith(9100), {9}, label .. "correction-return mutations never reach the overlay")
      db.SetCorrection("Fixture", "Quest", "change", nil)
      equal(quest.name(9002), "Scalar only", label .. "withdrawal invalidates scalar cache")
      equal(quest.objectives(9005), {{{6,nil,0}}}, label .. "withdrawal restores the populated base structure")
      equal(quest.Exists(9100), false, label .. "withdrawal removes correction-only entity")
      equal(quest.GetAllIds(true)[9100], nil, label .. "withdrawal invalidates enumeration")
      equal(quest.inGroupWith(9100), nil, label .. "withdrawn entity has no table read")

      -- Only Baked has ordinary Base translations. Both retain fallback and locale lifecycle.
      db.l10n.SetLocale("deDE")
      if mode == "baked" then
        equal(db.Item.name(9000), "Übersetzung", "baked: compressed translation column uses sorted ID position")
        equal(quest.GetAll(9005, {"name", "objectivesText"}),
          {"Übersetzte Quest", {"Ziel", ""}, n = 2}, "baked: compressed scalar and list translations")
        local translated = quest.objectivesText(9005)
        translated[1] = "mutation"
        equal(quest.objectivesText(9005), {"Ziel", ""}, "baked: decoded translated lists remain caller-owned")
      else
        equal(db.Item.name(9000), "English item", "source: ordinary Base translation is absent")
        equal(quest.objectivesText(9005), nil, "source: ordinary translated list is absent")
      end
      equal(db.Item.name(9001), "English fallback", label .. "missing translation falls back")
      db.l10n.SetLocale("enUS")
      equal(db.Item.name(9000), "English item", label .. "locale switch drops translated scalar cache")
      equal(quest.objectivesText(9005), nil, label .. "locale switch drops translated list cache")
    end
  end)
  for key in pairs(_G) do if saved[key] == nil then _G[key] = nil end end
  for key, value in pairs(saved) do _G[key] = value end
  files.removeTree(root)
  assert(ok, err)
end
