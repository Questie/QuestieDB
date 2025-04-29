local script_path = debug.getinfo(1, "S").source:sub(2)
local script_dir = script_path:match("(.*/)")
package.path = script_dir .. "?.lua;" .. package.path

-- Allow accessing private fields
---@diagnostic disable: invisible
require("cli.dump")
local helpers = require(".db_helpers")

local f = string.format
local tInsert = table.insert

local export = {}

---Remove the first 3 lines which checks the GetLocale() if it should load, we want to load all
---@param version string Expansions e.g. "Classic", "TBC", "Wotlk"
---@param type string Type of data e.g. "item", "npc", "object", "quest"
function export.CleanFiles(version, type)
  local cleaned_files = {}
  local capitalized_type = helpers.capitalize(type)
  -- Remove the first 3 lines in all .lua files in .database_generator\Questie-translations\Localization\lookups\Classic\lookupItems
  local path = helpers.get_project_dir_path() ..
      "/.database_generator/Questie-translations/Localization/lookups/" .. version .. "/lookup" .. capitalized_type .. "s/"
  -- Get all .lua files in the directory
  local files = helpers.get_files_in_directory(path, "lua")
  for _, file in ipairs(files) do
    local file_path = path .. file
    local filedata = io.open(file_path, "r")
    if filedata then
      local lines = {}
      for line in filedata:lines() do
        tInsert(lines, line)
      end
      filedata:close()

      -- Remove lines until "---@type l10n"
      local new_lines = {}
      local found_l10n = false
      for _, line in ipairs(lines) do
        if found_l10n then
          if type == "npc" then
            line = string.gsub(line, "l10n%.npcNameLookup", "l10n.npcLookup")
          end
          tInsert(new_lines, line)
        elseif line:find("local l10n") then
          found_l10n = true
          tInsert(new_lines, line)
        end
      end


      -- Write the new lines back to the file
      local filename = string.gsub(file_path, ".lua", ".lua.clean")
      local clean_filedata = io.open(filename, "w")
      if clean_filedata then
        local combined_lines = table.concat(new_lines, "\n")
        -- Write the new lines back to the file
        clean_filedata:write(combined_lines)

        clean_filedata:close()
        print("Cleaned file: " .. filename)
        tInsert(cleaned_files, filename)
      end
    end
  end

  -- Change the XML file to point to the cleaned files
  -- Example path: .database_generator\Questie-translations\Localization\lookups\Classic\lookupItems\lookupItems.xml
  local xml_path = helpers.get_project_dir_path() ..
      "/.database_generator/Questie-translations/Localization/lookups/" .. version .. "/lookup" .. capitalized_type .. "s/lookup" .. capitalized_type .. "s.xml"
  local xml_filedata = io.open(xml_path, "r")
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
    data = string.gsub(data, "%.lua", ".lua.clean") -- Replace .lua with .lua.clean
    -- Write the new data back to the XML file
    local filename = string.gsub(xml_path, ".xml", ".clean.xml")
    local clean_xml_filedata = io.open(filename, "w")
    if clean_xml_filedata then
      clean_xml_filedata:write(data)
      clean_xml_filedata:close()
      print("Cleaned XML file: " .. xml_path .. ".clean.xml")
      tInsert(cleaned_files, filename)
    end
  end
  return cleaned_files
end

---comment
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
    print("Dumping: " .. lookupKey)
    local lookup = l10nObject[lookupKey]
    for _, localeKey in ipairs(locales) do
      local allLocaleData = lookup[localeKey]()
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
      -- Quest text is a table, join it with <br>
      if type(val) == "table" then
        val = joinAndEscape(val, "<br>", "")
      elseif type(val) == "string" then
        -- Escape single quotes
        val = string.gsub(val, "'", "\\'")
      end
      -- Replace newlines specifically for quest text as per python script logic
      val = string.gsub(val, "\r", "")
      val = string.gsub(val, "\n", "<br>")
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

--- Joins a list of strings with a separator, escaping single quotes and handling nil values.
---@param tbl table<number, string?> List of strings to join.
---@param separator string Separator character.
---@param emptyValue string The string representing an empty joined value (e.g., "‡‡‡").
---@return string|'"nil"' Joined string wrapped in single quotes, or '"nil"' if empty.
local function joinAndEscape2(tbl, separator, emptyValue)
  local result = {}
  local hasContent = false
  for i = 1, #tbl do
    local val = tbl[i]
    if val == nil then
      result[i] = ""
    else
      -- Escape single quotes
      val = string.gsub(val, "'", "\\'")
      -- Replace newlines specifically for quest text as per python script logic
      val = string.gsub(val, "\r", "")
      val = string.gsub(val, "\n", "<br>")
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

-- local function dumpQuest(questid, locales)
--   for _, locale in ipairs(locales) do
--     local questData = l10nObject.questLookup[locale](questid)
--     if questData then
--       local title = questData[1] or nil
--       local description = questData[2] or nil
--       local text = questData[3] or nil
--       print(f("Quest ID: %d, Title: %s, Description: %s, Text: %s", questid, title, description, text))
--     end
--   end

