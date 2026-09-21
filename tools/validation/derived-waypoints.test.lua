-- Literal paths protect the shared transform, not a snapshot of production NPC data.
return function(check, equal)
  local config = dofile("src/config.lua")
  local runtime = dofile("generator/runtime.lua")
  local db = runtime.build()
  local keys = db.Meta.Npc.keys

  equal(db.DerivedWaypoints.Optimize({ [12] = { {0, 0}, {0.1, 0.05}, {3, 0} } },
    db.RamerDouglasPeucker, {}), { [12] = { { {0, 0}, {1.5, 0}, {3, 0} } } },
    "RDP removes the small bend before subdivision inserts evenly spaced points")
  equal(db.DerivedWaypoints.Optimize({ [12] = { { {0, 0}, {3, 0} }, { {0, 1}, {1.5, 1} } } },
    db.RamerDouglasPeucker, {}),
    { [12] = { { {0, 0}, {1.5, 0}, {3, 0} }, { {0, 1}, {1.5, 1} } } },
    "nested paths stay separate and a segment exactly at the threshold stays intact")

  -- Use the actual expansion declarations with synthetic providers. A change to Era/TBC
  -- admission must fail even if Generation and Source mode make the same mistake.
  local manifest = {}
  for _, spec in ipairs(db.CorrectionManifest) do
    if spec.file == "Era/classicNPCFixes.lua" or spec.file == "Tbc/tbcNPCFixes.lua" or
       spec.file == "Wotlk/wotlkNPCFixes.lua" then
      manifest[#manifest + 1] = spec
    end
  end
  local modules = {
    QuestieNPCFixes = { Load = function() return {
      [990001] = { [keys.name] = "Inherited", [keys.minLevel] = 10,
        [keys.waypoints] = { [1519] = { {0, 0}, {0.1, 0.05}, {3, 0} } } },
      [990002] = { [keys.waypoints] = { [12] = { {0, 0}, {0.1, 0.05}, {3, 0} } } },
    } end },
    QuestieTBCNpcFixes = { Load = function() return {
      [990001] = { [keys.minLevel] = 20, [keys.maxLevel] = 25 },
    } end },
    QuestieWotlkNpcFixes = { LoadAutomatics = function() return {} end, Load = function() return {
      [990001] = { [keys.name] = "Future", [keys.minLevel] = 30 },
    } end },
  }
  db.CorrectionManifest = manifest
  db.CorrectionRegister.FromManifest(config.flavorByName.TBC, function(name) return modules[name] end)

  -- Replace only input loading and registry construction. The real flavor pipeline,
  -- correction engine, schema checks, support loader, and Derived Pass registry still run.
  local function loadWith(path, dependencies)
    local env = setmetatable({ dofile = function(file)
      if dependencies[file] then return dependencies[file] end
      return dofile(file)
    end }, { __index = _G })
    return setfenv(assert(loadfile(path)), env)()
  end
  local corrections = loadWith("generator/corrections.lua", {
    ["generator/runtime.lua"] = { build = function() return db end, loadCorrections = function() return 3, 3 end },
  })
  local derived = loadWith("generator/derived.lua", { ["generator/corrections.lua"] = corrections })
  local flavorLoader = loadWith("generator/flavor.lua", {
    ["generator/corrections.lua"] = corrections,
    ["generator/derived.lua"] = derived,
    ["generator/loader.lua"] = { loadEntityData = function()
      return {
        [990001] = { [keys.name] = "Raw", [keys.waypoints] = { [1519] = { {9, 9}, {10, 9} } } },
        [990002] = { [keys.name] = "Outside city" },
      }, keys
    end },
  })
  local loaded = flavorLoader.load(config.flavorByName.TBC, { Npc = true })
  local npc = loaded.Npc.entities[990001]
  equal(npc[keys.name], "Inherited", "TBC inherits Era's field and excludes the future Wrath correction")
  equal(npc[keys.minLevel], 20, "TBC overrides the earlier Era field")
  equal(npc[keys.maxLevel], 25, "TBC adds its own field without replacing the earlier row")
  equal(npc[keys.waypoints], { [1519] = { { {0, 0}, {0.75, 0}, {1.5, 0}, {2.25, 0}, {3, 0} } } },
    "Generation transforms the static-corrected path using the city's half-scale threshold")
  equal(loaded.Npc.entities[990002][keys.waypoints], { [12] = { { {0, 0}, {1.5, 0}, {3, 0} } } },
    "Generation uses the ordinary threshold outside cities")
end
