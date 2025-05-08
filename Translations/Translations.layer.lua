-- ? This file contains layer functions to allow for the creation of frames in the CLI environment

---@class LibQuestieDB
local LibQuestieDB = select(2, ...)

---@class Translation
---@field package TemplateToPath table<string, string> @ Only used when running the CLI
---@field package CreateFakeFrame fun(GetTextTable: table):table
local Translation = LibQuestieDB.Translation

local f = string.format

---@package
local function GetTemplateNames()
  print("Getting all template names")

  ---@type table<string, string>
  Translation.TemplateToPath = {}
  local templateFile = "TranslationsDataFiles.xml"
  assert(type(FindFile) == "function", "FindFile function is missing.")
  local filepath = FindFile(templateFile, nil, nil, "Translations")
  print(f("Data file found (%s): %s", tostring(templateFile), tostring(filepath)))
  -- Read the file and parse the XML
  -- Example content
  -- <SimpleHTML name="ac.html" file="Interface\AddOns\QuestieDB\translations\_data\ac.html" virtual="true" font="GameFontNormal"/>
  -- <SimpleHTML name="ab.html" file="Interface\AddOns\QuestieDB\translations\_data\ab.html" virtual="true" font="GameFontNormal"/>
  for line in io.lines(filepath) do
    local templateName, filePath = line:match('<SimpleHTML name="([^"]+)" file="Interface\\AddOns\\QuestieDB\\([^"]+)"')
    if templateName and filePath then
      Translation.TemplateToPath[templateName] = "./" .. filePath:gsub("\\", "/")
      -- I was stupid once upon a time and saved the folder as lowercase... stupid me...
      Translation.TemplateToPath[templateName] = Translation.TemplateToPath[templateName]:gsub("/L10n/", "/l10n/")
    else
      if not line:match('</*Ui>') and not line:match('<Ui ') then
        print("WARNING - Template not found in line: " .. line)
      end
    end
  end
end

local NOP = function() end
---
local function CreateFakeFrame(GetTextTable)
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

---[Documentation](https://warcraft.wiki.gg/wiki/API_CreateFrame)
---@generic T
---@param frameType `T` | FrameType
---@param name? string
---@param parent? any
---@param template string
---@param id? number
---@return T frame
function Translation.CreateFrame(frameType, name, parent, template, id)
  -- Is_CLI is set in the CLI environment, otherwise it is nil
  ---@diagnostic disable-next-line: undefined-global
  if Is_CLI then
    assert(frameType == "SimpleHTML" or frameType == "Frame", "Only SimpleHTML frames are supported in the CLI environment.")
    if frameType == "SimpleHTML" then
      if Translation.TemplateToPath == nil then
        GetTemplateNames()
      end
      assert(Translation.TemplateToPath[template], "Template not found: " .. template)
      -- In the CLI environment, we don't want to create frames but instead find the files that would be loaded.
      assert(type(FindFile) == "function", "FindFile function is missing.")
      local filepath = Translation.TemplateToPath[template]

      -- ? Load the file
      local file = io.open(filepath, "r")
      assert(file, "File not found: " .. filepath)
      local content = file:read("*all")
      file:close()

      -- Replace all newlines with spaces
      -- TODO: When l10n is fixed to not create newlines, remove this
      -- content = content:gsub("\n", " ")

      -- ? Read all the data between <p> tags
      local allPData = {}
      for pData in string.gmatch(content, '<p>(.-)</p>') do
        local fakeFontString = {}
        fakeFontString.GetText = function()
          return pData
        end
        table.insert(allPData, fakeFontString)
      end

      return CreateFakeFrame(allPData)
    else
      -- ? Create a fake frame
      return CreateFakeFrame({})
    end
  else
    -- ? Create a real frame
    return CreateFrame(frameType, name, parent, template, id)
  end
end
