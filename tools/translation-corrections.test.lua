-- Exercise the real read, localization, and Correction modules with small backend fixtures.
-- Encoding is an identity adapter here: block byte fidelity belongs to l10n-blocks.
---@param check fun(condition: boolean, message: string)
---@param equal fun(actual: any, expected: any, message: string)
---@return nil
return function(check, equal)
  local lib = dofile("generator/lib.lua")
  local config = dofile("src/config.lua")
  local savedEncoding, savedLocale = C_EncodingUtil, GetLocale
  local savedGlobals = { LibQuestieDB = LibQuestieDB, QuestDB = QuestDB, NpcDB = NpcDB,
    ItemDB = ItemDB, ObjectDB = ObjectDB }
  C_EncodingUtil = {
    DecodeBase64 = function(value) return value end,
    DecompressString = function(value) return value end,
    DeserializeCBOR = function(value) return value end,
  }
  GetLocale = function() return "enUS" end

  local ok, err = pcall(function()
    for _, mode in ipairs({ "source", "baked" }) do
      local db = { config = config, Meta = {}, mode = mode, read = {}, flavor = config.flavorByName.Wrath }
      for _, file in ipairs(config.runtimeFiles.head) do
        if file ~= "src/config.lua" then assert(loadfile(file))("QuestieTDB", db) end
      end
      local shared = assert(loadfile("src/read/shared.lua"))("QuestieTDB", db)
      assert(loadfile("src/corrections/registry.lua"))("QuestieTDB", db)
      local keys = db.Meta.Quest.keys
      local rows = {
        [1] = { [keys.name] = "Base English", [keys.objectivesText] = { "Base objective" }, [keys.requiredRaces] = 77 },
        [2] = { [keys.name] = "Untranslated English" },
      }
      local backendReads = 0
      local backend = {
        getAllIds = function() return { 1, 2 }, { [1] = true, [2] = true } end,
        readField = function(id, key) backendReads = backendReads + 1; return rows[id] and rows[id][key] end,
      }
      if mode == "baked" then
        backend.hasScalarRows = true
        backend.scalarRow = function(id)
          backendReads = backendReads + 1
          if not rows[id] then return nil end
          local row = {}
          for key, value in pairs(rows[id]) do if type(value) ~= "table" then row[key] = value end end
          return row
        end
        backend.tableProducer = function(id, key)
          local value = rows[id] and rows[id][key]
          if value then return function() return { unpack(value) } end end
        end
      end
      local factory = { CreateBackend = function(meta)
        if meta.entity == "Quest" then return backend end
        return { getAllIds = function() return {}, {} end, readField = function() end }
      end }
      db.read[mode] = factory
      if mode == "baked" then
        factory.getStored = function(key)
          if key == config.l10nHeaderKey then return tostring(config.l10nVersion) end
          if key == config.l10nBlockKey("Quest", "deDE") then
            return { { "Basisübersetzung" }, { { "Basisziel" } } }
          end
          if key == config.l10nBlockKey("Quest", "frFR") then return { {}, {} } end
          error("unexpected localization key " .. tostring(key))
        end
      end
      assert(loadfile("src/l10n/overlay.lua"))("QuestieTDB", db)
      assert(loadfile("src/api.lua"))("QuestieTDB", db)
      local l10n, quest = db.l10n, db.Quest
      local label = mode .. ": "
      equal(backendReads, 0, label .. "localization does not eagerly read entity fields")
      equal(l10n.IsAvailable(), mode == "baked", label .. "availability describes base blocks")
      db.Corrections.Set("EntityOwner", "Quest", "english", {
        [1] = { [keys.name] = "Corrected English", [keys.objectivesText] = { "Corrected objective" }, [keys.requiredRaces] = 178 },
      })
      equal(quest.name(1), "Corrected English", label .. "enUS bypasses translation")
      l10n.SetLocale("deDE")
      if mode == "baked" then
        equal(quest.name(1), "Basisübersetzung", label .. "base translation wins over English correction")
        equal(quest.objectivesText(1), { "Basisziel" }, label .. "base objective translation wins")
        equal(db.GetProvenance("Quest", 1, "name"), "QuestieTDB", label .. "base translation provenance")
      else
        equal(quest.name(1), "Corrected English", label .. "Source has no ordinary translations")
      end
      equal(quest.name(2), "Untranslated English", label .. "missing translation falls back to entity")
      equal(quest.requiredRaces(1), 178, label .. "non-localizable fields keep entity corrections")

      local authored = { [1] = { [keys.name] = "Überschrieben", [keys.objectivesText] = { "Neues Ziel", "" } } }
      l10n.SetCorrection("Provider", "deDE", "Quest", "quest", authored)
      authored[1][keys.name], authored[1][keys.objectivesText][1] = "mutated", "mutated"
      equal(quest.name(1), "Überschrieben", label .. "Set snapshots scalar inputs")
      equal(quest.GetByIndex(1, keys.name), "Überschrieben", label .. "positional getter translates")
      equal(quest.GetAll(1, { "name", "objectivesText" }),
        { "Überschrieben", { "Neues Ziel", "" }, n = 2 }, label .. "packed reads use both translated field shapes")
      local objectives = quest.objectivesText(1)
      objectives[1] = "caller mutation"
      equal(quest.objectivesText(1), { "Neues Ziel", "" }, label .. "translated lists are caller-owned")
      equal(db.GetProvenance("quest", 1, "name"), "Provider", label .. "winning translation provenance")
      equal(db.Corrections.GetProvenance("Quest", 1, "name"), "EntityOwner", label .. "entity provenance remains independently available")
      equal(quest.IdsByName("Überschrieben"), { 1 }, label .. "translation is indexed")

      l10n.SetCorrection("Consumer", "deDE", "Quest", "quest", { [1] = { [keys.name] = "Verbraucher" } })
      l10n.SetCorrection("Provider", "deDE", "Quest", "quest", nil)
      l10n.SetCorrection("Provider", "deDE", "Quest", "quest", { [1] = { [keys.name] = "Updated provider" } })
      equal(quest.name(1), "Verbraucher", label .. "reactivation does not hoist an earlier owner")
      equal(quest.IdsByName("Überschrieben"), nil, label .. "replacement invalidates old name index")
      l10n.SetCorrection("Consumer", "deDE", "Quest", "quest", nil)
      equal(quest.name(1), "Updated provider", label .. "withdrawal reveals earlier translation")
      l10n.SetLocale("enUS")
      equal(quest.name(1), "Corrected English", label .. "leaving locale removes translated scalar cache")
      equal(quest.objectivesText(1), { "Corrected objective" }, label .. "leaving locale removes translated table cache")
      equal(l10n.GetProvenance("Quest", 1, "name"), nil, label .. "enUS has no translation provenance")
      equal(db.GetProvenance("Quest", 1, "name"), "EntityOwner", label .. "English owner restored")
      l10n.SetLocale("deDE")
      equal(quest.name(1), "Updated provider", label .. "returning locale restores translation")

      l10n.SetCorrection("Consumer", "deDE", "Quest", "empty", {})
      equal(quest.name(1), "Updated provider", label .. "empty slot contributes no translations")
      local before = quest.IdsByName("Updated provider")
      l10n.SetCorrection("Provider", "frFR", "Quest", "quest", { [1] = { [keys.name] = "Français" } })
      check(quest.IdsByName("Updated provider") == before, label .. "inactive locale writes preserve active caches")
      l10n.SetLocale("frFR")
      equal(quest.name(1), "Français", label .. "locale selects its own registered translation")
      l10n.SetLocale("deDE")

      -- Custom locales use the same slots without joining the generated locale inventory.
      before = quest.IdsByName("Updated provider")
      l10n.SetCorrection("ExternalLocale", "ukUA", "Quest", "quest", {
        [1] = { [keys.name] = "Перекладена назва" },
      })
      check(quest.IdsByName("Updated provider") == before, label .. "inactive custom locale preserves caches")
      equal(l10n.localeIndex.ukUA, nil, label .. "custom locale adds no Baked index")
      equal(#l10n.locales, 9, label .. "custom locale leaves nine generated locales unchanged")
      l10n.SetLocale("ukUA")
      equal(l10n.currentIndex, nil, label .. "custom locale has no stored block index")
      equal(l10n.IsAvailable(), mode == "baked", label .. "custom locale preserves base block availability")
      equal(quest.name(1), "Перекладена назва", label .. "custom translation wins over corrected English")
      equal(quest.objectivesText(1), { "Corrected objective" }, label .. "missing custom field falls back to correction")
      equal(quest.name(2), "Untranslated English", label .. "missing custom entity translation falls back to base")
      equal(db.GetProvenance("Quest", 1, "name"), "ExternalLocale", label .. "custom translation provenance")
      equal(quest.IdsByName("Перекладена назва"), { 1 }, label .. "custom translation is indexed")
      l10n.SetLocale("enUS")
      equal(quest.name(1), "Corrected English", label .. "enUS bypasses custom translations")
      l10n.SetLocale("ukUA")
      equal(quest.name(1), "Перекладена назва", label .. "returning to custom locale restores translation")
      l10n.SetCorrection("ExternalLocale", "ukUA", "Quest", "quest", nil)
      equal(quest.name(1), "Corrected English", label .. "custom withdrawal restores corrected value")
      equal(l10n.GetProvenance("Quest", 1, "name"), nil, label .. "custom withdrawal removes translation provenance")
      equal(db.GetProvenance("Quest", 1, "name"), "EntityOwner", label .. "custom withdrawal restores entity provenance")
      equal(quest.IdsByName("Перекладена назва"), nil, label .. "custom withdrawal clears old name index")
      l10n.SetLocale("deDE")
      equal(quest.name(1), "Updated provider", label .. "stored locale translations survive custom locale switches")
      before = quest.IdsByName("Updated provider")
      local invalid = {
        { locale = "enUS", rows = {} }, { locale = "", rows = {} },
        { rows = {} }, { locale = 123, rows = {} }, { locale = {}, rows = {} },
        { locale = "deDE", rows = { [1] = { [keys.requiredRaces] = 77 } } },
        { locale = "deDE", rows = { [1] = { [keys.name] = {} } } },
        { locale = "deDE", rows = { [1] = { [keys.objectivesText] = { [2] = "hole" } } } },
        { locale = "deDE", rows = { [1.5] = { [keys.name] = "bad id" } } },
      }
      for index, case in ipairs(invalid) do
        check(not pcall(l10n.SetCorrection, "Provider", case.locale, "Quest", "quest", case.rows),
          label .. "reject invalid translation input " .. index)
      end
      check(quest.IdsByName("Updated provider") == before, label .. "invalid writes leave state and caches unchanged")

      l10n.SetCorrection("Provider", "deDE", "Quest", "added", { [3] = { [keys.name] = "Neue Quest" } })
      equal(quest.name(3), nil, label .. "translation cannot invent entity")
      equal(l10n.GetProvenance("Quest", 3, "name"), nil, label .. "absent entity has no translation provenance")
      db.Corrections.Set("EntityOwner", "Quest", "added", { [3] = { [keys.name] = "Added English" } })
      equal(quest.name(3), "Neue Quest", label .. "correction-added entities can translate")
      db.Corrections.Set("EntityOwner", "Quest", "added", nil)
      equal(quest.name(3), nil, label .. "withdrawing entity also removes translated read")
      equal(quest.Exists(3), false, label .. "translation does not retain existence")

      l10n.SetLocale("enUS")
      db.Corrections.Set("EntityOwner", "Quest", "deleted", {
        [1] = { [keys.name] = {}, [keys.objectivesText] = {} },
      })
      equal(quest.name(1), nil, label .. "missing translation does not resurrect explicitly deleted English field")
      l10n.SetCorrection("Provider", "frFR", "Quest", "quest", nil)
      l10n.SetLocale("frFR")
      equal(quest.name(1), nil, label .. "missing French name preserves explicit entity deletion")
      equal(quest.objectivesText(1), nil, label .. "missing French objectives preserve explicit entity deletion")
      l10n.SetLocale("deDE")
      equal(quest.name(1), "Updated provider", label .. "available translation still outranks English deletion")
      quest.SetL10nProvider(nil)
      equal(quest.name(1), nil, label .. "detaching optional l10n restores ordinary corrected read")
      equal(quest.name(2), "Untranslated English", label .. "detaching l10n preserves base read")
      equal(db.GetProvenance("Quest", 1, "name"), "EntityOwner", label .. "detaching l10n restores entity provenance")
    end
  end)
  C_EncodingUtil, GetLocale = savedEncoding, savedLocale
  for _, name in ipairs({ "LibQuestieDB", "QuestDB", "NpcDB", "ItemDB", "ObjectDB" }) do _G[name] = savedGlobals[name] end
  assert(ok, err)
end
