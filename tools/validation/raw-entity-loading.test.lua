-- Exercise executable providers, not a mock of loadEntityData. Fixtures stay in the worktree.
---@param check fun(condition: boolean, message: string)
---@param equal fun(actual: any, expected: any, message: string)
---@return nil
return function(check, equal)
  local loader = dofile("generator/loader.lua")
  local lib = dofile("generator/lib.lua")
  local entityType = { keysField = "questKeys", dataField = "questData" }
  local path = ".out/test-raw-entity.lua"
  local prefix = 'local db = QuestieLoader:ImportModule("QuestieDB")\n'
  local validKeys = 'db.questKeys = {name = 1, startedBy = 2, requiredLevel = 4}\n'

  -- Pre-existing client/consumer globals must retain both identity and content.
  local names = {
    "QuestieLoader", "Questie", "GetLocale", "tinsert", "tremove", "wipe", "strsplit",
    "hooksecurefunc", "CreateFrame", "C_Timer", "C_Seasons", "C_AddOns", "Enum", "LibStub",
    "RawEntityProbe",
  }
  local saved, sentinels = {}, {}
  for _, name in ipairs(names) do
    saved[name] = rawget(_G, name)
    sentinels[name] = { marker = "consumer" }
    rawset(_G, name, sentinels[name])
  end

  ---Check every global binding, including newly introduced names, after either outcome.
  ---@param source string? nil tests a missing file.
  ---@return boolean ok
  ---@return any result
  ---@return table? keys
  local function loadFixture(source)
    if source then lib.writeAll(path, source) else os.remove(path) end
    local before, metatable = {}, getmetatable(_G)
    for key, value in pairs(_G) do before[key] = value end
    local ok, result, keys = pcall(loader.loadEntityData, path, entityType)
    os.remove(path)
    local unchanged = getmetatable(_G) == metatable
    for key, value in pairs(before) do
      if rawget(_G, key) ~= value then unchanged = false end
    end
    for key, value in pairs(_G) do
      if before[key] ~= value then unchanged = false end
    end
    check(unchanged, "provider/payload execution preserves global bindings and metatable")
    local contentUnchanged = true
    for _, name in ipairs(names) do
      if not lib.deepEqual(sentinels[name], { marker = "consumer" }) then contentUnchanged = false end
    end
    check(contentUnchanged, "pre-existing client/consumer tables retain their content")
    return ok, result, keys
  end

  ---@param source string?
  ---@param diagnostic string
  ---@return nil
  local function rejects(source, diagnostic)
    local ok, message = loadFixture(source)
    check(not ok and tostring(message):find(path, 1, true) ~= nil and
      tostring(message):find(diagnostic, 1, true) ~= nil,
      "invalid provider identifies path and " .. diagnostic .. ": " .. tostring(message))
  end

  ---@return nil
  local function cases()
    lib.mkdirp(".out")
    local ok, rows, keys = loadFixture(prefix .. validKeys .. [=[
loadstring('RawEntityProbe = "outer"')()
_G.Questie = { private = true }
db.questData = [[
local outer = RawEntityProbe
_G.RawEntityProbe = "payload"
local nested = loadstring('RawEntityProbe = "nested"; return RawEntityProbe')()
return {[42] = {outer, nil, {nested, _G.RawEntityProbe, Questie.private}, 0}, [99] = {""}}
]]
]=])
    check(ok, "provider and deferred payload execute successfully: " .. tostring(rows))
    equal(rows, { [42] = { "outer", nil, { "nested", "nested", true }, 0 }, [99] = { "" } },
      "rows preserve sparse slots, empty strings, zero and private nested payload values")
    equal(keys, { name = 1, startedBy = 2, requiredLevel = 4 }, "the provider's key header is returned unchanged")

    -- A second load cannot see either the first file's globals or its module fields.
    local nextOk, nextRows = loadFixture(prefix .. validKeys ..
      'db.questData = "return {[7] = {RawEntityProbe, Questie}}"')
    check(nextOk, "a subsequent provider loads")
    equal(nextRows, { [7] = {} }, "each load starts without ambient or prior-provider globals")
    rejects(nil, "Cannot load")
    rejects("local =", "Cannot load")
    rejects('QuestieLoader:ImportModule("OtherModule")', "unexpected raw entity import: OtherModule")
    rejects(prefix, "QuestieDB.questKeys as a table")
    rejects(prefix .. 'db.questKeys = "wrong"', "QuestieDB.questKeys as a table")
    rejects(prefix .. validKeys, "QuestieDB.questData as a string")
    rejects(prefix .. validKeys .. 'db.questData = {}', "QuestieDB.questData as a string")
    rejects(prefix .. validKeys .. 'db.questData = "return {"', "Cannot parse questData")
    rejects(prefix .. validKeys .. 'db.questData = "return 42"', "did not return a table")
    rejects(prefix .. validKeys .. 'db.questData = ""', "did not return a table")
    rejects(prefix .. 'RawEntityProbe = "provider write"; MissingProviderDependency()', "MissingProviderDependency")
    rejects(prefix .. validKeys ..
      'db.questData = \'RawEntityProbe = "payload write"; MissingPayloadDependency()\'', "Error executing questData")
    rejects(prefix .. validKeys ..
      'db.questData = \'return loadstring("_G.RawEntityProbe = 1; MissingNestedDependency()")()\'',
      "MissingNestedDependency")

    -- An empty caller environment must also stay empty on success and failure.
    for _, name in ipairs(names) do rawset(_G, name, nil) end
    local emptyOk, emptyRows = loadFixture(prefix .. validKeys .. 'db.questData = "return {}"')
    check(emptyOk, "loading does not require pre-existing client globals")
    equal(emptyRows, {}, "an empty entity table remains valid")
    rejects(prefix .. 'MissingProviderDependency()', "MissingProviderDependency")
    rejects(prefix .. validKeys .. 'db.questData = "MissingPayloadDependency()"', "MissingPayloadDependency")
  end

  local ok, message = pcall(cases)
  os.remove(path)
  for _, name in ipairs(names) do rawset(_G, name, saved[name]) end
  if not ok then error(message, 0) end
end
