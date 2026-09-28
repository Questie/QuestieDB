local _, LibQuestieDB = ...
-- Use the real combined Classic quest slots so validation exercises production policy.
local providers = {}
LibQuestieDB.CorrectionProviders.classicQuestFixes = providers
local iconTypes = LibQuestieDB.Enum.iconTypes
local questKeys = LibQuestieDB.Meta.Quest.keys
local raceKeys = LibQuestieDB.Enum.corrections.raceKeys
assert(raceKeys.SKYBORNE_ALLIANCE == 4294967296, "conversion must evaluate the destination race masks")
local hints = LibQuestieDB.ObjectiveFirst
hints.itemObjectiveFirst[123] = true

---@return table<number, table>
function providers.LoadFactionFixes()
    local name = "Alliance objective"
    if UnitFactionGroup("Player") == "Horde" and UnitClassBase("Player") == "MAGE" then
        name = "Horde mage objective"
    end
    return {
        [123] = {
            [questKeys.name] = name,
            [questKeys.requiredRaces] = raceKeys.ALL_ALLIANCE,
            [questKeys.extraObjectives] = {{{[215] = {{10,20}}}, iconTypes.ICON_TYPE_EVENT, "Use the object"}},
        },
    }
end

---@return table
function providers.Load()
    return {}
end
