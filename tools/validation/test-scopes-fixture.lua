-- Tiny Baked witnesses for the scope-selection test, not a flavor Generation.
-- Require an explicit disposable directory and refuse existing artifacts.
local output = assert(arg[1], "provide a disposable fixture directory")
local lib = dofile("generator/lib.lua")
local fixture = dofile("tools/validation/storage-fixture.lua")
local db = fixture.namespace()
local quest, npc, object, item = db.Meta.Quest.keys, db.Meta.Npc.keys, db.Meta.Object.keys, db.Meta.Item.keys
local path = output .. "/QuestieDB_Forever.toc"
local alias = output .. "/QuestieDB_Camelot.toc"
assert(not lib.fileExists(path) and not lib.fileExists(alias), "refusing to overwrite an artifact")

-- These literals satisfy forever-delta-base.test.lua's public Baked witnesses.
-- No raw entity payloads, correction providers, or production Generation are needed.
fixture.write(path, {
  Quest = {
    [86585] = {
      [quest.name] = "Banner of the Fallen",
      [quest.questLevel] = 17,
      [quest.requiredLevel] = 10,
      [quest.startedBy] = {{269153}},
      [quest.finishedBy] = {{1092}},
    },
  },
  Npc = {
    [269153] = {
      [npc.name] = "Mountaineer Ylva",
      [npc.questStarts] = {86585},
      [npc.spawns] = {[38] = {{31.8, 86.2}}},
    },
  },
  Object = {
    [175725] = {
      [object.name] = "The Old Gods and the Ordering of Azeroth",
      [object.spawns] = {[11] = {{9.9, 20}}},
    },
  },
  Item = {
    [286647] = {
      [item.name] = "Depleted Crystal Heart",
      [item.itemLevel] = 1,
      [item.requiredLevel] = 1,
      [item.class] = 12,
      [item.subClass] = 0,
      [item.npcDrops] = {252711},
    },
  },
}, {})

local content, replaced = lib.readAll(path):gsub("## X%-Flavor: Vanilla", "## X-Flavor: Forever", 1)
assert(replaced == 1, "fixture must declare exactly one flavor")
local files = {}
for _, file in ipairs(db.config.runtimeFiles.head) do files[#files + 1] = file end
for _, file in ipairs({
  db.config.runtimeFiles.bakedReader,
  "src/read/shared.lua",
  "src/corrections/registry.lua",
  "src/l10n/overlay.lua",
  "src/api.lua",
}) do files[#files + 1] = file end
content = table.concat(files, "\n") .. "\n" .. content
for _, destination in ipairs({path, alias}) do
  local out = assert(io.open(destination, "wb"))
  assert(out:write(content))
  assert(out:close())
end
