return function(check, equal)
  local audit = dofile("tools/validation/correction-audit.lua")
  local globals = {}
  for key, value in pairs(_G) do globals[key] = value end

  -- Self-proof providers enter through the same loader, manifest registration, capture wrapper,
  -- persona matrix and row audit as the corpus. Only their source comes from memory.
  local state = audit.build("TBC")
  local cases = {
    { "unknown_add", "return {[1] = {[keys.doesNotExist_add] = {2}}}", "questKeys.doesNotExist_add" },
    { "unknown_remove", "return {[1] = {[keys.doesNotExist_remove] = {2}}}", "questKeys.doesNotExist_remove" },
    { "unknown_name", "return {[1] = {[keys.doesNotExist] = 2}}", "questKeys.doesNotExist" },
    { "scalar_target", "return {[1] = {[keys.name_add] = {2}}}", "target is not table-valued" },
    { "scalar_operand", "return {[1] = {[keys.finishedBy_add] = 2}}", "malformed questgivers operand" },
    { "grouped_tuple", "return {[1] = {[keys.finishedBy_add] = {[2] = {{42}}}}}", "malformed questgivers operand" },
    { "replace_add", "return {[1] = {[keys.finishedBy] = {}, [keys.finishedBy_add] = {[2] = {42}}}}",
      "replacement and operation share a field" },
    { "overlap", "return {[1] = {[keys.finishedBy_add] = {[2] = {42}}, [keys.finishedBy_remove] = {[2] = {42}}}}",
      "same value requested for add and remove" },
    { "numeric_operation", "return {[1] = {[1999] = {}}}", "unknown operation key 1999" },
    { "numeric_field", "return {[1] = {[999] = 2}}", "unknown field key 999" },
    { "named_field", "return {[1] = {name = 'typo'}}", "unknown field key name" },
    { "replacement_type", "return {[1] = {[keys.requiredLevel] = 'wrong'}}", "field requiredLevel expected number" },
    { "entity_id", "return {[-1] = {}}", "invalid entity ID -1" },
    { "row_shape", "return {[1] = 2}", "entity 1 row must be a table" },
    { "return_shape", "return 2", "provider must return a table" },
    { "capture_shape", "db.questData[1] = 2", "entity 1 row must be a table" },
    { "capture_datatype", "db.npcData[1] = {[1999] = 2}; return {}", "Quest provider wrote captured Npc corrections" },
  }
  local source = {
    "local module = QuestieLoader:CreateModule('Audit')",
    "local db = QuestieLoader:ImportModule('QuestieDB')",
    "local keys = db.questKeys",
  }
  local names = {}
  for _, case in ipairs(cases) do
    names[#names + 1] = case[1]
    source[#source + 1] = "function module:" .. case[1] .. "() " .. case[2] .. " end"
  end
  names[#names + 1] = "hidden_branch"
  source[#source + 1] = [[
    function module:hidden_branch()
      if UnitFactionGroup('player') == 'Horde' and UnitClassBase('player') == 'DRUID'
          and select(2, UnitRace('player')) == 'Orc' then
        return {[1] = {[keys.hiddenTypo_add] = {2}}}
      end
      return {}
    end
    function module:valid()
      db.questData[1] = {[keys.name] = 'captured'}
      return {[1] = {[keys.requiredLevel] = {}, [keys.finishedBy_add] = {[2] = {42}}}}
    end
  ]]
  names[#names + 1] = "valid"
  local spec = { file = "Shared/audit-memory.lua", module = "Audit", datatype = "Quest", dynamic = names }
  state.namespace.CorrectionManifest = { spec }
  local load = state.env.loadfile
  state.env.loadfile = function(path)
    if path == "src/corrections/" .. spec.file then
      return setfenv(assert(loadstring(table.concat(source, "\n"), "@" .. path)), state.env)
    end
    return load(path)
  end
  state.runtime.loadCorrections(state.namespace, state.flavor)
  local providers = audit.inventory(state)
  local entries = {}
  for _, provider in ipairs(providers) do entries[provider.entry.name:match(":(.+)$")] = provider.entry end
  for _, case in ipairs(cases) do
    local ok, err = audit.invoke(state, entries[case[1]], audit.personas[1])
    check(not ok and err:find(case[3], 1, true) ~= nil
        and err:find("Shared/audit-memory.lua:" .. case[1], 1, true) ~= nil
        and err:find("TBC/plain/Alliance/WARRIOR/Human", 1, true) ~= nil,
      "Self-proof " .. case[1] .. ": " .. tostring(err))
  end
  local rejected = 0
  for _, persona in ipairs(audit.personas) do
    local ok, err = audit.invoke(state, entries.hidden_branch, persona)
    if not ok then
      rejected = rejected + 1
      check(err:find("Horde/DRUID/Orc", 1, true) and err:find("questKeys.hiddenTypo_add", 1, true),
        "hidden branch diagnostic: " .. err)
    end
  end
  equal(rejected, 1, "Self-proof detects the hidden faction/class/race typo exactly once")
  local valid, rows = audit.invoke(state, entries.valid, audit.personas[1])
  check(valid and rows == 1, "captured writes, returned operations and scalar {} deletion are accepted")
  equal(rawget(state.namespace.Meta.Quest.keys, "finishedBy_add"), nil, "canonical schema stays isolated from aliases")

  -- FromManifest silently skips this method; the independent inventory check must not.
  local missing = audit.build("TBC")
  missing.namespace.CorrectionManifest = {
    { file = spec.file, module = "Audit", datatype = "Quest", dynamic = { "missing" } },
  }
  missing.namespace.CorrectionRegister.FromManifest(missing.flavor, function() return {} end)
  local ok, err = pcall(audit.inventory, missing)
  check(not ok and tostring(err):find("missing declared provider Shared/audit-memory.lua:missing Quest dynamic", 1, true),
    "Self-proof detects a declared but absent provider: " .. tostring(err))

  local report = audit.corpus()
  for _, failure in ipairs(report.failures) do check(false, failure) end
  check(#report.failures == 0, "all authored and generated Correction providers pass the authoring audit")
  io.write(("  Correction audit: %d providers, %d scenarios x %d personas, %d calls, %d rows, %.2fs CPU\n")
    :format(report.providers, report.scenarios, #audit.personas, report.invocations, report.rows, report.seconds))

  for key, value in pairs(globals) do assert(_G[key] == value, "audit changed global " .. tostring(key)) end
  for key in pairs(_G) do assert(globals[key] ~= nil, "audit leaked global " .. tostring(key)) end
  check(true, "audit preserves the caller's global environment")
end
