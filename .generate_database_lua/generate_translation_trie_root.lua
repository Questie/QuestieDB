require("cli.dump")

---@alias trie table<string, any>
---@alias filepath string

-- The root folder
local root_folder = "translations"

-- Variable to disable the writing of html
local write_html = true

-- Double Dagger
local splitCharacter = "‡"

-- Define the maximum number of translations per file
local MAX_TRANSLATIONS_PER_FILE = 50
local SEGMENT_SIZE = 4000
local REDUCE_SEGMENT_SIZE = math.max(math.min(SEGMENT_SIZE * 0.05, 100), 10)
print("Max translations per file: " .. MAX_TRANSLATIONS_PER_FILE)
print("Segment size: " .. SEGMENT_SIZE, "Reduced segment size: " .. SEGMENT_SIZE - REDUCE_SEGMENT_SIZE)

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

--- Function to split a string into segments based on maximum characters per segment
---@param str string
---@param max_chars number
---@return string[]
local function split_into_segments(str, max_chars)
  local segments = {}
  local total_segments = math.ceil(#str / max_chars)

  -- Loop through the string and create segments
  for i = 1, total_segments do
    local start_pos = (i - 1) * max_chars + 1
    local end_pos = math.min(i * max_chars, #str)
    local segment = string.sub(str, start_pos, end_pos)
    -- Add segment number prefix for all segments except the first one
    if i > 1 then
      segment = tostring(i) .. segment
    end
    table.insert(segments, segment)
  end

  -- Add total segments count to the first segment
  segments[1] = total_segments .. segments[1]

  return segments
end

--- Function to write translations to an HTML file with segmentation
---@param key_path string The path for the translation e.g. translations/u/s/e/t/h/e
---@param translations string[]
---@param translation_func fun(string):string[] A function that takes the english string and returns all translations
local function write_html_file(key_path, translations, translation_func)
  -- ? This stops the function from writing in subfolders but instead  writes in the root folder
  -- ? Remember to activate the folder creation function in the create_trie_folders function if disabled
  -- "%-" Always escape
  local replaceChar = ""
  key_path = key_path:gsub("/", replaceChar)
  key_path = key_path:gsub(root_folder .. replaceChar, root_folder .. "/", 1) -- We also removed the root folder from the key_path, add back the /

  -- Define the file path
  local filename = key_path .. ".html"

  -- print(filename)

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
      local fullTranslationTable = translation_func(translation)



      -- Check if the translation needs to be segmented
      if #table.concat(fullTranslationTable, splitCharacter) > SEGMENT_SIZE - REDUCE_SEGMENT_SIZE then
        print("Splitting translation into segments", translation, filename)
        -- Split the translation into segments
        local segments = split_into_segments(table.concat(fullTranslationTable, splitCharacter), SEGMENT_SIZE - REDUCE_SEGMENT_SIZE)
        -- Write each segment as a separate paragraph
        for _, segment in ipairs(segments) do
          file:write("<p>" .. sanitize_translation(segment) .. "</p>\n")
        end
      else
        -- Write the translation as a single paragraph
        file:write("<p>" .. sanitize_translation(table.concat(fullTranslationTable, splitCharacter)) .. "</p>\n")
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
---@param translation_func fun(translation:string):string[] A function that takes the english string and returns all translations
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
    local cleanedString = string.gsub(string, "%s", "")
    -- Remove all numbers from the string
    -- cleanedString = string.gsub(cleanedString, "%d+", "")
    cleanedString = string.gsub(cleanedString, "%p", "")
    cleanedString = string.gsub(cleanedString, "%c", "")

    -- Get the character at the current index
    -- local char = string.sub(string.lower(cleanedString), stringIndex, stringIndex)
    local char = string.sub(cleanedString, stringIndex, stringIndex)

    if char == "" then
      -- error(string.format("%s: %d out of range, increase MAX_TRANSLATIONS_PER_FILE", string, stringIndex))
      print(string.format("%s: %d out of range", string, stringIndex))
      char = "."
      -- table.insert(parent[char], string)
      -- else
    end
    -- Create a new branch for the character if it doesn't exist
    if not branch[char] then
      branch[char] = {}
    end
    table.insert(branch[char], string)
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

-- Main function to compile translations to HTML
---comment
---@param strings string[]
---@param translation_func fun(string):table<string, string|boolean> A function that takes the english string and returns all translations
function Compile_translations_to_html(strings, translation_func)
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

  ---@param enUStext string
  ---@return string[]?
  ---@return error?
  local function getTranslation(enUStext)
    local allTranslations, err = translation_func(enUStext)
    if err then
      return nil, err
    end
    local combinedTranslations = { "enUS" .. "[" .. enUStext .. "]", }
    for _, locale in ipairs(localeOrder) do
      local text = allTranslations[locale]
      if type(text) == "string" and locale ~= "enUS" then
        table.insert(combinedTranslations, locale .. "[" .. text .. "]")
      elseif locale ~= "enUS" then
        table.insert(combinedTranslations, "")
      end
    end
    return combinedTranslations --table.concat(combinedTranslations, "‡")
  end

  -- Create trie folders and write translations
  write_trie_structure(trie, root_folder, getTranslation)

  -- Replace the actual string arrays with the template xml name
  replaceArrays(trie, "")

  -- Function to print the table for verification (optional)
  local function printTable(t, indent)
    local lines = {}
    indent = indent or ""
    for k, v in pairs(t) do
      if type(v) == "table" then
        table.insert(lines, indent .. "[\"" .. tostring(k) .. "\"] = {")
        table.insert(lines, printTable(v, indent .. "  "))
        table.insert(lines, indent .. "},")
      else
        -- if html in v use " otherwise it will be wrapped in [[]]
        if string.find(v, ".html") then
          table.insert(lines, indent .. "[\"" .. tostring(k) .. "\"] = \"" .. tostring(v) .. "\",")
        else
          table.insert(lines, indent .. "[\"" .. tostring(k) .. "\"] = [[" .. tostring(v) .. "]],")
        end
      end
    end
    return table.concat(lines, "\n")
  end

  local lua_file = io.open(root_folder .. "/trie.lua", "w")
  if lua_file ~= nil then
    local dump_str = printTable(trie, "") --dump_trie(point_to_html(trie), 1)
    lua_file:write("local trie = {\n" .. dump_str .. "\n}")
    lua_file:close()
  end
end
