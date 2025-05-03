local lfs = require('lfs')

CLI_Helpers = {}

function print(...)
  local printstring = ""
  for i = 1, select("#", ...) do
    local arg = select(i, ...)
    if arg == nil then
      printstring = printstring .. "  " .. "nil"
    else
      printstring = printstring .. "  " .. tostring(arg)
    end
  end
  -- Remove colors from the string "|cFFffff00"
  printstring = printstring:gsub("|c%x%x%x%x%x%x%x%x", "")
  io.stdout:write(printstring .. "\n")
  io.stdout:flush()
end

local excludedDirectories = {
  [".git"] = true,
  [".translator"] = true,
  [".wowhead"] = true,
  [".generate_database"] = true,
  [".database_generator"] = true,
  ["venv"] = true,
  [".build"] = true,
  [".vscode"] = true,
  ["_data"] = true,
}

---@param searchName string filename to search for
---@param version string? version to search for
---@return unknown
function FindFile(searchName, version)
  local function search(path)
    for file in lfs.dir(path) do
      if file ~= "." and file ~= ".." and file ~= ".build" then
        local f = path .. '/' .. file
        local attr = lfs.attributes(f)
        if attr.mode == 'directory' then
          if excludedDirectories[file] then
            -- print("Skipping directory: " .. f)
          else
            -- print("Searching directory: " .. f)
            local result = search(f)
            if result then return result end
          end
        else
          -- We want to fetch the correct version of the file
          local correctVersion = true
          if version then
            -- Check if the file is in the correct version directory
            local pathVersion = path:match("/(%w+)$") or ""
            if pathVersion then
              pathVersion = pathVersion:lower()
            end
            version = version:lower()
            correctVersion = pathVersion == version
          end
          if file == searchName and correctVersion then
            print("FindFile: Found file: " .. f)
            return f
          end
        end
      end
    end
  end
  local currentDir = lfs.currentdir()
  print("FindFile: Searching in: " .. currentDir)
  return search(currentDir)
end

function CLI_Helpers.loadFile(filepath)
  assert(CLI_addonName, "CLI_addonName not set")
  assert(CLI_addonTable, "CLI_addonTable not set")
  -- Read file
  local filedata = io.open(filepath, "r")
  if not filedata then
    print("Error loading " .. filepath .. " - File not found")
    error("Error loading " .. filepath .. " - File not found")
    return
  end
  local filetext = filedata:read("*all")
  filetext = filetext:gsub("select%(2, %.%.%.%)", "LibQuestieDBTable")
  local pcallResult, errorMessage

  local chunk = loadstring(filetext, filepath)
  if chunk then
    pcallResult, errorMessage = pcall(chunk, CLI_addonName, CLI_addonTable)
  end
  if pcallResult then
    --print("Loaded " .. filepath)
  else
    if errorMessage then
      print("Error loading " .. filepath .. ": " .. errorMessage)
      error("Error loading " .. filepath .. ": " .. errorMessage)
    else
      print("Error loading " .. filepath .. " - No errorMessage")
      error("Error loading " .. filepath .. " - No errorMessage")
    end
  end
end

--- Loads all files in a xml file
---@param file string file path e.g ".generate_database_lua/Questie/Localization/Translations/Translations.xml"
---@param failIfMissing boolean?
function CLI_Helpers.loadXML(file, failIfMissing)
  local xmlFilePath = file:match("^(.*)/.-%.xml$") .. "/"
  local filedata = io.open(file, "r")
  -- Only load the file if it exists
  -- If you generate for the first time some files in the toc arn't present
  if filedata then
    local filetext = filedata:read("*all")
    -- print(xmlFilePath)
    for xmlFile in string.gmatch(filetext, "<Script.-file%=\"(.-)\"") do
      -- Replace \ with /
      local slashxmlFile = xmlFile:gsub("\\", "/")
      print("  Loading file: ", xmlFilePath .. slashxmlFile)
      CLI_Helpers.loadFile(xmlFilePath .. slashxmlFile)
    end
  else
    if failIfMissing then
      error("Error loading " .. file .. " - File not found")
      os.exit(1)
    end
  end
end

--- Loads all files in a TOC file
---@param file string file path e.g ".generate_database_lua/Questie/Questie.toc"
function CLI_Helpers.loadTOC(file)
  local rfile = io.open(file, "r")
  assert(rfile, "TOC file not found: " .. file)
  for line in rfile:lines() do
    -- If line is longer than 1 character and the first character is not a comment
    if string.len(line) > 1 and string.byte(line, 1) ~= 35 then
      -- If line is not a xml file
      if (not string.find(line, ".xml")) then
        line = line:gsub("\\", "/")
        line = line:gsub("%s+", "")
        print("Loading file: ", line)
        CLI_Helpers.loadFile(line)
      elseif string.find(line, ".xml") then
        line = line:gsub("\\", "/")
        line = line:gsub("%s+", "")
        print("Loading XML:  ", line)
        CLI_Helpers.loadXML(line)
      end
    end
  end
end
