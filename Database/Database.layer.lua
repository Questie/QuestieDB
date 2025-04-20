-- ? This file contains layer functions to allow for the creation of frames in the CLI environment

---@class LibQuestieDB
local LibQuestieDB = select(2, ...)

---@class Database
---@field package TemplateToPath table<string, string> @ Only used when running the CLI
---@field package CreateFakeFrame fun(GetTextTable: table):table
local Database = LibQuestieDB.Database

local f = string.format
function Database.GetTemplateNames()
  print("Getting all template names")
  ---@type table<string, string>
  Database.TemplateToPath = {}
  for entityType in pairs(Database.entityTypes) do
    local templateFile = entityType .. "DataFiles.xml"
    assert(type(FindFile) == "function", "FindFile function is missing.")
    local filepath = FindFile(templateFile)
    print(f("Data file found (%s): %s", tostring(templateFile), tostring(filepath)))
    -- Read the file and parse the XML
    -- Example content
    -- <SimpleHTML name="ItemDataIds" file="Interface\AddOns\QuestieDB\Database\Item\Era\ItemDataIds.html" virtual="true" font="GameFontNormal"/>
    -- <SimpleHTML name="ItemDataFiles" file="Interface\AddOns\QuestieDB\Database\Item\Era\ItemDataTemplates.html" virtual="true" font="GameFontNormal"/>
    -- <SimpleHTML name="ItemData25-236" file="Interface\AddOns\QuestieDB\Database\Item\Era\_data\25-236.html" virtual="true" font="GameFontNormal"/>
    for line in io.lines(filepath) do
      local templateName, filePath = line:match('<SimpleHTML name="([^"]+)" file="Interface\\AddOns\\QuestieDB\\([^"]+)"')
      if templateName and filePath then
        Database.TemplateToPath[templateName] = "./" .. filePath:gsub("\\", "/")
        -- I was stupid once upon a time and saved the folder as lowercase... stupid me...
        Database.TemplateToPath[templateName] = Database.TemplateToPath[templateName]:gsub("/L10n/", "/l10n/")
      else
        print("WARNING - Template not found in line: " .. line)
      end
    end
  end
end

do
  local NOP = function() end
  ---
  function Database.CreateFakeFrame(GetTextTable)
    local frame = {}
    frame.Hide = NOP
    frame.UnregisterEvent = NOP
    frame.RegisterEvent = NOP
    frame.SetScript = NOP
    frame.GetRegions = function()
      return unpack(GetTextTable)
    end
    return frame
  end
end

---[Documentation](https://warcraft.wiki.gg/wiki/API_CreateFrame)
---@generic T, Tp
---@param frameType `T` | FrameType
---@param name? string
---@param parent? any
---@param template? `Tp` | TemplateType
---@param id? number
---@return T|Tp frame
function Database.CreateFrame(frameType, name, parent, template, id)
  -- Is_CLI is set in the CLI environment, otherwise it is nil
  ---@diagnostic disable-next-line: undefined-global
  if Is_CLI then
    assert(frameType == "SimpleHTML" or frameType == "Frame", "Only SimpleHTML frames are supported in the CLI environment.")
    if frameType == "SimpleHTML" then
      if Database.TemplateToPath == nil then
        Database.GetTemplateNames()
      end
      assert(Database.TemplateToPath[template], "Template not found: " .. template)
      -- In the CLI environment, we don't want to create frames but instead find the files that would be loaded.
      -- Example: If template is ItemData, we want to find the file "ItemDataFiles.xml" and return the path to it.
      assert(type(FindFile) == "function", "FindFile function is missing.")
      local filepath = Database.TemplateToPath[template]

      -- ? Load the file
      local file = io.open(filepath, "r")
      assert(file, "File not found: " .. filepath)
      local content = file:read("*all")
      file:close()

      -- Replace all newlines with spaces
      -- TODO: When l10n is fixed to not create newlines, remove this
      content = content:gsub("\n", " ")

      -- ? Read all the data between <p> tags
      local allPData = {}
      for pData in string.gmatch(content, '<p>(.-)</p>') do
        local fakeFontString = {}
        fakeFontString.GetText = function()
          return pData
        end
        table.insert(allPData, fakeFontString)
      end

      return Database.CreateFakeFrame(allPData)
    else
      -- ? Create a fake frame
      return Database.CreateFakeFrame({})
    end
  else
    -- ? Create a real frame
    return CreateFrame(frameType, name, parent, template, id)
  end
end
