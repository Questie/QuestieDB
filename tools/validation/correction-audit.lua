-- Offline authoring audit. No raw entity database or generated TOC is loaded.
local audit = {}

-- All classes through Mists, both faction branches, and both TBC race outcomes.
-- Facts are read inside provider functions today; expansion/season are fixed at file load.
audit.personas = {}
for _, faction in ipairs({ "Alliance", "Horde" }) do
  for classId, class in ipairs({ "WARRIOR", "PALADIN", "HUNTER", "ROGUE", "PRIEST", "DEATHKNIGHT",
      "SHAMAN", "MAGE", "WARLOCK", "MONK", "DRUID" }) do
    for raceId, race in ipairs({ "Human", "Orc" }) do
      audit.personas[#audit.personas + 1] = {
        faction = faction, class = class, classId = classId, race = race, raceId = raceId,
      }
    end
  end
end

---Load the existing generator and client adapters entirely inside a private global environment.
---Its loadfile/dofile also isolate nested loads; canonical schema and production enums stay untouched.
function audit.build(flavorName, season)
  local env = setmetatable({ Enum = {} }, { __index = _G })
  env._G = env
  env.loadfile = function(path)
    local chunk, err = loadfile(path)
    if chunk then setfenv(chunk, env) end
    return chunk, err
  end
  env.dofile = function(path) return assert(env.loadfile(path))() end
  local runtime = env.dofile("generator/runtime.lua")
  local namespace = runtime.build()
  local flavor = assert(namespace.config.flavorByName[flavorName])
  env.dofile("emulator/client.lua").install({ expansion = flavor.expansion, season = season })
  local state = { namespace = namespace, env = env, flavor = flavor,
    label = flavorName .. "/" .. (season or "plain"), runtime = runtime }
  for _, name in ipairs({ "questKeys", "npcKeys", "itemKeys", "objectKeys" }) do
    setmetatable(namespace.Enum[name], { __index = function(_, key)
      error("unknown correction enum " .. name .. "." .. tostring(key), 0)
    end })
  end

  -- Registration merges returned rows with captured writes. Reject malformed returns before
  -- that wrapper can silently discard a scalar, or obscure an invalid row with pairs().
  local invoke = namespace.CorrectionCompat.Invoke
  namespace.CorrectionCompat.Invoke = function(func, ...)
    local returned = invoke(func, ...)
    if returned ~= nil then audit.rows(returned) end
    for _, captured in pairs(namespace.CorrectionCompat.captured) do audit.rows(captured) end
    return returned
  end
  return state
end

---Validate the provider envelope before the existing registration wrapper merges it.
function audit.rows(rows)
  assert(type(rows) == "table", "provider must return a table or nil for captured writes")
  for id, fields in pairs(rows) do
    assert(type(id) == "number" and id > 0 and id < math.huge and id % 1 == 0,
      "invalid entity ID " .. tostring(id))
    assert(type(fields) == "table", "entity " .. tostring(id) .. " row must be a table")
  end
end

---Execute the registered provider, including its direct-write capture, under one persona.
---@return boolean ok
---@return number|string rowsOrError
function audit.invoke(state, entry, persona)
  local env, namespace = state.env, state.namespace
  env.UnitFactionGroup = function() return persona.faction end
  env.UnitClassBase = function() return persona.class, persona.classId end
  env.UnitClass = function() return persona.class, persona.class, persona.classId end
  env.UnitRace = function() return persona.race, persona.race, persona.raceId end
  local context = state.label .. "/" .. persona.faction .. "/" .. persona.class .. "/" .. persona.race
    .. " " .. entry.name .. " " .. entry.datatype .. " " .. (entry.dynamic and "dynamic" or "static")
  local ok, result = pcall(function()
    local rows = entry.func()
    -- Registration only returns captures for the declared datatype. Other writes
    -- would otherwise disappear before their field keys can be audited.
    for datatype, captured in pairs(namespace.CorrectionCompat.captured) do
      assert(datatype == entry.datatype or next(captured) == nil,
        entry.datatype .. " provider wrote captured " .. datatype .. " corrections")
    end
    audit.rows(rows)
    local meta = assert(namespace.Meta[entry.datatype])
    local count = 0
    for id, fields in pairs(rows) do
      for key, value in pairs(fields) do
        -- Operation encoding and operand grammar belong to TablePatch.Resolve, below.
        if type(key) ~= "number" or (key > 0 and key < 1000) then
          assert(type(key) == "number" and meta.names[key],
            "entity " .. id .. " unknown field key " .. tostring(key))
          local deleting = type(value) == "table" and next(value) == nil
          assert(deleting or type(value) == meta.types[key],
            "entity " .. id .. " field " .. meta.names[key] .. " expected " .. meta.types[key]
              .. ", got " .. type(value))
        end
      end
      -- An empty base tests authoring, not baseline-dependent atomic replacement success.
      namespace.TablePatch.Resolve(fields, meta, entry, id)
      count = count + 1
    end
    return count
  end)
  if not ok then return false, context .. ": " .. tostring(result) end
  return true, result
