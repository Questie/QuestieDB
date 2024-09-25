-- helpers.lua
local lfs = require("lfs")

-- Require the necessary LuaSocket modules
local http = require("socket.http")
local https = require("ssl.https")
local ltn12 = require("ltn12")

--- Get the script directory.
---@return string The directory containing the script.
local function get_script_dir()
  local script_path = debug.getinfo(1, "S").source:sub(2)
  return script_path:match("(.*/)")
end

--- Get the project directory path.
---@return string The project directory path.
local function get_project_dir_path()
  return get_script_dir() .. ".."
end

--- Get the data directory path for a given entity type and expansion.
---@param entity_type string The type of entity (e.g., "Quest", "Item").
---@param expansion string The expansion name (e.g., "Era", "Tbc", "Wotlk").
---@return string The data directory path.
local function get_data_dir_path(entity_type, expansion)
  local path = get_project_dir_path() .. "/Database/" .. entity_type .. "/" .. expansion
  -- Does path not exist, l10n has this issue...
  if not lfs.attributes(path, "mode") then
    print("Path " .. path .. " does not exist, trying lowercase")
    path = get_project_dir_path() .. "/Database/" .. entity_type:lower() .. "/" .. expansion
  end
  return path
end

--- Find the addon name.
---@return string The addon name.
local function find_addon_name()
  local current_dir = lfs.currentdir()
  local previous_dir = nil
  local addon_dir = nil
  local max_level = 20
  local level = 0

  while level < max_level do
    local dir_name = current_dir:match("([^/]+)$")
    local parent_dir = current_dir:match("^(.*)/[^/]+$")
    if type(dir_name) == "nil" then
      addon_dir = previous_dir
      break
    elseif dir_name:lower() == "addons" and parent_dir:match("([^/]+)$"):lower() == "interface" then
      addon_dir = previous_dir
      break
    else
      previous_dir = current_dir
      current_dir = parent_dir
      level = level + 1
    end
  end

  if not addon_dir then
    print("Could not find the Addons folder, defaulting to 'QuestieDB'.")
    return "QuestieDB"
  else
    print("Found Addons folder: " .. addon_dir)
  end

  return addon_dir
end

--- Read expansion data from a Lua file.
---@param expansion string The expansion name (e.g., "Era", "Tbc", "Wotlk").
---@param entity_type string The type of entity (e.g., "Quest", "Item").
---@return string|nil The content of the Lua file, or nil if not found.
local function read_expansion_data(expansion, entity_type)
  local path = get_data_dir_path(entity_type, expansion)
  print("Reading " .. expansion .. " lua " .. entity_type:lower() .. " data from " .. path)
  local file_path = path .. "/" .. entity_type:sub(1, 1):upper() .. entity_type:sub(2):lower() .. "Data.lua-table"

  if not lfs.attributes(file_path, "mode") then
    file_path = path .. "/" .. entity_type:lower() .. "Data.lua-table"
    if not lfs.attributes(file_path, "mode") then
      print("File not found: " .. file_path)
      return nil
    end
  end

  local file, err = io.open(file_path, "r")
  if not file then
    print("File not found: " .. path)
    return nil
  end

  local data = file:read("*all")
  file:close()

  -- Perform any necessary replacements on the data string
  data = data:gsub("&", "and"):gsub("<", "|"):gsub(">", "|")
  return data
end

--- Download a raw text file from a URL and return its contents as a string.
-- @param url string The URL of the text file to download.
-- @return string|nil The contents of the text file, or nil if the download fails.
local function download_text_file(url)
  local response_body = {}
  local res, code, response_headers = https.request {
    url = url,
    sink = ltn12.sink.table(response_body),
  }

  if res == 1 and code == 200 then
    -- Concatenate the table into a single string
    return table.concat(response_body)
  else
    print("Failed to download file: HTTP response code " .. tostring(code))
    return nil
  end
end

---Dumps the data for Item, Quest, Npc, Object into a string
---@param tbl table<number, table<number, any>> @ Table that will be dumped, Item, Quest, Npc, Object
---@param dataKeys ItemDBKeys|QuestDBKeys|NpcDBKeys|ObjectDBKeys @ Contains name of data as keys and their index as value
---@param dumpFunctions table<string, function> @ Contains the functions that will be used to dump the data
---@param combineFunc function? @ Function that will be used to combine the data, if nil the data will not be combined
---@return string,table[] @ Returns the dumped data as a string and a table of the dumped data
local function dumpData(tbl, dataKeys, dumpFunctions, combineFunc)
  -- sort tbl by key
  local sortedKeys = {}
  for key in pairs(tbl) do
    sortedKeys[#sortedKeys + 1] = key
  end
  table.sort(sortedKeys)

  local nrDataKeys = 0
  local reversedKeys = {}
  for key, id in pairs(dataKeys) do
    reversedKeys[id] = key
    nrDataKeys = nrDataKeys + 1
  end

  local allResultsTbl = {}
  local allResults = { "{\n", }
  for sortKeyIndex = 1, #sortedKeys do
    local sortKey = sortedKeys[sortKeyIndex]

    -- print(sortKey)
    local value = tbl[sortKey]

    local resulttable = {}
    for i = 1, nrDataKeys do
      resulttable[i] = "nil"
    end

    for key = 1, nrDataKeys do
      -- The name of the key e.g. "objectDrops"
      local dataName = dataKeys[key] == nil and reversedKeys[key] or key
      -- The id of the key e.g. "3"-(objectDrops)
      local dataKey = type(key) == "number" and key or dataKeys[key]

      -- print(key, dataName, dataKey)

      -- Get the data from the table
      local data = value[key]

      -- Because we build it with nil we have to check for nil here, if the value is nil we just print nil
      if data ~= "nil" and data ~= nil then
        local dumpFunction = dumpFunctions[dataName]
        if dumpFunction then
          local dumpedData = dumpFunction(data)
          resulttable[dataKey] = dumpedData
        else
          error("No dump function for key: " .. "dataName" .. " (" .. tostring(dataName) .. ")" .. " dataKey: " .. tostring(dataKey))
        end
      else
        resulttable[dataKey] = "nil"
      end
    end
    -- DevTools_Dump({resulttable})

    -- If a combine funnction exist we run it here
    assert(#resulttable == nrDataKeys, "resulttable length is not equal to dataKeys length, combine will fail")
    if combineFunc then
      combineFunc(resulttable)
    end
    -- DevTools_Dump({resulttable})

    -- Concat the data into a string
    local data = table.concat(resulttable, ",")

    allResultsTbl[sortKey] = data

    -- Remove trailing nil
    repeat
      local count = 0
      data, count = string.gsub(data, ",nil$", "")
    until count == 0

    -- Add the data to the result
    allResults[#allResults + 1] = "  [" .. sortKey .. "] = {"
    allResults[#allResults + 1] = data
    allResults[#allResults + 1] = ",},\n"
  end
  allResults[#allResults + 1] = "}"
  -- return result .. "}"
  return table.concat(allResults), allResultsTbl
end

---@class helpers
local return_table = {
  get_project_dir_path = get_project_dir_path,
  get_data_dir_path = get_data_dir_path,
  find_addon_name = find_addon_name,
  read_expansion_data = read_expansion_data,
  dumpData = dumpData,
  download_text_file = download_text_file,
}
-- Expose functions
return return_table
