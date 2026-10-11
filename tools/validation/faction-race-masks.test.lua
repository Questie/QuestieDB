-- Literal faction membership expectations cover native Source selection and Baked metadata.
return function(equal)
  local config = dofile("src/config.lua")
  local client = dofile("emulator/client.lua")
  local emulator = dofile("emulator/metadata.lua")
  local encode = dofile("generator/encode.lua")
  local cases = {
    { flavor = "Vanilla", Alliance = 77, Horde = 178, allClasses = 1503 },
    { flavor = "TBC", Alliance = 1101, Horde = 690, allClasses = 1503 },
    { flavor = "Wrath", Alliance = 1101, Horde = 690, allClasses = 1535 },
    { flavor = "Cata", Alliance = 2098253, Horde = 946, allClasses = 1535 },
    { flavor = "Mists", Alliance = 18875469, Horde = 33555378, allClasses = 2047 },
    -- Forever has no classKeys of its own and uses its Classic rules flavor's table.
    { flavor = "Forever", Alliance = 4294967373, Horde = 8589934770, allClasses = 1503 },
    { flavor = "Vanilla", season = "SoD", Alliance = 77, Horde = 178, allClasses = 1503 },
    { flavor = "Wrath", season = "TitanReforged", Alliance = 1101, Horde = 690, allClasses = 1535 },
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
    equal(source.Enum.classKeys.ALL_CLASSES, case.allClasses, label .. " Source publishes active class keys")
    equal(source.Enum.classKeys.MAGE, 128, label .. " Source class keys carry named classes")

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
    equal(baked.Enum.classKeys.ALL_CLASSES, case.allClasses, label .. " Baked publishes active class keys")
  end
  client.reset()
end
