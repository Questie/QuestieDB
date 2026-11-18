-- Full-addon extra objective translation with representative Era and SoD quests.
return function(check, equal, modeScope)
  local lib = dofile("generator/lib.lua")
  local emulator = dofile("emulator/metadata.lua")
  local savedLibStub = rawget(_G, "LibStub")
  _G.LibStub = nil
  local ok, client = pcall(dofile, "emulator/client.lua")
  _G.LibStub = savedLibStub
  assert(ok, client)

  local questId, english, german = 1579, "Fish for Gaffer Jacks", "Klemm-Muffen angeln"
  local modes = {}
  if modeScope == "Source" then
    modes[1] = { name = "Source", toc = "QuestieDB.toc" }
  else
    local artifact = lib.fileExists("QuestieDB_Vanilla.toc") and lib.readAll("QuestieDB_Vanilla.toc"):gsub("\\", "/")
    local current = artifact and artifact:find("## X-l10n-Version:", 1, true) ~= nil
    for _, path in ipairs(dofile("src/config.lua").sourceFileList()) do
      if current and path:find("^src/corrections/enum/") and (not artifact:find(path, 1, true)) then
        current = false
      end
    end
    if current then
      modes[1] = { name = "Baked", toc = "QuestieDB_Vanilla.toc" }
    else
      io.write("  SKIP extra-objective-translations Baked: Vanilla artifact absent, stale or without localization\n")
    end
  end

  for _, mode in ipairs(modes) do
    client.reset()
    client.install({ expansion = "Classic", locale = "deDE" })
    emulator.install("QuestieDB", emulator.parse(mode.toc))
    local db = emulator.loadAddon(mode.toc, "QuestieDB")
    local label = mode.name .. ": "

    local objectives = db.Quest.extraObjectives(questId)
    equal(objectives[1][3], german, label .. "should translate the extra objective text")
    check(type(objectives[1][1]) == "table" and objectives[1][2] ~= nil,
      label .. "should keep spawns and icon of the translated extra objective")
    objectives[1][3] = "caller mutation"
    equal(db.Quest.extraObjectives(questId)[1][3], german, label .. "should return caller-owned extra objectives")

    equal(db.GetProvenance("Quest", questId, "extraObjectives"), "QuestieDB",
      label .. "should report the base translation provenance")

    db.l10n.SetLocale("enUS")
    local englishObjectives = db.Quest.extraObjectives(questId)
    equal(englishObjectives[1][3], english, label .. "should keep English on enUS")

    db.l10n.SetLocale("deDE")
    local keys = db.Meta.Quest.keys
    local added = { nil, englishObjectives[1][2], "Untranslated English" }
    db.Corrections.Set("EntityOwner", "Quest", "reordered",
      { [questId] = { [keys.extraObjectives] = { added, englishObjectives[1] } } })
    local reordered = db.Quest.extraObjectives(questId)
    equal(reordered[1][3], "Untranslated English", label .. "should keep English for texts without translation")
    equal(reordered[2][3], german, label .. "should translate by text after a correction reorders objectives")
    db.l10n.SetCorrection("Consumer", "deDE", "Quest", "partial",
      { [questId] = { [keys.extraObjectives] = { ["Untranslated English"] = "Eigener Text" } } })
    local partial = db.Quest.extraObjectives(questId)
    equal(partial[1][3], "Eigener Text", label .. "should use the Translation Correction for its texts")
    equal(partial[2][3], german, label .. "should keep base translations for texts the correction leaves out")
    db.l10n.SetCorrection("Consumer", "deDE", "Quest", "partial", nil)
    db.l10n.SetCorrection("UnusedOwner", "deDE", "Quest", "unused",
      { [questId] = { [keys.extraObjectives] = { ["Text not present in this quest"] = "Andere Übersetzung" } } })
    equal(db.GetProvenance("Quest", questId, "extraObjectives"), "QuestieDB",
      label .. "should not credit a Translation Correction whose texts match no objective")
    db.l10n.SetCorrection("UnusedOwner", "deDE", "Quest", "unused", nil)
    db.Corrections.Set("EntityOwner", "Quest", "replaced", { [questId] = { [keys.extraObjectives] = { added } } })
    equal(db.GetProvenance("Quest", questId, "extraObjectives"), "EntityOwner",
      label .. "should report the correction owner when no objective text is translated")
    db.Corrections.Set("EntityOwner", "Quest", "replaced", nil)
    db.Corrections.Set("EntityOwner", "Quest", "deleted", { [questId] = { [keys.extraObjectives] = {} } })
    equal(db.Quest.extraObjectives(questId), nil, label .. "should keep an explicit deletion")
    db.Corrections.Set("EntityOwner", "Quest", "deleted", nil)
    db.Corrections.Set("EntityOwner", "Quest", "reordered", nil)

    db.l10n.SetCorrection("Consumer", "deDE", "Quest", "texts",
      { [questId] = { [keys.extraObjectives] = { [english] = "Eigene Übersetzung" } } })
    equal(db.Quest.extraObjectives(questId)[1][3], "Eigene Übersetzung",
      label .. "should let a Translation Correction override the extra objective text")
    db.l10n.SetCorrection("Consumer", "deDE", "Quest", "texts", nil)
    equal(db.Quest.extraObjectives(questId)[1][3], german, label .. "should restore the base translation on withdrawal")
  end

  -- Dynamic Corrections add quests the generated artifact never saw, such as SoD's.
  for _, mode in ipairs(modes) do
    client.reset()
    client.install({ expansion = "Classic", season = "SoD", faction = "Horde", locale = "deDE" })
    emulator.install("QuestieDB", emulator.parse(mode.toc))
    local db = emulator.loadAddon(mode.toc, "QuestieDB")
    equal(db.Quest.extraObjectives(79242)[1][3], "Benutze das Ruderboot, um zur Ostküste zu gelangen.",
      mode.name .. ": should translate extra objectives from Dynamic Corrections")
  end
  client.reset()
end
