-- src/derived/npcServices.lua
--
-- Derived Pass keeping NPC `services` and the legacy `npcFlags` bitmask consistent (ADR 0017).
--
-- `services` is the authored field: a list of `Enum.serviceKeys` values, the same in every
-- flavor. `npcFlags` stays readable for consumers written before contract 5, so this pass
-- rebuilds the mask from the list with the flavor's own bit values.
--
-- A Static Correction may still set `npcFlags`. Generated imports and older Corrections do,
-- and a mask replaces the whole set of flags by nature. The pass honours that: when a row
-- carries `npcFlags` after Corrections, the services a flag can express are replaced by the
-- mask's, and services no flag expresses (weapon master, portal trainer, ...) are kept. Base
-- data rows carry no `npcFlags`, so a mask on a row always came from a Correction.
--
-- Dynamic Corrections apply at read time, after this pass. One that sets `npcFlags` must set
-- `services` too; the pass cannot see it.

local _, LibQuestieDB = ...

local pairs, ipairs, type = pairs, ipairs, type
local floor, sort = math.floor, table.sort

local npcServices = {}

-- Flag bit -> service name, for the bits the classic-era client family uses.
local classicBits = {
  [1] = "GOSSIP", [2] = "QUEST_GIVER", [4] = "VENDOR", [8] = "FLIGHT_MASTER", [16] = "TRAINER",
  [32] = "SPIRIT_HEALER", [64] = "SPIRIT_GUIDE", [128] = "INNKEEPER", [256] = "BANKER",
  [512] = "PETITIONER", [1024] = "TABARD_DESIGNER", [2048] = "BATTLEMASTER", [4096] = "AUCTIONEER",
  [8192] = "STABLE_MASTER", [16384] = "REPAIR",
}

-- From TBC the client renumbered the flags and split trainers and vendors by kind.
local tbcBits = {
  [1] = "GOSSIP", [2] = "QUEST_GIVER", [16] = "TRAINER", [32] = "CLASS_TRAINER",
  [64] = "PROFESSION_TRAINER", [128] = "VENDOR", [256] = "VENDOR_AMMO", [512] = "VENDOR_FOOD",
  [1024] = "VENDOR_POISON", [2048] = "VENDOR_REAGENT", [4096] = "REPAIR", [8192] = "FLIGHT_MASTER",
  [16384] = "SPIRIT_HEALER", [32768] = "SPIRIT_GUIDE", [65536] = "INNKEEPER", [131072] = "BANKER",
  [262144] = "PETITIONER", [524288] = "TABARD_DESIGNER", [1048576] = "BATTLEMASTER",
  [2097152] = "AUCTIONEER", [4194304] = "STABLE_MASTER", [8388608] = "GUILD_BANKER",
  [16777216] = "SPELLCLICK",
}

---@param base table<integer, string>
---@param extra table<integer, string>
---@return table<integer, string>
local function extend(base, extra)
  local bits = {}
  for bit, name in pairs(base) do bits[bit] = name end
  for bit, name in pairs(extra) do bits[bit] = name end
  return bits
end

local wotlkBits = extend(tbcBits, { [33554432] = "BARBER" })
local cataBits = extend(wotlkBits, {
  [67108864] = "MAILBOX", [134217728] = "ARCANE_REFORGER", [268435456] = "TRANSMOGRIFIER",
  [536870912] = "VOID_STORAGE",
})

--- expansion -> flag bit -> service name. A bit absent here has no meaning in that flavor and
--- is dropped; a service absent here has no flag in that flavor and never reaches the mask.
npcServices.flagBits = {
  Classic = classicBits,
  TBC = tbcBits,
  Wotlk = wotlkBits,
  Cata = cataBits,
  MoP = extend(cataBits, { [1073741824] = "BLACK_MARKET" }),
  -- Forever keeps Classic numbering and places the later services on bits Era data left free.
  Forever = extend(classicBits, { [33554432] = "BARBER", [536870912] = "TRANSMOGRIFIER" }),
}

---Resolve one flavor's bit table to service IDs, in both directions.
---@param expansion string
---@return table<integer, integer> serviceByBit
---@return table<integer, integer> bitByService
---@return integer[] bits Ascending.
function npcServices.Tables(expansion)
  local names = npcServices.flagBits[expansion]
  if not names then error("npcServices pass: no NPC flag table for expansion " .. tostring(expansion), 0) end
  local serviceKeys = LibQuestieDB.Enum.serviceKeys
  local serviceByBit, bitByService, bits = {}, {}, {}
  for bit, name in pairs(names) do
    local service = serviceKeys[name]
    if not service then error("npcServices pass: unknown service name " .. name, 0) end
    serviceByBit[bit] = service
    bitByService[service] = bit
    bits[#bits + 1] = bit
  end
  sort(bits)
  return serviceByBit, bitByService, bits
end

---@class NpcServicesDerivedContext
---@field flavor table Active flavor; `expansion` selects its flag bit values.
---@field entities fun(entityType: string): table? Corrected raw rows by entity type.
---@field meta fun(entityType: string): table? Materialized schema by entity type.

---Fold a corrected `npcFlags` mask into `services`, then rebuild `npcFlags` from `services`.
---@param ctx NpcServicesDerivedContext
---@return nil
function npcServices.Apply(ctx)
  local npcs = ctx.entities("Npc")
  if not npcs then return end
  local meta = ctx.meta("Npc")
  local keys = meta and meta.keys
  if not keys or not keys.services or not keys.npcFlags then
    error("npcServices pass: the Npc schema must define services and npcFlags", 0)
  end
  local servicesIndex, flagsIndex = keys.services, keys.npcFlags
  local serviceByBit, bitByService, bits = npcServices.Tables(ctx.flavor.expansion)

  for _, row in pairs(npcs) do
    local services = row[servicesIndex]
    local flags = row[flagsIndex]

    if type(flags) == "number" then
      -- Keep what no flag can express, then take the flag-expressible services from the mask.
      local merged, seen = {}, {}
      if type(services) == "table" then
        for _, service in ipairs(services) do
          if not bitByService[service] and not seen[service] then
            seen[service] = true
            merged[#merged + 1] = service
          end
        end
      end
      for _, bit in ipairs(bits) do
        if floor(flags / bit) % 2 == 1 then
          local service = serviceByBit[bit]
          if not seen[service] then
            seen[service] = true
            merged[#merged + 1] = service
          end
        end
      end
      sort(merged)
      services = merged
      row[servicesIndex] = merged
    end

    local mask = 0
    if type(services) == "table" then
      local counted = {}
      for _, service in ipairs(services) do
        local bit = bitByService[service]
        if bit and not counted[bit] then
          counted[bit] = true
          mask = mask + bit
        end
      end
    end
    row[flagsIndex] = mask ~= 0 and mask or nil
  end
end

LibQuestieDB.DerivedNpcServices = npcServices

return npcServices
