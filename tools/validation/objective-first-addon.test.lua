-- Full-addon and stripped-package coverage. Run after Generation in an isolated checkout;
-- the focused objective-first suite needs no entity payload generation.
local lib = dofile("generator/lib.lua")
local testFiles = dofile("tools/validation/test-files.lua")
local config = dofile("src/config.lua")
local fixture = dofile("tools/validation/correction-block.lua")
-- Earlier suites may leave a LibStub mock that cannot register LibDeflate. Load the
-- client's offline dependencies without it, then restore it even if loading fails.
local savedLibStub = rawget(_G, "LibStub")
_G.LibStub = nil
local clientLoaded, client = pcall(dofile, "emulator/client.lua")
_G.LibStub = savedLibStub
assert(clientLoaded, client)
local emulator = dofile("emulator/metadata.lua")

---@param value string
---@return string quoted
local function quote(value)
  return lib.shellQuote(value)
end

---@param command string
---@return boolean succeeded
local function succeeds(command)
  local status = lib.execute(command)
  return status == true or status == 0
end

---@param check fun(condition: boolean, message: string)
---@param equal fun(actual: any, expected: any, message: string)
---@param selectedFlavor? table|string A flavor for artifact gates, or Source for shared checks.
---@return nil
return function(check, equal, selectedFlavor)
  local sourceOnly = selectedFlavor == "Source"
  if sourceOnly then selectedFlavor = nil end
  local generated, available = {}, {}
  local flavors = config.flavors
  if sourceOnly then
    flavors = {}
  elseif selectedFlavor then
    flavors = { selectedFlavor }
  end
  -- The explicit hint witnesses below cover these five flavors. Forever has no witness
  -- here yet; its generic artifact and independent data tests still run.
  for _, flavor in ipairs(flavors) do
    if flavor.name ~= "Forever" then
      if lib.fileExists(config.tocPath(flavor)) then
        generated[#generated + 1] = flavor
        available[flavor.name] = true
      else
        io.write("  SKIP objective-first-addon Baked/stripped ", flavor.name, ": artifact not generated\n")
      end
    end
  end
  if #generated == 0 and not sourceOnly then return end

  -- Stage the union of the actual emitted file lists, like the combined release package.
  -- Use a unique directory and remove only this test's copies, including on assertion errors.
  local stage = not sourceOnly and testFiles.temporaryDirectory() or nil
  local ok, err = pcall(function()
    if stage then
      local copied = {}
      for _, flavor in ipairs(generated) do
        local toc = config.tocPath(flavor)
        lib.copyFile(toc, stage .. "/" .. toc)
        for _, file in ipairs(fixture.tocFiles(toc)) do
          if not copied[file] then
            lib.mkdirp(stage .. "/" .. assert(file:match("^(.+)/")))
            lib.copyFile(file, stage .. "/" .. file)
            copied[file] = true
          end
        end
      end
      local lua = os.getenv("LUA") or "lua5.1"
      assert(succeeds(quote(lua) .. " tools/distribution/strip-static.lua " .. quote(stage) .. " --quiet"),
        "staged package failed Static Correction stripping and per-file behavior parity")
      local stripped = lib.readAll(stage .. "/src/corrections/Era/classicQuestFixes.lua")
      check(stripped:find("Static body stripped at package time", 1, true) ~= nil,
        "the staged addon really contains stripped correction bodies")
    end

    -- These few authored hints witness expansion inheritance and season boundaries.
    -- The synthetic scope tests cover Titan even though it currently declares no hints.
    local cases = {
      { name = "Vanilla", flavor = "Vanilla", season = 0, expected = { item = true } },
      { name = "SoD", flavor = "Vanilla", season = 2, expected = { item = true, event = true } },
      { name = "TBC", flavor = "TBC", season = 0, expected = { item = true } },
      { name = "Wrath", flavor = "Wrath", season = 0, expected = { item = true } },
      { name = "Titan", flavor = "Wrath", season = 109, expected = { item = true } },
      { name = "Cata", flavor = "Cata", season = 0, expected = { item = true, killCredit = true } },
      { name = "Mists", flavor = "Mists", season = 0,
        expected = { item = true, killCredit = true, spell = true } },
      { name = "Vanilla after seasons", flavor = "Vanilla", season = 0, expected = { item = true } },
    }
    local personas = {}
    for _, persona in ipairs(cases) do
      if not selectedFlavor or persona.flavor == selectedFlavor.name then
        personas[#personas + 1] = persona
      end
    end
    for _, persona in ipairs(personas) do
      local flavor = config.flavorByName[persona.flavor]
      local modes = { { name = "Source", mode = "source", toc = "QuestieDB.toc" } }
      if available[flavor.name] then
        modes[#modes + 1] = { name = "Baked", mode = "baked", toc = config.tocPath(flavor) }
        modes[#modes + 1] = { name = "stripped package", mode = "baked",
          toc = stage .. "/" .. config.tocPath(flavor), root = stage }
      end
      for _, mode in ipairs(modes) do
        client.reset()
        client.install({ expansion = flavor.expansion })
        _G.C_Seasons.GetActiveSeason = function() return persona.season end
        _G.C_Seasons.HasActiveSeason = function() return persona.season ~= 0 end
        emulator.install(config.addonName, emulator.parse(mode.toc))
        local namespace = emulator.loadAddon(mode.toc, config.addonName, mode.root)
        local label = persona.name .. " full " .. mode.name
        check(namespace.mode == mode.mode, label .. " selects the expected backend")
        local hints = namespace.ObjectiveFirst
        equal({ item = hints.itemObjectiveFirst[503], event = hints.eventObjectiveFirst[85304],
          killCredit = hints.killCreditObjectiveFirst[52], spell = hints.spellObjectiveFirst[10068] },
          persona.expected, label .. " admits only this expansion's and season's hints")
        check(namespace.ObjectiveFirst == namespace.CorrectionCompat.objectiveFirst,
          label .. " publishes the original hint table")
        check(rawget(_G, "QuestieLoader") == nil, label .. " restores QuestieLoader")
        -- Retain only the small hint tables, not multi-expansion entity payloads.
        namespace = nil
        client.reset()
        collectgarbage("collect")
      end
    end
  end)
  client.reset()
  if stage then
    local cleaned = pcall(testFiles.removeTree, stage)
    check(cleaned, "removed only the temporary ObjectiveFirst addon stage")
  end
  assert(ok, err)
end
