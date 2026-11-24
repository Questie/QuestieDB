-- Object entity facts (ADR 0017): `services`, `requiredFaction`, and the deprecated
-- `factionID`, through both real readers.
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
    local namespace = fixture.namespace()
    local keys = namespace.Meta.Object.keys
    local services = namespace.Enum.serviceKeys

    local entities = {
      Quest = {}, Npc = {}, Item = {},
      Object = {
        [1] = { [keys.name] = "Alliance mailbox", [keys.services] = { services.MAILBOX }, [keys.requiredFaction] = "A" },
        [2] = { [keys.name] = "Shared mailbox", [keys.services] = { services.MAILBOX }, [keys.requiredFaction] = "AH" },
        [3] = { [keys.name] = "Anvil and forge", [keys.services] = { services.ANVIL, services.FORGE } },
        -- A stale source value in the retired column must never be served or stored.
        [4] = { [keys.name] = "Old faction data", [keys.factionID] = 12, [keys.requiredFaction] = "H" },
        [5] = { [keys.name] = "Empty spellings", [keys.services] = {}, [keys.requiredFaction] = "" },
      },
    }
    local metadata = fixture.write(root .. "/fixture.toc", entities, {})
    equal(metadata["X-Object-2-S"] and metadata["X-Object-2-S"]:find("AH", 1, true), nil,
      "an unrestricted object stores no faction text")

    for _, mode in ipairs({ "source", "baked" }) do
      local db = fixture.load(mode, entities, metadata)
      local object = db.Object
      local label = mode .. ": "

      equal(object.services(1), { services.MAILBOX }, label .. "services reads as the stored list")
      equal(object.services(5), nil, label .. "an empty services list reads nil")
      equal(object.services(4), nil, label .. "an object without services reads nil")

      equal(object.requiredFaction(1), "A", label .. "Alliance-only restriction")
      equal(object.requiredFaction(4), "H", label .. "Horde-only restriction")
      equal(object.requiredFaction(2), nil, label .. "\"AH\" is no restriction")
      equal(object.requiredFaction(5), nil, label .. "\"\" is no restriction")
      equal(object.requiredFaction(3), nil, label .. "an absent restriction reads nil")

      check(object.HasServices(1, db.Set(services.MAILBOX)) == true, label .. "HasServices matches a provided service")
      check(object.HasServices(3, db.Set(services.MAILBOX, services.FORGE)) == true, label .. "HasServices needs only one match")
      check(object.HasServices(3, db.Set(services.MAILBOX)) == false, label .. "HasServices rejects an unprovided service")
      check(object.HasServices(4, db.Set(services.MAILBOX)) == false, label .. "HasServices on an object without services")
      check(object.HasServices(999, db.Set(services.MAILBOX)) == false, label .. "HasServices on an unknown object")
      check(object.HasServices(1, nil) == false, label .. "HasServices without a set")

      equal(object.GetServices(3), { [services.ANVIL] = true, [services.FORGE] = true }, label .. "GetServices returns a lookup set")
      equal(object.GetServices(4), nil, label .. "GetServices is nil without services")
      equal(object.GetServices(999), nil, label .. "GetServices is nil for an unknown object")
      local owned = object.GetServices(3)
      owned[services.MAILBOX] = true
      equal(object.GetServices(3), { [services.ANVIL] = true, [services.FORGE] = true }, label .. "GetServices returns a caller-owned set")
      check(object.HasServices(3, db.Set(services.MAILBOX)) == false, label .. "a caller's set never reaches the database")

      -- The deprecated field returns its placeholder on every read path.
      equal(object.factionID(4), 0, label .. "named getter returns the placeholder")
      equal(object.Get(4, "factionID"), 0, label .. "Get returns the placeholder")
      equal(object.GetByIndex(4, keys.factionID), 0, label .. "GetByIndex returns the placeholder")
      equal(object.GetRaw(4, "factionID"), 0, label .. "GetRaw returns the placeholder")
      equal(object.GetAll(4, { "factionID", "requiredFaction" }), { 0, "H", n = 2 }, label .. "GetAll returns the placeholder")
      equal(object.factionID(999), nil, label .. "an unknown object still reads nil")

      local registrar = db.GetRegistrar("ObjectFactsTest")
      registrar.Set("Object", "facts", { [4] = { [keys.factionID] = 80, [keys.services] = { services.MOONWELL } } })
      equal(object.factionID(4), 0, label .. "a Correction cannot revive the deprecated field")
      check(object.HasServices(4, db.Set(services.MOONWELL)) == true, label .. "a corrected services list is checked")
      registrar.Set("Object", "facts", nil)

      -- Deprecation reporting: once per calling addon, only while the stack budget lasts.
      local messages, stackCalls = {}, 0
      local stack = "[Interface/AddOns/QuestieDB/src/read/shared.lua]:1: in function <x>\n" ..
        "[Interface/AddOns/FirstAddon/Core.lua]:10: in function <y>"
      _G.print = function(message) messages[#messages + 1] = message end
      _G.debugstack = function() stackCalls = stackCalls + 1; return stack end
      local fresh = fixture.load(mode, entities, metadata).Object
      fresh.factionID(4)
      equal(#messages, 1, label .. "the first deprecated read reports")
      check(messages[1]:find("ObjectDB.factionID", 1, true) ~= nil, label .. "the message names the deprecated field")
      check(messages[1]:find("requiredFaction", 1, true) ~= nil, label .. "the message names the replacement")
      check(messages[1]:find("FirstAddon", 1, true) ~= nil, label .. "the message names the calling addon, not QuestieDB")
      fresh.Get(4, "factionID")
      fresh.GetByIndex(4, keys.factionID)
      fresh.GetRaw(4, "factionID")
      fresh.GetAll(4, { "factionID" })
      equal(#messages, 1, label .. "the same addon is reported once across every read path")

      stack = "Interface\\AddOns\\SecondAddon\\Main.lua:5: in function `z'"
      fresh.factionID(4)
      equal(#messages, 2, label .. "a different addon gets its own report")
      check(messages[2]:find("SecondAddon", 1, true) ~= nil, label .. "backslash paths name the addon")

      stack = "[string \"*:OnClick\"]:1: in function <w>"
      fresh.factionID(4)
      check(messages[3] and messages[3]:find("unknown", 1, true) ~= nil, label .. "a stack without an addon reports an unknown caller")

      for _ = 1, 500 do fresh.factionID(4) end
      check(stackCalls <= 32, label .. "stack inspection stops at the budget (" .. stackCalls .. " calls)")
      equal(#messages, 3, label .. "repeated reads stay silent")
      stack = "[Interface/AddOns/LateAddon/Core.lua]:1: in function <q>"
      fresh.factionID(4)
      equal(#messages, 3, label .. "no report after the budget is spent")

      fresh.requiredFaction(4)
      fresh.services(1)
      equal(#messages, 3, label .. "current fields never report")

      -- Offline tooling has no debugstack and must stay silent.
      _G.debugstack = nil
      messages = {}
      local offline = fixture.load(mode, entities, metadata).Object
      offline.factionID(4)
      equal(#messages, 0, label .. "no report without debugstack")
      _G.print = saved.print
    end
  end)
  files.removeTree(root)
  for key in pairs(_G) do if saved[key] == nil then _G[key] = nil end end
  for key, value in pairs(saved) do _G[key] = value end
  assert(ok, err)
end
