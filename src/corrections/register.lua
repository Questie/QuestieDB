-- Compose native exports only after all selected files have loaded. Providers publish directly
-- into the addon namespace; unlike raw/support payloads, this path has no legacy module loader.
-- The manifest owns registration sequence and policy. The registry owns application and consumer
-- precedence after entries are published.
--
-- Registration is intentionally not transactional. If validation fails after an earlier entry
-- was published, discard the failed addon namespace and load a fresh one before retrying.
local _, LibQuestieDB = ...
local registry = LibQuestieDB.Corrections
local config = LibQuestieDB.config
local seen = {}

for _, spec in ipairs(LibQuestieDB.CorrectionManifest) do
  -- Select one applicable native provider. Era/Forever may reuse a key only because their
  -- file-level applicability is mutually exclusive.
  if config.correctionApplies(spec, LibQuestieDB.flavor)
      and LibQuestieDB.IsCorrectionProviderActive(spec.provider) then
    assert(not seen[spec.provider], "duplicate applicable correction provider: " .. spec.provider)
    seen[spec.provider] = true
    local providers = LibQuestieDB.CorrectionProviders[spec.provider]
    assert(type(providers) == "table", "missing correction provider: " .. spec.file)

    -- Validate and publish every centrally declared export in manifest order.
    local methods = {}
    for _, declaration in ipairs(spec.functions) do
      assert(declaration.category == "static" or declaration.category == "dynamic",
        "invalid correction category: " .. declaration.name)
      assert(not methods[declaration.method], "duplicate correction function: " .. declaration.name)
      methods[declaration.method] = true
      -- Unstripped worktrees and stripped packages share this path. Baked never registers
      -- Static exports, and packages need not define them at all.
      if LibQuestieDB.mode ~= "baked" or declaration.category == "dynamic" then
        local func = providers[declaration.method]
        assert(type(func) == "function", "missing correction function: " .. spec.file .. ":" .. declaration.method)
        local register = declaration.category == "dynamic" and registry.RegisterRuntimeCorrection or registry.RegisterCorrection
        local order = assert(registry.loadOrder[declaration.order], "unknown correction order: " .. declaration.order)
        local entry = register(registry.OWNER, spec.datatype, declaration.name, func, order + declaration.offset)
        entry.minExpansionOrder = declaration.minExpansionOrder
        entry.sourceExpansionOrder = declaration.sourceExpansionOrder
        entry.expansions = declaration.expansions
        entry.options = declaration.options
      end
    end
    -- Reject provider exports that have no central category, identity, or ordering policy.
    for method in pairs(providers) do
      assert(methods[method], "unlisted correction function: " .. spec.file .. ":" .. tostring(method))
    end
  end
end
