-- The launcher must enter its checkout before running Lua, without finding Python on PATH.
local output = assert(io.open("batch-result.txt", "wb"))
output:write("checkout")
output:close()
print(#arg == 0 and "default: all" or table.concat(arg, "|"))
print("LUA=" .. tostring(os.getenv("LUA")))
os.exit(tonumber(os.getenv("QUESTIEDB_TEST_EXIT")) or 0)
