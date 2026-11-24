-- List membership helpers (ADR 0017): `LibQuestieDB.Set` and `Entity.HasAny`, through both
-- real readers.
return function(check, equal)
  local saved = {}
  for key, value in pairs(_G) do saved[key] = value end
  local files = dofile("tools/validation/test-files.lua")
  local root = files.temporaryDirectory()
  local ok, err = pcall(function()
    _G.LibStub, _G.Enum = nil, nil
    local client = dofile("emulator/client.lua")
    client.install({ expansion = "Classic" })
    local fixture = dofile("tools/validation/storage-fixture.lua")
    local keys = fixture.namespace().Meta.Quest.keys

    local entities = {
      Quest = {
        [10] = { [keys.name] = "Two members", [keys.exclusiveTo] = { 7, 9 } },
        [11] = { [keys.name] = "Signed member", [keys.preQuestGroup] = { -7 } },
        [12] = { [keys.name] = "No list" },
      },
      Npc = {}, Item = {}, Object = {},
    }
    local metadata = fixture.write(root .. "/fixture.toc", entities, {})

    for _, mode in ipairs({ "source", "baked" }) do
      local db = fixture.load(mode, entities, metadata)
      local quest = db.Quest
      local label = mode .. ": "

      equal(db.Set(7, nil, 9), { [7] = true, [9] = true }, label .. "Set skips nil arguments")
      equal(db.Set(), {}, label .. "Set without arguments is empty")

      check(quest.HasAny(10, "exclusiveTo", db.Set(9)) == true, label .. "one wanted value matches")
      check(quest.HasAny(10, "exclusiveTo", db.Set(1, 2, 7)) == true, label .. "any wanted value is enough")
      check(quest.HasAny(10, "exclusiveTo", db.Set(8)) == false, label .. "an absent value does not match")
      check(quest.HasAny(10, keys.exclusiveTo, db.Set(9)) == true, label .. "positional field index works")
      check(quest.HasAny(10, "exclusiveTo", {}) == false, label .. "an empty set never matches")

      check(quest.HasAny(11, "preQuestGroup", db.Set(-7)) == true, label .. "a signed ID matches its own sign")
      check(quest.HasAny(11, "preQuestGroup", db.Set(7)) == false, label .. "a signed ID does not match the other sign")

      check(quest.HasAny(12, "exclusiveTo", db.Set(7)) == false, label .. "an entity without the list")
      check(quest.HasAny(999, "exclusiveTo", db.Set(7)) == false, label .. "an unknown entity")
      check(quest.HasAny(10, "name", db.Set("Two members")) == false, label .. "a scalar field")
      -- Structured fields are not flat lists; retaining them per entity would hold the database.
      check(quest.HasAny(10, "objectives", db.Set(7)) == false, label .. "a structured table field")
      check(quest.HasAny(10, "noSuchField", db.Set(7)) == false, label .. "an unknown field")
      check(quest.HasAny(10, "exclusiveTo", nil) == false, label .. "a missing set")
      check(quest.HasAny("10", "exclusiveTo", db.Set(7)) == false, label .. "a non-numeric ID")

      -- The check runs over a list the database retains; a caller's copy must not reach it.
      local owned = quest.exclusiveTo(10)
      owned[1], owned[2] = 100, 200
      check(quest.HasAny(10, "exclusiveTo", db.Set(7)) == true, label .. "mutating a read copy leaves membership intact")
      check(quest.HasAny(10, "exclusiveTo", db.Set(100)) == false, label .. "a caller's value never joins the list")

      -- A Correction must be visible to the next check, not masked by the retained list.
      local registrar = db.GetRegistrar("ListMembershipTest")
      registrar.Set("Quest", "members", { [10] = { [keys.exclusiveTo] = { 42 } }, [12] = { [keys.exclusiveTo] = { 7 } } })
      check(quest.HasAny(10, "exclusiveTo", db.Set(42)) == true, label .. "a corrected list is checked")
      check(quest.HasAny(10, "exclusiveTo", db.Set(7)) == false, label .. "the replaced list no longer matches")
      check(quest.HasAny(12, "exclusiveTo", db.Set(7)) == true, label .. "a list added by a Correction matches")
      registrar.Set("Quest", "members", nil)
      check(quest.HasAny(10, "exclusiveTo", db.Set(7)) == true, label .. "withdrawing the Correction restores the base list")

      quest.InvalidateCache(10)
      check(quest.HasAny(10, "exclusiveTo", db.Set(9)) == true, label .. "membership survives a cache invalidation")
    end
  end)
  files.removeTree(root)
  for key in pairs(_G) do if saved[key] == nil then _G[key] = nil end end
  for key, value in pairs(saved) do _G[key] = value end
  assert(ok, err)
end
