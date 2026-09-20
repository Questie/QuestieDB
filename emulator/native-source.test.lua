-- Exercise the emitted TOC, not just config's selected paths. Synthetic writes make
-- isolation observable even when independently owned starting inputs happen to agree.
local config = dofile("src/config.lua")
config.correctionManifest = dofile("src/corrections/manifest.lua")
local savedLibStub = rawget(_G, "LibStub")
_G.LibStub = nil
local client = dofile("emulator/client.lua")
_G.LibStub = savedLibStub
local emulator = dofile("emulator/metadata.lua")
local runtime = dofile("generator/runtime.lua")
local id = 900000001

-- Independent expectations: a shared applicability bug must not validate itself through
-- sourceFileList/correctionApplies. Columns are Era, TBC, Wrath, Cata, Mists and owned Forever.
local representativePaths = {
  "src/corrections/Era/classicQuestFixes.lua",
  "src/corrections/Tbc/tbcQuestFixes.lua",
  "src/corrections/Wotlk/wotlkQuestFixes.lua",
  "src/corrections/Cata/cataQuestFixes.lua",
  "src/corrections/MoP/mopQuestFixes.lua",
  "src/corrections/Forever/legacy/classicQuestFixes.lua",
  "src/corrections/Forever/foreverQuestFixes.lua",
  "src/corrections/Shared/itemStartFixes.lua",
  "src/corrections/Era/classicQuestReputationFixes.lua",
}
local expectedProviders = {
  Vanilla = { true, false, false, false, false, false, false, true, true },
  TBC     = { true, true,  false, false, false, false, false, true, false },
  Wrath   = { true, true,  true,  false, false, false, false, true, false },
  Cata    = { true, true,  true,  true,  false, false, false, true, false },
  Mists   = { true, true,  true,  true,  true,  false, false, true, false },
  Forever = { false, false, false, false, false, true, true, false, false },
}

