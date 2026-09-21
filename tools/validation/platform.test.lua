-- Direct Lua tooling must select native quoting and directory syntax without Unix tools
-- on Windows. Commands are captured, never executed against a real filesystem here.
---@param check fun(condition: boolean, message: string)
---@param equal fun(actual: any, expected: any, message: string)
---@return nil
return function(check, equal)
  local commands = {}
  local outputs = {
    -- `cd` at a drive root already ends in a backslash; `dir` may differ from it in case.
    ["^cd 2>NUL$"] = "C:\\\r\n",
    ["^dir /s /b /a%-d"] = "c:\\src\\types\\Quest.t.lua\r\nc:\\src\\types\\notes.md\r\nc:\\src\\types\\General.t.lua\r\n",
    ["^dir /b /a%-d"] = "General.t.lua\r\nQuest.t.lua\r\n",
  }
  local function fakePipe(command)
    local output = string.rep("a", 40) .. "\n"
    for pattern, text in pairs(outputs) do
      if command:match(pattern) then output = text end
    end
    return {
      read = function() return output end,
      lines = function() return output:gmatch("([^\n]*)\n") end,
      close = function() end,
    }
  end
  local env = setmetatable({
    package = { config = "\\\n;\n?\n!\n-\n" },
    os = {
      getenv = function(name)
        if name == "TEMP" then return "C:\\Users\\dev\\AppData\\Local\\Temp" end
      end,
      execute = function(command) commands[#commands + 1] = command; return 0 end,
      time = function() return 1700000000 end,
      clock = function() return 0.5 end,
    },
    io = {
      popen = function(command)
        commands[#commands + 1] = command
        return fakePipe(command)
      end,
    },
  }, { __index = _G })
  local load = assert(loadfile("generator/lib.lua"))
  setfenv(load, env)
  local windows = load()
  check(windows.isWindows, "Windows detection uses Lua's platform separator")
  equal(windows.nullDevice, "NUL", "Windows redirects to its native null device")
  equal(windows.shellQuote("C:\\Data Files\\Questie"), '"C:\\Data Files\\Questie"', "Windows paths keep spaces quoted")
  equal(windows.shellQuote("C:\\Data Files\\"), '"C:\\Data Files' .. string.rep("\\", 2) .. '"',
    "native argv preserves a trailing backslash before the closing quote")
  check(not pcall(windows.shellQuote, "%TEMP%"), "cmd variable expansion cannot reinterpret a caller's path")
  windows.mkdirp("C:/Data Files/Questie")
  equal(commands[#commands], 'if not exist "C:\\Data Files\\Questie" mkdir "C:\\Data Files\\Questie"',
    "Windows directory creation does not attempt mkdir -p")
  equal(windows.gitCommit("C:/Data Files/Questie"), string.rep("a", 40), "Windows Git provenance is retained")
  equal(commands[#commands], 'git -C "C:/Data Files/Questie" rev-parse HEAD 2>NUL', "Windows Git uses native quoting and redirection")
  windows.execute(windows.shellQuote("C:\\Lua Tools\\lua.exe") .. ' "test.lua"')
  equal(commands[#commands], '""C:\\Lua Tools\\lua.exe" "test.lua""',
    "cmd receives outer quotes for a quoted executable")

  -- The test filesystem helper must resolve to the same Windows lib, not the real one.
  env.dofile = function(path)
    if path == "generator/lib.lua" then return windows end
    return dofile(path)
  end
  load = assert(loadfile("tools/validation/test-files.lua"))
  setfenv(load, env)
  local testFiles = load()
  equal(table.concat(testFiles.list("src/types", true, { ".t.lua" }), " "),
    "src/types/General.t.lua src/types/Quest.t.lua",
    "recursive Windows listing strips the working directory case-insensitively, filters suffixes, and sorts")
  equal(commands[#commands], 'dir /s /b /a-d "src\\types" 2>NUL', "recursive Windows listing uses dir /s")
  equal(table.concat(testFiles.list("src/types", false, {}), " "),
    "src/types/General.t.lua src/types/Quest.t.lua",
    "flat Windows listing keeps the requested prefix")
  equal(testFiles.temporaryDirectory(), "C:/Users/dev/AppData/Local/Temp/questiedb-test-1700000000-05",
    "Windows temporary directories live under TEMP, not the drive root")
  equal(commands[#commands], 'mkdir "C:\\Users\\dev\\AppData\\Local\\Temp\\questiedb-test-1700000000-05"',
    "Windows temporary directory creation fails loudly on a collision")
  testFiles.removeTree("C:/Data Files/stage")
  equal(commands[#commands],
    'if exist "C:\\Data Files\\stage\\" (rmdir /s /q "C:\\Data Files\\stage") else (if exist "C:\\Data Files\\stage" del /f /q "C:\\Data Files\\stage") & if exist "C:\\Data Files\\stage" exit 1',
    "Windows tree removal uses rmdir for directories, del for files, and proves the path is gone")

  local posixEnv = setmetatable({ package = { config = "/\n;\n?\n!\n-\n" } }, { __index = _G })
  load = assert(loadfile("generator/lib.lua"))
  setfenv(load, posixEnv)
  local posix = load()
  equal(posix.shellQuote("a'b"), "'a'\\''b'", "POSIX arguments retain embedded apostrophes")
  equal(posix.nullDevice, "/dev/null", "POSIX null device is unchanged")
end
