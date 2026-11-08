-- Loads QuestieDB-owned raw entity providers and their deferred Lua payloads.
-- Both execute privately; neither needs the addon/client mocks used by other inputs.

local loader = {}

---Each file owns its module and globals, including chunks compiled by its payload.
---These are trusted owned inputs, not hostile Lua requiring a security sandbox.
---@return table env
---@return table module
local function environment()
  local module = {}
  local env = {}
  env._G = env
  env.QuestieLoader = {
    ---@param _ table
    ---@param name string
    ---@return table
    ImportModule = function(_, name)
      assert(name == "QuestieDB", "unexpected raw entity import: " .. tostring(name))
      return module
    end,
  }
  -- No ambient globals: raw data must not depend on a preceding client or correction load.
  ---@param text string
  ---@param name string?
  ---@return function? chunk
  ---@return string? err
  env.loadstring = function(text, name)
    local chunk, err = loadstring(text, name)
    if chunk then setfenv(chunk, env) end
    return chunk, err
  end
  return env, module
end

---Load rows and the file's own key header, checked against src/meta/ by the flavor loader.
---@param path string Path to e.g. data/Classic/classicQuestDB.lua
---@param entityType table An entry from config.entityTypes
---@return table entities id -> { [fieldIndex] = value }
---@return table keys fieldName -> fieldIndex
function loader.loadEntityData(path, entityType)
  local env, module = environment()
  local provider, loadErr = loadfile(path)
  if not provider then
    error("Cannot load " .. path .. ": " .. tostring(loadErr), 0)
  end
  setfenv(provider, env)
  local ok, execErr = pcall(provider, "QuestieDB", {})
  if not ok then
    error("Error executing " .. path .. ": " .. tostring(execErr), 0)
  end

  local keys = module[entityType.keysField]
  if type(keys) ~= "table" then
    error(path .. " did not define QuestieDB." .. entityType.keysField .. " as a table", 0)
  end
  local payload = module[entityType.dataField]
  if type(payload) ~= "string" then
    error(path .. " did not define QuestieDB." .. entityType.dataField .. " as a string", 0)
  end

  local chunk, parseErr = env.loadstring(payload, "@" .. path .. ":" .. entityType.dataField)
  if not chunk then
    error("Cannot parse " .. entityType.dataField .. " in " .. path .. ": " .. tostring(parseErr), 0)
  end
  local decoded, entities = pcall(chunk)
  if not decoded then
    error("Error executing " .. entityType.dataField .. " in " .. path .. ": " .. tostring(entities), 0)
  end
  if type(entities) ~= "table" then
    error(entityType.dataField .. " in " .. path .. " did not return a table", 0)
  end
  return entities, keys
end

return loader
