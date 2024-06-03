## Event: UNIT_AURA

**Title:** UNIT AURA

**Content:**
Fires when a buff, debuff, status, or item bonus was gained by or faded from an entity (player, pet, NPC, or mob.)
`UNIT_AURA: unitTarget, updateInfo`

**Payload:**
- `unitTarget`
  - *string* : UnitId
- `updateInfo`
  - *UnitAuraUpdateInfo?* : Optional table of information about changed auras.
    - Field
      - Type
      - Description
    - addedAuras
      - AuraData?
      - List of auras added to the unit during this update.
    - updatedAuraInstanceIDs
      - *number?*
      - List of existing auras on the unit modified during this update.
    - removedAuraInstanceIDs
      - *number?*
      - List of existing auras removed from the unit during this update.
    - isFullUpdate
      - *boolean?* = false
      - Whether or not a full update of the units' auras should be performed. If this is set, the other fields will likely be nil.
    - AuraData
      - Field
        - Type
        - Description
      - applications
        - *number*
      - auraInstanceID
        - *number*
      - canApplyAura
        - *boolean*
        - Whether or not the player can apply this aura.
      - charges
        - *number*
      - dispelName
        - *string?*
      - duration
        - *number*
      - expirationTime
        - *number*
      - icon
        - *number*
      - isBossAura
        - *boolean*
        - Whether or not this aura was applied by a boss.
      - isFromPlayerOrPlayerPet
        - *boolean*
        - Whether or not this aura was applied by a player or their pet.
      - isHarmful
        - *boolean*
        - Whether or not this aura is a debuff.
      - isHelpful
        - *boolean*
        - Whether or not this aura is a buff.
      - isNameplateOnly
        - *boolean*
        - Whether or not this aura should appear on nameplates.
      - isRaid
        - *boolean*
        - Whether or not this aura meets the conditions of the RAID aura filter.
      - isStealable
        - *boolean*
      - maxCharges
        - *number*
      - name
        - *string*
        - The name of the aura.
      - nameplateShowAll
        - *boolean*
        - Whether or not this aura should always be shown irrespective of any usual filtering logic.
      - nameplateShowPersonal
        - *boolean*
      - points
        - *array*
        - Variable returns - Some auras return additional values that typically correspond to something shown in the tooltip, such as the remaining strength of an absorption effect.
      - sourceUnit
        - *string?*
        - Token of the unit that applied the aura.
      - spellId
        - *number*
        - The spell ID of the aura.
      - timeMod
        - *number*

**Content Details:**
The extended payload can be supplied to the AuraUtil.ShouldSkipAuraUpdate function alongside a predicate function to determine if a consumer of this event may skip further processing of the event as a performance optimization.
Related API
UnitAura

**Usage:**
The aura InstanceIDs can be used to efficiently process aura updates and is queried with C_UnitAuras.GetAuraDataByAuraInstanceID.
 Warning: GetAuraDataByAuraInstanceID doesn't work on removed aura InstanceIDs, so it might be a good idea to cache the information.
```lua
local count = 0
local function OnEvent(self, event, unit, info)
    count = count + 1
    if info.isFullUpdate then
        print("full update")
        return
    end
    if info.addedAuras then
        local t = {}
        for _, v in pairs(info.addedAuras) do
            tinsert(t, format("%d(%s)", v.auraInstanceID, v.name))
        end
        print(count, unit, "|cnGREEN_FONT_COLOR:added|r", table.concat(t, ", "))
    end
    if info.updatedAuraInstanceIDs then
        local t = {}
        for _, v in pairs(info.updatedAuraInstanceIDs) do
            local aura = C_UnitAuras.GetAuraDataByAuraInstanceID(unit, v)
            tinsert(t, format("%d(%s)", aura.auraInstanceID, aura.name))
        end
        print(count, unit, "|cnYELLOW_FONT_COLOR:updated|r", table.concat(t, ", "))
    end
    if info.removedAuraInstanceIDs then
        local t = {}
        for _, v in pairs(info.removedAuraInstanceIDs) do
            tinsert(t, v)
        end
        print(count, unit, "|cnRED_FONT_COLOR:removed|r", table.concat(t, ", "))
    end
end
local f = CreateFrame("Frame")
f:RegisterEvent("UNIT_AURA")
f:SetScript("OnEvent", OnEvent)
```
The payload can contain any combination of addedAuras, updatedAuraInstanceIDs and removedAuraInstanceIDs.