end

---Require exact registration coverage, including declared functions FromManifest can skip.
---Return active entries and stable inventory keys for the cross-scenario coverage check.
function audit.inventory(state)
  local namespace, expected, entries = state.namespace, {}, {}
  local register = namespace.CorrectionRegister
  for _, spec in ipairs(namespace.CorrectionManifest) do
    local active = namespace.config.correctionApplies(spec, state.flavor)
      and (not register.IsSod(spec) or register.IsSodActive(state.flavor))
      and (not register.IsTitanReforged(spec) or register.IsTitanReforgedActive(state.flavor))
    for _, category in ipairs({ "static", "dynamic" }) do
      for _, name in ipairs(spec[category] or {}) do
        local key = spec.file .. ":" .. name .. " " .. spec.datatype .. " " .. category
        assert(expected[key] == nil, "duplicate declared provider " .. key)
        expected[key] = active and "missing" or "inactive"
      end
    end
  end
  for _, entry in ipairs(namespace.Corrections.Select()) do
    local key = entry.name .. " " .. entry.datatype .. " " .. (entry.dynamic and "dynamic" or "static")
    assert(expected[key] == "missing", state.label .. " unexpected registration " .. key)
    expected[key] = "registered"
    entries[#entries + 1] = { entry = entry, key = key }
  end
  for key, status in pairs(expected) do
    assert(status ~= "missing", state.label .. " missing declared provider " .. key)
  end
  return entries, expected
end

function audit.corpus()
  local started = os.clock()
  local scenarios = {}
  for _, flavor in ipairs(dofile("src/config.lua").flavors) do
    scenarios[#scenarios + 1] = { flavor.name }
  end
  scenarios[#scenarios + 1] = { "Vanilla", "SoD" }
  scenarios[#scenarios + 1] = { "Wrath", "TitanReforged" }
  local report = { providers = 0, invocations = 0, rows = 0, failures = {}, scenarios = #scenarios }
  local declared, exercised, failed = {}, {}, {}
  for _, scenario in ipairs(scenarios) do
    local state = audit.build(unpack(scenario))
    local ok, err = pcall(state.runtime.loadCorrections, state.namespace, state.flavor)
    assert(ok, state.label .. "/Alliance/WARRIOR/Human loading providers: " .. tostring(err))
    local entries, inventory = audit.inventory(state)
    for key in pairs(inventory) do declared[key] = true end
    for _, provider in ipairs(entries) do
      for _, persona in ipairs(audit.personas) do
        local passed, result = audit.invoke(state, provider.entry, persona)
        report.invocations = report.invocations + 1
        exercised[provider.key] = true
        if passed then
          report.rows = report.rows + result
        elseif not failed[provider.key] then
          -- Keep the first full diagnostic per provider, but still execute every persona.
          failed[provider.key] = true
          report.failures[#report.failures + 1] = result
        end
      end
    end
  end
  for key in pairs(declared) do
    assert(exercised[key], "declared provider never exercised in any scenario: " .. key)
    report.providers = report.providers + 1
  end
  report.seconds = os.clock() - started
  return report
end

return audit
