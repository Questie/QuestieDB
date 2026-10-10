-- Child-process harness: inject bad data in memory, then run the real validator CLI.
-- No owned entity/support files or baselines are edited.
-- Usage: lua5.1 validators/fixtures/diagnostic-failures.lua spawns|missing-starter|write-error <output-directory>

--------------------------------------------------------------------------------------------
-- Fixture identities
--------------------------------------------------------------------------------------------

local fixtures = {
    area = 16919, -- The Hall of Thanes has entrances, but no native UiMap.
    coordinates = {10, 20}, -- Deliberately ordinary coordinates, not the {-1,-1} dungeon marker.
    firstObject = 9000001, -- Synthetic IDs 9000001..9000016 prove output is not capped at 15 findings.
    objectCount = 16,
    quest = 9000042, -- Synthetic quest used to exercise a broken starter relationship.
    npc = 9000073, -- Synthetic existing NPC with an empty questStarts list.
    missingNpc = 9000099, -- Synthetic NPC ID deliberately absent from npcData.
}
local mode, output = assert(arg[1]), assert(arg[2])
local quiet = arg[3] == "--quiet"
assert(mode == "spawns" or mode == "missing-starter" or mode == "write-error", "Unknown diagnostic fixture mode")

--------------------------------------------------------------------------------------------
-- In-memory failures: preserve the real check behind each wrapper
--------------------------------------------------------------------------------------------

local function injectUnmappedObjects(checks)
    local original = checks.checkObjectSpawnAreaIds
    checks.checkObjectSpawnAreaIds = function(objects, keys, lookup)
        for offset = 0, fixtures.objectCount - 1 do
            objects[fixtures.firstObject + offset] = {
                [keys.name] = "Diagnostic fixture object " .. offset,
                [keys.spawns] = {[fixtures.area] = {fixtures.coordinates}},
            }
        end
        return original(objects, keys, lookup)
    end
end

-- The missing-starter case uses no NPC row. The write-error case needs a real, inconsistent
-- NPC row so the check reaches its suggested-correction file writer.
local function injectStarterFailure(checks)
    local original = checks.checkNpcQuestStarts
    checks.checkNpcQuestStarts = function(npcs, npcKeys, quests, questKeys)
        local starter = mode == "missing-starter" and fixtures.missingNpc or fixtures.npc
        quests[fixtures.quest] = {
            [questKeys.name] = "Diagnostic fixture quest",
            [questKeys.startedBy] = {{starter}},
            [questKeys.requiredRaces] = 0, -- Neutral; this fixture tests starters, not race eligibility.
        }
        if mode == "write-error" then
            npcs[fixtures.npc] = {
                [npcKeys.name] = "Diagnostic fixture NPC",
                [npcKeys.questStarts] = {},
            }
        end
        return original(npcs, npcKeys, quests, questKeys)
    end
end

--------------------------------------------------------------------------------------------
-- Child-only hooks: targeted file failure and check-module injection
--------------------------------------------------------------------------------------------

local originalOpen = io.open
if mode == "write-error" then
    rawset(io, "open", function(path, access)
        if access == "w" and path:match("/npcQuestStartsCorrections%.lua$") then
            return nil, "synthetic permission denied"
        end
        return originalOpen(path, access)
    end)
end

local originalDofile = dofile
rawset(_G, "dofile", function(path)
    local loaded = originalDofile(path)
    if path ~= "validators/checks.lua" then return loaded end
    if mode == "spawns" then
        injectUnmappedObjects(loaded)
    else
        injectStarterFailure(loaded)
    end
    return loaded
end)

--------------------------------------------------------------------------------------------
-- Execute the real CLI; process exit discards the hooks and injected rows
--------------------------------------------------------------------------------------------

local arguments = {"Forever", "--out=" .. output}
if quiet then arguments[#arguments + 1] = "--quiet" end
rawset(_G, "arg", arguments)
dofile("validators/run.lua")
