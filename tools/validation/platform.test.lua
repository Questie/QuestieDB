-- Direct Lua tooling must select native quoting and directory syntax without Unix tools
-- on Windows. Commands are captured, never executed against a real filesystem here.
---@param check fun(condition: boolean, message: string)
---@param equal fun(actual: any, expected: any, message: string)
---@return nil
return function(check, equal)
  local commands = {}
  local env = setmetatable({
    package = { config = "\\\n;\n?\n!\n-\n" },
    os = {
      getenv = function(name) if name == "QUESTIEDB_PYTHON" then return "C:\\Python Tools\\python.exe" end end,
      execute = function(command) commands[#commands + 1] = command; return 0 end,
    },
    io = {
      popen = function(command)
        commands[#commands + 1] = command
        return { read = function() return string.rep("a", 40) .. "\n" end, close = function() end }
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
  windows.execute(windows.pythonCommand({ "tools/cli/questiedb.test.py" }))
  equal(commands[#commands], '""C:\\Python Tools\\python.exe" "tools/cli/questiedb.test.py""',
    "cmd receives outer quotes for a quoted Python executable")

  local posixEnv = setmetatable({ package = { config = "/\n;\n?\n!\n-\n" } }, { __index = _G })
  load = assert(loadfile("generator/lib.lua"))
  setfenv(load, posixEnv)
  local posix = load()
  equal(posix.shellQuote("a'b"), "'a'\\''b'", "POSIX arguments retain embedded apostrophes")
  equal(posix.nullDevice, "/dev/null", "POSIX null device is unchanged")
end
