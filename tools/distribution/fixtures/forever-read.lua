-- Read the real staged runtime through either Forever TOC filename.
local stage, filename = assert(arg[1]), assert(arg[2])
local client = dofile("emulator/client.lua")
local metadata = dofile("emulator/metadata.lua")
client.install({})
metadata.load(stage .. "/" .. filename, "QuestieDB")
local db, files = metadata.loadAddon(stage .. "/" .. filename, "QuestieDB", stage, "camelot")
assert(db.flavor.name == "Forever")
assert(QuestDB.name(2) == "Sharptalon's Claw")
local ownedProviders = 0
for _, path in ipairs(files) do
  assert(not path:find("%["), "Baked paths must already be resolved")
  assert(not path:find("src/corrections/Era/", 1, true), "Era provider leaked into Forever")
  if path:find("src/corrections/Forever/", 1, true) then ownedProviders = ownedProviders + 1 end
end
assert(ownedProviders == 4, "Forever must load its four Dynamic providers")
