-- Literal faction membership expectations cover native Source selection and Baked metadata.
return function(equal)
  local config = dofile("src/config.lua")
  local client = dofile("emulator/client.lua")
  local emulator = dofile("emulator/metadata.lua")
  local encode = dofile("generator/encode.lua")
  local cases = {
    { flavor = "Vanilla", Alliance = 77, Horde = 178 },
    { flavor = "TBC", Alliance = 1101, Horde = 690 },
    { flavor = "Wrath", Alliance = 1101, Horde = 690 },
    { flavor = "Cata", Alliance = 2098253, Horde = 946 },
    { flavor = "Mists", Alliance = 18875469, Horde = 33555378 },
    { flavor = "Forever", Alliance = 4294967373, Horde = 8589934770 },
    { flavor = "Vanilla", season = "SoD", Alliance = 77, Horde = 178 },
    { flavor = "Wrath", season = "TitanReforged", Alliance = 1101, Horde = 690 },
  }

  for _, case in ipairs(cases) do
    local flavor = config.flavorByName[case.flavor]
    local label = case.season or case.flavor
    local expected = { Alliance = case.Alliance, Horde = case.Horde }

    client.reset()
    client.install({ expansion = flavor.expansion, season = case.season })
    -- Native file selection, not the project ID, owns Source flavor selection.
    _G.WOW_PROJECT_ID = -1
    local source = emulator.loadAddon(config.addonName .. ".toc", config.addonName)
    equal(source.readMode, "source", label .. " exercises Source mode")
    equal(source.Enum.factionRaceMasks, expected, label .. " Source publishes active faction masks")

    client.reset()
    client.install({ expansion = "Classic", season = case.season })
    -- Deliberately keep a Classic client persona: the artifact's X-Flavor owns Baked selection.
    local metadata = { ["X-Flavor"] = case.flavor }
    for _, entity in ipairs(config.entityTypes) do
      metadata["X-" .. entity.name .. "-IDS"] = encode.idList({})
    end
    emulator.install(config.addonName, metadata)
    local baked = {}
    for _, path in ipairs(config.bakedFileList(flavor)) do
      assert(loadfile(path))(config.addonName, baked)
    end
    equal(baked.readMode, "baked", label .. " exercises Baked mode")
    equal(baked.Enum.factionRaceMasks, expected, label .. " Baked publishes active faction masks")
  end
  client.reset()
end
