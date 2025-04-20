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
  -- Remove filename from path
  script_path = script_path:match("(.*/)")
  -- Remove trailing / or \ if present
  script_path = script_path:gsub("[/\\]*$", "") .. "/"
  return script_path
end

--- Get the project directory path.
---@return string The project directory path.
local function get_project_dir_path()
  return get_script_dir() .. ".."
end

--- Capitalize a string.
--- @param str string The string to capitalize.
--- @return string The capitalized string.
local function capitalize(str)
  return str:sub(1, 1):upper() .. str:sub(2)
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
  local current_dir = get_script_dir()
  -- Remove the trailing .database_generator
  current_dir = current_dir:gsub("/%.database_generator/", "/")

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

  -- Remove / or \ characters
  addon_dir = addon_dir:gsub("[/\\]", "")

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

--- Recursively create directories if they don't exist.
---@param dir_path string The directory path to ensure exists.
local function ensureDirExists(dir_path)
  -- Check if the path exists and is a directory
  local mode = lfs.attributes(dir_path, "mode")
  if mode == "directory" then
    return true -- Directory already exists
  elseif mode then
    print("Error: Path exists but is not a directory: " .. dir_path)
    return false -- Path exists but is not a directory
  end

  -- Try to create the directory
  -- Find the parent directory
  local parent_dir = dir_path:match("^(.*)/[^/]+$") or dir_path:match("^(.*)\\[^\\]+$")
  if parent_dir and parent_dir ~= "" and parent_dir ~= "." and parent_dir ~= ".." then
    -- Recursively ensure the parent directory exists
    ensureDirExists(parent_dir)
  end

  -- Create the current directory
  local success, err = lfs.mkdir(dir_path)
  if not success then
    -- Check if it was created by another process in the meantime
    mode = lfs.attributes(dir_path, "mode")
    if mode ~= "directory" then
      print("Error creating directory " .. dir_path .. ": " .. tostring(err))
      return false
    end
  end
  return true
end

--- Remove all .html files from a specified directory.
---@param dir_path string The directory path from which to remove HTML files.
local function clearHtmlFiles(dir_path)
  local mode = lfs.attributes(dir_path, "mode")
  if mode ~= "directory" then
    print("Warning: Cannot clear HTML files, path is not a directory or does not exist: " .. dir_path)
    return
  end

  print("Clearing *.html files from: " .. dir_path)
  local removed_count = 0
  for file in lfs.dir(dir_path) do
    -- Skip '.' and '..' directories
    if file ~= "." and file ~= ".." then
      local file_path = dir_path .. "/" .. file
      local file_mode = lfs.attributes(file_path, "mode")
      -- Check if it's a file and ends with .html (case-insensitive)
      if file_mode == "file" and file:lower():match("%.html$") then
        local success, err = os.remove(file_path)
        if success then
          removed_count = removed_count + 1
        else
          print("Error removing file " .. file_path .. ": " .. tostring(err))
        end
      end
    end
  end
  print("Removed " .. removed_count .. " HTML files.")
end

--- Ensures a .gitkeep file exists in the specified directory.
--- Creates the file if it doesn't exist.
---@param dir_path string The directory path to check.
local function ensureGitKeepFile(dir_path)
  local gitkeepFilePath = dir_path .. "/.gitkeep"
  -- Check if the file already exists
  if not lfs.attributes(gitkeepFilePath, "mode") then
    -- Attempt to create the file
    local gitkeepFile, err = io.open(gitkeepFilePath, "w")
    if gitkeepFile then
      -- Write nothing to create an empty file
      gitkeepFile:write("")
      gitkeepFile:close()
      print("Created .gitkeep file in " .. dir_path)
    else
      -- Print error if file creation failed
      print("Failed to create .gitkeep file in " .. dir_path .. ": " .. tostring(err))
    end
    -- else File already exists, do nothing
  end
end

---Dumps the data for Item, Quest, Npc, Object into a string
---@param tbl table<number, table<number, any>> @ Table that will be dumped, Item, Quest, Npc, Object
---@param dataKeys ItemDBKeys|QuestDBKeys|NpcDBKeys|ObjectDBKeys @ Contains name of data as keys and their index as value
---@param dumpFunctions table<string, function> @ Contains the functions that will be used to dump the data
---@param combineFunc function? @ Function that will be used to combine the data, if nil the data will not be combined
---@return string,table<number, table<number, string>>,table<number, table<number, any>> @ Returns the dumped data as a string and a table of the dumped data
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
  local allResultsDataTbl = {}
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

    -- Save the data to a table
    allResultsTbl[sortKey] = data
    -- Call me lazy but it is easier to load the string into a table
    -- It is a bit slower but keeps the earlier code cleaner
    allResultsDataTbl[sortKey] = loadstring("return {" .. data .. "}")()


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

  return table.concat(allResults), allResultsTbl, allResultsDataTbl
end

---@class helpers
local return_table = {
  capitalize = capitalize,
  get_project_dir_path = get_project_dir_path,
  get_data_dir_path = get_data_dir_path,
  find_addon_name = find_addon_name,
  read_expansion_data = read_expansion_data,
  dumpData = dumpData,
  download_text_file = download_text_file,
  ensureDirExists = ensureDirExists,
  clearHtmlFiles = clearHtmlFiles,
  ensureGitKeepFile = ensureGitKeepFile,
}
-- Expose functions
return return_table
