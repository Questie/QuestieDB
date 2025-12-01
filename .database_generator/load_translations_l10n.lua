-- Allow accessing private fields
---@diagnostic disable: invisible
require("cli.dump")
local helpers = require(".db_helpers")

local f = string.format
local tInsert = table.insert

-- Double Dagger
local splitCharacter = "‡"

local export = {}

---Remove the first 3 lines which checks the GetLocale() if it should load, we want to load all
---@param version string Expansions e.g. "Classic", "TBC", "Wotlk", etc
---@param type string Type of data e.g. "item", "npc", "object", "quest"
---@return table<number, string>? files A table containing the names of files with the specified extension.
function export.CleanFiles(version, type)
  local cleaned_files = {}
  -- Remove the first 3 lines in all .lua files in .database_generator\Questie-data\Localization\lookups\Classic\lookupItems
  local capitalized_type = helpers.capitalize(type)
  -- Get all .lua files in the directory
  local path = helpers.get_project_dir_path() ..
      "/.database_generator/Questie-data/Localization/lookups/" .. version .. "/lookup" .. capitalized_type .. "s/"

  local files = helpers.get_files_in_directory(path, "lua")
  if not files then
    print("No files found in directory: " .. path)
    return nil
  end

  for _, file in ipairs(files) do
    local file_path = path .. file
    local filedata = io.open(file_path, "rb")
    if filedata then
      local content = filedata:read("*a")
      filedata:close()

      -- Remove lines until "---@type l10n"
      local start_index = content:find("local l10n", 1, true)
      if start_index then
        local sliced = content:sub(start_index)
        if type == "npc" then
          sliced = sliced:gsub("l10n%.npcNameLookup", "l10n.npcLookup")
        end

        -- Write the new lines back to the file
        local filename = string.gsub(file_path, ".lua", ".lua.clean")
        local clean_filedata = io.open(filename, "wb")
        if clean_filedata then
          -- Write the new lines back to the file
          clean_filedata:write(sliced)
          clean_filedata:close()
          tInsert(cleaned_files, filename)
        end
      end
    end
  end
  print("  Cleaned " .. #files .. " LUA files in directory: " .. path .. " (fast)")

  -- Change the XML file to point to the cleaned files
  -- Example path: .database_generator\Questie-data\Localization\lookups\Classic\lookupItems\lookupItems.xml
  local xml_path = helpers.get_project_dir_path() ..
      "/.database_generator/Questie-data/Localization/lookups/" .. version .. "/lookup" .. capitalized_type .. "s/lookup" .. capitalized_type .. "s.xml"
  local xml_filedata = io.open(xml_path, "rb")
  -- <Ui xsi:schemaLocation="http://www.blizzard.com/wow/ui/ ..\FrameXML\UI.xsd">
  --   <Script file="deDE.lua"/>
  --   <Script file="esES.lua"/>
  --   <Script file="esMX.lua"/>
  --   <Script file="frFr.lua"/>
  --   <Script file="koKR.lua"/>
  --   <Script file="ptBR.lua"/>
  --   <Script file="ruRU.lua"/>
  --   <Script file="zhCN.lua"/>
  --   <Script file="zhTW.lua"/>
  -- </Ui>

  if xml_filedata then
    local data = xml_filedata:read("*a")
    xml_filedata:close()
    data = string.gsub(data, "%.lua", ".lua.clean")
    -- Write the new data back to the XML file
    local filename = string.gsub(xml_path, ".xml", ".clean.xml")
    local clean_xml_filedata = io.open(filename, "wb")
    if clean_xml_filedata then
      clean_xml_filedata:write(data)
      clean_xml_filedata:close()
      print("  Cleaned 1 XML file: " .. xml_path .. ".clean.xml (fast)")
      tInsert(cleaned_files, filename)
    end
  end

  return cleaned_files
end

---Creates a new l10n object with the translations for the specified locales and entity types.
---@param locales L10nLocales The locales to be dumped
---@param entityTypes table<string> The entity types to be dumped (e.g., "Item", "Npc", "Object", "Quest")
---@param l10nObject table The full l10n object containing all the lookups
---@return table<ItemId|NpcId|ObjectId|QuestId, table<L10nDBKeys, table<L10nLocales, any>>>
function export.GenerateL10nTranslation(locales, entityTypes, l10nObject)
  ---@type table<ItemId|NpcId|ObjectId|QuestId, table<L10nDBKeys, table<L10nLocales, any>>>
  local newL10nObject = {}

  for _, entityType in ipairs(entityTypes) do
    local lEntityType = entityType:lower()
    local lookupKey = lEntityType .. "Lookup"

    local lookup = l10nObject[lookupKey]
    for _, localeKey in ipairs(locales) do
      local allLocaleData = type(lookup[localeKey]) == "function" and lookup[localeKey]() or lookup[localeKey]
      local sortTable = {}

      for id in pairs(allLocaleData) do
        tInsert(sortTable, id)
      end
      table.sort(sortTable)

      for _, id in ipairs(sortTable) do
        local localeData = allLocaleData[id]
        newL10nObject[id] = newL10nObject[id] or {}
        newL10nObject[id][lEntityType] = newL10nObject[id][lEntityType] or {}
        newL10nObject[id][lEntityType][localeKey] = localeData
      end
    end
  end

  return newL10nObject
end

-- Example output format:
-- [2] = {
--     -- Item
--     'Worn Shortsword‡Espadim Usado‡Иссеченный короткий меч‡Abgenutztes Kurzschwert‡낡은 쇼트소드‡Espada corta desgastada‡Epée courte usée‡破损的短剑',
--     -- Object
--     'Old Lion Statue‡Estátua de Leão Antiga‡Статуя старого льва‡Alte Löwenstatue‡오래된 사자상‡Estatua de león antigua‡Statue du vieux lion‡石狮子',
--     { -- Npc
--       'Kobold Vermin‡Kobold Daninho‡Кобольд-вредитель‡Koboldgezücht‡코볼트 졸개‡Alimaña kóbold‡Vermine kobold‡狗头人歹徒',
--       nil,
--     },
--     { -- Quest
--       'Sharptalon\'s Claw‡Garra de Garraguda‡Коготь гиппогрифа Острокогтя‡Klaue von Scharfkralle‡뾰족발톱의 발톱‡La garfa de Garrafilada‡La griffe de Serres-tranchantes‡沙普塔隆的爪子',
--       'The mighty hippogryph Sharptalon has been slain, with the claw of the felled beast serving as a testament to your victory. Senani Thunderheart at the Splintertree Post will no doubt be interested in seeing this trophy as proof of your deeds.‡O poderoso hipogrifo Garraguda foi abatido, e a garra da fera serve como prova da sua vitória. Senani Coração Trovejante , do Posto Machadada, sem dúvida ficará interessada em ver esse troféu como prova do seu feito.‡Могучий гиппогриф Острокоготь был убит, и коготь этой свирепой твари – свидетельство вашей победы. Сенани Громовое Сердце на заставе Расщепленного Дерева несомненно пожелает увидеть этот трофей – доказательство ваших деяний.‡Der mächtige Hippogryph Scharfkralle wurde getötet und die Klaue der erschlagenen Bestie dient als Beweis für Euren Sieg. Senani Donnerherz im Splitterholzposten wird zum Beweis Eurer Tat sicher gern diese Trophäe sehen wollen.‡강력한 히포그리프 뾰족발톱의 발톱은 당신의 승리를 나타내는 명백한 증거가 되어 줄 것입니다. 토막나무 주둔지에 있는 세나니 썬더하트에게 이 자랑스러운 전리품을 보여 주십시오.‡El poderoso hipogrifo Garrafilada ha sido ejecutado, con la garfa de la bestia derribada como testimonio de tu victoria. Seguro que Senani Corazón Atronador , del Puesto del Hachazo, estará interesado en ver este trofeo que prueba tus actos.‡Le grand hippogriffe Serres-tranchantes a été tué, et la griffe arrachée à son cadavre témoigne de votre victoire. Senani Cœur-de-tonnerre , au poste de Bois-brisé, sera sans doute intéressée de voir ce trophée qui est la preuve de votre exploit.‡强大的角鹰兽沙普塔隆已经被你杀死了，它的爪子将成为你胜利的象征。碎木哨岗的塞娜尼·雷心一定会对你的战利品感兴趣的。',
--       'Bring Sharptalon\'s Claw to Senani Thunderheart at Splintertree Post, Ashenvale.‡Leve a Garra de Garraguda para Senani Coração Trovejante no Posto Machadada, Vale Gris.‡Принесите коготь гиппогрифа Острокогтя Сенани Громовое Сердце на заставу Расщепленного Дерева в Ясеневом лесу.‡Bringt die Klaue von Scharfkralle zu Senani Donnerherz im Splitterholzposten im Eschental.‡뾰족발톱의 발톱을 잿빛 골짜기의 토막나무 주둔지에 있는 세나니 썬더하트에게 가져가야 합니다.‡Llévale la garfa de Garrafilada a Senani Corazón Atronador en el Puesto del Hachazo, Vallefresno.‡Apportez la Griffe de Serres-tranchantes à Senani Cœur-de-tonnerre, au poste de Bois-brisé, en Orneval.‡将沙普塔隆的爪子交给灰谷碎木哨岗的塞娜尼·雷心。',
--     },
-- },
-- Item and Object are not tables so they are just raw strings
-- Npc and Quest are tables with multiple values

--- Joins a list of strings with a separator, escaping single quotes and handling nil values.
---@param tbl table<number, string?> List of strings to join.
---@param separator string Separator character.
---@param emptyValue string The string representing an empty joined value (e.g., "‡‡‡").
---@return string|'"nil"' Joined string wrapped in single quotes, or '"nil"' if empty.
local function joinAndEscape(tbl, separator, emptyValue)
  local result = {}
  local hasContent = false
  for i = 1, #tbl do
    local val = tbl[i]
    if val == nil then
      result[i] = ""
    else
      -- Quest text is a table, join it with |n
      if type(val) == "table" then
        val = joinAndEscape(val, "|n", "")
      elseif type(val) == "string" then
        -- Escape characters that are special in Lua strings or problematic for other formats.
        -- Backslashes and single quotes are escaped for Lua string syntax.
        -- Control characters are replaced with a textual representation (e.g., the string "\\5")
        -- to avoid writing raw control bytes, which can be invalid in other contexts (e.g. HTML/XML).
        -- This is UTF-8 safe as it only operates on single-byte ASCII control characters.
        val = string.gsub(val, "['\\%z\1-\8\11\12\14-\31\127]", function(c)
          if c == "'" then
            return "\\'"
          elseif c == "\\" then
            return "\\\\"
          else
            return string.format("\\\\%d", string.byte(c))
          end
        end)
      end
      -- Replace newlines specifically for quest text as per python script logic
      val = string.gsub(val, "\r", "")
      val = string.gsub(val, "\n", "|n")
      result[i] = val
      if val ~= "" then
        hasContent = true
      end
    end
  end
  local joined = table.concat(result, separator)
  if not hasContent or joined == emptyValue then
    return ""
  else
    return joined
  end
end

---Builds the l10n dump string for a single entity type.
---@param entityType "item"|"npc"|"object"|"quest"
---@param typeData table<L10nLocales, any>|nil
---@param L10nMeta L10nMeta
---@param localeCount integer
---@param emptyValue string
---@param indentation string
---@param includeTypeComment boolean? Include the leading "-- <Type>" comment (default: true)
---@return string
local function dumpSingleEntityType(entityType, typeData, L10nMeta, localeCount, emptyValue, indentation, includeTypeComment)
  includeTypeComment = includeTypeComment ~= false
  if not typeData then
    local dumpedNil = f("%s%s,\n", indentation, "nil")
    if not includeTypeComment then
      dumpedNil = dumpedNil:gsub("^%s*%-%-[^\n]*\n", "", 1)
    end
    return dumpedNil
  end

  local translations = {}
  for i = 1, localeCount do
    translations[i] = typeData[L10nMeta.locales[i]] or ""
  end

  local dumped
  if entityType == "item" or entityType == "object" then
    dumped = L10nMeta.lua_tableDumpFuncs[entityType](joinAndEscape(translations, splitCharacter, emptyValue))
  elseif entityType == "npc" then
    local names = {}
    local subnames = {}
    for i = 1, #translations do
      local npcData = translations[i] or { "", "", }
      names[i] = npcData[1] or ""    -- Name is index 1
      subnames[i] = npcData[2] or "" -- Subname is index 2
    end
    dumped = L10nMeta.lua_tableDumpFuncs[entityType]({
      joinAndEscape(names, splitCharacter, emptyValue),
      joinAndEscape(subnames, splitCharacter, emptyValue),
    })
  elseif entityType == "quest" then
    local titles = {}
    local descriptions = {}
    local texts = {}
    for i = 1, #translations do
      local questData = translations[i] or { "", "", "", }
      titles[i] = questData[1] or ""       -- Title
      descriptions[i] = questData[2] or "" -- Description
      texts[i] = questData[3] or ""        -- Text
    end
    dumped = L10nMeta.lua_tableDumpFuncs[entityType]({
      joinAndEscape(titles, splitCharacter, emptyValue),
      joinAndEscape(descriptions, splitCharacter, emptyValue),
      joinAndEscape(texts, splitCharacter, emptyValue),
    })
  end

  if not dumped then
    dumped = f("%s%s,\n", indentation, "nil")
  end

  if not includeTypeComment then
    dumped = dumped:gsub("^%s*%-%-[^\n]*\n", "", 1) -- Strip leading comment line (string dumps)
    dumped = dumped:gsub("%-%-[^%]\n]*", "", 1)     -- Strip first inline comment (table dumps)
    dumped = dumped:gsub("%s+\n", "\n", 1)          -- Clean extra spacing left behind
  end
  return dumped
end


---------------------------------------------------------------------------
-- Dumps the structured l10n data into a Lua table string format.
-- •  Adds a “-- break / return {” marker every <maxIdsPerSlice> IDs
--    to keep each compiled slice well below Lua‑5.1’s constant limit.
-- •  The loader only needs to split on “-- break” and feed every slice
--    to loadstring()/require(); see comments in the merge script.
---------------------------------------------------------------------------
---@param L10nMeta L10nMeta
---@param entityTypes table<string> The entity types to be dumped (e.g., "Item", "Npc", "Object", "Quest")
---@param l10nData table<AllIdTypes, table<L10nDBKeys, table<L10nLocales, any>>> The structured localization data.
---@param maxIdsPerSlice number? -- optional; defaults to 2000
---@return string luaTableString The generated Lua table as a string.
function export.DumpL10nData(L10nMeta, entityTypes, l10nData, maxIdsPerSlice)
  maxIdsPerSlice = maxIdsPerSlice or 20000 -- *** new parameter ***
  print("Creating l10n data dump...")
  local outputLines = {}
  tInsert(outputLines, "{\n")

  local localeCount = #L10nMeta.locales
  -- Create the string representing an empty value for comparison
  local emptyValue = string.rep(splitCharacter, #L10nMeta.locales - 1)

  -- Get entity types sorted by their index in L10nMeta.l10nKeys
  local sortedEntityTypes = {}
  local entityTypeIndices = {}
  for index, key in ipairs(entityTypes) do
    entityTypeIndices[index] = key:lower()
  end
  for i = 1, #entityTypeIndices do
    tInsert(sortedEntityTypes, entityTypeIndices[i])
  end

  -- Sort IDs numerically
  local sortedIds = {}
  for id in pairs(l10nData) do
    tInsert(sortedIds, id)
  end
  table.sort(sortedIds)

  local indentation = "  "

  local idsInCurrentSlice = 0

  ---@param id ItemId|NpcId|ObjectId|QuestId
  for _, id in ipairs(sortedIds) do
    local entryData = l10nData[id]

    tInsert(outputLines, string.format("[%d] = {\n", id))

    for _, entityType in ipairs(sortedEntityTypes) do
      local typeData = entryData[entityType]
      tInsert(outputLines, dumpSingleEntityType(entityType, typeData, L10nMeta, localeCount, emptyValue, indentation, true))
    end
    -- Remove trailing comma from the last element within the ID's table
    local lastLine = outputLines[#outputLines]
    if string.sub(lastLine, -2) == ",\n" then
      outputLines[#outputLines] = string.sub(lastLine, 1, -3) .. "\n"
    end
    tInsert(outputLines, "},\n")

    ----------------------------------------------------------------
    --  SLICE BREAK
    ----------------------------------------------------------------
    idsInCurrentSlice = idsInCurrentSlice + 1
    if idsInCurrentSlice >= maxIdsPerSlice then
      -- remove trailing comma from the final ID of this slice
      local ll = outputLines[#outputLines]
      if ll:sub(-2) == ",\n" then outputLines[#outputLines] = ll:sub(1, -3) .. "\n" end

      -- close slice, insert marker, start new slice
      tInsert(outputLines, "}\n")
      tInsert(outputLines, "-- break\n")
      tInsert(outputLines, "{\n")

      idsInCurrentSlice = 0
    end
  end
  -- Remove trailing comma from the last ID entry
  local lastLine = outputLines[#outputLines]
  if string.sub(lastLine, -2) == ",\n" then
    outputLines[#outputLines] = string.sub(lastLine, 1, -3) .. "\n"
  end
  tInsert(outputLines, "}\n")

  print("Done creating l10n data dump.")

  return table.concat(outputLines)
end

---------------------------------------------------------------------------
--- Splits the l10n dump into one file per entity type.
---@param L10nMeta L10nMeta
---@param entityTypes table<string>
---@param l10nData table<AllIdTypes, table<L10nDBKeys, table<L10nLocales, any>>>
---@param maxIdsPerSlice number?
---@return table<string, string> dumps Table keyed by entity type (capitalized) to dump string
---------------------------------------------------------------------------
function export.DumpL10nDataByType(L10nMeta, entityTypes, l10nData, maxIdsPerSlice)
  maxIdsPerSlice = maxIdsPerSlice or 20000
  local dumps = {}

  for _, entityType in ipairs(entityTypes) do
    print(string.format("Creating l10n data dump for %s", entityType))

    local entityTypeLower = entityType:lower()
    local outputLines = { "{\n", }
    local localeCount = #L10nMeta.locales
    local emptyValue = string.rep(splitCharacter, #L10nMeta.locales - 1)
    local indentation = "  "

    local sortedIds = {}
    for id, entryData in pairs(l10nData) do
      if entryData and entryData[entityTypeLower] then
        tInsert(sortedIds, id)
      end
    end
    table.sort(sortedIds)

    local idsInCurrentSlice = 0
    for _, id in ipairs(sortedIds) do
      local entryData = l10nData[id]
      local typeData = entryData and entryData[entityTypeLower] or nil
      if typeData ~= nil then
        tInsert(outputLines, string.format("[%d] = {\n", id))
        tInsert(outputLines, dumpSingleEntityType(entityTypeLower, typeData, L10nMeta, localeCount, emptyValue, indentation, false))

        local lastLine = outputLines[#outputLines]
        if string.sub(lastLine, -2) == ",\n" then
          outputLines[#outputLines] = string.sub(lastLine, 1, -3) .. "\n"
        end

        tInsert(outputLines, "},\n")

        idsInCurrentSlice = idsInCurrentSlice + 1
        if idsInCurrentSlice >= maxIdsPerSlice then
          local ll = outputLines[#outputLines]
          if ll:sub(-2) == ",\n" then outputLines[#outputLines] = ll:sub(1, -3) .. "\n" end

          tInsert(outputLines, "}\n")
          tInsert(outputLines, "-- break\n")
          tInsert(outputLines, "{\n")

          idsInCurrentSlice = 0
        end
      end
    end

    local lastLine = outputLines[#outputLines]
    if string.sub(lastLine, -2) == ",\n" then
      outputLines[#outputLines] = string.sub(lastLine, 1, -3) .. "\n"
    end
    tInsert(outputLines, "}\n")

    dumps[entityType] = table.concat(outputLines)
  end

  return dumps
end

-------------------------------------------------------------------------------
--- Loads a sliced localisation dump produced by `export.DumpL10nData`.
---
--- The dump is one text file that looks like:
--- ```
--- return {
---   [1] = { … },
---   ...
--- }
--- -- break
--- {
---   [2001] = { … },
---   ...
--- }
--- -- break
--- {
---   ...
--- }
--- ```
--- Each “slice” after a `-- break` marker is small enough to compile on Lua 5.1
--- without tripping the *constant table overflow* limit.  This loader:
---   1. Reads the file line‑by‑line.
---   2. Whenever it sees `-- break`, it compiles the lines collected so far
---      with `loadstring`, gets a partial table, and merges that into
---      a shared result table.
---   3. Repeats until EOF, then returns the merged table.
---
--- @param  path  string  Absolute or relative path to the dump file.
--- @return table<AllIdTypes, table>  The fully merged localisation table.
-------------------------------------------------------------------------------
function export.LoadL10n(path)
  ---------------------------------------------------------------------------
  -- Locals
  ---------------------------------------------------------------------------
  local L10n  = {} --- Final result.
  local lines = {} --- Buffer holding the current slice’s source lines.

  --- Copies every key/value pair from *src* into *dest*.
  --- Later slices overwrite earlier duplicates (last‑one‑wins).
  --- @param dest table
  --- @param src  table
  local function merge(dest, src)
    for k, v in pairs(src) do
      dest[k] = v
    end
  end

  ---------------------------------------------------------------------------
  -- Pass 1 – stream the file, splitting on “-- break”
  ---------------------------------------------------------------------------
  for line in io.lines(path) do
    if line:match("^%-%- break") then -- ➊ slice delimiter
      if #lines > 0 then              -- compile current slice
        local chunk = assert(loadstring("return " .. table.concat(lines, "\n")))
        merge(L10n, chunk())          -- merge into result
        lines = {}                    -- reset buffer
      end
    else
      lines[#lines + 1] = line -- normal data line
    end
  end

  ---------------------------------------------------------------------------
  -- Pass 2 – compile the last slice (no “-- break” after it)
  ---------------------------------------------------------------------------
  if #lines > 0 then
    local chunk = assert(loadstring("return " .. table.concat(lines, "\n")))
    merge(L10n, chunk())
  end

  return L10n
end

-------------------------------------------------------------------------------
--- Loads multiple per-type l10n dumps and merges them into a single table.
--- @param pathsByType table<string, string> Map of entity type (capitalized) -> file path.
--- @param L10nMeta L10nMeta
--- @return table<AllIdTypes, table>
-------------------------------------------------------------------------------
function export.LoadL10nByType(pathsByType, L10nMeta)
  local l10n = {}

  for entityType, path in pairs(pathsByType) do
    local typeLower = entityType:lower()
    local typeIndex = L10nMeta.l10nKeys[typeLower]
    assert(typeIndex, string.format("Unknown entity type for l10n load: %s", tostring(entityType)))

    local partial = export.LoadL10n(path)
    for id, typeTable in pairs(partial) do
      local value
      if type(typeTable) == "table" then
        value = typeTable[1]
      else
        value = typeTable
      end

      if value ~= nil then
        l10n[id] = l10n[id] or {}
        l10n[id][typeIndex] = value
      end
    end
  end

  return l10n
end

return export
