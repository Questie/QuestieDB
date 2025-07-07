-- main.lua
-- Prepend your script's directory to the package.path
do
  local lfs = require("lfs")

  -- Get the path separator
  local sep = package.config:sub(1, 1)

  -- If we are executing from any other location than the script dir
  local relative_script_path = debug.getinfo(1, "S").source:sub(2):match("(.*)[/\\]")
  if relative_script_path then
    print("SETUP: Relative script path:", debug.getinfo(1, "S").source:sub(2):match("(.*)[/\\]"))

    -- First we change into the script directory
    lfs.chdir(debug.getinfo(1, "S").source:sub(2):match("(.*)[/\\]"))
  end

  -- Then we get the full path to the script directory
  local full_script_dir = lfs.currentdir()
  print("SETUP: Changed directory to absolute script directory : ", full_script_dir)

  -- Then we get the full path to the project directory
  local full_project_dir = full_script_dir:match("(.*)[/\\]") -- Remove last slash

  -- Then we set the package.path to include the script and project directories
  package.path = full_project_dir .. sep .. "?.lua;" .. package.path
  package.path = full_script_dir .. sep .. "?.lua;" .. package.path

  -- Then we change back to the project directory
  lfs.chdir(full_project_dir)
  print("SETUP: Changed directory to absolute project directory: ", lfs.currentdir())
  if lfs.attributes("Library.lua", "mode") == "file" then
    print("SETUP: Library.lua found in project directory.")
  else
    print("SETUP: ERROR - Library.lua not found in project directory.")
    error("SETUP: ERROR - Library.lua not found in project directory.")
    os.exit(1)
  end
end

local helpers = require(".db_helpers")
require("cli.CLI_Helpers")

require(".createStatic")

-- ! Debug mode settings
-- Output extra debug information in the HTML files
DB_GEN_DEBUG_MODE = false
-- Output timer creation and execution information
DB_C_TIMER_DEBUG = true

---@class ThreadLib
local ThreadLib = {}

--Coroutine functions
local coStatus, coResume, coCreate = coroutine.status, coroutine.resume, coroutine.create
local lType = type
-- local cTimer = C_Timer
local newTicker = C_Timer.NewTicker


---Thread a function, callback function is called when the thread is done.
---@param threadFunction function @The function to thread
---@param delay integer @Anything below 0.05 is each frame
---@param errorMessage string? @What is the "Prepend" of the error message, could be something like "Error in thread: ", or "[main.lua:123]"
---@param callbackFunction function? @Function to call when the thread is done
---@param errorCallback fun(errorMessage: string, error: string, traceback: string)? @Function to call when an error occurs
function ThreadLib.Thread(threadFunction, delay, errorMessage, callbackFunction, errorCallback)
  if lType(threadFunction) ~= "function" then
    error("ThreadLib:Thread: threadFunction is not a function")
  end
  if lType(delay) ~= "number" then
    error("ThreadLib:Thread: delay is not a number")
  end
  if errorMessage and lType(errorMessage) ~= "string" then
    error("ThreadLib:Thread: errorMessage is not a string")
  end
  if errorCallback and lType(errorCallback) ~= "function" then
    error("ThreadLib:Thread: errorCallback is not a function")
  end
  if callbackFunction and lType(callbackFunction) ~= "function" then
    error("ThreadLib:Thread: callbackFunction is not a function")
  end

  local thread = coCreate(threadFunction)

  print(debug.traceback(errorMessage or "", 2))

  local timer
  timer = newTicker(delay or 0, function()
    if (coStatus(thread) == "suspended") then --It's faster not to lookup the value but instead have it here
      local success, err = coResume(thread)
      -- Something in the coroutine went wrong, print the error and stop the timer
      if not success and timer then
        timer:Cancel();
        if errorCallback then
          errorCallback(errorMessage or "Error In Thread:", err, debug.traceback(errorMessage or err, 4))
        else
          print((errorMessage or "Error In Thread:") .. ": " .. tostring(err) .. "\n" .. debug.traceback(errorMessage or err, 4))
          error((errorMessage or "Error In Thread:") .. ": " .. tostring(err) .. "\n" .. debug.traceback(errorMessage or err, 4))
        end
      end
    elseif (coStatus(thread) == "dead") then --It's faster not to lookup the value but instead have it here
      if timer then
        timer:Cancel();
      end
      if (callbackFunction) then
        callbackFunction()
      end

      --? Is this needed?
      timer = nil
      ---@diagnostic disable-next-line: cast-local-type
      thread = nil
    end
  end)

  -- ? This code is a duplicate of the above, but it is needed to ensure the coroutine starts running
  local success, err = coResume(thread)
  -- Something in the coroutine went wrong, print the error and stop the timer
  if not success and timer then
    timer:Cancel();
    if errorCallback then
      errorCallback(errorMessage or "Error In Thread:", err, debug.traceback(errorMessage or err, 2))
    else
      error((errorMessage or "Error In Thread:") .. ": " .. tostring(err) .. "\n" .. debug.traceback(errorMessage or err, 2))
    end
  end

  return timer, thread
