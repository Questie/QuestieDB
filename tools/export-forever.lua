-- Export all four merged Forever databases as standalone Lua, one entity per line.
-- Run from the repository root with bundled Lua:
--   Linux/WSL: ./tools/lua-binary/linux-x64/lua tools/export-forever.lua [--include-authored]
--   PowerShell: .\tools\lua-binary\lua.exe tools/export-forever.lua [--include-authored]
-- An installed Lua 5.1-compatible interpreter also works.
--
-- Writes foreverQuestDB.lua, foreverNpcDB.lua, foreverItemDB.lua and foreverObjectDB.lua
-- under src/corrections/Forever/combined/. Rerunning replaces these generated files.
-- Authored Forever Static Corrections are excluded unless --include-authored is passed.
-- Rows are positional with inline nil holes. Each file returns its entity table.
-- No TOCs, runtime files or source data are changed.

local config = dofile("src/config.lua")
local lib = dofile("generator/lib.lua")
local inline = dofile("tools/export/inline.lua")

local outputDir = "src/corrections/Forever/combined"
local includeAuthored = false
for _, value in ipairs(arg) do
  if value == "--help" or value == "-h" then
    lib.printUsage(arg[0])
  elseif value == "--include-authored" then
    includeAuthored = true
  else
    error("Unknown option: " .. value, 0)
  end
end

local loaded = inline.loadForever(includeAuthored)
local outputs = {}
-- Verify every type before replacing any output, including nil holes and explicit zeroes.
for _, entityType in ipairs(config.entityTypes) do
  local entry = loaded[entityType.name]
  local path = outputDir .. "/forever" .. entityType.name .. "DB.lua"
  local source = inline.render(entry, includeAuthored)
  local decoded = assert(loadstring(source, "@" .. path))()
  assert(lib.deepEqual(entry.entities, decoded), "Export round-trip failed: " .. entityType.name)
  outputs[#outputs + 1] = { path = path, source = source, count = lib.count(entry.entities) }
end

lib.mkdirp(outputDir)
for _, output in ipairs(outputs) do
  local file = assert(io.open(output.path, "wb"))
  assert(file:write(output.source))
  assert(file:close())
  print(string.format("Wrote %s (%d rows, %d bytes)", output.path, output.count, #output.source))
end
print("Authored corrections " .. (includeAuthored and "included" or "excluded"))
