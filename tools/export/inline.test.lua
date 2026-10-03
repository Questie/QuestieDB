-- Run from the repository root with bundled Lua:
-- Linux/WSL: ./tools/lua-binary/linux-x64/lua tools/export/inline.test.lua
-- PowerShell: .\tools\lua-binary\lua.exe tools/export/inline.test.lua
local inline = dofile("tools/export/inline.lua")
local lib = dofile("generator/lib.lua")
local meta = dofile("src/meta/questMeta.lua")

local rows = {
  [42] = {
    [1] = "A \"quote\", a 'quote', \\ and\na new line: 雪",
    [2] = { nil, { 424005 } },
    [4] = 0,
    [8] = { "", "second" },
    [9] = { "trigger", { [1519] = { { 0.12345678901234566, -1 } } } },
    [10] = {},
    [36] = 123,
  },
  [7] = {},
}
local loaded = { meta = meta, entities = rows }
local text = inline.render(loaded)
local result = assert(loadstring(text))()
assert(lib.deepEqual(result, rows), "Export changed a raw value")
assert(text:find("quest[7]", 1, true) < text:find("quest[42]", 1, true), "IDs must be sorted")
local rowLines = 0
for line in text:gmatch("[^\n]+") do
  if line:match("^quest%[") then rowLines = rowLines + 1 end
end
assert(rowLines == 2, "Exactly one source line per entity")
assert(text == inline.render(loaded), "Output must be deterministic")
rows[42][1036] = { 1 }
assert(not pcall(inline.render, loaded), "Unresolved correction operations must fail")
rows[42][1036] = nil

-- Check the toggle against the actual manifest, without pinning changeable gameplay values.
local without, withoutRegistry = inline.loadForever()
local with, withRegistry = inline.loadForever(true)
-- Every file returns its own ID-keyed table, without a wrapper for the other types.
for name, entry in pairs(without) do
  local id = assert(next(entry.entities))
  local sample = { meta = entry.meta, entities = { [id] = entry.entities[id] } }
  local decoded = assert(loadstring(inline.render(sample)))()
  assert(lib.deepEqual(decoded, sample.entities), name .. " export must return its entity table")
end
local authored = {
  ["Forever/foreverQuestFixes.lua:Load"] = true,
  ["Forever/foreverNPCFixes.lua:Load"] = true,
  ["Forever/foreverItemFixes.lua:Load"] = true,
  ["Forever/foreverObjectFixes.lua:Load"] = true,
}
local retained = {}
for _, entry in ipairs(withoutRegistry.Select({ dynamic = false })) do
  assert(not authored[entry.name], "Default export retained " .. entry.name)
  retained[entry.name] = true
end
local authoredCount = 0
for _, entry in ipairs(withRegistry.Select({ dynamic = false })) do
  if authored[entry.name] then
    authoredCount = authoredCount + 1
    -- Adding only these final providers to the default export must reconstruct the opt-in result.
    withRegistry.MergeInto(without[entry.datatype].entities, entry.func(), entry.options, entry)
  else
    assert(retained[entry.name], "Toggle dropped an inherited/generated/trace provider: " .. entry.name)
    retained[entry.name] = nil
  end
end
assert(authoredCount == 4 and next(retained) == nil, "Toggle must exclude exactly the four authored sets")
for name, entry in pairs(with) do
  assert(lib.deepEqual(entry.entities, without[name].entities), "Toggle changed more than authored " .. name)
end
assert(inline.render(loaded):find("Authored corrections excluded", 1, true))
assert(inline.render(loaded, true):find(" -> authored corrections.", 1, true))
print("PASS inline export: shapes, ordering, field validation and authored-correction toggle")
