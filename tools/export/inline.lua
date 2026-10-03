-- Standalone Lua tables, one entity per line. Nested tuples/maps use the shared serializer.
local config = dofile("src/config.lua")
local lib = dofile("generator/lib.lua")
local serialize = dofile("generator/serialize.lua")

local inline = {}

---Load Forever's converted Era base and fold in the real Static Correction registry.
---Dynamic Corrections and Derived Passes deliberately remain outside this source export.
---@param includeAuthored boolean? Include authored Forever Static Corrections; defaults to false.
function inline.loadForever(includeAuthored)
  local flavor = config.flavorByName.Forever
  local loaded = dofile("generator/flavor.lua").load(flavor, nil, false)
  local runtime = dofile("generator/runtime.lua")
  local db = runtime.build()
  if not includeAuthored then
    local selected = {}
    for _, spec in ipairs(db.CorrectionManifest) do
      -- Authored Forever providers live directly here; legacy/generated/traces are retained.
      if not spec.file:match("^Forever/forever[^/]+Fixes%.lua$") then
        selected[#selected + 1] = spec
      end
    end
    db.CorrectionManifest = selected
  end
  runtime.loadCorrections(db, flavor)
  for _, entityType in ipairs(config.entityTypes) do
    db.Corrections.ApplyStaticToEntities(entityType.name, loaded[entityType.name].entities,
      flavor, db.Corrections.OWNER)
  end
  return loaded, db.Corrections
end

local function rowLiteral(row, fieldCount)
  local last = 0
  for index in pairs(row) do
    assert(type(index) == "number" and index % 1 == 0 and index >= 1 and index <= fieldCount,
      "Export row contains an unknown field: " .. tostring(index))
    last = math.max(last, index)
  end

  local parts = {}
  -- Never use #row: a nil hole must not hide a later field.
  for index = 1, last do
    parts[#parts + 1] = serialize.value(row[index])
  end
  return "{" .. table.concat(parts, ",") .. "}"
end

---Render one entity type's corrected source rows without getter defaults or normalization.
---@param entry table {meta, entities}, as returned for one type by generator/flavor.lua.
---@param includeAuthored boolean? Must match the loadForever selection; defaults to false.
function inline.render(entry, includeAuthored)
  local name = entry.meta.entity:lower()
  local lines = {
    "-- Generated Forever " .. entry.meta.entity .. " static data. Do not edit.",
    "-- Base -> inherited corrections -> generated base -> traces"
      .. (includeAuthored and " -> authored corrections." or ". Authored corrections excluded."),
    "-- No Dynamic Corrections, Derived Passes, localization or getter normalization.",
    "local " .. name .. " = {}",
  }
  for _, index in ipairs(lib.sortedIds(entry.meta.names)) do
    lines[#lines + 1] = "-- [" .. index .. "] = " .. entry.meta.names[index]
  end
  for _, id in ipairs(lib.sortedIds(entry.entities)) do
    lines[#lines + 1] = name .. "[" .. serialize.integer(id) .. "]="
      .. rowLiteral(entry.entities[id], entry.meta.fieldCount)
  end
  lines[#lines + 1] = "return " .. name .. "\n"
  return table.concat(lines, "\n")
end

return inline
