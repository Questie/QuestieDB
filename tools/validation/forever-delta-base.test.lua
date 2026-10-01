-- Maintained data examples are independent of Source/Baked agreement; update them when
-- those specific gameplay facts change. Correction behavior uses controlled rows below,
-- not live levels, coordinates, missing objectives or import row counts.
-- Run Baked checks only against a freshly generated disposable artifact.
local client = dofile("emulator/client.lua")
local emulator = dofile("emulator/metadata.lua")
local runtime = dofile("generator/runtime.lua")
local config = dofile("src/config.lua")
local baked = arg[1] == "Baked"

local function load(flavor, gameType)
  client.reset()
  client.install({ expansion = flavor, gameType = gameType })
  local path = "QuestieDB.toc"
  if baked then
    path = config.tocPath(config.flavorByName.Forever)
    emulator.install(config.addonName, emulator.parse(path))
  end
  return emulator.loadAddon(path, config.addonName)
end

local function witness(db)
  assert(db.Npc.friendlyToFaction(211033) == "A", "Garion's explicit Alliance reaction")
  assert(db.Npc.friendlyToFaction(205729) == "H", "Boarton's explicit Horde reaction")
  assert(db.Npc.friendlyToFaction(202093) == "AH", "Polymorphed Apprentice is non-hostile to both")
  -- Primary areas cover own-page evidence and explicit zone-row fallback, not spawn inference.
  assert(db.Npc.zoneID(269153) == 38, "Ylva own-page zone")
  assert(db.Npc.zoneID(251428) == 16593, "Hoarder zone-row fallback")
  assert(db.Object.zoneID(424005) == 406, "Pocket Litter own-page zone")
  assert(db.Object.zoneID(375548) == 331, "Unlit Torch zone-row fallback")
  -- Literal restrictions distinguish explicit masks, faction inference and reviewed zeroes.
  assert(db.Quest.requiredRaces(90902) == 16 and db.Quest.requiredClasses(90902) == 2,
    "explicit Undead Paladin restriction")
  assert(db.Quest.requiredRaces(94006) == 12884901888, "both Skyborne races, not all races")
  assert(db.Quest.requiredRaces(86585) == 4294967373, "Alliance fallback includes Alliance Skyborne")
  assert(db.Quest.requiredRaces(94004) == 0, "reviewed all-race writ assumption")
  local writStarters = db.Quest.startedBy(94004)
  assert(writStarters[1] == nil and writStarters[2] == nil and writStarters[3][1] == 264011,
    "writ starter preserves the item group and nil holes")
  assert(db.Item.startQuest(264011) == 94004, "writ item links back to its quest")
  -- Rewards cover initialization, amount replacement and preservation of other factions.
  local bannerRep = db.Quest.reputationReward(86585)
  assert(bannerRep and #bannerRep == 1 and bannerRep[1][1] == 47 and bannerRep[1][2] == 100,
    "new quest supplies its explicit reputation reward")
  local writRep = db.Quest.reputationReward(94004)
  assert(writRep and #writRep == 2 and writRep[1][1] == 2586 and writRep[1][2] == 75
    and writRep[2][1] == 2587 and writRep[2][2] == 75, "both reported writ rewards survive")
  local pvpRep = db.Quest.reputationReward(8368)
  assert(pvpRep and #pvpRep == 1 and pvpRep[1][1] == 889 and pvpRep[1][2] == 100,
    "changed reward replaces the old amount without leaving a duplicate")
  local tribalRep = db.Quest.reputationReward(6562)
  assert(tribalRep and #tribalRep == 2 and tribalRep[1][1] == 530 and tribalRep[1][2] == 25
    and tribalRep[2][1] == 2787 and tribalRep[2][2] == 100, "new faction keeps the inherited reward")
  -- Accepted deferred issue: current inference narrows the authored zero after NPC enrichment.
  -- The separate Static assertions below still require the original zero and Mage mask.
  assert(db.Quest.requiredRaces(97286) == 4294967373 and db.Quest.requiredClasses(97286) == 128,
    "Research Access reflects existing Alliance inference without removing Mage eligibility")
  for _, id in ipairs({ 92534, 94901, 3911 }) do
    assert(not db.Quest.Exists(id) and not db.Quest.GetAllIds(true)[id], "held quest leaked: " .. id)
  end
  assert(db.Quest.Exists(86585) and db.Quest.GetAllIds(true)[86585], "new quest is enumerable")
  assert(db.Quest.name(86585) == "Banner of the Fallen")
  assert(db.Quest.startedBy(86585)[1][1] == 269153, "explicit new quest giver")
  assert(db.Quest.finishedBy(86585)[1][1] == 1092, "explicit existing finisher")
  assert(db.Npc.Exists(269153) and db.Npc.GetAllIds(true)[269153], "new giver is enumerable")
  assert(db.Npc.name(269153) == "Mountaineer Ylva")
  assert(db.Npc.questStarts(269153)[1] == 86585, "reverse giver link")
  assert(db.Object.name(175725) == "The Old Gods and the Ordering of Azeroth", "imported object")
  assert(db.Object.spawns(175725)[11][1][1] == 9.9, "imported object spawn")
  assert(db.Item.Exists(286647) and db.Item.GetAllIds(true)[286647], "new item is enumerable")
  assert(db.Item.name(286647) == "Depleted Crystal Heart", "imported item name")
  assert(db.Item.itemLevel(286647) == 1 and db.Item.requiredLevel(286647) == 1, "imported item levels")
  assert(db.Item.class(286647) == 12 and db.Item.subClass(286647) == 0, "imported item category")
  assert(db.Item.npcDrops(286647)[1] == 252711, "additive item drop source")
