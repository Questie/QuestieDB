--? CLI
require("cli.CLI_Helpers")

--? Blizzard builtins
-- CONSTANTS
require("cli.builtins.CONST")
-- Global Strings
require("cli.builtins.GLOBAL_STRINGS")
-- Global Addon Functions
require("cli.builtins.builtin")

-- C_ Namespace
require("cli.builtins.C_Timer")
-- require("cli.builtins.C_Map")
-- require("cli.builtins.C_Seasons")
-- require("cli.builtins.C_QuestLog")

-- Frames
-- require("cli.builtins.Frames")

-- Used to print extra information and the like when generating the database
Is_CLI = true

-- WoW addon namespace
CLI_addonName = "QuestieDB"
CLI_addonTable = {}

-- "Client" data
CLI_Locale = "deDE"
-- CLI_Locale = "enUS"

-- "Player" data
CLI_PlayerLevel = 60
CLI_PlayerFaction = "Horde"
CLI_PlayerClass = { "Druid", "DRUID", 11, }
CLI_PlayerName = "Reebookie"

_EmptyDummyFunction = function() end
_TableDummyFunction = function() return {} end

-- Used when registering slash command
SlashCmdList = {}
-- Used to create a popup dialog for the user
StaticPopupDialogs = {}
do
  local initByVersion = {
    ["Era"] = function()
      ---@type LibQuestieDB
      ---@diagnostic disable-next-line: missing-fields
      LibQuestieDBTable = {}

      -- When creating the static database, we load the QuestieDB which writes to this global, so we reset it here
      QuestieDB = {}
      -- Same here, the old Questie code expects this.
      QuestieLoader = {
        ImportModule = function()
          return QuestieDB
        end,
      }

      C_Seasons = {
        HasActiveSeason = function() return false end,
        ---@see Enum.SeasonID
        GetActiveSeason = function() return 0 end,
      }

      GetBuildInfo = function()
        return "1.14.3", "44403", "Jun 27 2022", 11403
      end

      WOW_PROJECT_ID = WOW_PROJECT_CLASSIC

      CLI_Helpers.loadTOC("QuestieDB-Vanilla.toc")

      return LibQuestieDBTable
    end,
    ["Sod"] = function()
      ---@type LibQuestieDB
      ---@diagnostic disable-next-line: missing-fields
      LibQuestieDBTable = {}

      -- When creating the static database, we load the QuestieDB which writes to this global, so we reset it here
      QuestieDB = {}
      -- Same here, the old Questie code expects this.
      QuestieLoader = {
        ImportModule = function()
          return QuestieDB
        end,
      }

      C_Seasons = {
        HasActiveSeason = function() return true end,
        ---@see Enum.SeasonID
        GetActiveSeason = function() return 2 end,
      }


      GetBuildInfo = function()
        return "1.14.3", "44403", "Jun 27 2022", 11403
      end

      WOW_PROJECT_ID = WOW_PROJECT_CLASSIC

      CLI_Helpers.loadTOC("QuestieDB-Vanilla.toc")

      return LibQuestieDBTable
    end,
    ["Tbc"] = function()
      ---@type LibQuestieDB
      ---@diagnostic disable-next-line: missing-fields
      LibQuestieDBTable = {}

      -- When creating the static database, we load the QuestieDB which writes to this global, so we reset it here
      QuestieDB = {}
      -- Same here, the old Questie code expects this.
      QuestieLoader = {
        ImportModule = function()
          return QuestieDB
        end,
      }

      GetBuildInfo = function()
        return "2.5.1", "38644", "May 11 2021", 20501
      end

      WOW_PROJECT_ID = WOW_PROJECT_BURNING_CRUSADE_CLASSIC

      CLI_Helpers.loadTOC("QuestieDB-BCC.toc")

      return LibQuestieDBTable
    end,
    ["Wotlk"] = function()
      ---@type LibQuestieDB
      ---@diagnostic disable-next-line: missing-fields
      LibQuestieDBTable = {}

      -- When creating the static database, we load the QuestieDB which writes to this global, so we reset it here
      QuestieDB = {}
      -- Same here, the old Questie code expects this.
      QuestieLoader = {
        ImportModule = function()
          return QuestieDB
        end,
      }

      GetBuildInfo = function()
        return "3.4.0", "44644", "Jun 12 2022", 30400
      end

      WOW_PROJECT_ID = WOW_PROJECT_WRATH_CLASSIC

      CLI_Helpers.loadTOC("QuestieDB-WOTLKC.toc")

      return LibQuestieDBTable
    end,
    ["Cata"] = function()
      ---@type LibQuestieDB
      ---@diagnostic disable-next-line: missing-fields
      LibQuestieDBTable = {}

      -- When creating the static database, we load the QuestieDB which writes to this global, so we reset it here
      QuestieDB = {}
      -- Same here, the old Questie code expects this.
      QuestieLoader = {
        ImportModule = function()
          return QuestieDB
        end,
      }

      GetBuildInfo = function()
        return "4.4.0", "12340", "Jun 12 2022", 40402
      end

      WOW_PROJECT_ID = WOW_PROJECT_CATACLYSM_CLASSIC

      CLI_Helpers.loadTOC("QuestieDB-Cata.toc")

      return LibQuestieDBTable
    end,
  }

  --- (Re-)Initializes the global variables for the addon
  ---@param version ExpansionStrings|string e.g. "Classic", "TBC", "Wotlk"
  ---@return LibQuestieDB
  function AddonInitializeVersion(version)
    local lowerVersion = version:lower()
    local capitalizedVersion = lowerVersion:gsub("^%l", string.upper)
    assert(initByVersion[capitalizedVersion], "Invalid version: " .. version)
    local returnVersion = initByVersion[capitalizedVersion]()
    -- ? Print all the IsEra, IsSoD, IsTbc, IsWotlk, IsCata and so on...
    for k, v in pairs(returnVersion) do
      if type(k) == "string" then
        if k:sub(1, 2) == "Is" and type(v) == "boolean" then
          print(k, ":", v)
        end
      end
    end
    return returnVersion
  end

  function DoesVersionExist(version)
    local lowerVersion = version:lower()
    local capitalizedVersion = lowerVersion:gsub("^%l", string.upper)
    return initByVersion[capitalizedVersion] ~= nil
  end
end
