-- Allow accessing private fields
---@diagnostic disable: invisible
require("cli.dump")
local helpers = require(".db_helpers")

require("cli.Addon_Meta")
require("cli.CLI_Helpers")

assert(Is_CLI, "This function should only be called from the CLI environment")

local f = string.format

--- Function to sanitize translation strings by replacing special characters with HTML entities
---@param str string
---@return string
local function escapeString(str)
  -- str = str:gsub('&', "and") -- Escape ampersands
  -- str = str:gsub("&", "＆")
  -- str = str:gsub("<", "❮") -- Escape less-than signs
  -- str = str:gsub('>', "❯") -- Escape greater-than signs
  str = str:gsub('&', "＆") -- Escape ampersands
  str = str:gsub('<', "＜") -- Escape less-than signs
  str = str:gsub('>', "＞") -- Escape greater-than signs

  -- We use this "cool" utf-8 dagger because the segmented split can split multi-chars ... 🗡
  str = str:gsub('|n', "🗡")
  str = str:gsub("\\n", "🗡")
  str = str:gsub("\n", "🗡")
  str = str:gsub('\\\\"', '"') -- Unescape double quotes if needed
  return str
end

--- Function to replace special characters with HTML entities
--- @param str string
--- @return string
local function replaceWithCorrect(str)
  str = str:gsub("🗡", "<br/>") -- Replace 🗡 with <br /> : Use <br /> for XHTML validity
  str = str:gsub('＆', "&amp;") -- Escape ampersands
  str = str:gsub('＜', "&lt;") -- Escape less-than signs
  str = str:gsub('＞', "&gt;") -- Escape greater-than signs
  return str
end

-- ! -------------------------------------------
-- !
-- !  The reason for all these utf-8 things is that chinese characters are multiple "chars" in a lua string
-- !  So if we just do the normal len for strings it would split a chinese character in the middle -
-- !  creating errors ingame.
-- !
-- ! -------------------------------------------
-- UTF-8 char boundary pattern for Lua 5.1 (no \x escapes)
local _CHARPAT = "[%z\1-\127\194-\244][\128-\191]*"

--- utf8_sub(s, i, j) -> substring of s from character i to j (both 1-based, negative ok)
---@param s (string) UTF-8 encoded string
---@param i (number) start index in characters (1 = first char; negative = from end)
---@param j (number) end index in characters (inclusive; positive or negative).
---              If nil, defaults to -1 (last character).
---@return (string) the UTF-8-safe substring
local function utf8_sub(s, i, j)
  -- 1) collect byte-offsets of each UTF-8 character
  local offsets = {}
  for pos in s:gmatch("()" .. _CHARPAT) do
    offsets[#offsets + 1] = pos
  end
  local n = #offsets
  if n == 0 then return "" end

  -- 2) handle defaults & negative indices
  if not j then j = -1 end
  if i < 0 then i = n + 1 + i end
  if j < 0 then j = n + 1 + j end

  -- 3) clamp to [1..n]
  if i < 1 then i = 1 end
  if j > n then j = n end
  if i > j then return "" end

  -- 4) byte positions for slicing
  local start_byte = offsets[i]
  local end_byte = offsets[j + 1] and (offsets[j + 1] - 1) or #s

  return s:sub(start_byte, end_byte)
end

--- utf8_len(s) -> number of UTF-8 characters in s
---@param s (string) UTF-8 encoded string
---@return (number) count of codepoints
local function utf8_len(s)
  local count = 0
  for _ in s:gmatch(_CHARPAT) do
    count = count + 1
  end
  return count
end

