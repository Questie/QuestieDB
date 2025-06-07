---@meta

---A General name alias
---@alias Name string
---@alias Level number
---@alias XP number

--- Category id like in the ZoneOrSort
---@alias CategoryId number

---@alias FactionId number
---@alias SkillId number

---@alias SkillPair {[1]: SkillId, [2]: number}
---@alias ReputationPair {[1]: FactionId, [2]: number}

---@alias QuestId number
---@alias ItemId number
---@alias NpcId number
---@alias ObjectId number

---@alias ZoneOrSort number -- >0: AreaTable.dbc ID; <0: QuestSort.dbc ID
---@alias Category string --- Used a lot in the tracker and questlog
---@alias ObjectiveIndex number --- The index of the objective in the quest

---@alias ZoneName string
---@alias ContinentName string

---@alias AreaId number --ZoneId
---@alias X number
---@alias Y number
--- CoordPairs are hard to represent in Emmy, it's basically [1]=X [2]=Y
---@class CoordPair : { [1]: X, [2]: Y }
---@class AreaCoordinate : { [1]: AreaId, [2]: X, [3]: Y }

--------------------------------------------------------------------------------
-- Starters

--  ['startedBy'] = 2, -- table
--    ['creatureStart'] = 1, -- table {creature(int),...}
--    ['objectStart'] = 2, -- table {object(int),...}
--    ['itemStart'] = 3, -- table {item(int),...}

---@alias StartedBy {[1]: StartedByNpc, [2]: StartedByObject, [3]: StartedByItem}
---@alias StartedByNpc NpcId[]
---@alias StartedByObject ObjectId[]
---@alias StartedByItem ItemId[]

--------------------------------------------------------------------------------
-- Finishers

---@class Finisher
---@field Type "monster"|"object"
---@field Id NpcId|ObjectId
---@field Name Name

-- ['finishedBy'] = 3, -- table
--   ['creatureEnd'] = 1, -- table {creature(int),...}
--   ['objectEnd'] = 2, -- table {object(int),...}

---@alias FinishedBy {[1]: FinishedByNpc, [2]: FinishedByObject}
---@alias FinishedByNpc NpcId[]
---@alias FinishedByObject ObjectId[]


--------------------------------------------------------------------------------
-- Objectives
---@alias Objective NpcObjective|ObjectObjective|ItemObjective|ReputationObjective|KillObjective|TriggerEndObjective

---@class NpcObjective
---@field Type "monster"
---@field Id NpcId
---@field Text string

---@class ObjectObjective
---@field Type "object"
---@field Id ObjectId
---@field Text string

---@class ItemObjective
---@field Type "item"
---@field Id ItemId
---@field Text string

---@class ReputationObjective
---@field Type "reputation"
---@field Id FactionId
---@field RequiredRepValue number

---@class KillObjective
---@field Type "killcredit"
---@field IdList NpcId[]
---@field RootId NpcId
----@field Text string

---@class TriggerEndObjective
---@field Type "event"
---@field Text string
---@field Coordinates table<AreaId, CoordPair[]>

--------------------------------------------------------------------------------

-- table: {{spawnlist, iconFile, text, objectiveIndex (optional), {{dbReferenceType, id}, ...} (optional)},...}, a list of hidden special objectives for a quest. Similar to requiredSourceItems
---@class ExtraObjective
---@field [1] table<AreaId, CoordPair[]>? spawnList
---@field [2] string iconFile path
---@field [3] string Objective Text
---@field [4] ObjectiveIndex? Optional ObjectiveIndex
---@field [5] table<"monster"|"object", function>? dbReference which uses _QuestieQuest.objectiveSpawnListCallTable to fetch spawns

---@class RawObjectives : {[1]: RawNpcObjective[], [2]: RawObjectObjective[], [3]: RawItemObjective[], [4]: RawReputationObjective, [5]: RawKillObjective[]}
---@class RawNpcObjective : { [1]: NpcId, [2]: string }
---@class RawObjectObjective : { [1]: ObjectId, [2]: string }
---@class RawItemObjective : { [1]: ItemId, [2]: string }
---@class RawReputationObjective : { [1]: FactionId, [2]: number }
---@class RawKillObjective : { [1]: NpcId[], [2]: NpcId, [3]: string }