local function anyValue(table)
  for _, v in pairs(table) do
    if v ~= nil then
      return true
    end
  end
  return false
end

---comment
---@param lines table<string> The lines object to be modified
---@param entityType string Will write the entitytype in a comment, not used for anything else (e.g., "Item", "Npc", "Object", "Quest")
---@param nrOfValues number The number of values to output, We need this because we want to output nils
---@param values table<string>
---@return table<string> Modified lines object
local function insertLines(lines, entityType, nrOfValues, values)
  local indentation = "  "
  if anyValue(values) then
    tInsert(lines, f("%s{ -- %s\n", indentation, helpers.capitalize(entityType)))
    for i = 1, nrOfValues do
      local value = values[i]
      if value ~= nil then
        -- Escape single quotes in the joined string
        tInsert(lines, f("%s'%s',\n", string.rep(indentation, 2), value))
      else
        -- If the joined string is nil, add a placeholder
        tInsert(lines, f("%snil,\n", string.rep(indentation, 2)))
      end
    end
    tInsert(lines, f("%s},\n", indentation))
  else
    -- If data for this entity type doesn't exist for this ID, add nil placeholder
    tInsert(lines, f("%snil,\n", indentation))
  end
  return lines
end

--- Dumps the structured l10n data into a Lua table string format.
---@param L10nMeta L10nMeta
---@param entityTypes table<string> The entity types to be dumped (e.g., "Item", "Npc", "Object", "Quest")
---@param l10nData table<AllIdTypes, table<L10nDBKeys, table<L10nLocales, any>>> The structured localization data.
---@return string luaTableString The generated Lua table as a string.
function export.DumpL10nData(L10nMeta, entityTypes, l10nData)
  local outputLines = {}
  tInsert(outputLines, "{\n")

  local localeCount = #L10nMeta.locales
  -- Create the string representing an empty value for comparison
  local emptyValue = string.rep("‡", #L10nMeta.locales - 1)

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

  ---@param id ItemId|NpcId|ObjectId|QuestId
  for _, id in ipairs(sortedIds) do
    local entryData = l10nData[id]

    tInsert(outputLines, string.format("[%d] = {\n", id))

    for _, entityType in ipairs(sortedEntityTypes) do
      local typeData = entryData[entityType]
      if typeData then
        local translations = {}
        for i = 1, localeCount do
          -- Get data in the order defined by L10nMeta.locales
          -- Always set "" empty value here for the locale count to be correct.
          translations[i] = typeData[L10nMeta.locales[i]] or ""
        end

        if entityType == "item" or entityType == "object" then
          tInsert(outputLines, L10nMeta.lua_tableDumpFuncs[entityType](
            joinAndEscape(translations, "‡", emptyValue)
          ))
        elseif entityType == "npc" then
          -- translations is a table of {name, subname} pairs
          local names = {}
          local subnames = {}
          for i = 1, #translations do
            local npcData = translations[i] or { "", "", }
            names[i] = npcData[1] or ""    -- Name is index 1
            subnames[i] = npcData[2] or "" -- Subname is index 2
          end
          tInsert(outputLines, L10nMeta.lua_tableDumpFuncs[entityType](
            {
              joinAndEscape(names, "‡", emptyValue),
              joinAndEscape(subnames, "‡", emptyValue),
            }))
        elseif entityType == "quest" then
          -- translations is a table of {title, description, text} triples
          local titles = {}
          local descriptions = {}
          local texts = {}
          for i = 1, #translations do
            local questData = translations[i] or { "", "", "", }
            titles[i] = questData[1] or ""       -- Title
            descriptions[i] = questData[2] or "" -- Description
            texts[i] = questData[3] or ""        -- Text
          end
          tInsert(outputLines, L10nMeta.lua_tableDumpFuncs[entityType](
            {
              joinAndEscape(titles, "‡", emptyValue),
              joinAndEscape(descriptions, "‡", emptyValue),
              joinAndEscape(texts, "‡", emptyValue),
            }))
        end
      else
        -- If data for this entity type doesn't exist for this ID, add nil placeholder
        tInsert(outputLines, f("%snil,\n", indentation))
      end
    end
    -- Remove trailing comma from the last element within the ID's table
    local lastLine = outputLines[#outputLines]
    if string.sub(lastLine, -2) == ",\n" then
      outputLines[#outputLines] = string.sub(lastLine, 1, -3) .. "\n"
    end
    tInsert(outputLines, "},\n")
  end
  -- Remove trailing comma from the last ID entry
  local lastLine = outputLines[#outputLines]
  if string.sub(lastLine, -2) == ",\n" then
    outputLines[#outputLines] = string.sub(lastLine, 1, -3) .. "\n"
  end
  tInsert(outputLines, "}\n")

  return table.concat(outputLines)
end

return export
