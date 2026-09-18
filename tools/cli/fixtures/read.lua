-- Records a Lua gate starting in the disposable command-flow fixture.
local log = assert(io.open("events.log", "a"))
log:write("read:" .. arg[0] .. "\n")
log:close()
if os.getenv("FAIL_READ") == "1" then os.exit(9) end
print("[PASS] fixture")
