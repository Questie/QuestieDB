-- Every flavor must translate the extra objective texts of its own quests from the files its TOC loads.
return function(check, equal)
  local emulator = dofile("emulator/metadata.lua")
  local savedLibStub = rawget(_G, "LibStub")
  _G.LibStub = nil
  local ok, client = pcall(dofile, "emulator/client.lua")
  _G.LibStub = savedLibStub
  assert(ok, client)

  local config = dofile("src/config.lua")
  local translations = dofile("generator/l10n-inputs.lua").loadExtraObjectiveTexts(".", config.l10nExtraObjectiveFiles)
  local installs = {
    { name = "Vanilla", expansion = "Classic" },
    { name = "Vanilla SoD", expansion = "Classic", season = "SoD", faction = "Horde" },
    { name = "TBC", expansion = "TBC" },
    { name = "Wrath", expansion = "Wotlk" },
    { name = "Cata", expansion = "Cata" },
    { name = "Mists", expansion = "MoP" },
    { name = "Forever", expansion = "Forever" },
  }

  for _, install in ipairs(installs) do
    install.locale = "deDE"
    client.reset()
    client.install(install)
    emulator.install("QuestieDB", emulator.parse("QuestieDB.toc"))
    local db = emulator.loadAddon("QuestieDB.toc", "QuestieDB")

    local untranslated = {}
    for id in pairs(db.Quest.GetAllIds(true)) do
      for _, objective in ipairs(db.Quest.extraObjectives(id) or {}) do
        local translated = translations[objective[3]] and translations[objective[3]].deDE
        if type(translated) == "string" and translated ~= "" and translated ~= objective[3] then
          untranslated[#untranslated + 1] = objective[3]
        end
      end
    end
    table.sort(untranslated)
    equal(table.concat(untranslated, "; "), "",
      install.name .. ": should load a file with a translation for every extra objective text")
  end
  client.reset()
end
