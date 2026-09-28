-- One set of literal expectations runs through Static merging and both real read backends.
-- The only artifact is a small temporary TOC made from these rows, never a flavor database.
return function(check, equal)
  local saved = {}
  for key, value in pairs(_G) do saved[key] = value end
  local files = dofile("tools/validation/test-files.lua")
  local root = files.temporaryDirectory()
  local ok, err = pcall(function()
    _G.LibStub, _G.Enum = nil, nil
    dofile("emulator/client.lua").install({ expansion = "Classic" })
    local fixture = dofile("tools/validation/storage-fixture.lua")
    local lib = dofile("generator/lib.lua")
    local db = fixture.namespace()
    assert(loadfile("src/corrections/registry.lua"))("QuestieDB", db)
    local constants = dofile("generator/runtime.lua").build().Enum
    local cases = {
      { field = "preQuestGroup", base = {-1, 2, 3}, add = {3, -4, -4, 5}, remove = {2}, expected = {-1, 3, -4, 5} },
      { field = "objectivesText", base = {"a", "b"}, add = {"b", "c"}, remove = {"a"}, expected = {"b", "c"} },
      { field = "requiredSkill", base = {164, 75}, add = {164, 75}, expected = {164, 75} },
      { field = "requiredMinRep", base = {72, -100}, remove = {72, -100} },
      { field = "requiredMaxRep", base = {[2] = 300}, add = {[2] = 300}, expected = {[2] = 300} },
      { field = "reputationReward", base = {{72, 1}, {72, 2}}, add = {{72, 3}}, remove = {{72, 1}}, expected = {{72, 2}, {72, 3}} },
      { field = "finishedBy", base = {{11}, {22}, {33}}, add = {[2] = {424005}}, remove = {[2] = {22}}, expected = {{11}, {424005}, {33}} },
      { field = "objectives", base = { {{11}}, {{22, "object"}}, {{33}}, {72, 5}, {{{11,12}, 13}}, {{44}} },
        add = { {{55}}, nil, nil, {73, 6}, {{{11,12}, 14}}, {{45}} },
        remove = { {{11,nil,0}}, nil, nil, {72, 5}, {{{11,12}, 13,nil,0}}, {{44,nil,0}} },
        expected = { {{55,nil,0}}, {{22,"object",0}}, {{33,nil,0}}, {73,6}, {{{11,12},14,nil,0}}, {{45,nil,0}} } },
      { entity = "Npc", field = "spawns", base = {[12] = {{1,2,0}, {-1,-1,7}, {3,4}}, [13] = {{5,6}}},
        add = {[12] = {{3,4,0}, {7,8}}}, remove = {[12] = {{1,2}, {-1,-1}}},
        expected = {[12] = {{3,4}, {7,8}}, [13] = {{5,6}}} },
      { entity = "Object", field = "waypoints", base = {[12] = {{{1,2}, {1,2}, {3,4}}, {{5,6}}}, [13] = {{{7,8}}}},
        add = {[12] = {{{9,10}, {9,10}}}}, remove = {[12] = {{{5,6}}}},
        expected = {[12] = {{{1,2}, {1,2}, {3,4}}, {{9,10}, {9,10}}}, [13] = {{{7,8}}}} },
      { field = "triggerEnd", base = {"done", {[12] = {{1,2,0}}}}, add = {"done", {[12] = {{1,2}}}},
        expected = {"done", {[12] = {{1,2}}}} },
      { field = "triggerEnd", base = {"done", {[12] = {{1,2,0}}}}, remove = {"done", {[12] = {{1,2}}}} },
      { field = "extraObjectives", base = {{ {[12] = {{1,2,0}}}, 3, "go", nil, {{"monster", 11}} }},
        remove = {{ {[12] = {{1,2}}}, 3, "go", 0, {{"monster", 11}} }},
        add = {{ nil, 3, "new", nil, {{"item", 22}} }}, expected = {{ nil, 3, "new", 0, {{"item", 22}} }} },
      { entity = "Item", field = "relatedQuests", add = {7786}, expected = {7786} },
    }
    -- Append the contract matrix so the specialized normalization cases keep their IDs.
    local matrix = dofile("tools/validation/table-correction-cases.lua")
    for _, case in ipairs(matrix) do cases[#cases + 1] = case end
    local entities = { Quest = {}, Npc = {}, Item = {}, Object = {} }
    local corrections = { Quest = {}, Npc = {}, Item = {}, Object = {} }
    local coveredShapes, requiredShapes = {}, {}
    for id, case in ipairs(cases) do
      local datatype = case.entity or "Quest"
      local field = db.Meta[datatype].keys[case.field]
      case.index = field
      case.label = case.label or (case.field .. " #" .. id)
      if case.shape then
        assert(db.Meta[datatype].structures[field] == case.shape, "matrix field/shape mismatch: " .. case.label)
        coveredShapes[case.shape] = true
      end
      entities[datatype][id] = { [field] = case.base }
      case.fields = { [field] = case.replace, [field + 1000] = case.add, [field - 1000] = case.remove }
      if not case.error then corrections[datatype][id] = case.fields end
    end
    for datatype in pairs(entities) do
      local meta = db.Meta[datatype]
      for field, storage in ipairs(meta.types) do
        if storage == "table" then
          local shape = assert(meta.structures[field], "missing table shape: " .. datatype .. "." .. meta.names[field])
          requiredShapes[shape] = true
        end
      end
    end
    for shape in pairs(requiredShapes) do
      check(coveredShapes[shape], "contract matrix covers schema shape " .. shape)
    end
    local original = lib.show(entities)
    local originalOperands = lib.show(corrections)
    local metadata = fixture.write(root .. "/patches.toc", entities, {})
    for _, datatype in ipairs({ "Quest", "Npc", "Item", "Object" }) do
      local rows = {}
      for id, row in pairs(entities[datatype]) do
        rows[id] = {}; for key, value in pairs(row) do rows[id][key] = value end
      end
      db.Corrections.RegisterCorrection("Author", datatype, "shape-fixtures", function() return corrections[datatype] end)
      for pass = 1, 2 do
        db.Corrections.ApplyStaticToEntities(datatype, rows, nil, "Author")
        for id, case in ipairs(cases) do
          if (case.entity or "Quest") == datatype then
            if case.error then
              local accepted, message = pcall(db.Corrections.MergeInto, rows, {[id] = case.fields}, nil,
                {datatype = datatype, owner = "Author", name = case.label})
              check(not accepted and tostring(message):find(case.error, 1, true) ~= nil,
                "Static rejects " .. case.label .. ": " .. tostring(message))
            end
            equal(db.Meta.normalize.field(db.Meta[datatype], case.index, rows[id][case.index]), case.expected,
              "Static pass " .. pass .. " " .. case.label)
            for key in pairs(rows[id]) do check(key > 0 and key < 1000, "Static rows contain only canonical keys") end
          end
        end
      end
    end
    equal(lib.show(entities), original, "Static operations never mutate shared base tables")
    equal(lib.show(corrections), originalOperands, "Static operations never mutate operands")

    for _, mode in ipairs({ "source", "baked" }) do
      local live = fixture.load(mode, entities, metadata)
      local registry = live.Corrections
      for datatype, rows in pairs(corrections) do live.SetCorrection("Author", datatype, "shapes", rows) end
      for id, case in ipairs(cases) do
        local datatype = case.entity or "Quest"
        local entity = live[datatype]
        if case.error then
          local accepted, message = pcall(live.SetCorrection, "Author", datatype, case.label, {[id] = case.fields})
          check(not accepted and tostring(message):find(case.error, 1, true) ~= nil,
            mode .. " rejects " .. case.label .. ": " .. tostring(message))
        end
        equal(entity.Get(id, case.field), case.expected, mode .. " " .. case.label)
        equal(entity.GetRaw(id, case.field), db.Meta.normalize.field(db.Meta[datatype], case.index, case.base),
          mode .. " raw bypasses " .. case.label)
      end
      registry.ApplyRegisteredCorrections("Author")
      for id, case in ipairs(cases) do
        equal(live[case.entity or "Quest"].Get(id, case.field), case.expected, mode .. " reapply " .. case.label)
      end
      local owned = live.Quest.objectives(8)
      owned[5][1][1][1] = 999
      equal(live.Quest.objectives(8), cases[8].expected, mode .. " nested reads are independent")
      for datatype in pairs(corrections) do live.SetCorrection("Author", datatype, "shapes", nil) end

      local key = constants.questKeys.preQuestGroup
      local add, remove = constants.questKeys.preQuestGroup_add, constants.questKeys.preQuestGroup_remove
      local earlier = {40}
      live.SetCorrection("Earlier", "Quest", "replace", {[1] = {[key] = earlier}})
      live.SetCorrection("Later", "Quest", "patch", {[1] = {[add] = {50}}})
      live.SetCorrection("Earlier", "Quest", "replace", {[1] = {[key] = {41}}})
      equal(live.Quest.preQuestGroup(1), {41,50}, mode .. " fixed owner order uses earlier composed replacement")
      equal(earlier, {40}, mode .. " earlier literal never mutated")
      live.SetCorrection("Earlier", "Quest", "replace", {[1] = {[key] = {}}})
      equal(live.Quest.preQuestGroup(1), {50}, mode .. " NIL deletion blocks backend fallback")
      live.SetCorrection("Later", "Quest", "patch", {[1] = {[add] = {}}})
      equal(live.Quest.preQuestGroup(1), nil, mode .. " empty add does not resurrect NIL")
      equal(registry.GetProvenance("Quest", 1, key), "Earlier", mode .. " no-op does not claim ownership")
      live.SetCorrection("Earlier", "Quest", "replace", nil)
      live.SetCorrection("Later", "Quest", "patch", {[1] = {[add] = {50}, [remove] = {2}}})
      equal(live.Quest.preQuestGroup(1), {-1,3,50}, mode .. " withdrawal rebuilds against backend")

      -- Fail after a valid publication: reads, cache identities and provenance stay together.
      local view, provenance = registry.composed.Quest, registry.provenance.Quest
      local ids = live.Quest.GetAllIds(true)
      local invalid = {
        { [add] = 1 }, { [add] = {"bad"} }, { [add] = { [2] = 4 } },
        { [add] = {9}, [key] = {8} }, { [add] = {9}, [remove] = {9} },
        { [constants.questKeys.requiredLevel_add] = {} }, { [2001] = {} }, { [-1000] = {} }, { [1001.5] = {} },
        { [constants.questKeys.finishedBy_add] = {[4] = {1}} },
        { [constants.questKeys.objectives_add] = {[7] = {{1}}} },
        { [constants.questKeys.objectives_add] = {{{11}}}, [constants.questKeys.objectives_remove] = {{{11,nil,0}}} },
        { [constants.questKeys.objectives_add] = {[4] = {72,3}}, [constants.questKeys.objectives_remove] = {[4] = {72,3}} },
        { [constants.questKeys.triggerEnd_add] = {"text", {[12] = {{1,2,"phase"}}}} },
      }
      for index, row in ipairs(invalid) do
        local accepted, message = pcall(live.SetCorrection, "Later", "Quest", "patch", {[1] = row})
        check(not accepted and tostring(message):find("Later/patch Quest 1 field", 1, true) ~= nil,
          mode .. " invalid operation context #" .. index .. ": " .. tostring(message))
        check(registry.composed.Quest == view and registry.provenance.Quest == provenance,
          mode .. " rejected patch does not publish #" .. index)
        check(live.Quest.GetAllIds(true) == ids, mode .. " rejected patch retains caches")
        equal(live.Quest.preQuestGroup(1), {-1,3,50}, mode .. " previous reads survive invalid Set")
        equal(registry.GetProvenance("Quest", 1, key), "Later", mode .. " previous provenance survives invalid Set")
      end
      live.SetCorrection("Later", "Quest", "patch", {[1] = {[add] = {60}}})
      equal(live.Quest.preQuestGroup(1), {-1,2,3,60}, mode .. " invalid Set can be corrected")
      live.SetCorrection("Later", "Quest", "patch", nil)
      equal(live.Quest.preQuestGroup(1), {-1,2,3}, mode .. " invalid Set can be withdrawn")

      local retained = {[1] = {[add] = {81}}}
      live.SetCorrection("Retained", "Quest", "same-table", retained)
      retained[1][add][1] = 82
      live.SetCorrection("Retained", "Quest", "same-table", retained)
      equal(live.Quest.preQuestGroup(1), {-1,2,3,82}, mode .. " successful slots retain reference semantics")
      retained[1][add] = false
      check(not pcall(live.SetCorrection, "Retained", "Quest", "same-table", retained),
        mode .. " mutated same-reference Set fails")
      equal(retained[1][add], false, mode .. " rollback leaves caller input untouched")
      live.SetCorrection("FollowOn", "Quest", "valid", {[1] = {[constants.questKeys.name] = "Still valid"}})
      equal(live.Quest.preQuestGroup(1), {-1,2,3,82}, mode .. " another owner can write after same-reference failure")
      local restored = registry.owners.Retained.entries[1].data
      restored[1][add][1] = 99
      restored[1][remove] = false
      check(not pcall(live.SetCorrection, "Retained", "Quest", "same-table", restored),
        mode .. " restored rows are independent from rollback snapshot")
      registry.ApplyRegisteredCorrections("Retained")
      equal(live.Quest.preQuestGroup(1), {-1,2,3,82}, mode .. " repeated rollback preserves nested snapshot")
      live.SetCorrection("Retained", "Quest", "same-table", nil)

      local mixed = {[1] = {[key] = {81}}}
      live.SetCorrection("Mixed", "Quest", "replacement-and-patch", mixed)
      equal(live.Quest.preQuestGroup(1), {81}, mode .. " replacement read cached before caller mutation")
      local mixedView, mixedIds = registry.composed.Quest, live.Quest.GetAllIds(true)
      mixed[1][key][1] = 82
      mixed[1][constants.questKeys.objectives_add] = false
      check(not pcall(live.SetCorrection, "Mixed", "Quest", "replacement-and-patch", mixed),
        mode .. " replacement mutation plus invalid operation is rejected")
      check(registry.composed.Quest == mixedView and live.Quest.GetAllIds(true) == mixedIds,
        mode .. " mixed failure retains published view and caches")
      equal(live.Quest.preQuestGroup(1), {81}, mode .. " published replacement is independent of caller input")
      equal(registry.GetProvenance("Quest", 1, key), "Mixed", mode .. " mixed failure preserves provenance")
      live.SetCorrection("FollowOn", "Quest", "valid", {[1] = {[constants.questKeys.name] = "Still valid"}})
      equal(live.Quest.preQuestGroup(1), {81}, mode .. " mixed rollback survives another owner's write")
      mixed[1][constants.questKeys.objectives_add] = nil
      live.SetCorrection("Mixed", "Quest", "replacement-and-patch", mixed)
      equal(live.Quest.preQuestGroup(1), {82}, mode .. " valid resubmission publishes caller's replacement")
      live.SetCorrection("Mixed", "Quest", "replacement-and-patch", nil)

      local pairAdd, pairRemove = constants.questKeys.requiredSkill_add, constants.questKeys.requiredSkill_remove
      check(not pcall(live.SetCorrection, "Bad", "Quest", "atomic", {[3] = {[pairAdd] = {165,75}}}), mode .. " differing atomic add fails")
      check(not pcall(live.SetCorrection, "Bad", "Quest", "atomic", {[3] = {[pairAdd] = {165,75}, [pairRemove] = {164,75}}}), mode .. " two atomic operations fail")
      live.SetCorrection("Good", "Quest", "after-failure", {[3] = {[pairRemove] = {164,99}}})
      equal(live.Quest.requiredSkill(3), {164,75}, mode .. " remove compares the entire atomic record")
      live.SetCorrection("Good", "Quest", "empty", {[999] = {[add] = {}, [remove] = {}}})
      equal(live.Quest.Exists(999), false, mode .. " empty operations do not create an entity")
      live.SetCorrection("Good", "Quest", "new", {[999] = {[add] = {4}}})
      equal(live.Quest.preQuestGroup(999), {4}, mode .. " nonempty add can create an entity")
      live.SetCorrection("Good", "Quest", "new", nil)
      equal(live.Quest.Exists(999), false, mode .. " withdrawal removes added entity")

      local providerRows = {[1] = {[add] = {70}}}
      registry.RegisterRuntimeCorrection("Provider", "Quest", "function-patch", function() return providerRows end)
      registry.ApplyRegisteredCorrections("Provider")
      equal(live.Quest.preQuestGroup(1), {-1,2,3,70}, mode .. " function operations use backend fallback")
      local providerView, providerProvenance = registry.composed.Quest, registry.provenance.Quest
      local providerIds = live.Quest.GetAllIds(true)
      providerRows = {[1] = {[add] = false}}
      check(not pcall(registry.ApplyRegisteredCorrections, "Provider"), mode .. " invalid provider raises")
      check(registry.composed.Quest == providerView and registry.provenance.Quest == providerProvenance
        and live.Quest.GetAllIds(true) == providerIds, mode .. " failed provider preserves view, provenance and cache identities")
      equal(live.Quest.preQuestGroup(1), {-1,2,3,70}, mode .. " invalid provider retains published view")
      equal(registry.GetProvenance("Quest", 1, key), "Provider", mode .. " invalid provider retains provenance")
      providerRows = {[1] = {[add] = {71}}}
      registry.ApplyRegisteredCorrections()
      equal(live.Quest.preQuestGroup(1), {-1,2,3,71}, mode .. " no-arg Apply retries corrected provider")
      providerRows = {[1] = {[add] = false}}
      check(not pcall(registry.ApplyRegisteredCorrections, "Provider"), mode .. " provider may fail again")
      providerRows = {[1] = {[add] = {72}}}
      registry.ApplyRegisteredCorrections("Provider")
      equal(live.Quest.preQuestGroup(1), {-1,2,3,72}, mode .. " explicit Apply retries corrected provider")
      providerRows = {[1] = {[add] = false}}
      check(not pcall(registry.ApplyRegisteredCorrections, "Provider"), mode .. " invalid provider before withdrawal")
      registry.UnregisterCorrection("Provider", "Quest", "function-patch")
      registry.ApplyRegisteredCorrections("Provider")
      equal(live.Quest.preQuestGroup(1), {-1,2,3}, mode .. " invalid function provider can be withdrawn")

      local providerReplacement = {[1] = {[key] = {81}}}
      registry.RegisterRuntimeCorrection("Provider", "Quest", "replacement-patch", function() return providerReplacement end)
      registry.ApplyRegisteredCorrections("Provider")
      equal(live.Quest.preQuestGroup(1), {81}, mode .. " provider replacement read cached")
      providerReplacement[1][key][1] = 82
      providerReplacement[1][constants.questKeys.objectives_add] = false
      check(not pcall(registry.ApplyRegisteredCorrections, "Provider"), mode .. " reused provider replacement and invalid patch fail")
      equal(live.Quest.preQuestGroup(1), {81}, mode .. " published provider replacement survives caller mutation")
      providerReplacement[1][constants.questKeys.objectives_add] = nil
      registry.ApplyRegisteredCorrections()
      equal(live.Quest.preQuestGroup(1), {82}, mode .. " provider retry publishes corrected replacement")
      registry.UnregisterCorrection("Provider", "Quest", "replacement-patch")
      registry.ApplyRegisteredCorrections("Provider")

      -- Empty operations need no existing value; nonempty operations still reject scalars.
      live.SetCorrection("Scalar", "Quest", "base", {[1] = {[key] = 7}})
      local scalarOk, scalarErr = pcall(live.SetCorrection, "ScalarPatch", "Quest", "op", {[1] = {[add] = {8}}})
      check(not scalarOk and tostring(scalarErr):find("preQuestGroup add", 1, true) ~= nil,
        mode .. " scalar base fails with field/operation context")
    end

    -- Load the real Baked reader with the operation file omitted, as in an older manifest.
    local namespace = fixture.namespace
    fixture.namespace = function()
      local stale = { Meta = {} }
      for _, path in ipairs(dofile("src/config.lua").runtimeFiles.head) do
        if path ~= "src/corrections/tablePatch.lua" then assert(loadfile(path))("QuestieDB", stale) end
      end
      for _, path in ipairs(dofile("src/config.lua").enumFiles) do
        assert(loadfile(path))("QuestieDB", stale)
      end
      assert(loadfile("src/corrections/compat.lua"))("QuestieDB", stale)
      return stale
    end
    local loaded, stale = pcall(fixture.load, "baked", entities, metadata)
    fixture.namespace = namespace
    assert(loaded, stale)
    equal(stale.TablePatch, nil, "stale manifest genuinely omits operation engine")
    local staleKeys = stale.Enum.questKeys
    equal(staleKeys.preQuestGroup_add, staleKeys.preQuestGroup + 1000, "stale manifest initializes enums")
    equal(stale.Quest.preQuestGroup(1), {-1,2,3}, "stale manifest initializes Baked reads")
    stale.SetCorrection("Old", "Quest", "replacement", {[1] = {[staleKeys.preQuestGroup] = {90}}})
    equal(stale.Quest.preQuestGroup(1), {90}, "stale manifest keeps replacement corrections")
    local accepted, message = pcall(stale.SetCorrection, "Old", "Quest", "operation",
      {[1] = {[staleKeys.preQuestGroup_add] = {91}}})
    check(not accepted and tostring(message):find("Old/operation Quest 1 field preQuestGroup add", 1, true)
      and tostring(message):find("updated TOC; regenerate", 1, true), "stale manifest reports actionable operation error")
    equal(stale.Quest.preQuestGroup(1), {90}, "stale operation failure preserves replacement")
    local staticRows = {}
    stale.Corrections.MergeInto(staticRows, {[1] = {[staleKeys.preQuestGroup] = {90}}})
    equal(staticRows[1][staleKeys.preQuestGroup], {90}, "stale engine-free Static replacements work")

    local fallbackReads = 0
    local function fallback()
      fallbackReads = fallbackReads + 1
      return 7
    end
    local field = constants.questKeys.preQuestGroup
    local patchContext = {datatype = "Quest", owner = "Counted", name = "fallback"}
    local conflict, conflictError = pcall(db.TablePatch.Resolve,
      {[field + 1000] = {9}, [field - 1000] = {9}}, db.Meta.Quest, patchContext, 1, nil, fallback)
    check(not conflict and tostring(conflictError):find("same value", 1, true), "operand conflict precedes backend validation")
    equal(fallbackReads, 0, "conflicting operands never decode backend")
    equal(db.TablePatch.Resolve({[field + 1000] = {}}, db.Meta.Quest, patchContext, 1, nil, fallback),
      {}, "empty operation resolves without backend")
    equal(fallbackReads, 0, "empty operation never decodes backend")
    check(not pcall(db.TablePatch.Resolve, {[field + 1000] = {9}}, db.Meta.Quest, patchContext, 1, nil, fallback),
      "nonempty operation validates backend scalar")
    equal(fallbackReads, 1, "nonempty operation reads backend once")

    local key = constants.itemKeys.relatedQuests
    local rows = { [1] = {[key] = {1}} }
    local edits = { [1] = {[key + 1000] = {2}}, [2] = {[key + 1000] = {3}} }
    local context = { datatype = "Item", owner = "StaticOwner", name = "policy" }
    db.Corrections.MergeInto(rows, edits, {noNewEntries = true, noOverwrites = true}, context)
    equal(rows, {[1] = {[key] = {1}}}, "Static noNewEntries and noOverwrites remain authoritative")
    db.Corrections.MergeInto(rows, {[2] = {[1] = "Named", [key + 1000] = {3}}},
      {noNewEntries = true, allowNamedInheritedEntry = true}, context)
    equal(rows[2], {[1] = "Named", [key] = {3}}, "Static inherited named rows may create patched fields")
    local accepted, message = pcall(db.Corrections.MergeInto, rows, {[1] = {[key + 1000] = 1}}, nil, context)
    check(not accepted and tostring(message):find("StaticOwner/policy Item 1 field relatedQuests add", 1, true) ~= nil,
      "Static errors carry provider, entity, field and operation")

    local scalarOk = pcall(db.Corrections.MergeInto, {[1] = {[key] = 7}},
      {[1] = {[key + 1000] = {8}}}, nil, context)
    check(not scalarOk, "Static scalar base is rejected for nonempty operands")
    local unchanged = {}
    db.Corrections.MergeInto(unchanged, {[1] = {}}, nil, context)
    equal(unchanged, {[1] = {}}, "ordinary empty replacement rows preserve creation behavior")

    for _, datatype in ipairs({ "Quest", "Npc", "Item", "Object" }) do
      local meta = db.Meta[datatype]
      local enum = constants[datatype:sub(1,1):lower() .. datatype:sub(2) .. "Keys"]
      for name, index in pairs(meta.keys) do
        equal(enum[name], index, datatype .. " canonical authoring key " .. name)
        equal(enum[name .. "_add"], index + 1000, datatype .. " add alias " .. name)
        equal(enum[name .. "_remove"], index - 1000, datatype .. " remove alias " .. name)
        equal(meta.keys[name .. "_add"], nil, "add aliases never enter canonical schema")
        equal(meta.keys[name .. "_remove"], nil, "remove aliases never enter canonical schema")
      end
      equal(#meta.names, meta.fieldCount, "canonical field count remains unchanged")
    end
    equal(lib.show(entities), original, "Dynamic operations leave fixture bases untouched")
    equal(lib.show(corrections), originalOperands, "Dynamic operations leave operands untouched")
  end)
  for key in pairs(_G) do if saved[key] == nil then _G[key] = nil end end
  for key, value in pairs(saved) do _G[key] = value end
  files.removeTree(root)
  assert(ok, err)
end
