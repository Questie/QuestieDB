-- Coroutine builds must publish complete buckets from one composed view, through both readers.
---@param check fun(condition: any, message: string)
---@param equal fun(actual: any, expected: any, message: string)
---@return nil
return function(check, equal)
  local saved = {}
  for key, value in pairs(_G) do saved[key] = value end
  local files = dofile("tools/validation/test-files.lua")
  local root = files.temporaryDirectory()
  local ok, err = pcall(function()
    _G.LibStub, _G.Enum = nil, nil
    dofile("emulator/client.lua").install({ expansion = "Classic" })
    local fixture = dofile("tools/validation/storage-fixture.lua")
    local entities = { Quest = {}, Npc = {}, Item = {}, Object = {} }
    for i = 1, 501 do entities.Object[i * 2] = { [1] = "Name " .. i } end
    entities.Object[2][1], entities.Object[4][1] = "Shared", "Shared"
    entities.Object[6][1], entities.Object[8][1] = nil, ""
    entities.Object[1002][1] = "Last"
    local metadata = fixture.write(root .. "/fixture.toc", entities, {
      Object = { [2] = { [1] = { [1] = "Gemeinsam" } }, [1002] = { [1] = { [1] = "Letzter" } } },
    })

    ---Resume without hiding a failure inside the test harness's pcall boundary.
    ---@param thread thread
    ---@return nil
    local function resume(thread)
      local resumed, failure = coroutine.resume(thread)
      assert(resumed, failure)
    end

    for _, mode in ipairs({ "source", "baked" }) do
      local label = mode .. ": "
      local db = fixture.load(mode, entities, metadata)
      local object = db.Object
      local spawnsKey = db.Meta.Object.keys.spawns
      local spawns = { [12] = {{10,20}} }
      if mode == "source" then
        check(db.read.source.entities.Object == nil, "source: Object data starts lazy")
        db.SetCorrection("Fixture", "Object", "initial-spawns", { [4] = { [spawnsKey] = spawns } })
        db.SetCorrection("Fixture", "Object", "initial-spawns", nil)
        check(db.read.source.entities.Object == nil, "source: overlay comparison does not materialize base data")
      end
      -- Source has no stored translations; a Dynamic slot exercises the same locale lifecycle.
      db.l10n.SetCorrection("Fixture", "deDE", "Object", "names", {
        [2] = { [1] = "Gemeinsam" }, [1002] = { [1] = "Letzter" },
      })
      db.l10n.SetLocale("deDE")
      local reads = 0
      local readKey = mode == "baked" and "scalarRow" or "readField"
      local originalRead = object.backend[readKey]
      object.backend[readKey] = function(...)
        reads = reads + 1
        return originalRead(...)
      end

      local completed = false
      local thread = coroutine.create(function()
        object.BuildNameIndexAsync()
        completed = true
      end)
      resume(thread)
      -- Source skips backend reads for the two translated rows; Baked decodes their scalar rows.
      equal(reads, mode == "baked" and 250 or 249, label .. "first resume reads only one batch")
      check(not completed, label .. "caller remains suspended before completion")
      resume(thread)
      equal(reads, mode == "baked" and 500 or 499, label .. "second resume reads only the next batch")
      check(not completed and coroutine.status(thread) == "suspended", label .. "yields after the second batch")
      resume(thread)
      equal(reads, mode == "baked" and 501 or 499, label .. "final resume finishes the remaining ID")
      check(completed and coroutine.status(thread) == "dead", label .. "returns only after completion")
      equal(object.IdsByName("Gemeinsam"), {2}, label .. "indexes the active translation")
      equal(object.IdsByName("Shared"), {4}, label .. "preserves English fallback")
      equal(object.IdsByName(""), {8}, label .. "preserves empty-string names")
      equal(object.IdsByName("Letzter"), {1002}, label .. "publishes the final batch")
      for i = 5, 500 do
        equal(object.IdsByName("Name " .. i), {i * 2}, label .. "complete bucket " .. i)
      end
      local built = object.IdsByName("Letzter")
      object.BuildNameIndexAsync()
      object.BuildNameIndex()
      check(object.IdsByName("Letzter") == built, label .. "both builders reuse an existing index")

      -- Publishing/withdrawing a spawn row for an existing base ID must refresh fields, but
      -- must not drop any bucket or trigger a full scan on the next tooltip name lookup.
      equal(object.spawns(4), nil, label .. "base spawns are initially absent")
      db.SetCorrection("Fixture", "Object", "spawns", { [4] = { [spawnsKey] = spawns } })
      equal(object.spawns(4), spawns, label .. "spawn correction clears the field cache")
      check(object.IdsByName("Letzter") == built, label .. "new base-ID spawn row retains name buckets")
      local replacementSpawns = { [12] = {{30,40}} }
      db.SetCorrection("Fixture", "Object", "spawns", { [4] = { [spawnsKey] = replacementSpawns } })
      equal(object.spawns(4), replacementSpawns, label .. "replacement spawn fields are fresh")
      check(object.IdsByName("Letzter") == built, label .. "replacement spawn row retains name buckets")
      db.SetCorrection("Fixture", "Object", "spawns", nil)
      equal(object.spawns(4), nil, label .. "spawn withdrawal restores the base field")
      check(object.IdsByName("Letzter") == built, label .. "withdrawn base-ID spawn row retains name buckets")

      local functionSpawns = spawns
      db.Corrections.RegisterRuntimeCorrection("FunctionFixture", "Object", "spawns", function()
        return { [4] = { [spawnsKey] = functionSpawns } }
      end, 10)
      db.Corrections.ApplyRegisteredCorrections("FunctionFixture")
      equal(object.spawns(4), spawns, label .. "function apply refreshes fields")
      check(object.IdsByName("Letzter") == built, label .. "function apply retains unchanged name buckets")
      functionSpawns = replacementSpawns
      db.Corrections.ApplyRegisteredCorrections("FunctionFixture")
      equal(object.spawns(4), replacementSpawns, label .. "function refresh publishes the replacement fields")
      check(object.IdsByName("Letzter") == built, label .. "function refresh retains unchanged name buckets")
      db.Corrections.UnregisterCorrection("FunctionFixture", "Object", "spawns")
      db.Corrections.ApplyRegisteredCorrections("FunctionFixture")
      equal(object.spawns(4), nil, label .. "function withdrawal restores the base field")
      check(object.IdsByName("Letzter") == built, label .. "function withdrawal retains unchanged name buckets")

      db.SetCorrection("Fixture", "Object", "name-and-spawns", {
        [4] = { [1] = "Corrected", [spawnsKey] = spawns },
      })
      built = object.IdsByName("Corrected")
      equal(built, {4}, label .. "a changed name drops the previous index")
      db.SetCorrection("Fixture", "Object", "name-and-spawns", {
        [4] = { [1] = "Corrected", [spawnsKey] = replacementSpawns },
      })
      equal(object.spawns(4), replacementSpawns, label .. "fields refresh alongside an unchanged corrected name")
      check(object.IdsByName("Corrected") == built, label .. "unchanged name slot retains the index")
      db.SetCorrection("Fixture", "Object", "name-and-spawns", { [4] = { [1] = {} } })
      equal(object.IdsByName("Corrected"), nil, label .. "name deletion drops the old bucket")
      equal(object.name(4), nil, label .. "deleted name remains nil")
      db.SetCorrection("Fixture", "Object", "name-and-spawns", nil)
      equal(object.IdsByName("Shared"), {4}, label .. "name withdrawal restores the fallback bucket")

      -- Added/withdrawn correction-only IDs matter even when their row has no name field.
      built = object.IdsByName("Letzter")
      db.SetCorrection("Fixture", "Object", "nameless", { [2000] = { [spawnsKey] = spawns } })
      check(object.Exists(2000), label .. "nameless correction-only entity exists")
      local afterAddition = object.IdsByName("Letzter")
      check(afterAddition ~= built, label .. "nameless addition invalidates membership-dependent index")
      db.SetCorrection("Fixture", "Object", "nameless", { [2000] = { [spawnsKey] = replacementSpawns } })
      equal(object.spawns(2000), replacementSpawns, label .. "existing correction-only entity fields refresh")
      check(object.IdsByName("Letzter") == afterAddition, label .. "unchanged correction-only membership retains index")
      db.SetCorrection("Fixture", "Object", "nameless", nil)
      check(not object.Exists(2000), label .. "nameless withdrawal updates membership")
      check(object.IdsByName("Letzter") ~= afterAddition, label .. "nameless withdrawal invalidates the index")

      for _, invalid in ipairs({0, -1, 1.5, false, "100", {}, math.huge, -math.huge, 0/0}) do
        check(not pcall(object.BuildNameIndexAsync, invalid), label .. "rejects an invalid batch size")
      end

      for _, batchSize in ipairs({1, 100, 501, 1000}) do
        object.InvalidateCache()
        thread = coroutine.create(function() object.BuildNameIndexAsync(batchSize) end)
        local resumes = 0
        repeat
          resume(thread)
          resumes = resumes + 1
        until coroutine.status(thread) == "dead"
        equal(resumes, math.ceil(501 / batchSize), label .. "uses the requested batch size " .. batchSize)
        equal(object.IdsByName("Letzter"), {1002}, label .. "custom batches publish the final ID")
      end

      -- A spawn-only publication must not restart a pass whose first batch is already private.
      object.InvalidateCache()
      thread = coroutine.create(function() object.BuildNameIndexAsync() end)
      resume(thread)
      db.SetCorrection("Fixture", "Object", "spawns", { [4] = { [spawnsKey] = spawns } })
      local remainingResumes = 0
      repeat
        resume(thread)
        remainingResumes = remainingResumes + 1
      until coroutine.status(thread) == "dead"
      equal(remainingResumes, 2, label .. "spawn-only publication does not restart an async build")
      equal(object.spawns(4), spawns, label .. "async continuation still sees fresh corrected fields")
      equal(object.IdsByName("Gemeinsam"), {2}, label .. "async continuation retains earlier name buckets")
      db.SetCorrection("Fixture", "Object", "spawns", nil)

      -- A suspended pass has already indexed the translated first row. Changing locale must
      -- restart it, not append English rows to those private German buckets.
      object.InvalidateCache()
      thread = coroutine.create(function() object.BuildNameIndexAsync() end)
      resume(thread)
      db.l10n.SetLocale("enUS")
      repeat resume(thread) until coroutine.status(thread) == "dead"
      equal(object.IdsByName("Gemeinsam"), nil, label .. "locale restart discards old translated buckets")
      equal(object.IdsByName("Shared"), {2,4}, label .. "locale restart keeps ascending shared IDs")
      equal(object.IdsByName("Last"), {1002}, label .. "locale restart reaches the last ID")

      -- Recomposition replaces the ID union as well as renaming an already processed row.
      db.SetCorrection("Fixture", "Object", "entities", { [9998] = { [1] = "Withdrawn" } })
      thread = coroutine.create(function() object.BuildNameIndexAsync() end)
      resume(thread)
      db.SetCorrection("Fixture", "Object", "entities", {
        [2] = { [1] = "Renamed" }, [9999] = { [1] = "Added" },
      })
      repeat resume(thread) until coroutine.status(thread) == "dead"
      equal(object.IdsByName("Shared"), {4}, label .. "correction restart drops the old name")
      equal(object.IdsByName("Renamed"), {2}, label .. "correction restart rereads processed rows")
      equal(object.IdsByName("Withdrawn"), nil, label .. "correction restart drops withdrawn IDs")
      equal(object.IdsByName("Added"), {9999}, label .. "correction restart refreshes enumeration")

      -- Even invalidating one row restarts a suspended full index.
      object.InvalidateCache(2)
      thread = coroutine.create(function() object.BuildNameIndexAsync() end)
      resume(thread)
      object.InvalidateCache(2)
      local resumes = 0
      repeat
        resume(thread)
        resumes = resumes + 1
      until coroutine.status(thread) == "dead"
      equal(resumes, 3, label .. "single-ID invalidation restarts from the first batch")

      -- A competing synchronous lookup must see the whole view, and the resumed builder
      -- must reuse that published index instead of replacing its shared buckets.
      object.InvalidateCache()
      thread = coroutine.create(function() object.BuildNameIndexAsync() end)
      resume(thread)
      built = object.IdsByName("Added")
      equal(built, {9999}, label .. "lookup during a build sees a complete index")
      resume(thread)
      equal(coroutine.status(thread), "dead", label .. "resumed builder reuses another complete build")
      check(object.IdsByName("Added") == built, label .. "does not replace another builder's buckets")

      object.InvalidateCache()
      thread = coroutine.create(function() object.BuildNameIndexAsync() end)
      resume(thread)
      -- Stop resuming this coroutine, as a canceled caller's scheduler would.
      equal(object.IdsByName("Added"), {9999}, label .. "abandoned build leaves synchronous rebuilding usable")
      object.InvalidateCache()
      check(not pcall(object.BuildNameIndexAsync), label .. "cold yielding build requires a coroutine")
      equal(object.IdsByName("Added"), {9999}, label .. "failed yield never publishes a partial index")

      -- Small and empty entity types finish without yielding.
      db.SetCorrection("Fixture", "Item", "one", { [1] = { [1] = "One item" } })
      db.Item.BuildNameIndexAsync()
      equal(db.Item.IdsByName("One item"), {1}, label .. "small build completes immediately")
      db.Quest.BuildNameIndexAsync()
      equal(db.Quest.IdsByName("Absent"), nil, label .. "empty build completes immediately")
    end
  end)
  for key in pairs(_G) do if saved[key] == nil then _G[key] = nil end end
  for key, value in pairs(saved) do _G[key] = value end
  files.removeTree(root)
  assert(ok, err)
end