--- Generates the HTML and XML files for a given entity type and expansion.
--- @see Corrections.ItemMeta
--- @see Corrections.NpcMeta
--- @see Corrections.ObjectMeta
--- @see Corrections.QuestMeta
--- @param dataTbl table<number, table> The final, corrected data table (e.g., itemOverride).
--- @param meta ObjectMeta|ItemMeta|QuestMeta|NpcMeta|L10nMeta The metadata table (e.g., Corrections.ItemMeta). L10n is just nil
--- @param entityType string The type name ("Item", "Quest", etc.).
--- @param expansionName string The expansion name ("Era", "Tbc", "Wotlk").
--- @param idsPerFile number? The number of IDs per file (default: 50).
--- @param ptagPerFile number? The number of <p> tags per file (default: 65000).
--- @param debug boolean? Do you want to print extra debug output to the html files?
function GenerateHtmlForEntityType(dataTbl, meta, entityType, expansionName, idsPerFile, ptagPerFile, debug)
  print(f("Generating HTML for %s (%s)...", entityType, expansionName))

  local p_tags_per_file_avg = 0
  local p_tags_highest = 0
  local p_tags_lowest = math.huge

  -- 1. Define Constants & Paths (mirroring Python)
  local range_size = idsPerFile or 50
  local p_tags_per_file = ptagPerFile or 65000
  local max_file_size = 45000 -- Less critical now, but good for reference
  local max_p_size = 4000
  local entityTypeLower = entityType:lower()
  local entityTypeCapitalized = entityType:gsub("^%l", string.upper)
  local addon_dir = helpers.find_addon_name()
  local outputBasePath = helpers.get_data_dir_path(entityType, expansionName)
  local outputDataPath = outputBasePath .. "/_data"
  -- When doing paths in xml the full path all the way from Interface needs to be used.
  local dataDirPathInAddon = f("Interface\\AddOns\\%s\\Database\\%s\\%s", addon_dir, entityTypeCapitalized, helpers.capitalize(expansionName)) -- Helper needed for capitalize


  print(f("Addon Directory:      %s", addon_dir))
  print(f("Output Base Path:     %s", outputBasePath))
  print(f("Output Data Path:     %s", outputDataPath))
  print(f("Data Dir Path (Addon): %s", dataDirPathInAddon))

  -- Ensure output directories exist (Helper needed: helpers.ensureDirExists(path))
  helpers.ensureDirExists(outputBasePath)
  helpers.ensureDirExists(outputDataPath)

  -- Add .gitkeep file if needed
  helpers.ensureGitKeepFile(outputDataPath)

  -- Optional: Clear old *.html files in _data (Helper needed: helpers.clearHtmlFiles(path))
  helpers.clearHtmlFiles(outputDataPath)

  -- 2. Initialize State Variables
  local all_ids = {}
  local sorted_keys = {}
  for k in pairs(dataTbl) do table.insert(sorted_keys, k) end
  table.sort(sorted_keys) -- Sort IDs numerically

  local all_filenames = {}
  local embed_file_strings = {}
  table.insert(embed_file_strings,
               f('<SimpleHTML name="%sDataFiles" file="%s\\%sDataTemplates.html" virtual="true" font="GameFontNormal"/>\n', entityTypeCapitalized,
                 dataDirPathInAddon,
                 entityTypeCapitalized))

  local entries_written           = 0
  local p_tags_written            = 0
  local lowest_id, highest_id     = math.huge, -math.huge
  local current_chunk_output_data = {} -- Use a table for efficient string building
  local current_chunk_lookup_data = {} -- Use a table

  -- Get reversed keys and dump functions from meta
  local reversedKeys              = {}
  local nrDataKeys                = 0
  local dataKeys                  = meta[entityTypeLower .. "Keys"] -- e.g., meta.itemKeys
  local dumpFunctions             = meta.dumpFuncs
  local combineFunc               = meta.combine                    -- May be nil
  for key, id in pairs(dataKeys) do
    reversedKeys[id] = key
    nrDataKeys = nrDataKeys + 1
  end

  print("Writing HTML files...")

  -- 3. Main Loop: Iterate Through Sorted IDs
  for i = 1, #sorted_keys do
    local dataId = sorted_keys[i]
    local entity_data_raw = dataTbl[dataId] -- This is the array of values

    local entity_data_processed = entity_data_raw


    local output_data_local = {}  -- For the current ID's <p> tags
    local writtenDataIndexes = {} -- Tracks indices (1, 2, '3-1', '3-e', etc.)

    -- Prepare the data row using dump functions (similar to dumpData)
    local resulttable = {}
    for keyIndex = 1, nrDataKeys do
      local dataName = reversedKeys[keyIndex]                                              -- Get field name from index
      local dataValue = entity_data_processed[dataName] or entity_data_processed[keyIndex] -- Allow lookup by name or index

      if dataValue ~= nil and dataValue ~= "nil" then
        local dumpFunction = dumpFunctions[dataName]
        if dumpFunction then
          resulttable[keyIndex] = dumpFunction(dataValue) -- Get the Lua-like string representation
        else
          error("No dump function for key: " .. tostring(dataName) .. " (Index: " .. keyIndex .. ")")
        end
      else
        resulttable[keyIndex] = "nil"
      end
    end

    -- Apply combine function *here* if it modifies the resulttable
    if combineFunc then
      -- Ensure resulttable has the expected structure for combineFunc
      local tempTableForCombine = {}
      for idx = 1, nrDataKeys do tempTableForCombine[idx] = resulttable[idx] or "nil" end
      combineFunc(tempTableForCombine)
      -- Update resulttable from tempTableForCombine (indices might change!)
      -- This needs careful mapping based on combineFunc's behavior.
      -- Assuming combineFunc modifies the table passed to it:
      resulttable = tempTableForCombine
    end


    -- Inner Loop: Iterate Through Serialized Data Fields (resulttable)
    for entityDataIndex = 1, #resulttable do -- Use the length of the potentially combined table
      local serialized_line = resulttable[entityDataIndex]

      -- Skip nil/empty entries *after* serialization
      if serialized_line ~= "nil" and serialized_line ~= "" then
        -- HTML Formatting (similar to Python)
        local formatted_line = tostring(serialized_line)

        -- We have to check if first and last character is ' and remove them
        -- The reason for this is that the dump function adds ' to the start and end of the string
        ---@see DumpFunctions.dump
        if formatted_line:sub(1, 1) == "'" and formatted_line:sub(-1) == "'" then
          formatted_line = formatted_line:sub(2, -2)
        end

        -- -- formatted_line = formatted_line:gsub('&', "and") -- Escape ampersands
        -- formatted_line = formatted_line:gsub("&", "＆")
        -- formatted_line = formatted_line:gsub("<", "❮") -- Escape less-than signs
        -- formatted_line = formatted_line:gsub('>', "❯") -- Escape greater-than signs
        -- -- formatted_line = formatted_line:gsub('<', "lt;")    -- Escape less-than signs
        -- -- formatted_line = formatted_line:gsub('>', "gt;")    -- Escape greater-than signs
        -- -- We use this cool dagger because the segmented split can split multi-chars ... 🗡
        -- formatted_line = formatted_line:gsub('|n', "<br/>")
        -- formatted_line = formatted_line:gsub("\\n", "<br/>") -- Use <br/> for XHTML validity if needed
        -- formatted_line = formatted_line:gsub("\n", "<br/>")  -- Use <br/> for XHTML validity if needed
        -- formatted_line = formatted_line:gsub('\\\\"', '"')   -- Unescape double quotes if needed
        formatted_line = escapeString(formatted_line)

        -- Remove surrounding quotes ONLY if not a table literal
        if not formatted_line:match("^%s*{") and not formatted_line:match("}%s*$") then
          if formatted_line:match('^"') and formatted_line:match('"$') then
            formatted_line = formatted_line:sub(2, -2)
          end
          -- Unescape single quotes potentially added by DumpFunctions.dump
          formatted_line = formatted_line:gsub("\\'", "'")
        end

        -- Cleanups (less critical if DumpFunctions are precise)
        -- formatted_line = formatted_line:gsub(",}", "}")
        -- formatted_line = formatted_line:gsub("nil}", "}")
        -- formatted_line = formatted_line:gsub(" = ", "=")

        -- Check length and split if necessary
        local length = #formatted_line > max_p_size and utf8_len(formatted_line) or #formatted_line
        if length > max_p_size then
          if debug then
            table.insert(output_data_local, f("  <!-- %s -->\n", meta.NameIndexLookupTable[entityDataIndex]))
          end
          if outputSegments then
            table.insert(output_data_local, f("<!-- Segment start: %s -->\n", entityDataIndex))
          end
          local segments = math.ceil(length / max_p_size)
          for seg = 1, segments do
            local start = (seg - 1) * max_p_size + 1
            local stop = math.min(seg * max_p_size, length)
            local segmentMarker
            if seg < segments then
              segmentMarker = f("%s-%d", entityDataIndex, seg)
            else
              segmentMarker = f("%s-e", entityDataIndex) -- End marker
            end
            p_tags_written = p_tags_written + 1
            table.insert(writtenDataIndexes, segmentMarker)
            table.insert(output_data_local, f("<p>%s</p>\n", replaceWithCorrect(utf8_sub(formatted_line, start, stop))))
          end
          if outputSegments then
            table.insert(output_data_local, f("<!-- Segment end: %s -->\n", entityDataIndex))
          end
        else
          -- Add the single <p> tag
          table.insert(writtenDataIndexes, tostring(entityDataIndex))
          if (debug) then
            table.insert(output_data_local, f("  <!-- %s -->\n", meta.NameIndexLookupTable[entityDataIndex]))
          end
          p_tags_written = p_tags_written + 1
          table.insert(output_data_local, f("<p>%s</p>\n", replaceWithCorrect(formatted_line)))
        end
      end
    end -- End inner loop (data fields)

    -- If data was written for this ID, add it to the chunk
    if #writtenDataIndexes > 0 then
      table.insert(all_ids, dataId) -- Track all valid IDs

      -- Update chunk state
      lowest_id = math.min(lowest_id, dataId)
      highest_id = math.max(highest_id, dataId)
      entries_written = entries_written + 1

      -- Calculate p_tags stats
      p_tags_written = p_tags_written + 1
      if p_tags_written > p_tags_highest then
        p_tags_highest = p_tags_written
      end
      if p_tags_written < p_tags_lowest then
        p_tags_lowest = p_tags_written
      end

      table.insert(current_chunk_lookup_data, tostring(dataId))
      table.insert(current_chunk_output_data, f("<!-- %d -->\n", dataId))      -- Add ID comment
      table.insert(current_chunk_output_data, "<p>" .. table.concat(writtenDataIndexes, ",") .. "</p>\n")
      table.insert(current_chunk_output_data, table.concat(output_data_local)) -- Add the generated <p> tags
    end

    -- Check if chunk needs to be written
    if entries_written == range_size or i == #sorted_keys or p_tags_written >= p_tags_per_file then
      if entries_written > 0 then -- Don't write empty chunks
        local chunk_filename = f("%d-%d.html", lowest_id, highest_id)
        local chunk_filepath = outputDataPath .. "/" .. chunk_filename
        local chunk_frame_name = f("%sData%d-%d", entityTypeCapitalized, lowest_id, highest_id)

        print(f("Writing chunk: %s (%s entries)", chunk_filename, entries_written))

        -- Write the chunk file
        local file = io.open(chunk_filepath, "w")
        if file then
          file:write("<html><body>\n")
          -- Write Index -> ID lookup <p>
          file:write("<!-- Index to Id table -->\n")
          file:write("<p>" .. table.concat(current_chunk_lookup_data, ",") .. "</p>\n")
          -- Write Data
          file:write(table.concat(current_chunk_output_data))
          file:write("</body></html>\n")
          file:close()

          -- Add filename for Templates file
          table.insert(all_filenames, chunk_frame_name)
          -- Add embed string for XML file
          local embed_str = f('<SimpleHTML name="%s" file="%s\\_data\\%s" virtual="true" font="GameFontNormal"/>\n',
                              chunk_frame_name, dataDirPathInAddon, chunk_filename)
          table.insert(embed_file_strings, embed_str)
        else
          error("Failed to open file for writing: " .. chunk_filepath)
        end

        p_tags_per_file_avg = (p_tags_per_file_avg + p_tags_written) / 2

        -- Reset chunk state
        entries_written = 0
        p_tags_written = 0
        lowest_id, highest_id = math.huge, -math.huge
        current_chunk_output_data = {}
        current_chunk_lookup_data = {}
      end
    end
  end -- End main loop (IDs)

  -- 4. Generate Auxiliary Files

  -- Write ID File (<Type>DataIds.html)
  local ids_filepath = outputBasePath .. "/" .. entityTypeCapitalized .. "DataIds.html"
  local ids_file = io.open(ids_filepath, "w")
  if ids_file then
    ids_file:write(f("<!-- This contains all the ids for %ss -->\n", entityType))
    ids_file:write("<html><body>\n")
    local current_p = {}
    local current_len = 0
    for _, id in ipairs(all_ids) do
      local id_str = tostring(id)
      local id_len = #id_str + 1 -- Include comma
      if current_len + id_len > max_p_size and #current_p > 0 then
        ids_file:write("<p>" .. table.concat(current_p, ",") .. "</p>\n")
        current_p = {}
        current_len = 0
      end
      table.insert(current_p, id_str)
      current_len = current_len + id_len
    end
    if #current_p > 0 then -- Write remaining IDs
      ids_file:write("<p>" .. table.concat(current_p, ",") .. "</p>\n")
    end
    ids_file:write("</body></html>\n")
    ids_file:close()
    print(f("Written ID file: %s", ids_filepath))
    -- Add embed string for XML file (insert at beginning)
    table.insert(embed_file_strings, 1,
                 f('<SimpleHTML name="%sDataIds" file="%s\\%sDataIds.html" virtual="true" font="GameFontNormal"/>\n', entityTypeCapitalized, dataDirPathInAddon,
                   entityTypeCapitalized))
  else
    error("Failed to open file for writing: " .. ids_filepath)
  end

  -- Write Template File (<Type>DataTemplates.html)
  local templates_filepath = outputBasePath .. "/" .. entityTypeCapitalized .. "DataTemplates.html"
  local templates_file = io.open(templates_filepath, "w")
  if templates_file then
    templates_file:write("<!-- This contains all the ranges for the files that are generated -->\n")
    templates_file:write("<html><body>\n")
    local full_template_string = table.concat(all_filenames, ",")
    local current_pos = 1
    while current_pos <= #full_template_string do
      local end_pos = math.min(current_pos + max_p_size - 1, #full_template_string)
      -- Avoid splitting mid-filename if possible (optional refinement)
      templates_file:write("<p>" .. full_template_string:sub(current_pos, end_pos) .. "</p>\n")
      current_pos = end_pos + 1
    end
    templates_file:write("</body></html>\n")
    templates_file:close()
    print(f("Written Templates file: %s", templates_filepath))
  else
    error("Failed to open file for writing: " .. templates_filepath)
  end

  -- Write XML File (<Type>DataFiles.xml)
  local xml_filepath = outputBasePath .. "/" .. entityTypeCapitalized .. "DataFiles.xml"
  local xml_file = io.open(xml_filepath, "w")
  if xml_file then
    xml_file:write(
      '<Ui xmlns="http://www.blizzard.com/wow/ui/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.blizzard.com/wow/ui/ https://raw.githubusercontent.com/Gethe/wow-ui-source/live/Interface/AddOns/Blizzard_SharedXML/UI.xsd">\n')
    for _, embed_str in ipairs(embed_file_strings) do
      xml_file:write(embed_str)
    end
    xml_file:write("</Ui>\n")
    xml_file:close()
    print(f("Written XML file: %s", xml_filepath))
  else
    error("Failed to open file for writing: " .. xml_filepath)
  end

  print(f("Finished HTML generation for %s (%s).", entityType, expansionName))
  print(f("Average <p> tags per file: Avg: %d , High: %d , Low: %d", p_tags_per_file_avg, p_tags_highest, p_tags_lowest))
end -- End GenerateHtmlForEntityType
