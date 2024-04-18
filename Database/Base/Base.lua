---@class LibQuestieDB
local LibQuestieDB = select(2, ...)


--*---- Import Modules -------
local Database = LibQuestieDB.Database
local Corrections = LibQuestieDB.Corrections
local DebugText = LibQuestieDB.DebugText


---- Local Functions ----
local tConcat    = table.concat
local tInsert    = table.insert
local wipe       = wipe
local loadstring = loadstring
local f          = string.format
local gsub       = string.gsub
local pairs      = pairs
local ipairs     = ipairs
local assert     = assert
local type       = type


--- Create a database in the passed in object
---@generic DBT
---@param refTable table
---@param databaseType `DBT`
---@param databaseTypeMeta table<string, number>
---@return DBT
function LibQuestieDB.CreateDatabaseInTable(refTable, databaseType, databaseTypeMeta)
  assert(type(refTable) == "table", "refTable must be a table")
  assert(type(databaseType) == "string", "databaseType must be a string")
  assert(type(databaseTypeMeta) == "table", "databaseTypeMeta must be a table")

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
  ---@type table<Id, table<string, any>>
  local override = {}

  ---- Contains the id strings ----
  local AllIdStrings = {}

  ---- Add entity type to the database ----
  Database.entityTypes[captializedType] = true

  --- Print debug messages to the console and the debug text frame.
  ---@param textKey string @The text to print.
  local function debugPrint(textKey, ...)
    debug:Print(textKey, ...)
    if Is_CLI then
      print(textKey, ...)
    end
  end

  ---@class DatabaseType
  ---@field private glob table<Id, table<number, FontString>>
  ---@field private override table<Id, table<string, any>>
  ----@field InitializeDynamic fun()
  ----@field LoadOverrideData fun(includeDynamic: boolean?, includeStatic: boolean?)
  ----@field AddOverrideData fun(dataOverride: table<string, any>, overrideKeys: table<string, number>): number
  ----@field ClearOverrideData fun()
  ----@field GetAllIds fun(hashmap: boolean?): QuestId[]
  ----@field AddStringGetter fun(numberKey: number, nameKey: string, defaultValue: string?): fun(id: Id): string?
  ----@field AddNumberGetter fun(numberKey: number, nameKey: string, defaultValue: number?): fun(id: Id): number?
  ----@field AddTableGetter fun(numberKey: number, nameKey: string, defaultValue: table?): fun(id: Id): table?
  ----@field AddPatternGetter fun(numberKey: number, nameKey: string, pattern: string, defaultValue: any?, converter: (fun(value: string): any)?): fun(id: Id): table?
  local DB = refTable

  --- Initializes the dynamic part of the database for the entity type.
  --- It sets up a metatable for lazy loading of data and prepares for overrides.
  function DB.InitializeDynamic()
    -- Load the list of data files for the entity type (e.g., "ItemData" for items).
    local itemData = Database.LoadDatafileList(captializedType .. "Data")

    -- Local reference to the LoadFile function for faster access.
    local loadFile = Database.LoadFile

    -- Create a binary search function to efficiently find data files based on entity ID.
    local binarySearch, _ = Database.CreateFindDataBinarySearchFunction(itemData)

    -- Set up a metatable for the global data table. This allows for lazy loading of data:
    -- When data for an ID is requested, it will be loaded on-demand using the binary search function.
    glob = setmetatable({},
                        {
                          -- The __index metamethod is called when a requested ID is not in the table.
                          -- It will load the data file containing the ID and return the data.
                          __index = function(t, k)
                            return loadFile(binarySearch(k), t, k)
                          end,
                          -- The __newindex metamethod prevents any modifications to the table,
                          -- ensuring that the database remains read-only.
                          __newindex = function()
                            error("Attempt to modify read-only table")
                          end,
                        }
    )

    -- Assign the global data table to the DB object for external access.
    DB.glob = glob

    -- Load any override data that may exist to correct or update the original data.
    DB.LoadOverrideData()
  end

  -- Function to load override data into the database.
  ---@param includeDynamic boolean? @If true, include dynamic data (default true).
  ---@param includeStatic boolean? @If true, include static data (default is the value of Database.debugEnabled).
  ---@return number totalLoaded @The total number of corrections loaded.
  function DB.LoadOverrideData(includeDynamic, includeStatic)
    -- Set default values for the parameters if they are not provided.
    if includeDynamic == nil then
      includeDynamic = true
    end
    if includeStatic == nil then
      includeStatic = Database.debugLoadStaticEnabled or false
    end

    -- Clear any existing override data before loading new corrections.
    DB.ClearOverrideData()

    -- Print a debug message indicating the type of corrections being loaded.
    if Database.debugPrintEnabled then
      LibQuestieDB.ColorizePrint("yellow", f("Loading %s Corrections", captializedType))
      if not Database.debugLoadStaticEnabled then
        LibQuestieDB.ColorizePrint("gray", "Skipping static correction loading for", captializedType)
      end
    end

    -- Initialize counters for load order and total corrections loaded.
    local overallLoadOrder = 0
    local totalLoaded = 0

    local allCorrections, order = Corrections.GetCorrections(dbType, includeStatic, includeDynamic)

    -- Iterate over all corrections for the current database type.
    -- Corrections.GetCorrections returns a table of correction functions filtered by type and inclusion flags.
    -- We use this table to always statically load corrections first, followed by dynamic corrections.
    for _, correctionType in ipairs(order) do
      local correctionList = allCorrections[correctionType]
      if correctionList then
        if Database.debugPrintEnabled then
          debugPrint(f("  %s Applied", LibQuestieDB.Capitalized(correctionType)))
        end
        for _, correctionObject in pairs(correctionList) do
          -- Execute the correction function to get the correction data.
          local correctionData = correctionObject.func()
          -- Add the correction data to the database and increment the total loaded counter.
          local loaded = DB.AddOverrideData(correctionData, databaseTypeMeta)
          totalLoaded = totalLoaded + loaded

          if Database.debugPrintEnabled then
            debugPrint(f("    %d:(%d) '%s' Applied", tostring(overallLoadOrder), correctionObject.loadOrder, correctionObject.name),
                       loaded)
          end
          overallLoadOrder = overallLoadOrder + 1
        end
      end
    end

    -- If debugging is enabled, print the total number of corrections loaded.
    if Database.debugPrintEnabled then
      debugPrint(f("  # %s Corrections", captializedType), totalLoaded)
    end

    -- Update the DB.override table with the new override data.
    DB.override = override
    return totalLoaded
  end

  ---@param dataOverride table<number, any> @ The data to add to the override table i.e { [15882] = {[itemKeys.objectDrops] = { 177844 }}, }
  ---@param overrideKeys table<string, number> @ The keys to use for the override table i.e { ['name'] = 1, }
  ---@return number @Returns the number of overrides applied.
  function DB.AddOverrideData(dataOverride, overrideKeys)
    -- Check if the database has been initialized by ensuring `glob` and `override` are not nil.
    if not glob or not override then
      error(f("You must initialize the %s database before adding override data", captializedType))
    end

    -- Retrieve new IDs from the override data that are not already present in the database.
    local newIds = Database.GetNewIds(AllIdStrings, dataOverride)

    -- If there are new IDs, concatenate them into a string and add to `AllIdStrings` for tracking.
    if #newIds ~= 0 then
      tInsert(AllIdStrings, tConcat(newIds, ","))
      if Database.debugPrintEnabled then
        LibQuestieDB.ColorizePrint("lightBlue", f(" # New %s IDs", captializedType), #newIds)
      end
    end

    -- Apply the override data to the database and return the number of overrides applied.
    return Database.Override(dataOverride, override, overrideKeys)
  end

  local function InitializeIdString()
    -- If the addon is running in a CLI environment to create statics, return early to prevent errors.
    -- It will however still initialize during the CLI testing phase.
    if Is_Create_Static then return end

    wipe(AllIdStrings)
    local func, idString = Database.GetAllEntityIdsFunction(captializedType)
    -- TODO: Maybe we should sort this list?
    tInsert(AllIdStrings, idString)
    if Database.debugPrintEnabled then
      assert(#func() == #DB.GetAllIds(), f("%s ids are not the same", captializedType))
    end
  end

  --- Clears the override data from the database.
  -- This function is used to remove all existing override data from the database.
  -- It is typically called when the addon needs to refresh its data, ensuring that
  -- outdated or irrelevant corrections are not applied. After clearing the override
  -- data, it re-initializes the list of entity IDs to work with the correct set of data.
  function DB.ClearOverrideData()
    if override then
      -- Use the `wipe` function to clear the `override` table.
      override = wipe(override)
    end
    -- Re-initialize the list of entity IDs after clearing the override data.
    InitializeIdString()
  end

  --- Retrieves all IDs from the database.
  --- @param hashmap boolean? @Optional. If true, returns a hashmap with the IDs as keys and true as values. Defaults to false.
  --- @return QuestId[] @Returns either a list of IDs or a hashmap of IDs (Not sorted).
  function DB.GetAllIds(hashmap)
    if hashmap == true then
      -- Substitute all numbers in the concatenated ID strings with Lua table format [number]=true
      local dat = gsub(tConcat(AllIdStrings, ","), "(%d+)", "[%1]=true")
      -- Execute the string as Lua code to create and return the hashmap
      return loadstring(f("return {%s}", dat))()
    else
      -- If hashmap is not requested, simply return a list of IDs
      return loadstring(f("return {%s}", tConcat(AllIdStrings, ",")))()
    end
  end

  --?-------------------------------------------------------------
  --? Add Getters
  do
    --- This function is used to add a string getter to the database.
    --- It returns a function that retrieves a string value from the database for a given ID.
    --- If the ID is not found in the database, the function will return the default value.
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

    --- This function is used to add a number getter to the database.
    --- It returns a function that retrieves a number value and converts it from the database for a given ID.
    --- If the ID is not found in the database, the function will return the default value.
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
    ---@return fun(id: Id): any?
    function DB.AddPatternGetter(numberKey, nameKey, pattern, defaultValue, converter)
      local allowedDefaultTypes = {
        ["string"] = true,
        ["number"] = true,
        ["table"] = true,
        ["nil"] = true,
      }
      assert(type(numberKey) == "number", "numberKey must be a number")
      assert(type(nameKey) == "string", "nameKey must be a string")
      assert(type(pattern) == "string", "pattern must be a string")
      assert(allowedDefaultTypes[type(defaultValue)], "defaultValue is not a valid type")
      assert(converter == nil or type(converter) == "function", "converter must be a function or nil")
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
