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
