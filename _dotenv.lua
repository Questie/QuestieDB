---@class LibQuestieDB
local LibQuestieDB = select(2, ...)
local dat = C_BattleNet.GetAccountInfoByID(select(3, BNGetInfo()))
local battle_tags = {
  -- Please do not add us to battle.net friends... contact us on Discord instead.
  -- https://discord.gg/s33MAYKeZd
  ["Logon#1822"] = true,
}

---@class DotEnv

if dat then
  local developer_account = battle_tags[dat.battleTag] and dat.battleTag or false
  if developer_account then
    print("|cFFffff00" .. "Developer account detected: Logon#1822")
    do
      -- Variables to load before all files
      print("|cB900FFFF" .. "  _dotenv.lua is loading pre-files environment variables...")
      -- A warning here is that files loaded after this point could overwrite these variables.
      -- For example, do NOT put Database.debugEnabled here, as it will be overwritten by the database generator.

      if developer_account == "Logon#1822" then
        -- Set other developer-specific settings
      elseif developer_account == "SomeOtherGuy#1337" then
        -- Set other developer-specific settings
      end

      print("|cFF00ff00" .. "  _dotenv.lua has finished loading pre-files environment variables.")
    end

    -- Variables to load after all files
    C_Timer.After(0, function()
      print("|cB900FFFF" .. "  _dotenv.lua is loading post-files environment variables...")
      -- This is where you can initialize any global variables or settings
      -- For example, you might want to set debug mode or other configurations
      -- e.g. LibQuestieDB.Database.debugEnabled = true
      if developer_account == "Logon#1822" then
        -- Set debug mode or any other developer-specific settings
        LibQuestieDB.Database.debugEnabled = true
        LibQuestieDB.Database.debugPrintEnabled = true
        LibQuestieDB.Database.debugLoadStaticEnabled = true
        LibQuestieDB.Database.debugPrintNewIdsEnabled = true

        -- Override the locale to be german to be able to run the l10n tests.
        LibQuestieDB.l10n.currentLocale = "deDE"
      elseif developer_account == "SomeOtherGuy#1337" then
        -- Set other developer-specific settings
      end
      print("|cFF00ff00" .. "  _dotenv.lua has finished loading environment variables.")
    end)
  end
end
