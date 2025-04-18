require("cli.dump")

---@alias trie table<string, any>
---@alias filepath string

-- The root folder
local root_folder = "Translations"
local data_folder = "_data"
local full_path = root_folder .. "/" .. data_folder

-- Variable to disable the writing of html
local write_html = true

-- Double Dagger
local splitCharacter = "‡"

-- Define the maximum number of translations per file
local MAX_TRANSLATIONS_PER_FILE = 50
local SEGMENT_SIZE = 4000
local REDUCE_SEGMENT_SIZE = math.max(math.min(SEGMENT_SIZE * 0.05, 100), 10)

local f = string.format

-- From here
-- https://github.com/Questie/Questie/blob/2e2c44dc42dd66fb144be8ba0115287da5b7cd8e/Localization/l10n.lua#L22
local localeOrder = {
  'enUS',
  'esES',
  'esMX',
  'ptBR',
  'frFR',
  'deDE',
  'ruRU',
  'zhCN',
  'zhTW',
  'koKR',
}

print("Max translations per file: " .. MAX_TRANSLATIONS_PER_FILE)
print("Segment size: " .. SEGMENT_SIZE, "Reduced segment size: " .. SEGMENT_SIZE - REDUCE_SEGMENT_SIZE)

local tConcat = table.concat
local tInsert = table.insert

--- Function to sanitize translation strings by replacing special characters with HTML entities
---@param str string
---@return string
local function sanitize_translation(str)
  str = string.gsub(str, "&", "&amp;")
  str = string.gsub(str, "<", "&lt;")
  str = string.gsub(str, ">", "&gt;")
  -- str = string.gsub(str, "\n", "<br>")
  -- str = string.gsub(str, '"', '\\"')
  return str
end

--- Function to create directories recursively using os.execute
---@param path filepath
local function mkdir(path)
  os.execute("mkdir -p " .. path)
end

