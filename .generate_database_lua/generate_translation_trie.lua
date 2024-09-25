require("cli.dump")

-- Define the maximum number of translations per file
local MAX_TRANSLATIONS_PER_FILE = 35
local SEGMENT_SIZE = 4000
local REDUCE_SEGMENT_SIZE = math.max(math.min(SEGMENT_SIZE * 0.05, 100), 10)
print("Max translations per file: " .. MAX_TRANSLATIONS_PER_FILE)
print("Segment size: " .. SEGMENT_SIZE, "Reduced segment size: " .. SEGMENT_SIZE - REDUCE_SEGMENT_SIZE)

-- Function to sanitize translation strings by replacing special characters with HTML entities
local function sanitize_translation(str)
  str = string.gsub(str, "&", "&amp;")
  str = string.gsub(str, "<", "&lt;")
  str = string.gsub(str, ">", "&gt;")
  return str
end

-- Function to create directories recursively using os.execute
local function mkdir(path)
  os.execute("mkdir -p " .. path)
end

-- Function to split a string into segments based on maximum characters per segment
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

-- Function to write translations to an HTML file with segmentation
local function write_html_file(key_path, translations)
  -- Define the file path
  local filename = key_path .. ".html"

  -- Open the file for writing
  local file, err = io.open(filename, "w")
  if not file then
    print("Error opening file " .. filename .. ": " .. err)
    return
  end

  -- Write the HTML structure
  file:write("<html><body>\n")
  for _, translation in ipairs(translations) do
    -- Check if the translation needs to be segmented
    if #translation > SEGMENT_SIZE - REDUCE_SEGMENT_SIZE then
      print("Splitting translation into segments", translation)
      -- Split the translation into segments
      local segments = split_into_segments(translation, SEGMENT_SIZE - REDUCE_SEGMENT_SIZE)
      -- Write each segment as a separate paragraph
      for _, segment in ipairs(segments) do
        file:write("<p>" .. sanitize_translation(segment) .. "</p>\n")
      end
    else
      -- Write the translation as a single paragraph
      file:write("<p>" .. sanitize_translation(translation) .. "</p>\n")
    end
  end
  file:write("</body></html>\n")
  file:close()
end

-- Function to create a branch in the trie structure
local function create_branch(strings, stringIndex)
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
      error(string.format("%s: %d out of range, increase MAX_TRANSLATIONS_PER_FILE", string, stringIndex))
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
      branch[char] = create_branch(child, stringIndex + 1)
    end
  end

  return branch
end

-- Function to create trie folders and write translations to HTML files
local function create_trie_folders(trie, current_path)
  print("Current path: " .. current_path)
  for key, value in pairs(trie) do
    local new_path = current_path .. "/" .. key
    if type(value) == "table" then
      -- If the number of translations is greater than the maximum or there are no translations
      if #value > MAX_TRANSLATIONS_PER_FILE or #value == 0 then
        mkdir(new_path)
        -- print("Continuing recursion for: " .. new_path)
        create_trie_folders(value, new_path)
      else
        print("Writing HTML file for: " .. new_path)
        write_html_file(new_path, value)
      end
    end
  end
end

-- Main function to compile translations to HTML
function Compile_translations_to_html(strings)
  -- Initialize the trie
  local success, trie
  repeat
    success, trie = pcall(create_branch, strings, 1)
    if not success then
      MAX_TRANSLATIONS_PER_FILE = MAX_TRANSLATIONS_PER_FILE + 1
      print(trie)
      print("Shortest word does not fit! - increasing MAX_TRANSLATIONS_PER_FILE to: " .. MAX_TRANSLATIONS_PER_FILE)
    end
  until success

  -- Create the root folder
  local root_folder = "translations"
  mkdir(root_folder)

  -- Create trie folders and write translations
  create_trie_folders(trie, root_folder)

  -- DevTools_Dump(trie)
  -- Dump the trie to a lua file
  -- local lines = {}
  local function dump_trie(trie, indent)
    local lines = {}
    local indent_str = string.rep("  ", indent)
    if type(trie) == "table" then
      for char, value in pairs(trie) do
        if type(value) == "table" then
          table.insert(lines, indent_str .. "['" .. char .. "'] = {")
          table.insert(lines, dump_trie(value, indent + 1))
          table.insert(lines, indent_str .. "},")
        else
          table.insert(lines, indent_str .. "\"" .. value .. "\",")
        end
      end
    else
      table.insert(lines, indent_str .. "[\"" .. trie .. "\"]")
    end
    return table.concat(lines, "\n")
  end

  local lua_file = io.open(root_folder .. "/trie.lua", "w")
  if lua_file ~= nil then
    local dump_str = dump_trie(trie, 1)
    lua_file:write("local trie = {\n" .. dump_str .. "\n}")
    lua_file:close()
  end
end
