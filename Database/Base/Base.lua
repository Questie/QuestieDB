---@class LibQuestieDB
local LibQuestieDB = select(2, ...)


--*---- Import Modules -------
local Database = LibQuestieDB.Database
local Corrections = LibQuestieDB.Corrections
local DebugText = LibQuestieDB.DebugText


---- Local Functions ----
local tConcat = table.concat
local tInsert = table.insert
local wipe = wipe
local loadstring = loadstring
local f = string.format
local gsub = string.gsub

--- Create a database in the passed in object
---@generic DBT
---@param refTable table
---@param databaseType `DBT`
---@return DBT
function LibQuestieDB.CreateDatabaseInTable(refTable, databaseType)
  assert(type(refTable) == "table", "refTable must be a table")
  assert(type(databaseType) == "string", "databaseType must be a string")

  if not Database then
    error("Database not loaded")
  end
  local getNumber = Database.getNumber
  local getTable = Database.getTable

  local debug = DebugText:Get(databaseType)
  ---@type string
  local dbType = databaseType
  ---@type string
  local captializedType = dbType:sub(1, 1):upper() .. dbType:sub(2)

  --*---------------------------
  --- The nil value for the database
  local _nil = Database._nil

  ---- Contains the data ----
  local glob = {}
  local override = {}

  ---- Contains the id strings ----
  local AllIdStrings = {}

  ---@class (exact) DatabaseType
  ---@field private glob table<Id, table<number, FontString>>
  ---@field private override table<Id, table<string, any>>
  ---@field InitializeDynamic fun()
  ---@field LoadOverrideData fun(includeDynamic: boolean?, includeStatic: boolean?)
  ---@field AddOverrideData fun(dataOverride: table<string, any>, overrideKeys: table<string, number>): number
  ---@field ClearOverrideData fun()
  ---@field GetAllIds fun(hashmap: boolean?): QuestId[]
  ---@field AddStringGetter fun(numberKey: number, nameKey: string, defaultValue: string?): fun(id: Id): string?
  ---@field AddNumberGetter fun(numberKey: number, nameKey: string, defaultValue: number?): fun(id: Id): number?
  ---@field AddTableGetter fun(numberKey: number, nameKey: string, defaultValue: table?): fun(id: Id): table?
  ---@field AddPatternGetter fun(numberKey: number, nameKey: string, pattern: string, defaultValue: any?, converter: (fun(value: string): any)?): fun(id: Id): table?
  local DB = refTable

  function DB.InitializeDynamic()
    -- This will be assigned from the initialize function
    local itemData = Database.LoadDatafileList(captializedType .. "Data") -- e.g ItemData
    -- localized for faster access
    local loadFile = Database.LoadFile
    -- Get the binary search function
    local binarySearch, _ = Database.CreateFindDataBinarySearchFunction(itemData)

    ---@type table<Id, table<number, FontString>>
    glob = setmetatable({},
                        {
                          __index = function(t, k)
                            return loadFile(binarySearch(k), t, k)
                          end,
                          __newindex = function()
                            error("Attempt to modify read-only table")
                          end,
                        }
    )
    DB.glob = glob
    DB.LoadOverrideData()
  end

  ---comment
  ---@param includeDynamic boolean? @If true, include dynamic data Default true
  ---@param includeStatic boolean? @If true, include dynamic data Default false
  function DB.LoadOverrideData(includeDynamic, includeStatic)
    if includeDynamic == nil then
      includeDynamic = true
    end
    if includeStatic == nil then
      includeStatic = Database.debugEnabled or false
    end
    -- Clear the override data
    DB.ClearOverrideData()

    LibQuestieDB.ColorizePrint("yellow", f("Loading %s Corrections", captializedType))
    local loadOrder = 0
    local totalLoaded = 0
    -- Load all Quest Corrections
    for _, list in pairs(Corrections.GetCorrections(dbType:lower(), includeStatic, includeDynamic)) do
      for id, func in pairs(list) do
        local correctionData = func()
        totalLoaded = totalLoaded + DB.AddOverrideData(correctionData, Corrections.QuestMeta.questKeys)
        if Database.debugEnabled then
          debug:Print("  " .. tostring(loadOrder) .. "  Loaded", id)
        end
        loadOrder = loadOrder + 1
      end
    end
    if Database.debugEnabled then
      debug:Print(f("  # %s Corrections", captializedType), totalLoaded)
    end
    DB.override = override
  end

  function DB.AddOverrideData(dataOverride, overrideKeys)
    if not glob or not override then
      error(f("You must initialize the %s database before adding override data", captializedType))
    end
    local newIds = Database.GetNewIds(AllIdStrings, dataOverride)
    if #newIds ~= 0 then
      tInsert(AllIdStrings, tConcat(newIds, ","))
      if Database.debugEnabled then
        LibQuestieDB.ColorizePrint("lightBlue", f(" # New %s IDs", captializedType), #newIds)
      end
    end
    return Database.Override(dataOverride, override, overrideKeys)
  end

  local function InitializeIdString()
    wipe(AllIdStrings)
    local func, idString = Database.GetAllEntityIdsFunction(captializedType)
    tInsert(AllIdStrings, idString)
    if Database.debugEnabled then
      assert(#func() == #DB.GetAllIds(), f("%s ids are not the same", captializedType))
    end
  end

  function DB.ClearOverrideData()
    if override then
      override = wipe(override)
    end
    InitializeIdString()
  end

  ---Get all quest ids.
  ---@param hashmap boolean? @If true, returns a hashmap with the ids as keys and true as value. Default false
  ---@return QuestId[]
  function DB.GetAllIds(hashmap)
    if hashmap == true then
      -- Sub all numbers and replace them with [number]=true,
      local dat = gsub(tConcat(AllIdStrings, ","), "(%d+)", "[%1]=true")
      return loadstring(f("return {%s}", dat))()
    else
      return loadstring(f("return {%s}", tConcat(AllIdStrings, ",")))()
    end
  end

  --?-------------------------------------------------------------
  --? Add Getters
  do
    --- <comment>
    ---@param numberKey number - The key of the information to retrieve.
    ---@param nameKey string - The key of the information to retrieve.
    ---@param defaultValue string? - The default value to return if the data is not found.
    ---@return fun(id: Id): string?
    function DB.AddStringGetter(numberKey, nameKey, defaultValue)
      assert(type(numberKey) == "number", "numberKey must be a number")
      assert(type(nameKey) == "string", "nameKey must be a string")
      assert(defaultValue == nil or type(defaultValue) == "string", "defaultValue must be a string or nil")

      return function(id)
        -- Check for override
        if override[id] and override[id][nameKey] then
          local value = override[id][nameKey]
          return value ~= _nil and value or defaultValue
        end

        -- Fetch from global data
        ---@type FontString?
        local data = glob[id] and glob[id][numberKey]
        if data then
          return data:GetText()
        else
          return defaultValue
        end
      end
    end

    --- <comment>
    ---@param numberKey number - The key of the information to retrieve.
    ---@param nameKey string - The key of the information to retrieve.
    ---@param defaultValue number? - The default value to return if the data is not found.
    ---@return fun(id: Id): number?
    function DB.AddNumberGetter(numberKey, nameKey, defaultValue)
      assert(type(numberKey) == "number", "numberKey must be a number")
      assert(type(nameKey) == "string", "nameKey must be a string")
      assert(defaultValue == nil or type(defaultValue) == "number", "defaultValue must be a number or nil")

      return function(id)
        -- Check for override
        if override[id] and override[id][nameKey] then
          local value = override[id][nameKey]
          return value ~= _nil and value or defaultValue
        end

        -- Fetch from global data
        ---@type FontString?
        local data = glob[id] and glob[id][numberKey]
        if data then
          return getNumber(data) or defaultValue
        else
          return defaultValue
        end
      end
    end

    --- <comment>
    ---@param numberKey number - The key of the information to retrieve.
    ---@param nameKey string - The key of the information to retrieve.
    ---@param defaultValue table? - The default value to return if the data is not found.
    ---@return fun(id: Id): table?
    function DB.AddTableGetter(numberKey, nameKey, defaultValue)
      assert(type(numberKey) == "number", "numberKey must be a number")
      assert(type(nameKey) == "string", "nameKey must be a string")
      assert(defaultValue == nil or type(defaultValue) == "table", "defaultValue must be a table or nil")

      return function(id)
        -- Check for override
        if override[id] and override[id][nameKey] then
          local value = override[id][nameKey]
          return value ~= _nil and value or defaultValue
        end

        -- Fetch from global data
        ---@type FontString?
        local data = glob[id] and glob[id][numberKey]
        if data then
          return getTable(data) or defaultValue
        else
          return defaultValue
        end

        -- Less readable version
        -- local data = glob[id] and glob[id][numberKey]
        -- return data and (getTable(data) or defaultValue) or defaultValue
      end
    end

    --- <comment>
    ---@param numberKey number - The key of the information to retrieve.
    ---@param nameKey string - The key of the information to retrieve.
    ---@param pattern string - The pattern to match the string value.
    ---@param defaultValue any? - The default value to return if the data is not found.
    ---@param converter (fun(value: string): any)? - The function to convert the string value to the desired type.
    ---@return fun(id: Id): table?
    function DB.AddPatternGetter(numberKey, nameKey, pattern, defaultValue, converter)
      if converter then
        return function(id)
          -- Check for override
          if override[id] and override[id][nameKey] then
            local value = override[id][nameKey]
            return value ~= _nil and value or defaultValue
          end

          -- Fetch from global data
          ---@type FontString?
          local data = glob[id] and glob[id][numberKey]
          if data then
            --! This is slower than a raw value
            return converter(data:GetText():match(pattern))
          else
            return defaultValue
          end
        end
      else
        return function(id)
          -- Check for override
          if override[id] and override[id][nameKey] then
            local value = override[id][nameKey]
            return value ~= _nil and value or defaultValue
          end

          -- Fetch from global data
          ---@type FontString?
          local data = glob[id] and glob[id][numberKey]
          if data then
            --! This is slower than a raw value
            return data:GetText():match(pattern)
          else
            return defaultValue
          end
        end
      end
    end
  end
  -- ? End Getters
  --?-------------------------------------------------------------

  return DB
end
