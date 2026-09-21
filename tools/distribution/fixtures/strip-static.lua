-- Packaging fixture, not the production stripper. It proves that packaging invokes Lua
-- on staged copies and propagates failures, without loading the full correction database.
if os.getenv("QUESTIEDB_TEST_FAIL_STRIP") == "1" then os.exit(7) end

local path = assert(arg[1]) .. "/src/corrections/Era/fixes.lua"
local input = assert(io.open(path, "rb"))
assert(input:read("*a") == "return 'unstripped'\n")
input:close()
local output = assert(io.open(path, "wb"))
output:write("return 'dynamic only'\n")
output:close()

-- Make alias ordering observable: only staged bytes may supply the compatibility TOC.
local toc = io.open(arg[1] .. "/QuestieDB_Forever.toc", "rb")
if toc then
  toc:close()
  local staged = assert(io.open(arg[1] .. "/QuestieDB_Forever.toc", "ab"))
  staged:write("# staged transformation\n")
  staged:close()
end
