-- Exercise authoring policy through native exports and the real registry, not source text.
---@param check fun(condition: boolean, message: string)
---@param equal fun(actual: any, expected: any, message: string)
---@return nil
return function(check, equal)
  local runtime = dofile("generator/runtime.lua")
  local db = runtime.build()
  local flavor = db.config.flavorByName.Wrath
  db.flavor = flavor
  runtime.execute("src/corrections/prepare.lua", "QuestieDB", db)

  -- Load applicable native exports without composing them. Files own functions; the central
  -- manifest alone decides which functions register and how they are classified.
  local npcSpec
  for _, spec in ipairs(db.CorrectionManifest) do
    if db.config.correctionApplies(spec, flavor) then
      runtime.execute("src/corrections/" .. spec.file, "QuestieDB", db)
    end
    if spec.file == "Wotlk/wotlkNPCFixes.lua" then npcSpec = spec end
  end
  equal(#db.Corrections.Select({}), 0, "loading providers does not register hidden policy")
  local exports = 0
  for _, providers in pairs(db.CorrectionProviders) do
    for _, func in pairs(providers) do
      check(type(func) == "function", "provider exports contain only lazy functions")
      exports = exports + 1
    end
  end
  check(exports > 20, "the authoring test loaded cumulative native providers")

  -- Change only central policy. Even the two functions sharing one physical file must
  -- follow its sequence, order and options rather than their declaration positions.
  local automatic, authored = npcSpec.functions[1], npcSpec.functions[2]
  npcSpec.functions = { authored, automatic, npcSpec.functions[3] }
  authored.offset, automatic.offset = 11, 12
  authored.options = { noNewEntries = true }
  runtime.execute("src/corrections/register.lua", "QuestieDB", db)
  local entries = {}
  for _, entry in ipairs(db.Corrections.Select({ datatype = "Npc", dynamic = false })) do
    entries[entry.name] = entry
  end
  local first, second = entries[authored.name], entries[automatic.name]
  check(first.sequence < second.sequence, "manifest function order controls registration sequence")
  check(first.loadOrder < second.loadOrder, "manifest offsets control application order")
  equal(first.options, { noNewEntries = true }, "manifest owns registry options")
  check(first.func == db.CorrectionProviders.wotlkNPCFixes.Load,
    "the registrar passes the exported zero-argument function without a wrapper")
  local rows = { [30208] = { "Stormforged Ambusher" } }
  db.Corrections.ApplyStaticToEntities("Npc", rows, flavor, "QuestieDB")
  check(next(rows[30208][7]) ~= nil, "central order reversal makes automatics win the real spawn overlap")

  -- WoW may silently skip a missing file. A selected declaration must fail at composition,
  -- but seasonal files that returned before exporting are not missing providers.
  local missing = runtime.build()
  missing.flavor = flavor
  missing.CorrectionManifest = { npcSpec }
  missing.CorrectionProviders.wotlkNPCFixes = { Load = function() return {} end }
  local ok, err = pcall(runtime.execute, "src/corrections/register.lua", "QuestieDB", missing)
  check(not ok and tostring(err):find("missing correction function: Wotlk/wotlkNPCFixes.lua:LoadAutomatics", 1, true),
    "missing applicable functions fail with the file and export name")

  -- Baked accepts omitted Static exports but still requires every Dynamic declaration.
  -- Poisoning the unstripped Static functions proves registration never materializes them.
  local baked = runtime.build()
  baked.flavor, baked.mode = flavor, "baked"
  runtime.execute("src/corrections/prepare.lua", "QuestieDB", baked)
  baked.CorrectionManifest = { npcSpec }
  runtime.execute("src/corrections/" .. npcSpec.file, "QuestieDB", baked)
  local providers = baked.CorrectionProviders.wotlkNPCFixes
  providers.Load = function() error("Baked invoked Static Load") end
  providers.LoadAutomatics = function() error("Baked invoked Static LoadAutomatics") end
  runtime.execute("src/corrections/register.lua", "QuestieDB", baked)
  equal(#baked.Corrections.Select({ dynamic = false }), 0, "unstripped Baked registers no Static exports")
  equal(#baked.Corrections.Select({ dynamic = true }), 1, "unstripped Baked registers the Dynamic export")
  providers.Load, providers.LoadAutomatics = nil, nil
  local stripped = runtime.build()
  stripped.flavor, stripped.mode = flavor, "baked"
  stripped.CorrectionManifest = { npcSpec }
  stripped.CorrectionProviders.wotlkNPCFixes = providers
  runtime.execute("src/corrections/register.lua", "QuestieDB", stripped)
  equal(#stripped.Corrections.Select({}), 1, "Baked permits omitted Static exports")
  providers.LoadFactionFixes = nil
  local dynamicOk, dynamicError = pcall(runtime.execute, "src/corrections/register.lua", "QuestieDB", stripped)
  check(not dynamicOk and tostring(dynamicError):find("missing correction function", 1, true),
    "Baked fails closed when its Dynamic export is absent")

  -- Provider names are unique namespace slots; loading a file twice must fail rather than
  -- silently replacing the first file's exports.
  local duplicate, duplicateError = pcall(runtime.execute,
    "src/corrections/Wotlk/wotlkNPCFixes.lua", "QuestieDB", db)
  check(not duplicate and tostring(duplicateError):find("duplicate correction provider", 1, true),
    "a second file load cannot silently replace a provider export")
end