end

for _, token in ipairs(baked and { "camelot" } or { "camelot", "forever" }) do
  local db, files = load("Forever", token)
  witness(db)
  local generated, traces = 0, 0
  for _, entry in ipairs(db.Corrections.Select()) do
    if entry.name:find("^Forever/generated/") then
      generated = generated + 1
      assert(not entry.dynamic, "delta-base must never become Dynamic")
    elseif entry.name:find("^Forever/traces/") then
      traces = traces + 1
      assert(not entry.dynamic, "traces must remain Static-only")
    end
  end
  assert(generated == (baked and 0 or 4), "only Source registers all four delta-base providers")
  assert(traces == (baked and 0 or 4), "only Source registers all four trace providers")
  if baked then
    for _, path in ipairs(files) do
      assert(not path:find("Forever/generated/", 1, true) and not path:find("Forever/traces/", 1, true),
        "static-only payload leaked into Baked file list")
    end
  end
end

if not baked then
  for _, flavor in ipairs({ "Classic", "TBC" }) do
    local db = load(flavor)
    assert(not db.Quest.Exists(86585) and not db.Npc.Exists(269153) and not db.Item.Exists(286647),
      "Forever content leaked into " .. flavor)
    for _, entry in ipairs(db.Corrections.Select()) do
      assert(not entry.name:find("^Forever/generated/") and not entry.name:find("^Forever/traces/"),
        "Forever provider leaked into " .. flavor)
    end
  end

  client.reset()
  client.install({ expansion = "Forever" })
  local offline = runtime.build()
  local flavor = offline.config.flavorByName.Forever
  offline.flavor = flavor
  runtime.loadCorrections(offline, flavor)
  local registry, providers = offline.Corrections, offline.CorrectionCompat.modules
  -- Assert real priorities across all six legacy providers, including generated Item starts
  -- and reputation, independently of manifest/file ordering or entity type.
  local legacyEntries, deltaEntries, traceEntries, authoredEntries = {}, {}, {}, {}
  for _, entry in ipairs(registry.Select({ dynamic = false })) do
    if entry.name:find("^Forever/legacy/") then
      legacyEntries[#legacyEntries + 1] = entry
    elseif entry.name:find("^Forever/generated/") then
      deltaEntries[#deltaEntries + 1] = entry
    elseif entry.name:find("^Forever/traces/") then
      traceEntries[#traceEntries + 1] = entry
    elseif entry.name:find("^Forever/forever") then
      authoredEntries[#authoredEntries + 1] = entry
    end
  end
  assert(#legacyEntries == 6 and #deltaEntries == 4 and #traceEntries == 4 and #authoredEntries == 4,
    "precedence fixture must cover every applicable Static provider")
  for _, delta in ipairs(deltaEntries) do
    for _, legacy in ipairs(legacyEntries) do
      assert(legacy.loadOrder < delta.loadOrder, legacy.name .. " must precede " .. delta.name)
    end
    for _, trace in ipairs(traceEntries) do
      assert(delta.loadOrder < trace.loadOrder, delta.name .. " must precede " .. trace.name)
    end
  end
  for _, trace in ipairs(traceEntries) do
    for _, authored in ipairs(authoredEntries) do
      assert(trace.loadOrder < authored.loadOrder, trace.name .. " must precede " .. authored.name)
    end
  end

  local quests, npcs = {}, {}
  registry.ApplyStaticToEntities("Quest", quests, flavor, "QuestieDB")
  registry.ApplyStaticToEntities("Npc", npcs, flavor, "QuestieDB")
  local questKeys, npcKeys = offline.Enum.questKeys, offline.Enum.npcKeys
  -- Getters normalize absent numbers to zero; inspect authored presence independently.
  local generatedQuests = providers.ForeverBaseQuest:Load()
  assert(generatedQuests[94004][questKeys.requiredRaces] == 0, "writ zero is explicitly present")
  assert(generatedQuests[97286][questKeys.requiredRaces] == 0, "library zero is explicitly present")
  assert(generatedQuests[97286][questKeys.requiredClasses] == 128, "library Mage mask remains authored")
  assert(generatedQuests[94004][questKeys.requiredClasses] == nil, "writ does not invent a class mask")
  assert(quests[94004][questKeys.requiredRaces] == 0 and quests[97286][questKeys.requiredRaces] == 0,
    "Static composition preserves reviewed zero presence")
  assert(quests[86585][questKeys.startedBy][1][1] == 269153, "offline static quest giver")
  assert(npcs[269153][npcKeys.questStarts][1] == 86585, "offline static reverse link")
  -- Read the Static collision rows through the real Source backend and shared getters.
  runtime.execute("src/read/shared.lua", "QuestieDB", offline)
  runtime.execute(offline.config.runtimeFiles.sourceReader, "QuestieDB", offline)
  local source = offline.read.source
  source.RemoveLoaderShim()
  for _, case in ipairs({
    { "Quest", "ForeverBaseQuest", "QuestieQuestFixes", "ForeverQuestFixes", 86585, "ForeverQuestTraces" },
    { "Npc", "ForeverBaseNpc", "QuestieNPCFixes", "ForeverNpcFixes", 269153, "ForeverNpcTraces" },
    { "Object", "ForeverBaseObject", "QuestieObjectFixes", "ForeverObjectFixes", 900000001, "ForeverObjectTraces" },
    { "Item", "ForeverBaseItem", "QuestieItemFixes", "ForeverItemFixes", 286647, "ForeverItemTraces" },
  }) do
    local datatype, delta, legacy, manual, id = case[1], providers[case[2]], providers[case[3]], providers[case[4]], case[5]
    local trace = providers[case[6]]
    assert(next(delta:Load()) ~= nil, "generated provider must supply data: " .. datatype)

    -- Controlled collisions through the real registered providers, not a second merge model.
    delta.Load = function() return {} end
    trace.Load = function() return {} end
    legacy.Load = function() return { [id] = { [1] = "legacy" } } end
    manual.Load = function() return {} end
    local rows = { [id] = { "raw" } }
    registry.ApplyStaticToEntities(datatype, rows, flavor, "QuestieDB")
    assert(rows[id][1] == "legacy", "inherited legacy must override raw base")
    delta.Load = function() return { [id] = { [1] = "delta" } } end
    registry.ApplyStaticToEntities(datatype, rows, flavor, "QuestieDB")
    assert(rows[id][1] == "delta", "generated delta-base must override legacy")
    trace.Load = function() return { [id] = { [1] = "trace" } } end
    registry.ApplyStaticToEntities(datatype, rows, flavor, "QuestieDB")
    assert(rows[id][1] == "trace", "generated traces must override generated delta-base")
    manual.Load = function() return { [id] = { [1] = "manual" } } end
    registry.ApplyStaticToEntities(datatype, rows, flavor, "QuestieDB")
    assert(rows[id][1] == "manual", "authored manual must override generated traces")
    source.entities[datatype] = rows
    local entity = offline.shared.CreateEntity(offline.Meta[datatype], source.CreateBackend(offline.Meta[datatype]))
    offline[datatype] = entity
    assert(entity.name(id) == "manual", "public read starts with the Static result")
    manual.LoadDynamic = function() return { [id] = { [1] = "dynamic" } } end
    registry.ApplyRegisteredCorrections("QuestieDB")
    assert(entity.name(id) == "dynamic", "Dynamic overrides the cached Static value through public reads")
    assert(entity.GetRaw(id, "name") == "manual", "Dynamic leaves the Static backend unchanged")
    manual.LoadDynamic = function() return {} end
    registry.ApplyRegisteredCorrections("QuestieDB")
    assert(entity.name(id) == "manual", "withdrawing Dynamic restores the Static value")
  end

  -- Controlled field composition: missing later fields preserve the base, while
  -- objectives may be supplied by the base, traces or authored corrections.
  local id = 900000002
  local baseRow = { [questKeys.requiredLevel] = 10 }
  local traceRow, manualRow = {}, {}
  providers.ForeverBaseQuest.Load = function() return { [id] = baseRow } end
  providers.ForeverQuestTraces.Load = function() return { [id] = traceRow } end
  providers.ForeverQuestFixes.Load = function() return { [id] = manualRow } end
  local function composeQuest()
    local rows = {}
    registry.ApplyStaticToEntities("Quest", rows, flavor, "QuestieDB")
    return rows[id]
  end

  traceRow[questKeys.objectives] = {{{101}}}
  local row = composeQuest()
  assert(row[questKeys.requiredLevel] == 10, "omitted trace level preserves the base level")
  assert(row[questKeys.objectives][1][1][1] == 101, "trace initializes missing objectives")

  baseRow[questKeys.objectives] = {{{102}}}
  traceRow[questKeys.objectives] = nil
  row = composeQuest()
  assert(row[questKeys.objectives][1][1][1] == 102, "omitted trace objectives preserve base objectives")

  traceRow[questKeys.requiredLevel] = 20
  traceRow[questKeys.objectives_add] = {{{103}}}
  row = composeQuest()
  assert(row[questKeys.requiredLevel] == 20, "trace level overrides the base level")
  assert(#row[questKeys.objectives][1] == 2 and row[questKeys.objectives][1][1][1] == 102
    and row[questKeys.objectives][1][2][1] == 103, "trace adds objectives without losing base objectives")

  manualRow[questKeys.requiredLevel] = 30
  manualRow[questKeys.objectives] = {{{104}}}
  row = composeQuest()
  assert(row[questKeys.requiredLevel] == 30, "authored level overrides the trace level")
  assert(#row[questKeys.objectives][1] == 1 and row[questKeys.objectives][1][1][1] == 104,
    "authored objectives replace the composed base and trace objectives")
end
client.reset()
print("PASS Forever delta-base " .. (baked and "Baked" or "Source, isolation and precedence"))
