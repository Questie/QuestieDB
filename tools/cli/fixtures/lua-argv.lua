-- Exercise the production process helper with an actual Python argv reader, including
-- a space-containing Windows path whose trailing backslash must survive native quoting.
local lib = dofile(assert(os.getenv("PROBE_LIB")))
local recorder = assert(arg[1], "Python argument recorder is required")
local value = assert(os.getenv("PROBE_ARGUMENT"))
local python = assert(os.getenv("QUESTIEDB_PYTHON"))
local command = lib.shellQuote(python) .. " " .. lib.shellQuote(recorder) .. " " .. lib.shellQuote(value)
local pipe = assert(lib.popen(command))
io.write(pipe:read("*a"))
pipe:close()
