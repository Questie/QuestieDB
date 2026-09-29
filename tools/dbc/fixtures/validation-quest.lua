-- Synthetic raw Quest input: repeated numbers outside requiredRaces must not change.
local QuestieDB = QuestieLoader:ImportModule("QuestieDB")
QuestieDB.questKeys = {
    name = 1, requiredRaces = 6, requiredClasses = 7, triggerEnd = 9, extraObjectives = 29,
}
QuestieDB.questData = [=[return {
    [77] = {"Alliance 77",{{178}},nil,1,77,77,178,nil,{"Signal",{[215]={{10,20}}}}},
    [178] = {"Horde 178",nil,nil,1,178,178,77},
    [3] = {"Neutral",nil,nil,1,1,0},
    [4] = {"Human",nil,nil,1,1,1},
    [5] = {"Human and Dwarf",nil,nil,1,1,5},
    [6] = {"Absent",nil,nil,1,1,nil,77},
    [7] = {"Already Alliance",nil,nil,1,1,4294967373},
    [8] = {"Already Horde",nil,nil,1,1,8589934770},
    [9] = {"Orc and Troll",nil,nil,1,1,130},
}]=]
