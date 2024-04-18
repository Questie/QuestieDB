bit = require("bit32")
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


---@type LibQuestieDB
LibQuestieDBTable = {}
-- WoW addon namespace
CLI_addonName = "QuestieDB"
CLI_addonTable = {}

-- "Client" data
CLI_Locale = "enUS"

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
      LibQuestieDBTable = {}

      GetBuildInfo = function()
        return "1.14.3", "44403", "Jun 27 2022", 11403
      end

      WOW_PROJECT_ID = WOW_PROJECT_CLASSIC

      CLI_Helpers.loadTOC("QuestieDB-Classic.toc")
    end,
    ["Tbc"] = function()
      LibQuestieDBTable = {}

      GetBuildInfo = function()
        return "2.5.1", "38644", "May 11 2021", 20501
      end

      WOW_PROJECT_ID = WOW_PROJECT_BURNING_CRUSADE_CLASSIC

      CLI_Helpers.loadTOC("QuestieDB-BCC.toc")
    end,
    ["Wotlk"] = function()
      LibQuestieDBTable = {}

      GetBuildInfo = function()
        return "3.4.0", "44644", "Jun 12 2022", 30400
      end

      WOW_PROJECT_ID = WOW_PROJECT_WRATH_CLASSIC

      CLI_Helpers.loadTOC("QuestieDB-WOTLKC.toc")
    end,
  }

  --- (Re-)Initializes the global variables for the addon
  ---@param version "Era"|"Tbc"|"Wotlk"
  function AddonInitializeVersion(version)
    local lowerVersion = version:lower()
    local capitalizedVersion = lowerVersion:gsub("^%l", string.upper)
    assert(initByVersion[capitalizedVersion], "Invalid version: " .. version)
    initByVersion[capitalizedVersion]()
  end

  function DoesVersionExist(version)
    local lowerVersion = version:lower()
    local capitalizedVersion = lowerVersion:gsub("^%l", string.upper)
    return initByVersion[capitalizedVersion] ~= nil
  end
end