--- Function to split a table of strings into segments based on maximum characters per segment
---@param tbl string[] The table of strings to split
---@param max_chars number The maximum number of characters per segment
---@return string[] A table of segments, each being a table of strings
local function split_into_segments(tbl, max_chars)
  local segments = {}
  local current_segment = {}

  -- Is the total length too long?
  if #tConcat(tbl, splitCharacter) > max_chars then
    local concat_current_segments = tConcat(current_segment, splitCharacter)
    for _, segment in ipairs(tbl) do
      -- Will the current length + the next one be over max_chars?
      if #concat_current_segments + #segment > max_chars then
        -- Insert a segment and start a new one
        tInsert(segments, concat_current_segments)
        current_segment = { segment, }
      else
        -- We are below the max_chars limit, so we can add the next string to the current segment
        tInsert(current_segment, segment)
      end
    end
    -- Insert the last segment
    tInsert(segments, concat_current_segments)
  end

  -- Iterate over each segment and write it as a separate paragraph
  local ret_segments = {}
  for idx, segment in ipairs(segments) do
    -- If it's the first segment, prepend the total segments count
    if idx == 1 and #segments > 0 then
      segment = tostring(#segments) .. segment
    elseif idx > 1 then
      segment = tostring(idx) .. segment
    end
    tInsert(ret_segments, segment)
  end

  return ret_segments
end

--- Function to write translations to an HTML file with segmentation
---@param key_path string The path for the translation e.g. translations/u/s/e/t/h/e
---@param translations string[]
---@param translation_func fun(string):string[], string A function that takes the english string and returns all translations
local function write_html_file(key_path, translations, translation_func)
  -- ? This stops the function from writing in subfolders but instead  writes in the root folder
  -- ? Remember to activate the folder creation function in the create_trie_folders function if disabled
  -- "%-" Always escape
  local replaceChar = ""
  key_path = key_path:gsub("/", replaceChar)
  key_path = key_path:gsub(full_path:gsub("/", replaceChar) .. replaceChar, full_path .. "/", 1) -- We also removed the root folder from the key_path, add back the /

  -- Define the file path
  local filename = key_path .. ".html"

  -- Open the file for writing
  if write_html then
    local file, err = io.open(filename, "w")
    if not file then
      print("Error opening file " .. filename .. ": " .. err)
      return
    end

    -- Write the HTML structure
    file:write("<html><body>\n")
    for _, translation in ipairs(translations) do
      local fullTranslationTable, enUS = translation_func(translation)
      file:write("<!--" .. enUS .. "-->\n")

      if #tConcat(fullTranslationTable, splitCharacter) > SEGMENT_SIZE - REDUCE_SEGMENT_SIZE then
        print("Splitting translation into segments", translation, filename)
        -- Split the translation into segments
        local segments = split_into_segments(fullTranslationTable, SEGMENT_SIZE - REDUCE_SEGMENT_SIZE)
        for _, segment in ipairs(segments) do
          file:write("<p>" .. sanitize_translation(segment) .. "</p>\n")
        end
      else
        -- Write the translation as a single paragraph
        local concatenated = tConcat(fullTranslationTable, splitCharacter)
        file:write("<p>" .. sanitize_translation(concatenated) .. "</p>\n")
      end
    end
    file:write("</body></html>\n")
    file:close()
  end
end

-- Function to create trie folders and write translations to HTML files
---comment
---@param trie trie
---@param current_path filepath
---@param translation_func fun(translation:string):string[], string A function that takes the english string and returns all translations
local function write_trie_structure(trie, current_path, translation_func)
  -- print("Current path: " .. current_path)
  for trieKey, translations in pairs(trie) do
    local new_path = current_path .. "/" .. trieKey
    if type(translations) == "table" then
      -- If the number of translations is greater than the maximum or there are no translations
      if #translations > MAX_TRANSLATIONS_PER_FILE or #translations == 0 then
        -- ? This line activates the function to create folders for the current path, disabled due to easier to just have it flat.
        -- * mkdir(new_path)

        -- print("Continuing recursion for: " .. new_path)
        write_trie_structure(translations, new_path, translation_func)
      else
        -- print("Writing HTML file for: " .. new_path)
        write_html_file(new_path, translations, translation_func)
      end
    end
  end
end

--- Function to create a branch in the trie structure
---@param strings string[]
---@param stringIndex number @ The index of the current character in the string
---@return trie
local function create_trie(strings, stringIndex)
  local branch = {}
  -- Process each string in the input array
  for i = 1, #strings do
    local string = strings[i]
    -- Remove all whitespaces from the string
    local cleanedString = string.gsub(string, "%s", "")
    -- Remove all numbers from the string (Not in use as some strings are very short and contains numbers)
    -- cleanedString = string.gsub(cleanedString, "%d+", "")
    -- Remove all punctuation from the string
    cleanedString = string.gsub(cleanedString, "%p", "")
    -- Remove all control characters from the string
    cleanedString = string.gsub(cleanedString, "%c", "")

    -- Get the character at the current index
    -- local char = string.sub(string.lower(cleanedString), stringIndex, stringIndex)
    local char = string.sub(cleanedString, stringIndex, stringIndex)

    if char == "" then
      -- error(f("%s: %d out of range, increase MAX_TRANSLATIONS_PER_FILE", string, stringIndex))
      print(f("%s: %d out of range", string, stringIndex))
      char = "."
      -- tInsert(parent[char], string)
      -- else
    end
    -- Create a new branch for the character if it doesn't exist
    if not branch[char] then
      branch[char] = {}
    end
    tInsert(branch[char], string)
  end

  -- Recursively create branches for child nodes if needed
  for char, child in pairs(branch) do
    if #child > MAX_TRANSLATIONS_PER_FILE then
      branch[char] = create_trie(child, stringIndex + 1)
    end
  end

  return branch
end

-- Function to check if a table is an array of strings
local function isStringArray(t)
  if type(t) ~= "table" then
    return false
  end
  -- Check if the table is a sequence (array) with consecutive integer keys starting at 1
  local index = 1
  for k, v in pairs(t) do
    if type(k) ~= "number" or k ~= index then
      return false
    end
    if type(v) ~= "string" then
      return false
    end
    index = index + 1
  end
  return true
end

-- Recursive function to traverse and modify the trie table
local function replaceArrays(t, filepath)
  for key, value in pairs(t) do
    if type(value) == "table" then
      if isStringArray(value) then
        -- Replace the array of strings with the filepath
        t[key] = filepath .. key .. ".html"
      else
        -- Recursively process nested tables
        replaceArrays(value, filepath .. key)
      end
    end
  end
end

-- Main function to compile translations to HTML
---@param strings string[]
---@param addonName string The folder name for the addon, it is for the path in the XML files
---@param translation_func fun(string):table<string, string|boolean> A function that takes the english string and returns all translations
function Compile_translations_to_html(strings, addonName, translation_func)
  -- Initialize the trie
  local success, trie
  repeat
    success, trie = pcall(create_trie, strings, 1)
    if not success then
      MAX_TRANSLATIONS_PER_FILE = MAX_TRANSLATIONS_PER_FILE + 1
      print(trie)
      print("Shortest word does not fit! - increasing MAX_TRANSLATIONS_PER_FILE to: " .. MAX_TRANSLATIONS_PER_FILE)
    end
  until success

  mkdir(root_folder)
  mkdir(root_folder .. "/" .. data_folder)

  ---@param enUStext string
  ---@return string[]?
  ---@return string enUS translation
  -- -@return error?
  local function getTranslation(enUStext)
    local allTranslations, err = translation_func(enUStext)
    if err then
      return nil, err
    end

    local enUSTranslation = enUStext -- "enUS" .. "[" .. enUStext .. "]"
    local combinedTranslations = {}
    for _, locale in ipairs(localeOrder) do
      local text = allTranslations[locale]
      if type(text) == "string" and locale ~= "enUS" then
        tInsert(combinedTranslations, locale .. "[" .. text .. "]")
      elseif locale ~= "enUS" then
        tInsert(combinedTranslations, "")
      end
    end
    return combinedTranslations, enUSTranslation --tConcat(combinedTranslations, "‡")
  end

  -- Create trie folders and write translations
  write_trie_structure(trie, full_path, getTranslation)

  -- Replace the actual string arrays with the template xml name
  replaceArrays(trie, "")

  local allHTMLFiles = {}
  -- Function to print the table for verification (optional)
  -- Function to print the table for verification and collect HTML files
  ---@param t table The table to print
  ---@param indent string? The indentation string
  ---@return string The formatted table string
  local function printTable(t, indent)
    -- Reset the HTML files if we are on the first step.
    if indent == "" then
      allHTMLFiles = {}
    end
    local lines = {}
    indent = indent or ""
    for k, v in pairs(t) do
      if type(v) == "table" then
        tInsert(lines, indent .. "[\"" .. tostring(k) .. "\"] = {")
        tInsert(lines, printTable(v, indent .. "  "))
        tInsert(lines, indent .. "},")
      else
        -- if html in v use " otherwise it will be wrapped in [[]]
        if string.find(v, ".html") then
          tInsert(lines, indent .. "[\"" .. tostring(k) .. "\"] = \"" .. tostring(v) .. "\",")
          tInsert(allHTMLFiles, v)
        else
          tInsert(lines, indent .. "[\"" .. tostring(k) .. "\"] = [[" .. tostring(v) .. "]],")
        end
      end
    end
    return tConcat(lines, "\n")
  end

  -- ? Generate the lookup file loaded in Lua
  local lua_file = io.open(root_folder .. "/TranslationsLookup_gen.lua", "w")
  if lua_file then
    local dump_str = printTable(trie, "") --dump_trie(point_to_html(trie), 1)
    lua_file:write("-- ! File generated by generate_translation_trie_root.lua --\n")
    lua_file:write("-- ! DO NOT EDIT --\n")
    lua_file:write("---@class LibQuestieDB\n")
    lua_file:write("---@field translationsLookup table<string, table<string, any>|string> Contains lookup for HTML files for translations\n")
    lua_file:write("local LibQuestieDB = select(2, ...)\n")
    lua_file:write("\n")
    lua_file:write(f("LibQuestieDB.translationsLookup = {\n%s\n}", dump_str))
    lua_file:close()
  end

  -- ? Generate the XML file that creates the virtual SimpleHTML objects
  local fileString = '<SimpleHTML name="%s" file="Interface\\AddOns\\%s\\translations\\%s\\%s" virtual="true" font="GameFontNormal"/>\n'
  lua_file = io.open(root_folder .. "/TranslationsFiles_gen.xml", "w")
  if lua_file then
    lua_file:write('<Ui xsi:schemaLocation="http://www.blizzard.com/wow/ui/ ..\\FrameXML\\UI.xsd">\n')
    for _, htmlfile in pairs(allHTMLFiles) do
      lua_file:write(f(fileString, htmlfile, addonName, data_folder, htmlfile))
    end
    lua_file:write('</Ui>')
  end
end
