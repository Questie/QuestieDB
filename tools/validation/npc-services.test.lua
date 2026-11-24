-- NPC services (ADR 0017): the Derived Pass that keeps `services` and the legacy `npcFlags`
-- mask consistent, and the trainer fields, through the real Source pipeline.
return function(check, equal)
  local config = dofile("src/config.lua")
  local client = dofile("emulator/client.lua")
  local emulator = dofile("emulator/metadata.lua")
  local constants = dofile("src/corrections/enum/constants.lua")
  local services = constants.serviceKeys
  local meta = dofile("src/meta/npcMeta.lua")
  local keys = meta.keys
  local pass = assert(loadfile("src/derived/npcServices.lua"))("QuestieDB", { Enum = constants })

  ---Run the pass over one row for one flavor and return the row.
  local function apply(expansion, row)
    local npcs = { [1] = row }
    pass.Apply({
      flavor = { expansion = expansion },
      entities = function(name) return name == "Npc" and npcs or nil end,
      meta = function(name) return name == "Npc" and meta or nil end,
    })
    return row
  end

  -- Literal masks: the flavor's own flag values, independent of the pass's tables.
  local vendorRepair = { services.VENDOR, services.REPAIR }
  equal(apply("Classic", { [keys.services] = { services.VENDOR, services.REPAIR } })[keys.npcFlags], 4 + 16384,
    "Classic builds the mask with Era flag values")
  equal(apply("TBC", { [keys.services] = { services.VENDOR, services.REPAIR } })[keys.npcFlags], 128 + 4096,
    "TBC builds the mask with its renumbered flag values")
  equal(apply("MoP", { [keys.services] = { services.TRANSMOGRIFIER } })[keys.npcFlags], 268435456,
    "Mists places TRANSMOGRIFIER on its own bit")
  equal(apply("Forever", { [keys.services] = { services.TRANSMOGRIFIER, services.VENDOR } })[keys.npcFlags], 536870912 + 4,
    "Forever keeps Classic numbering and its own TRANSMOGRIFIER bit")
  equal(vendorRepair, { services.VENDOR, services.REPAIR }, "the pass leaves an authored list untouched")

  equal(apply("Classic", { [keys.services] = { services.BARBER, services.WEAPON_MASTER } })[keys.npcFlags], nil,
    "services without a flag in the flavor produce no mask")
  equal(apply("Classic", { [keys.name] = "No services" })[keys.npcFlags], nil, "an NPC without services stores no mask")
  equal(apply("TBC", { [keys.services] = { services.CLASS_TRAINER } })[keys.npcFlags], 32,
    "TBC expresses the class trainer kind as a flag")
  equal(apply("Classic", { [keys.services] = { services.CLASS_TRAINER } })[keys.npcFlags], nil,
    "Classic has no class trainer flag")
  equal(apply("Classic", { [keys.services] = { services.VENDOR, services.VENDOR } })[keys.npcFlags], 4,
    "a repeated service is counted once in the mask")

  -- A corrected mask replaces what flags can express and keeps what they cannot.
  local corrected = apply("Classic", {
    [keys.services] = { services.GOSSIP, services.VENDOR, services.INNKEEPER, services.WEAPON_MASTER },
    [keys.npcFlags] = 4,
  })
  equal(corrected[keys.services], { services.VENDOR, services.WEAPON_MASTER },
    "a corrected mask drops flag services it omits and keeps services no flag expresses")
  equal(corrected[keys.npcFlags], 4, "the rebuilt mask equals the corrected one")

  local cleared = apply("Classic", { [keys.services] = { services.VENDOR, services.PORTAL_TRAINER }, [keys.npcFlags] = 0 })
  equal(cleared[keys.services], { services.PORTAL_TRAINER }, "a zero mask removes every flag service")
  equal(cleared[keys.npcFlags], nil, "a zero mask stores nothing")

  local fromMask = apply("Wotlk", { [keys.npcFlags] = 128 + 4096 + 33554432 })
  equal(fromMask[keys.services], { services.VENDOR, services.REPAIR, services.BARBER },
    "a mask on a row without services becomes its services")

  local stray = apply("Classic", { [keys.npcFlags] = 4 + 32768 })
  equal(stray[keys.services], { services.VENDOR }, "a bit no service names is dropped")
  equal(stray[keys.npcFlags], 4, "the rebuilt mask omits the unnamed bit")

  local tbcTrainer = apply("TBC", { [keys.services] = { services.TRAINER, services.PROFESSION_TRAINER }, [keys.npcFlags] = 16 })
  equal(tbcTrainer[keys.services], { services.TRAINER },
    "where the trainer kind is a flag, a mask without it removes the kind")

  local ok, message = pcall(pass.Tables, "NoSuchExpansion")
  equal(ok, false, "an unknown expansion is rejected")
  check(tostring(message):find("NoSuchExpansion", 1, true) ~= nil, "the failure names the expansion")

  -- Each flavor's table must agree with the public flag names it shares with Enum.npcFlags.
  local publicName = { STABLE_MASTER = "STABLEMASTER", CLASS_TRAINER = "TRAINER_CLASS", PROFESSION_TRAINER = "TRAINER_PROFESSION" }
  for expansion, bits in pairs(pass.flagBits) do
    local flags = constants.byExpansion[expansion].npcFlags
    for bit, name in pairs(bits) do
      local published = flags[publicName[name] or name]
      if published ~= nil then
        equal(published, bit, expansion .. " " .. name .. " matches Enum.npcFlags")
      end
    end
  end

  -- Real Classic data in Source mode: Corrections, then the registered pass, then reads.
  client.reset()
  client.install({ expansion = "Classic" })
  local source = emulator.loadAddon(config.addonName .. ".toc", config.addonName)
  local npc = source.Npc
  -- Katie Hunter: base data says vendor and innkeeper, a mask Correction says vendor only.
  check(npc.HasServices(384, source.Set(services.VENDOR)) == true, "source: a corrected vendor keeps VENDOR")
  check(npc.HasServices(384, source.Set(services.INNKEEPER)) == false, "source: the mask Correction removed INNKEEPER")
  equal(npc.npcFlags(384), 4, "source: the legacy mask reflects the corrected services")
  -- Hanashi, weapon master in Orgrimmar.
  check(npc.HasServices(2704, source.Set(services.WEAPON_MASTER)) == true, "source: a weapon master carries the service")
  equal(npc.trainerSkills(2704), { 44, 45, 136, 172, 176 }, "source: weapon master skills are skill line IDs")
  equal(npc.trainerClass(2704), 0, "source: a weapon master trains no class")
  -- Khelden Bremen, mage trainer in Northshire.
  equal(npc.trainerClass(198), constants.classIDs.MAGE, "source: a class trainer names its class")
  check(npc.HasServices(198, source.Set(services.CLASS_TRAINER)) == true, "source: a class trainer carries the service")
  equal(npc.GetServices(198)[services.TRAINER], true, "source: GetServices exposes the general trainer flag")
  equal(npc.trainerSkills(198), nil, "source: a class trainer has no trainer skills")
  client.reset()
end
