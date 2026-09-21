-- generator/schema.lua
--
-- Checks owned entity data against the canonical field tables in src/meta/.

local lib = dofile("generator/lib.lua")

local schema = {}

--- Check a data file's own copy of the key enum against the owned schema.
---
--- `questKeys` is defined inside each data file, so a *disagreement* there means the data and
--- the schema have drifted apart and generation must stop. A trailing *omission* is different
--- and legitimate: a field can be added to the canonical enum before every expansion's data
--- file is regenerated, and until then no row in that file carries the field. Two such
--- omissions exist today — `itemKeys.teachesSpell` (16) is absent from all five item data
--- files, and `objectKeys.waypoints` (7) is absent from MoP's.
---
---@return table omitted fieldName -> fieldIndex present in the schema but not in the data file
function schema.checkKeys(meta, keys, where)
  for name, index in pairs(keys) do
    if meta.keys[name] == nil then
      error(string.format("%s: key enum drift in %s — '%s' (index %s) is not in the owned schema. " ..
        "Update src/meta/ and the data key enums together.",
        meta.entity, where, name, tostring(index)), 0)
    end
    if meta.keys[name] ~= index then
      error(string.format("%s: key enum drift in %s — '%s' is %s there and %s in the owned schema",
        meta.entity, where, name, tostring(index), tostring(meta.keys[name])), 0)
    end
  end

  local omitted = {}
  for name, index in pairs(meta.keys) do
    if keys[name] == nil then omitted[name] = index end
  end
  return omitted
end

--- Fail if any row carries data in a field the data file's key enum never declared. This is
--- what makes a trailing omission safe to tolerate rather than merely tolerated.
function schema.assertNoDataBeyondKeys(meta, entities, keys, where)
  local declared = 0
  for _, index in pairs(keys) do
    if index > declared then declared = index end
  end
  for id, row in pairs(entities) do
    for index in pairs(row) do
      if type(index) == "number" and index > declared then
        error(string.format("%s: %s id %s carries data at field index %d, but its key enum " ..
          "declares only %d fields", meta.entity, where, tostring(id), index, declared), 0)
      end
    end
  end
end

--- Load the owned schema for one entity type.
function schema.loadMaterialized(entityType)
  local path = "src/meta/" .. entityType.name:lower() .. "Meta.lua"
  if not lib.fileExists(path) then
    error("Missing owned schema " .. path, 0)
  end
  return dofile(path)
end

return schema
