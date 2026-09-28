-- generator/runtime.lua
--
-- Stands up the shipped `src/` namespace offline, so Generation applies Static Corrections
-- through the *same* registry the client uses rather than a parallel implementation.
--
-- This is what makes "what I see in dev is what ships" a property of shared code. If the
-- generator had its own correction engine, source/baked equivalence would be testing two
-- implementations against each other and every divergence would be a coin flip about which one
-- was right.

local runtime = {}

--- Load one `src/` file with WoW's addon varargs.
---@param path string
---@param addonName string
---@param addonTable table
---@return nil
local function execute(path, addonName, addonTable)
  local chunk, err = loadfile(path)
  if not chunk then error("Cannot load " .. path .. ": " .. tostring(err), 0) end
  local ok, execErr = pcall(chunk, addonName, addonTable)
  if not ok then error("Error loading " .. path .. ": " .. tostring(execErr), 0) end
end

runtime.execute = execute

--- Build a fresh `LibQuestieDB` namespace with everything Generation needs: config, the
--- materialized schema, nil/empty semantics, constants, and the corrections registry. No read
--- backend: the generator reads raw tables directly. A fresh namespace is also the recovery
--- boundary when provider loading or central registration fails.
---@return table
function runtime.build()
  local config = dofile("src/config.lua")
  local LibQuestieDB = {}

  -- Runtime foundation shared with the shipped addon.
  local files = {
    "src/config.lua",
    "src/meta/normalize.lua",
    "src/meta/codec.lua",
    "src/meta/questMeta.lua",
    "src/meta/npcMeta.lua",
    "src/meta/itemMeta.lua",
    "src/meta/objectMeta.lua",
    "src/corrections/registry.lua",
  }
  for _, path in ipairs(files) do
    execute(path, "QuestieDB", LibQuestieDB)
  end

  -- Correction authoring environment and central inventory. Provider files load later, once
  -- loadCorrections has an explicit flavor for file and season applicability.
  for _, path in ipairs(config.enumFiles) do
    execute(path, "QuestieDB", LibQuestieDB)
  end
  execute("src/corrections/objectiveFirst.lua", "QuestieDB", LibQuestieDB)
  execute("src/corrections/manifest.lua", "QuestieDB", LibQuestieDB)

  -- Derived Passes share this namespace with the correction registry on purpose: Generation
  -- and Source mode must run the same pass code over the same corrected tables, exactly as
  -- they already share ApplyStaticToEntities. See docs/adr/0004-derived-passes.md.
  for _, path in ipairs(config.derivedFiles) do
    execute(path, "QuestieDB", LibQuestieDB)
  end

  return LibQuestieDB
end

--- Load the same native files selected by the addon, with explicit flavor rules.
--- Files publish exports and hints before central registration. Neither loading nor
--- registration is transactional: discard a failed namespace and rebuild before retrying.
---@param LibQuestieDB table
---@param flavor table
---@return number registered
---@return number loadedFiles
function runtime.loadCorrections(LibQuestieDB, flavor)
  local config = LibQuestieDB.config

  LibQuestieDB.flavor = flavor
  execute("src/corrections/prepare.lua", "QuestieDB", LibQuestieDB)
  local before = #LibQuestieDB.Corrections.Select({})
  local loadedFiles = 0

  -- Native provider chunks publish lazy exports and ObjectiveFirst hints. They do not register
  -- themselves, so every selected export is available before central composition starts.
  for _, spec in ipairs(LibQuestieDB.CorrectionManifest) do
    if config.correctionApplies(spec, flavor) and
       (LibQuestieDB.mode ~= "baked" or config.hasDynamicCorrections(spec)) then
      execute("src/corrections/" .. spec.file, "QuestieDB", LibQuestieDB)
      loadedFiles = loadedFiles + 1
    end
  end

  -- Validate the complete export inventory and publish registry entries in manifest order.
  execute("src/corrections/register.lua", "QuestieDB", LibQuestieDB)
  return #LibQuestieDB.Corrections.Select({}) - before, loadedFiles
end

return runtime