end

---Thread a function, callback function is called when the thread is done.
---@param threadFunction function @The function to thread
---@param delay integer @Anything below 0.05 is each frame
---@param callbackFunction function @Function to call when the thread is done
function ThreadLib.ThreadCallback(threadFunction, delay, callbackFunction)
  return ThreadLib.Thread(threadFunction, delay, nil, callbackFunction)
end

---Thread a function, using a specific error message.
---@param threadFunction function @The function to thread
---@param delay integer @Anything below 0.05 is each frame
---@param errorMessage string @What is the "Prepend" of the error message
function ThreadLib.ThreadError(threadFunction, delay, errorMessage)
  return ThreadLib.Thread(threadFunction, delay, errorMessage)
end

---Thread a function
---@param threadFunction function @The function to thread
---@param delay integer @Anything below 0.05 is each frame
function ThreadLib.ThreadSimple(threadFunction, delay)
  return ThreadLib.Thread(threadFunction, delay)
end

-- print(debug.traceback("Test", 1))

local function test()
  -- print(debug.traceback("coroutine lvl1", 1))

  -- print(debug.traceback("coroutine lvl2", 2))

  sasdf()

  print("This line will not be executed due to the error above.")
  return "asdf"
end

-- ThreadLib.Thread(test, 0.05, "Error In Test Thread:", function()
--                    print("Thread finished.")
--                  end, function(errorMessage, error, traceback)
--                    print("Err Msg:", errorMessage)
--                    print("Error:", error)
--                    print("Traceback:", traceback)
--                  end)
-- ThreadLib.Thread(test, 0.05, "Error In Test Thread:", function()
--   print("Thread finished.")
-- end)

-- print("done")
-- local g = coroutine.create(test)

-- local success, result = coroutine.resume(g)
-- if not success then
--   print("Error in coroutine:", result)
-- end
-- print("Coroutine result:", result)

-- print("asdf")
-- print(debug.traceback(g, "coroutine", 2))
-- print(pcall(coroutine.resume, g))

-- local ret = coroutine.wrap(function()
--   print(debug.traceback("coroutine", 1))

--   print(debug.traceback("coroutine", 2))
-- end)

-- ret()




-- os.exit(0)



require("cli.Addon_Meta")

-- Find the addon name
local addon_name = helpers.find_addon_name()
print("Addon Name: " .. addon_name)


------ * Get custom string translations from Questie * -------
-- ? This code makes it so that all ImportModule("l10n") gets redirected to the same table.
local translations = {}
QuestieLoader = {
  ImportModule = function()
    return { translations = translations, }
  end,
}

-- ? Load all the translation tables.
CLI_Helpers.loadXML(helpers.get_project_dir_path() .. "/.database_generator/Questie-data/Localization/Translations/Translations.xml")


local single_translation = {}
for key, value in pairs(translations) do
  table.insert(single_translation, key)
end

---comment
---@param enUStext string
---@return table<string, string|boolean>?
---@return string? Error
local function getTranslation(enUStext)
  if translations[enUStext] then
    return translations[enUStext], nil
  else
    return nil, "Translation not found for: " .. enUStext
  end
end


---@type profile
local profile
if DB_GEN_DEBUG_MODE then
  profile = require("libs.profile")
  profile.start()
  print("Profiler started.")
end

-- Generate Trie-translations
require("generateTranslations")
Compile_translations_to_html(single_translation, addon_name, getTranslation)

------ * End of custom string translations * -------


-- * Dump the database
-- for expansion, local_prefix in pairs(Expansions) do
for _, exp_data in ipairs(helpers.Expansions) do
  local questie_prefix_expansion, local_prefix_expansion = unpack(exp_data)
  local capitalized_expansion = local_prefix_expansion:sub(1, 1):upper() .. local_prefix_expansion:sub(2)
  DumpDatabase(capitalized_expansion, questie_prefix_expansion, DB_GEN_DEBUG_MODE)
end


if profile then
  profile.stop()
  print("Profiler stopped.")
  -- Print the profiling results
  print(profile.report(100))
end