for _, flavor in ipairs(config.flavors) do
  client.reset()
  client.install({ expansion = flavor.expansion, season = "SoD" })
  emulator.install(config.addonName, emulator.parse("QuestieDB.toc"))
  local previousLoader = {}
  _G.QuestieLoader = previousLoader
  local db, files = emulator.loadAddon("QuestieDB.toc", config.addonName)
  assert(db.flavor.name == flavor.name)
  assert(_G.QuestieLoader == previousLoader, "Source loader was not restored")
  local selected, initializers = {}, 0
  for _, path in ipairs(files) do
    assert(not selected[path], "duplicate selected file: " .. path)
    selected[path] = true
    if path:match("^src/flavors/") then initializers = initializers + 1 end
    if path:match("^data/.+DB%.lua$") then
      assert(path:match("^data/" .. flavor.expansion .. "/"), "foreign raw payload: " .. path)
    end
    if path:match("^support/") then
      assert((path:match("^support/Forever/") ~= nil) == (flavor.name == "Forever"), path)
    end
  end
  assert(initializers == 1)
  for index, path in ipairs(representativePaths) do
    assert((selected[path] == true) == expectedProviders[flavor.name][index], flavor.name .. ": " .. path)
  end
  local expected = config.sourceFileList(flavor)
  assert(#files == #expected)
  for index, path in ipairs(expected) do assert(files[index] == path) end
  for _, spec in ipairs(config.correctionManifest) do
    assert((selected["src/corrections/" .. spec.file] == true) == config.correctionApplies(spec, flavor), spec.file)
  end
  if flavor.name ~= "Vanilla" then
    assert(not selected["src/corrections/Sod/sodQuestFixes.lua"])
    assert(db.ObjectiveFirst.eventObjectiveFirst[85304] == nil, "SoD hint leaked")
    for _, entry in ipairs(db.Corrections.Select({ owner = "QuestieDB" })) do
      assert(not entry.name:match("^Sod"), "SoD provider leaked")
    end
  else
    assert(db.ObjectiveFirst.eventObjectiveFirst[85304] == true)
  end
  -- Offline Generation must admit the same load-time hints, including seasonal scope.
  local offline = runtime.build()
  local offlineSelected = {}
  local originalLoadfile = loadfile
  _G.loadfile = function(path)
    offlineSelected[path] = true
    return originalLoadfile(path)
  end
  local loaded, loadError = pcall(runtime.loadCorrections, offline, flavor)
  _G.loadfile = originalLoadfile
  assert(loaded, loadError)
  for index, path in ipairs(representativePaths) do
    assert((offlineSelected[path] == true) == expectedProviders[flavor.name][index],
      "offline " .. flavor.name .. ": " .. path)
  end
  for field, values in pairs(db.ObjectiveFirst) do
    for key, value in pairs(values) do assert(offline.CorrectionCompat.objectiveFirst[field][key] == value) end
    for key, value in pairs(offline.CorrectionCompat.objectiveFirst[field]) do assert(values[key] == value) end
  end
  db, offline = nil, nil
  client.reset()
  collectgarbage("collect")
end

-- Both native names must select the same complete input set, not separate data flavors.
do
  local expected = config.sourceFileList(config.flavorByName.Forever)
  for _, gameType in ipairs({ "camelot", "forever" }) do
    client.install({ expansion = "Forever", gameType = gameType, season = "SoD" })
    emulator.install(config.addonName, emulator.parse("QuestieDB.toc"))
    local db, files = emulator.loadAddon("QuestieDB.toc", config.addonName)
    assert(db.flavor.name == "Forever" and db.read.source.expansion == "Forever")
    assert(#files == #expected, gameType .. " selected a different input set")
    for index, path in ipairs(expected) do assert(files[index] == path, gameType .. ": " .. path) end
    assert(db.ObjectiveFirst.eventObjectiveFirst[85304] == nil, "SoD hint leaked through alias")
    client.reset()
  end
end

for _, changed in ipairs({ "Vanilla", "Forever" }) do
  for _, target in ipairs({ "Vanilla", "Forever" }) do
    local changedFlavor, flavor = config.flavorByName[changed], config.flavorByName[target]
    client.reset()
    client.install({ expansion = flavor.expansion, season = "SoD" })
    emulator.install(config.addonName, emulator.parse("QuestieDB.toc"))
    local originalLoadfile = loadfile
    -- Substitute only these fixture inputs, while retaining the real emitted selection path.
    _G.loadfile = function(path)
      local chunk, err = originalLoadfile(path)
      if not chunk then return nil, err end
      return function(...)
        chunk(...)
        if path == config.dataPath(changedFlavor, config.entityTypeByName.Npc) then
          QuestieLoader:ImportModule("QuestieDB").npcData = { [id] = { "owned raw " .. changed } }
        elseif path == config.zoneIdsPath(changedFlavor) then
          QuestieLoader:ImportModule("ZoneDB").nativeIsolation = changed
        elseif path == "src/corrections/" .. (changed == "Forever" and "Forever/legacy" or "Era") .. "/classicQuestFixes.lua" then
          local module = QuestieLoader:ImportModule("QuestieQuestFixes")
          local original = module.Load
          module.Load = function(self)
            local result = original(self)
            result[id] = { [1] = "owned correction " .. changed }
            return result
          end
          QuestieLoader:ImportModule("QuestieCorrections").itemObjectiveFirst[id] = true
        end
      end
    end
    local ok, db = pcall(emulator.loadAddon, "QuestieDB.toc", config.addonName)
    _G.loadfile = originalLoadfile
    assert(ok, db)
    local applies = changed == target
    assert(db.Npc.name(id) == (applies and ("owned raw " .. changed) or nil))
    assert(db.Quest.name(id) == (applies and ("owned correction " .. changed) or nil))
    assert(db.Support.Get("ZoneDB").nativeIsolation == (applies and changed or nil))
    assert((db.ObjectiveFirst.itemObjectiveFirst[id] == true) == applies)
    db = nil
    client.reset()
    collectgarbage("collect")
  end
end
print("PASS emitted Source TOC selection, ownership isolation and seasonal admission")

-- Locale inputs also route through the owned directory, independent of the client locale.
local inputs = dofile("generator/l10n-inputs.lua")
for _, changed in ipairs({ "Vanilla", "Forever" }) do
  local changedFlavor = config.flavorByName[changed]
  local changedPath = inputs.lookupPath("l10n", changedFlavor, inputs.types.Npc, "deDE")
  local originalLoadfile = loadfile
  _G.loadfile = function(path)
    if path == changedPath then
      return assert(loadstring('QuestieLoader:ImportModule("l10n").npcNameLookup.deDE = { [' .. id .. '] = { "owned translation" } }'))
    end
    return originalLoadfile(path)
  end
  local ok, err = pcall(function()
    for _, target in ipairs({ "Vanilla", "Forever" }) do
      local values = inputs.load("l10n", config.flavorByName[target], "Npc", "deDE")
      assert((values[id] ~= nil) == (target == changed), "foreign locale input leaked")
    end
  end)
  _G.loadfile = originalLoadfile
  assert(ok, err)
end

-- A missing owned input fails; neither Source nor Generation may substitute Era.
client.install({ expansion = "Forever" })
emulator.install(config.addonName, emulator.parse("QuestieDB.toc"))
local originalLoadfile = loadfile
_G.loadfile = function(path)
  if path == config.dataPath(config.flavorByName.Forever, config.entityTypeByName.Npc) then
    return function() end -- Model the native client's skipped/missing file.
  end
  return originalLoadfile(path)
end
local ok, err = pcall(emulator.loadAddon, "QuestieDB.toc", config.addonName)
_G.loadfile = originalLoadfile
assert(not ok and tostring(err):find("missing Forever Source payload: Npc", 1, true))
assert(rawget(_G, "QuestieLoader") == nil, "missing payload leaked its shim")
client.reset()
print("PASS owned locale input isolation and missing payload rejection")

-- Inject initializer faults through the emitted TOC's actual selected chunk.
for _, fault in ipairs({ "missing", "duplicate" }) do
  client.install({ expansion = "Forever" })
  emulator.install(config.addonName, emulator.parse("QuestieDB.toc"))
  local previousLoader = {}
  _G.QuestieLoader = previousLoader
  local originalLoadfile = loadfile
  _G.loadfile = function(path)
    if path == "src/flavors/Forever.lua" then
      local initialize = assert(originalLoadfile(path))
      return function(...)
        if fault == "duplicate" then
          initialize(...)
          initialize(...)
        end
      end
    end
    return originalLoadfile(path)
  end
  local ok, err = pcall(emulator.loadAddon, "QuestieDB.toc", config.addonName)
  _G.loadfile = originalLoadfile
  local expectedError = fault == "missing" and "no native Source flavor selected" or "multiple Source flavors selected"
  assert(not ok and tostring(err):find(expectedError, 1, true), tostring(err))
  assert(_G.QuestieLoader == previousLoader, fault .. " initializer replaced the previous loader")
  client.reset()
end

-- Provider execution and missing-file failures must both release the offline shim,
-- restoring either an existing consumer loader or the original absence of one.
for _, fault in ipairs({ "execute", "missing" }) do
  for _, hasPreviousLoader in ipairs({ false, true }) do
    client.install({ expansion = "Forever" })
    local previousLoader = hasPreviousLoader and {} or nil
    _G.QuestieLoader = previousLoader
    local offline = runtime.build()
    local originalLoadfile = loadfile
    local reachedProvider = false
    _G.loadfile = function(path)
      if path == "src/corrections/Forever/legacy/classicQuestFixes.lua" then
        reachedProvider = true
        assert(_G.QuestieLoader ~= previousLoader, "offline shim was not installed")
        if fault == "missing" then return nil, "injected missing provider" end
        return function() error("injected provider execution failure", 0) end
      end
      return originalLoadfile(path)
    end
    local ok, err = pcall(runtime.loadCorrections, offline, config.flavorByName.Forever)
    _G.loadfile = originalLoadfile
    local expectedError = fault == "missing" and "injected missing provider" or "injected provider execution failure"
    assert(reachedProvider and not ok and tostring(err):find(expectedError, 1, true), tostring(err))
    assert(_G.QuestieLoader == previousLoader, "offline provider failure leaked its shim")
    assert(offline.CorrectionCompat.modules.QuestieCorrections == offline.CorrectionCompat.objectiveFirst)
    -- The same namespace can load successfully after cleanup, not just disappear on failure.
    runtime.loadCorrections(offline, config.flavorByName.Forever)
    assert(_G.QuestieLoader == previousLoader, "offline retry leaked its shim")
    client.reset()
  end
end
print("PASS Source initializer rejection and offline provider-error shim cleanup")

-- Use the real manifest and loader, with conflicting rows, to prove both authoring
-- entry points work and the legacy baseline remains beneath the new corrections.
client.install({ expansion = "Forever" })
local offline = runtime.build()
local flavor = config.flavorByName.Forever
offline.flavor = flavor
runtime.loadCorrections(offline, flavor)
local providers = offline.CorrectionCompat.modules
for _, case in ipairs({
  { "Quest", "QuestieQuestFixes", "ForeverQuestFixes" },
  { "Npc", "QuestieNPCFixes", "ForeverNpcFixes" },
  { "Item", "QuestieItemFixes", "ForeverItemFixes" },
  { "Object", "QuestieObjectFixes", "ForeverObjectFixes" },
}) do
  local datatype, legacy, authored = case[1], providers[case[2]], providers[case[3]]
  assert(type(authored.Load) == "function" and type(authored.LoadDynamic) == "function")
  legacy.Load = function()
    return { [id] = { [1] = "legacy static" }, [id + 1] = { [1] = "legacy-only static" } }
  end
  authored.Load = function()
    return { [id] = { [1] = "Forever static" } }
  end
  legacy.LoadFactionFixes = function()
    return { [id] = { [1] = "legacy dynamic" }, [id + 1] = { [1] = "legacy-only dynamic" } }
  end
  authored.LoadDynamic = function()
    return { [id] = { [1] = "Forever dynamic" } }
  end

  local rows = {}
  offline.Corrections.ApplyStaticToEntities(datatype, rows, flavor, "QuestieDB")
  assert(rows[id][1] == "Forever static", datatype .. " authored Static Correction did not win")
  assert(rows[id + 1][1] == "legacy-only static", datatype .. " lost its legacy baseline")
end
offline.Corrections.ApplyRegisteredCorrections("QuestieDB")
for _, datatype in ipairs({ "Quest", "Npc", "Item", "Object" }) do
  local rows = offline.Corrections.composed[datatype]
  assert(rows[id][1] == "Forever dynamic", datatype .. " authored Dynamic Correction did not win")
  assert(rows[id + 1][1] == "legacy-only dynamic", datatype .. " lost its legacy Dynamic Correction")
end
client.reset()
print("PASS Forever authored Static/Dynamic precedence and legacy fall-through")
