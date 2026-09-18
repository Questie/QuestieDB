-- Exercise the production process helper with an actual Python argv reader, including
-- a space-containing Windows path whose trailing backslash must survive native quoting.
local lib = dofile(assert(os.getenv("PROBE_LIB")))
local recorder = assert(arg[1], "Python argument recorder is required")
local value = assert(os.getenv("PROBE_ARGUMENT"))
local pipe = assert(lib.popen(lib.pythonCommand({ recorder, value })))
io.write(pipe:read("*a"))
pipe:close()
