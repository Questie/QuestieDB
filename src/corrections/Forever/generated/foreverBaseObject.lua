-- Generated delta-base. Apply after inherited Static Corrections, before authored Forever Static Corrections.
-- Import provenance and refresh policy: docs/forever-delta-base.md.
local ForeverBaseObject = QuestieLoader:CreateModule("ForeverBaseObject")
local QuestieDB = QuestieLoader:ImportModule("QuestieDB")
local ZoneDB = QuestieLoader:ImportModule("ZoneDB")
function ForeverBaseObject:Load()
    local objectKeys = QuestieDB.objectKeys
    local zoneIDs = ZoneDB.zoneIDs
    return {
        [3972] = { -- WANTED : https://wowhead.com/forever/object=3972/wanted
            [objectKeys.questStarts_add] = {92706},
        },
        [12666] = { -- Twilight Tome : https://wowhead.com/forever/object=12666/twilight-tome
            [objectKeys.questStarts_add] = {98042},
        },
        [61934] = { -- Brazier of the Dormant Flame : https://wowhead.com/forever/object=61934/brazier-of-the-dormant-flame
            [objectKeys.questStarts_add] = {94468},
            [objectKeys.questEnds_add] = {94467},
        },
        [175320] = { -- WANTED: Murkdeep! : https://wowhead.com/forever/object=175320/wanted-murkdeep
            [objectKeys.questStarts_add] = {98025},
        },
        [175725] = { -- The Old Gods and the Ordering of Azeroth : https://wowhead.com/forever/object=175725/the-old-gods-and-the-ordering-of-azeroth
            [objectKeys.name] = "The Old Gods and the Ordering of Azeroth",
            [objectKeys.spawns] = {[11] = {{9.9, 57.4}, {9.9, 57.5}}, [1497] = {{55.9, 50.9}}, [1537] = {{75.6, 10.4}, {75.9, 11.5}, {76.1, 11}}, [1657] = {{55.4, 24}, {55.4, 24.5}, {55.5, 24}, {55.5, 24.5}}},
        },
        [175736] = { -- Ironforge - the Awakening of the Dwarves : https://wowhead.com/forever/object=175736/ironforge-the-awakening-of-the-dwarves
            [objectKeys.name] = "Ironforge - the Awakening of the Dwarves",
            [objectKeys.spawns] = {[17] = {{49.4, 84.4}, {49.5, 84.4}}, [38] = {{35.4, 49}, {35.6, 49}}, [440] = {{36.9, 77}}, [1537] = {{74.9, 9.1}, {74.9, 9.6}}},
        },
        [175739] = { -- War of the Three Hammers : https://wowhead.com/forever/object=175739/war-of-the-three-hammers
            [objectKeys.name] = "War of the Three Hammers",
            [objectKeys.spawns] = {[17] = {{49.1, 84.2}}, [1537] = {{75.1, 9.1}}},
        },
        [175740] = { -- The Last Guardian : https://wowhead.com/forever/object=175740/the-last-guardian
            [objectKeys.name] = "The Last Guardian",
            [objectKeys.spawns] = {[38] = {{37.2, 47}}, [40] = {{52.4, 53.1}, {52.5, 53.1}}},
        },
        [175742] = { -- Rise of the Horde : https://wowhead.com/forever/object=175742/rise-of-the-horde
            [objectKeys.name] = "Rise of the Horde",
            [objectKeys.spawns] = {[8] = {{47.9, 54.9}}, [14] = {{59.6, 58.2}}, [1537] = {{76.8, 12.4}, {77.1, 13}}},
        },
        [375548] = { -- Unlit Torch : https://wowhead.com/forever/object=375548/unlit-torch
            [objectKeys.name] = "Unlit Torch",
            [objectKeys.zoneID] = zoneIDs.ASHENVALE,
        },
        [386691] = { -- Library Book : https://wowhead.com/forever/object=386691/library-book
            [objectKeys.name] = "Library Book",
            [objectKeys.spawns] = {[12] = {{65.4, 70.1}}, [1537] = {{75.4, 11}, {75.6, 10.4}, {75.7, 10.5}}},
        },
        [404941] = { -- Relic Coffer : https://wowhead.com/forever/object=404941/relic-coffer
            [objectKeys.name] = "Relic Coffer",
            [objectKeys.spawns] = {[85] = {{52.5, 25.8}}},
            [objectKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
        },
        [405201] = { -- Shipwreck Cache : https://wowhead.com/forever/object=405201/shipwreck-cache
            [objectKeys.name] = "Shipwreck Cache",
            [objectKeys.spawns] = {[85] = {{66.7, 24.6}}},
            [objectKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
        },
        [405879] = { -- Apothecary Society Primer : https://wowhead.com/forever/object=405879/apothecary-society-primer
            [objectKeys.name] = "Apothecary Society Primer",
            [objectKeys.spawns] = {[85] = {{59.4, 52.3}, {59.5, 52.3}}},
            [objectKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
        },
        [406918] = { -- Messenger Bag : https://wowhead.com/forever/object=406918/messenger-bag
            [objectKeys.name] = "Messenger Bag",
            [objectKeys.questStarts] = {79976},
            [objectKeys.questEnds] = {79975},
            [objectKeys.spawns] = {[45] = {{22.4, 24.2}, {22.5, 24.2}}},
            [objectKeys.zoneID] = zoneIDs.ARATHI_HIGHLANDS,
        },
        [410847] = { -- Rusty Safe : https://wowhead.com/forever/object=410847/rusty-safe
            [objectKeys.name] = "Rusty Safe",
            [objectKeys.spawns] = {[28] = {{59.4, 84.6}, {59.5, 84.5}}},
            [objectKeys.zoneID] = zoneIDs.WESTERN_PLAGUELANDS,
        },
        [414197] = { -- Bough of Shadows : https://wowhead.com/forever/object=414197/bough-of-shadows
            [objectKeys.name] = "Bough of Shadows",
            [objectKeys.spawns] = {[331] = {{89.8, 37.3}, {89.8, 37.5}, {91.2, 37.5}, {92.5, 40.4}, {92.8, 35.7}, {94, 41.7}}},
            [objectKeys.zoneID] = zoneIDs.ASHENVALE,
        },
        [415106] = { -- Burned-Out Remains : https://wowhead.com/forever/object=415106/burned-out-remains
            [objectKeys.name] = "Burned-Out Remains",
            [objectKeys.questStarts] = {79007, 79192},
            [objectKeys.questEnds] = {79008},
            [objectKeys.spawns] = {[17] = {{46.4, 73.9}}, [40] = {{37.4, 50.6}, {37.5, 50.7}}},
        },
        [415107] = { -- Burned-Out Remains : https://wowhead.com/forever/object=415107/burned-out-remains
            [objectKeys.name] = "Burned-Out Remains",
            [objectKeys.questStarts] = {79008, 79192},
            [objectKeys.questEnds] = {79007},
            [objectKeys.spawns] = {[40] = {{37.4, 50.6}, {37.5, 50.7}}},
            [objectKeys.zoneID] = zoneIDs.WESTFALL,
        },
        [417072] = { -- Nailed Plank : https://wowhead.com/forever/object=417072/nailed-plank
            [objectKeys.name] = "Nailed Plank",
            [objectKeys.questStarts] = {79192},
            [objectKeys.questEnds] = {79008},
            [objectKeys.spawns] = {[17] = {{46.4, 73.8}}},
            [objectKeys.zoneID] = zoneIDs.THE_BARRENS,
        },
        [421526] = { -- Research Notes : https://wowhead.com/forever/object=421526/research-notes
            [objectKeys.name] = "Research Notes",
            [objectKeys.spawns] = {[33] = {{41.4, 50.9}, {41.5, 50.9}}},
            [objectKeys.zoneID] = zoneIDs.STRANGLETHORN_VALE,
        },
        [422911] = { -- Sealed Barrel : https://wowhead.com/forever/object=422911/sealed-barrel
            [objectKeys.name] = "Sealed Barrel",
            [objectKeys.spawns] = {[45] = {{21.3, 84}}},
            [objectKeys.zoneID] = zoneIDs.ARATHI_HIGHLANDS,
        },
        [423901] = { -- Book : https://wowhead.com/forever/object=423901/book
            [objectKeys.name] = "Book",
            [objectKeys.spawns] = {[8] = {{61.4, 22.4}, {61.4, 22.5}, {61.5, 22.6}, {61.6, 22.4}}, [618] = {{60.7, 37.7}}},
        },
        [424005] = { -- Pocket Litter : https://wowhead.com/forever/object=424005/pocket-litter
            [objectKeys.name] = "Pocket Litter",
            [objectKeys.questStarts] = {79980},
            [objectKeys.questEnds] = {79192},
            [objectKeys.spawns] = {[406] = {{40.7, 52.4}, {40.8, 52.5}}},
            [objectKeys.zoneID] = zoneIDs.STONETALON_MOUNTAINS,
        },
        [424006] = { -- Hastily Rolled-Up Satchel : https://wowhead.com/forever/object=424006/hastily-rolled-up-satchel
            [objectKeys.name] = "Hastily Rolled-Up Satchel",
            [objectKeys.questEnds] = {79976},
            [objectKeys.spawns] = {[45] = {{22.4, 24.2}, {22.5, 24.2}}},
            [objectKeys.zoneID] = zoneIDs.ARATHI_HIGHLANDS,
        },
        [424007] = { -- Carved Figurine : https://wowhead.com/forever/object=424007/carved-figurine
            [objectKeys.name] = "Carved Figurine",
            [objectKeys.questStarts] = {79975},
            [objectKeys.questEnds] = {79974},
            [objectKeys.spawns] = {[38] = {{49.4, 12.9}, {49.5, 12.8}}},
            [objectKeys.zoneID] = zoneIDs.LOCH_MODAN,
        },
        [424010] = { -- Nailed Plank : https://wowhead.com/forever/object=424010/nailed-plank
            [objectKeys.name] = "Nailed Plank",
            [objectKeys.questStarts] = {79192},
            [objectKeys.questEnds] = {79007},
            [objectKeys.spawns] = {[40] = {{37.4, 50.9}, {37.5, 50.8}}},
            [objectKeys.zoneID] = zoneIDs.WESTFALL,
        },
        [424012] = { -- Mound of Dirt : https://wowhead.com/forever/object=424012/mound-of-dirt
            [objectKeys.name] = "Mound of Dirt",
            [objectKeys.questStarts] = {79974},
            [objectKeys.questEnds] = {79980},
            [objectKeys.spawns] = {[406] = {{39.6, 49.9}}},
            [objectKeys.zoneID] = zoneIDs.STONETALON_MOUNTAINS,
        },
        [439628] = { -- Fool's Gold Vein : https://wowhead.com/forever/object=439628/fools-gold-vein
            [objectKeys.name] = "Fool's Gold Vein",
            [objectKeys.spawns] = {[331] = {{79.2, 49.9}, {81.6, 52.1}, {82.7, 45.8}, {84.8, 55.4}, {85.8, 46.7}, {86, 49.7}, {87.7, 64.9}, {88.1, 62.1}, {89, 45.6}, {89.8, 42.9}, {91, 56.3}, {91.3, 37.4}, {91.3, 37.6}, {92.6, 35.2}, {93.4, 42.4}, {93.4, 42.5}, {94.1, 36.6}}},
            [objectKeys.zoneID] = zoneIDs.ASHENVALE,
        },
        [439762] = { -- Star Lotus : https://wowhead.com/forever/object=439762/star-lotus
            [objectKeys.name] = "Star Lotus",
            [objectKeys.spawns] = {[47] = {{45.1, 43.2}, {46.1, 38.4}, {46.1, 38.5}, {49.4, 38}, {49.5, 38}, {57.3, 41.9}, {58.9, 43.4}, {59.1, 43.7}, {61.7, 25.5}, {61.8, 25.3}, {66.1, 42.9}, {66.6, 32.9}, {68.4, 46.6}, {68.5, 46.6}, {70.4, 45.5}, {70.5, 45.4}, {70.5, 45.5}, {71.3, 48.4}, {71.3, 48.5}, {73, 53.2}}},
            [objectKeys.zoneID] = zoneIDs.THE_HINTERLANDS,
        },
        [439778] = { -- Starsilver Vein : https://wowhead.com/forever/object=439778/starsilver-vein
            [objectKeys.name] = "Starsilver Vein",
            [objectKeys.spawns] = {[47] = {{45.4, 39.4}, {45.4, 39.5}, {46.9, 34.8}, {48.8, 45.5}, {56.6, 43.3}, {56.9, 43.6}, {57.9, 49.8}, {58.1, 41}, {58.9, 43.2}, {63.7, 43.4}, {63.8, 43.5}, {66.3, 50.7}, {72.2, 52.3}, {73.6, 53.7}}},
            [objectKeys.zoneID] = zoneIDs.THE_HINTERLANDS,
        },
        [439810] = { -- Moonroot : https://wowhead.com/forever/object=439810/moonroot
            [objectKeys.name] = "Moonroot",
            [objectKeys.spawns] = {[357] = {{37.4, 17.3}, {37.5, 17.4}, {38.2, 11.1}, {39.1, 11.1}, {40.4, 11.5}, {40.5, 11.4}, {40.5, 11.5}, {41.6, 18.4}, {41.6, 18.5}, {41.9, 13.9}, {44.7, 23.1}, {45.4, 10.9}, {46.5, 18.3}, {50.8, 18.3}, {52, 12.1}, {53.5, 17.4}}},
            [objectKeys.zoneID] = zoneIDs.FERALAS,
        },
        [439815] = { -- Greater Moonstone Formation : https://wowhead.com/forever/object=439815/greater-moonstone-formation
            [objectKeys.name] = "Greater Moonstone Formation",
            [objectKeys.spawns] = {[357] = {{37.6, 16.8}, {40.3, 19.7}, {40.8, 9.9}, {40.8, 12.5}, {42.8, 23.2}, {47.4, 21.9}, {47.5, 21.8}, {51, 19.8}, {51.2, 14.8}, {54, 13.4}}},
            [objectKeys.zoneID] = zoneIDs.FERALAS,
        },
        [441248] = { -- Book : https://wowhead.com/forever/object=441248/book
            [objectKeys.name] = "Book",
            [objectKeys.spawns] = {[440] = {{72.6, 47.8}}},
            [objectKeys.zoneID] = zoneIDs.TANARIS,
        },
        [554626] = { -- Lumber Pile : https://wowhead.com/forever/object=554626/lumber-pile
            [objectKeys.name] = "Lumber Pile",
            [objectKeys.spawns] = {[85] = {{8.5, 67.1}, {8.8, 66}, {9.1, 67.7}, {9.3, 64.4}, {9.3, 64.6}, {9.6, 63.4}, {9.6, 63.5}, {10, 64.7}, {10, 66.4}, {10, 68.1}, {10.4, 67.1}, {10.5, 67}, {10.6, 65.3}, {11.2, 65.7}, {12.4, 66.2}}},
            [objectKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
        },
        [556626] = { -- Corpse Laden Boat : https://wowhead.com/forever/object=556626/corpse-laden-boat
            [objectKeys.name] = "Corpse Laden Boat",
            [objectKeys.spawns] = {[130] = {{58.4, 34.9}}},
            [objectKeys.zoneID] = zoneIDs.SILVERPINE_FOREST,
        },
        [556641] = { -- Dusty Shelf : https://wowhead.com/forever/object=556641/dusty-shelf
            [objectKeys.name] = "Dusty Shelf",
            [objectKeys.spawns] = {[130] = {{65.3, 24.8}}},
            [objectKeys.zoneID] = zoneIDs.SILVERPINE_FOREST,
        },
        [556646] = { -- Mailbox : https://wowhead.com/forever/object=556646/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[267] = {{62.4, 19.9}, {62.6, 19.9}}},
            [objectKeys.zoneID] = zoneIDs.HILLSBRAD_FOOTHILLS,
        },
        [556650] = { -- Decorated Headstone : https://wowhead.com/forever/object=556650/decorated-headstone
            [objectKeys.name] = "Decorated Headstone",
            [objectKeys.spawns] = {[267] = {{51.8, 52.9}}},
            [objectKeys.zoneID] = zoneIDs.HILLSBRAD_FOOTHILLS,
        },
        [556669] = { -- Dangerous! : https://wowhead.com/forever/object=556669/dangerous
            [objectKeys.name] = "Dangerous!",
            [objectKeys.spawns] = {[267] = {{62.4, 19.8}, {62.5, 19.7}}},
            [objectKeys.zoneID] = zoneIDs.HILLSBRAD_FOOTHILLS,
        },
        [556670] = { -- WANTED : https://wowhead.com/forever/object=556670/wanted
            [objectKeys.name] = "WANTED",
            [objectKeys.spawns] = {[267] = {{62.6, 20.7}}},
            [objectKeys.zoneID] = zoneIDs.HILLSBRAD_FOOTHILLS,
        },
        [556683] = { -- Shallow Grave : https://wowhead.com/forever/object=556683/shallow-grave
            [objectKeys.name] = "Shallow Grave",
            [objectKeys.spawns] = {[130] = {{67.8, 24.8}}},
            [objectKeys.zoneID] = zoneIDs.SILVERPINE_FOREST,
        },
        [556693] = { -- Mailbox : https://wowhead.com/forever/object=556693/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[267] = {{50.4, 58.6}}},
            [objectKeys.zoneID] = zoneIDs.HILLSBRAD_FOOTHILLS,
        },
        [560880] = { -- Mailbox : https://wowhead.com/forever/object=560880/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[36] = {{18.1, 64.5}}},
        },
        [560881] = { -- Mailbox : https://wowhead.com/forever/object=560881/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[36] = {{19, 66.4}, {19, 66.6}}},
            [objectKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [560883] = { -- Mailbox : https://wowhead.com/forever/object=560883/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[36] = {{12.4, 68.1}, {12.5, 68.5}}},
            [objectKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [560884] = { -- Mailbox : https://wowhead.com/forever/object=560884/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[36] = {{14.4, 66.9}, {14.5, 66.4}, {14.6, 66.8}}},
            [objectKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [560885] = { -- Mailbox : https://wowhead.com/forever/object=560885/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[36] = {{13.2, 64.1}}},
            [objectKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [560886] = { -- Mailbox : https://wowhead.com/forever/object=560886/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[36] = {{14.9, 69.2}, {15, 69.9}}},
            [objectKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [560887] = { -- Mailbox : https://wowhead.com/forever/object=560887/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[36] = {{18.4, 61.4}, {18.4, 61.5}, {18.6, 61.5}}},
            [objectKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [560888] = { -- Mailbox : https://wowhead.com/forever/object=560888/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[36] = {{18, 71.4}, {18, 71.5}}},
            [objectKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [560901] = { -- Mailbox : https://wowhead.com/forever/object=560901/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[36] = {{19.2, 73.9}}},
        },
        [561073] = { -- Mailbox : https://wowhead.com/forever/object=561073/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[36] = {{20.7, 65.7}}},
            [objectKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [561074] = { -- Mailbox : https://wowhead.com/forever/object=561074/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[36] = {{20.4, 64.6}, {20.7, 64.8}, {21, 64.1}}},
            [objectKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [561075] = { -- Mailbox : https://wowhead.com/forever/object=561075/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[36] = {{15.2, 63}, {15.5, 63.3}}},
            [objectKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [561159] = { -- Stolen Enchanting Supplies : https://wowhead.com/forever/object=561159/stolen-enchanting-supplies
            [objectKeys.name] = "Stolen Enchanting Supplies",
            [objectKeys.spawns] = {[12] = {{64.6, 40.4}, {65, 41.1}, {66, 40.4}, {66, 40.6}, {66.3, 39}, {66.3, 43}, {66.4, 41.9}, {66.5, 38.8}, {66.6, 41.8}, {67.4, 42.7}, {67.5, 42.7}, {67.8, 39.2}, {67.9, 49.6}, {68, 41.6}, {68.1, 40}, {68.1, 41.4}, {68.1, 45.3}, {68.4, 45.6}, {68.5, 45.7}, {68.7, 51.1}, {69.4, 38.4}, {69.5, 38.3}, {69.8, 39}}},
            [objectKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
        },
        [562103] = { -- Waterlogged Saw : https://wowhead.com/forever/object=562103/waterlogged-saw
            [objectKeys.name] = "Waterlogged Saw",
            [objectKeys.spawns] = {[12] = {{74.2, 76.3}, {74.2, 76.5}, {74.5, 76.4}}},
            [objectKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
        },
        [562105] = { -- Waterlogged Axe : https://wowhead.com/forever/object=562105/waterlogged-axe
            [objectKeys.name] = "Waterlogged Axe",
            [objectKeys.spawns] = {[12] = {{76.7, 82.4}, {76.7, 82.5}}},
            [objectKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
        },
        [562106] = { -- Waterlogged Toolbox : https://wowhead.com/forever/object=562106/waterlogged-toolbox
            [objectKeys.name] = "Waterlogged Toolbox",
            [objectKeys.spawns] = {[12] = {{77.3, 86.7}}},
            [objectKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
        },
        [562111] = { -- Poor Copper Vein : https://wowhead.com/forever/object=562111/poor-copper-vein
            [objectKeys.name] = "Poor Copper Vein",
            [objectKeys.spawns] = {[1] = {{19.7, 75.3}, {19.8, 73.4}, {19.8, 75.5}, {20.3, 77.4}, {20.3, 77.5}, {20.7, 71.2}, {21.4, 78.6}, {21.6, 69.2}, {22.1, 79.4}, {23, 68.7}, {24, 72}, {24.4, 80.4}, {24.5, 80.4}, {24.9, 62.1}, {25.7, 61.6}, {26.4, 67.8}, {26.4, 79.7}, {26.7, 66}, {26.8, 81}, {27.1, 64}, {27.1, 65.4}, {27.1, 80.3}, {27.2, 62.3}, {27.5, 64.4}, {27.6, 81}, {28, 63}, {28.4, 81.6}, {28.8, 78.9}, {29.1, 82.5}, {29.4, 81.5}, {29.6, 75.6}, {29.6, 80}, {30.3, 79.3}, {30.4, 80.7}, {30.4, 81.7}, {30.5, 81}, {30.5, 82.1}, {30.6, 79.6}}, [12] = {{43.8, 38.4}, {44.1, 38.5}, {44.2, 34.4}, {44.3, 34.5}, {44.3, 43}, {44.6, 39.5}, {44.6, 41.4}, {44.6, 41.5}, {44.7, 39.4}, {44.9, 42.9}, {45.1, 33.9}, {45.1, 36.4}, {47.4, 30}, {47.4, 32}, {47.5, 30.1}, {47.5, 32.1}, {48, 31.2}, {48.2, 29.3}, {48.6, 29.9}, {48.7, 47.7}, {48.9, 27.9}, {49, 49.7}, {49.1, 26.1}, {49.1, 29.1}, {49.1, 33.3}, {49.5, 25.7}, {49.6, 28}, {50.2, 27.1}, {50.2, 31.4}, {50.2, 31.5}, {50.5, 26.6}, {51.3, 52.2}, {52.6, 33.4}, {52.8, 52.8}, {53.4, 34.4}, {53.4, 34.6}, {53.5, 34.5}, {53.5, 52.9}, {54.1, 33.4}, {54.1, 33.5}, {54.2, 37}, {55.1, 35.3}, {55.6, 38.3}, {55.8, 35.7}, {56.1, 39.2}, {56.6, 50.7}, {56.9, 44.8}, {57.1, 46.1}, {57.2, 39.7}, {58, 50}}, [14] = {{39.2, 63.1}, {39.3, 60.9}, {39.8, 67.6}, {39.9, 66.3}, {40, 64.2}, {40, 65.4}, {40, 66.5}, {40.1, 68.5}, {40.2, 60.6}, {40.4, 70.7}, {41.1, 61.5}, {41.1, 68.4}, {41.2, 58.7}, {41.4, 72.6}, {41.5, 66.2}, {41.5, 72.5}, {42, 62.2}, {42.2, 53.9}, {42.3, 57.1}, {42.6, 54.6}, {42.6, 60.4}, {42.6, 60.5}, {42.7, 59.2}, {42.8, 53}, {42.9, 63}, {43, 52.3}, {43.1, 71.6}, {43.1, 73}, {43.2, 54.2}, {43.4, 58.2}, {43.4, 61.7}, {43.5, 51.9}, {43.5, 61.5}, {43.9, 53.1}, {43.9, 73.3}, {44.4, 54.5}, {44.6, 69.5}, {44.8, 54}, {44.9, 52.6}, {45.1, 55.1}, {45.1, 61.7}, {45.2, 56.5}, {45.2, 71.7}, {45.2, 72.5}, {45.4, 56}, {45.4, 66.1}, {45.5, 55.1}, {45.5, 67.2}, {45.5, 73.8}, {45.6, 56.8}, {45.6, 70.7}, {45.9, 58.7}, {46, 58.1}, {46, 69.7}, {46.1, 66}, {46.2, 59.5}, {46.2, 61.5}, {46.5, 57}, {46.9, 67}, {47.1, 59.2}, {47.2, 69.7}, {47.3, 61.6}, {47.3, 63.3}, {47.6, 64.5}}, [85] = {{23.1, 59.8}, {23.3, 58.8}, {23.8, 58.7}, {23.9, 58}, {24, 60.8}, {24.3, 59.6}, {24.6, 60.5}, {25, 59.2}, {25.3, 59.6}, {25.8, 59.4}, {26.1, 60.3}, {26.2, 60.5}, {27, 59.1}, {27.4, 59.9}, {27.5, 59.9}, {27.7, 57.7}, {28.9, 60.9}, {28.9, 68.8}, {29.1, 64.8}, {29.1, 65.9}, {29.1, 70.8}, {29.3, 63.7}, {29.3, 71.6}, {30.3, 73}, {30.4, 67.3}, {31.3, 67.8}, {31.3, 72.2}, {32.1, 72.2}, {32.2, 55.9}, {32.4, 68.9}, {32.6, 68.9}, {32.8, 71.7}, {33.1, 70.4}, {33.2, 70.5}, {33.8, 70.2}, {34.2, 55.8}, {35.3, 70.5}, {35.4, 70.4}, {35.7, 55.6}, {36.3, 71.3}, {37.3, 62}, {37.9, 70.7}, {38, 57.3}, {38.4, 64.9}, {38.4, 67.8}, {38.5, 65}, {38.5, 67.8}, {38.6, 66.2}, {38.6, 66.5}}},
        },
        [562114] = { -- Mining Tools : https://wowhead.com/forever/object=562114/mining-tools
            [objectKeys.name] = "Mining Tools",
            [objectKeys.spawns] = {[12] = {{60.8, 52.7}, {60.9, 51.4}, {61.2, 51.5}, {61.3, 50.1}, {61.5, 50.2}, {61.5, 51.4}, {61.5, 51.5}, {61.6, 53.3}, {61.7, 53.5}}},
            [objectKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
        },
        [562131] = { -- Applejack Still : https://wowhead.com/forever/object=562131/applejack-still
            [objectKeys.name] = "Applejack Still",
            [objectKeys.spawns] = {[12] = {{24.5, 58.2}}},
            [objectKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
        },
        [563442] = { -- Kobold Tracks : https://wowhead.com/forever/object=563442/kobold-tracks
            [objectKeys.name] = "Kobold Tracks",
            [objectKeys.spawns] = {[12] = {{42.1, 62.5}, {45.4, 50.7}, {45.5, 51.3}, {46, 52.3}, {46.5, 54.4}, {47.8, 45.6}, {47.8, 51.9}}},
            [objectKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
        },
        [565745] = { -- Portal to The Purple Parlor : https://wowhead.com/forever/object=565745/portal-to-the-purple-parlor
            [objectKeys.name] = "Portal to The Purple Parlor",
            [objectKeys.spawns] = {[36] = {{14.4, 57.5}, {14.5, 57.6}}},
            [objectKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [566037] = { -- Charred Remains : https://wowhead.com/forever/object=566037/charred-remains
            [objectKeys.name] = "Charred Remains",
            [objectKeys.spawns] = {[130] = {{65, 34.2}}},
            [objectKeys.zoneID] = zoneIDs.SILVERPINE_FOREST,
        },
        [570207] = { -- Archmage Khadgar : https://wowhead.com/forever/object=570207/archmage-khadgar
            [objectKeys.name] = "Archmage Khadgar",
            [objectKeys.spawns] = {[36] = {{11.1, 63.4}, {11.2, 63.5}}},
            [objectKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [573811] = { -- Gravestone : https://wowhead.com/forever/object=573811/gravestone
            [objectKeys.name] = "Gravestone",
            [objectKeys.spawns] = {[616] = {{62.3, 60.9}}},
            [objectKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [576179] = { -- Supply Cache : https://wowhead.com/forever/object=576179/supply-cache
            [objectKeys.name] = "Supply Cache",
            [objectKeys.spawns] = {[16593] = {{48, 54.6}, {48.5, 55.8}, {49.1, 53.9}, {49.4, 57.1}, {49.5, 54.8}, {49.8, 57.3}, {49.9, 56}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [578266] = { -- Wind Bridge : https://wowhead.com/forever/object=578266/wind-bridge
            [objectKeys.name] = "Wind Bridge",
            [objectKeys.spawns] = {[16593] = {{70.8, 50.1}, {70.8, 50.6}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [578937] = { -- Ripe Stormapple : https://wowhead.com/forever/object=578937/ripe-stormapple
            [objectKeys.name] = "Ripe Stormapple",
            [objectKeys.spawns] = {[16593] = {{46.2, 78.4}, {46.3, 79.3}, {46.4, 80.2}, {46.5, 78.4}, {46.5, 78.5}, {46.6, 80.3}, {46.6, 80.7}, {47.4, 83.1}, {47.5, 83.1}, {48.3, 83.8}, {48.7, 83.6}, {49, 84.5}, {49.1, 83.4}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [578959] = { -- Flutterfly Dust : https://wowhead.com/forever/object=578959/flutterfly-dust
            [objectKeys.name] = "Flutterfly Dust",
            [objectKeys.spawns] = {[16593] = {{46.9, 76.9}, {47.8, 76.5}, {47.9, 76.4}, {48, 79.5}, {48.2, 78.4}, {48.2, 78.5}, {48.4, 73.7}, {48.7, 75.5}, {48.7, 79.1}, {48.9, 82}, {49.4, 74}, {49.5, 77.4}, {50, 75.2}, {50, 81.1}, {50.3, 73.5}, {50.3, 79.7}, {50.4, 77.6}, {50.4, 82.4}, {50.4, 82.5}, {50.5, 77.5}, {50.5, 79.6}, {50.5, 82.6}, {50.8, 80.9}, {51.1, 83.5}, {51.2, 81.8}, {51.4, 76}, {51.5, 77.1}, {51.8, 83.4}, {51.8, 83.5}, {51.9, 82.1}, {52.7, 79.4}, {52.8, 79.7}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [581777] = { -- Suspicious Crate : https://wowhead.com/forever/object=581777/suspicious-crate
            [objectKeys.name] = "Suspicious Crate",
            [objectKeys.spawns] = {[40] = {{41.8, 67.3}, {41.9, 67.6}, {42, 71}, {42.3, 69.6}, {42.4, 68.8}, {42.5, 68.7}, {43.4, 68.2}, {43.5, 67}, {44.4, 68.1}, {44.6, 70.8}, {45.4, 70.2}}},
        },
        [581792] = { -- Detonator : https://wowhead.com/forever/object=581792/detonator
            [objectKeys.name] = "Detonator",
            [objectKeys.spawns] = {[40] = {{38.7, 83.8}}},
            [objectKeys.zoneID] = zoneIDs.WESTFALL,
        },
        [581820] = { -- Dusty Bedroll : https://wowhead.com/forever/object=581820/dusty-bedroll
            [objectKeys.name] = "Dusty Bedroll",
            [objectKeys.spawns] = {[16593] = {{52, 69.4}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [581822] = { -- Bloodstained Satchel : https://wowhead.com/forever/object=581822/bloodstained-satchel
            [objectKeys.name] = "Bloodstained Satchel",
            [objectKeys.spawns] = {[16593] = {{53.3, 72.2}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [586726] = { -- Portal To Rohashi Spires : https://wowhead.com/forever/object=586726/portal-to-rohashi-spires
            [objectKeys.name] = "Portal To Rohashi Spires",
            [objectKeys.spawns] = {[16593] = {{65.3, 50.6}, {65.4, 50.4}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [602722] = { -- Mailbox : https://wowhead.com/forever/object=602722/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[616] = {{69.3, 47.2}, {69.3, 47.7}}},
            [objectKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [610954] = { -- Bounty Available: Vulgara the Insatiable! : https://wowhead.com/forever/object=610954/bounty-available-vulgara-the-insatiable
            [objectKeys.name] = "Bounty Available: Vulgara the Insatiable!",
            [objectKeys.spawns] = {[16593] = {{43.4, 45.8}, {43.5, 45.8}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [612088] = { -- Field Guide : https://wowhead.com/forever/object=612088/field-guide
            [objectKeys.name] = "Field Guide",
            [objectKeys.spawns] = {[10] = {{78.3, 45.3}}, [12] = {{33.5, 51.1}, {42.4, 65.9}}, [17] = {{47, 36.1}}, [33] = {{41, 62.6}}, [40] = {{42.4, 71.2}}, [148] = {{37.5, 43.7}}, [267] = {{50.5, 63.6}}, [331] = {{14.3, 15.2}, {35.4, 49.9}}},
        },
        [612090] = { -- Fishing Rack : https://wowhead.com/forever/object=612090/fishing-rack
            [objectKeys.name] = "Fishing Rack",
            [objectKeys.spawns] = {[17] = {{52, 30.5}}, [28] = {{41.3, 78.2}}},
        },
        [613238] = { -- Zephyrseed Cone : https://wowhead.com/forever/object=613238/zephyrseed-cone
            [objectKeys.name] = "Zephyrseed Cone",
            [objectKeys.spawns] = {[16593] = {{55.7, 39.2}, {55.8, 40.5}, {56.1, 37.9}, {56.1, 39.9}, {56.9, 38.1}, {57, 37.4}, {57, 39.5}, {57.2, 39.2}, {57.5, 37.7}, {57.6, 40.6}, {57.9, 40}, {58.7, 39.9}, {58.8, 38.7}, {59.2, 41.4}, {59.3, 38.3}, {59.5, 39.3}, {59.5, 40.7}, {59.6, 39.5}, {60.1, 37.7}, {60.3, 37.3}, {60.6, 38.6}, {61, 37.7}, {61.2, 35.4}, {61.7, 39.3}, {61.8, 36.4}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [613286] = { -- Raw Windstone : https://wowhead.com/forever/object=613286/raw-windstone
            [objectKeys.name] = "Raw Windstone",
            [objectKeys.spawns] = {[16593] = {{38.3, 30}, {39.4, 27.7}, {40.4, 30.4}, {41.6, 26.9}, {42, 23.8}, {42.9, 22.3}, {42.9, 28.7}, {43.4, 23.8}, {43.5, 23.8}, {43.8, 25.4}, {43.8, 25.5}, {44.1, 22.3}, {44.3, 27.2}, {45, 19.8}, {45.3, 29.1}, {46.6, 17.9}, {46.6, 24.6}, {46.6, 31.1}, {46.7, 28}, {47, 20.9}, {47.2, 23.6}, {47.4, 26.4}, {47.4, 26.5}, {47.5, 26.5}, {48.1, 29.3}, {48.2, 25.7}, {48.3, 19.1}, {49.9, 24.3}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [616466] = { -- Construct Parts : https://wowhead.com/forever/object=616466/construct-parts
            [objectKeys.name] = "Construct Parts",
            [objectKeys.spawns] = {[16593] = {{49.4, 46}, {49.6, 45.9}, {50, 44.8}, {50.7, 44.4}, {50.7, 44.5}, {51.4, 46.6}, {51.6, 46.6}, {52.4, 45.8}, {52.6, 45.9}, {52.8, 49.4}, {52.8, 49.7}, {52.9, 51.7}, {53.1, 47.7}, {53.1, 51.4}, {53.5, 50.4}, {53.6, 50.5}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [616467] = { -- Construct Parts : https://wowhead.com/forever/object=616467/construct-parts
            [objectKeys.name] = "Construct Parts",
            [objectKeys.spawns] = {[16593] = {{43.3, 74.5}, {43.9, 75.4}, {43.9, 75.5}, {44.7, 73.4}, {44.8, 74.2}, {44.8, 76.7}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [616468] = { -- Construct Parts : https://wowhead.com/forever/object=616468/construct-parts
            [objectKeys.name] = "Construct Parts",
            [objectKeys.spawns] = {[16593] = {{51.4, 67.6}, {51.5, 67.6}, {51.9, 65.6}, {51.9, 67.1}, {52.8, 64.8}, {53.2, 65.5}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [616860] = { -- Wind-Infused Bough : https://wowhead.com/forever/object=616860/wind-infused-bough
            [objectKeys.name] = "Wind-Infused Bough",
            [objectKeys.spawns] = {[16593] = {{48.4, 68.2}, {48.7, 67.4}, {48.7, 67.7}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [616907] = { -- Windstone : https://wowhead.com/forever/object=616907/windstone
            [objectKeys.name] = "Windstone",
            [objectKeys.spawns] = {[16593] = {{35.8, 54.9}, {36.5, 44.9}, {39.8, 39.2}, {40.1, 34.4}, {40.4, 37.2}, {40.5, 37.2}, {40.5, 40.6}, {41.1, 34.6}, {41.7, 62.4}, {43.4, 35.3}, {43.5, 47.4}, {43.5, 47.5}, {45, 73.6}, {46.3, 37.9}, {46.4, 81.1}, {46.9, 38.6}, {47.4, 36}, {47.4, 40.3}, {47.5, 36}, {47.5, 40.2}, {48.4, 72.3}, {48.6, 69.4}, {48.8, 36.9}, {48.8, 81}, {49.1, 39.9}, {49.3, 66.8}, {50.4, 54.9}, {50.5, 54.8}, {50.8, 56.3}, {53.5, 66.4}, {53.5, 66.5}, {53.9, 44.3}, {54.7, 81}, {54.8, 44.6}, {55.5, 67.1}, {56, 37.1}, {56.2, 32.2}, {56.3, 59.2}, {56.8, 71.4}, {56.8, 71.5}, {57.7, 51.4}, {58.1, 44.3}, {58.4, 30.4}, {58.4, 30.5}, {58.5, 30.5}, {58.9, 25.3}, {58.9, 35.3}, {59.4, 33.8}, {59.5, 33.8}, {60.3, 49.2}, {61.1, 53.2}, {62.4, 35.4}, {62.6, 63.4}, {62.7, 63.6}, {63, 45.8}, {63.1, 72.1}, {63.9, 38.1}, {64.6, 39.8}, {64.7, 54.3}, {65.9, 36.1}, {69.2, 67.1}, {69.5, 67.7}, {70, 62.3}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [617084] = { -- Portal to Valanaar : https://wowhead.com/forever/object=617084/portal-to-valanaar
            [objectKeys.name] = "Portal to Valanaar",
            [objectKeys.spawns] = {[16593] = {{75.2, 53.3}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [617085] = { -- Portal to Valanaar : https://wowhead.com/forever/object=617085/portal-to-valanaar
            [objectKeys.name] = "Portal to Valanaar",
            [objectKeys.spawns] = {[16593] = {{75.2, 53.3}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [617674] = { -- Arvensus Shadowsong : https://wowhead.com/forever/object=617674/arvensus-shadowsong
            [objectKeys.name] = "Arvensus Shadowsong",
            [objectKeys.spawns] = {[16593] = {{41, 64.1}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [617675] = { -- Raani Windgazer : https://wowhead.com/forever/object=617675/raani-windgazer
            [objectKeys.name] = "Raani Windgazer",
            [objectKeys.spawns] = {[16593] = {{41.1, 64.1}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [617704] = { -- Bloody Note : https://wowhead.com/forever/object=617704/bloody-note
            [objectKeys.name] = "Bloody Note",
            [objectKeys.spawns] = {[16593] = {{42.4, 62}, {42.5, 62.1}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [617839] = { -- Hippogryph Down : https://wowhead.com/forever/object=617839/hippogryph-down
            [objectKeys.name] = "Hippogryph Down",
            [objectKeys.spawns] = {[16593] = {{33.2, 54.4}, {33.2, 54.5}, {34, 55.2}, {34.2, 58}, {34.3, 51.4}, {34.3, 51.5}, {34.6, 52.7}, {35, 57}, {35.1, 54.1}, {35.2, 51.1}, {35.6, 53.1}, {35.7, 57.3}, {35.7, 57.5}, {35.8, 55.3}, {36, 51.9}, {36, 54.2}, {36.7, 59.1}, {36.8, 54.7}, {36.8, 56.8}, {36.9, 52.4}, {36.9, 53.3}, {37.2, 51.2}, {37.6, 58.2}, {37.7, 53}, {37.8, 51}, {38.3, 55.1}, {38.6, 51.8}, {38.6, 56.8}, {38.8, 53.2}, {39, 53.9}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [618329] = { -- Construct Parts : https://wowhead.com/forever/object=618329/construct-parts
            [objectKeys.name] = "Construct Parts",
            [objectKeys.spawns] = {[16593] = {{55.1, 69.5}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [619450] = { -- Lady's Tear Moss : https://wowhead.com/forever/object=619450/ladys-tear-moss
            [objectKeys.name] = "Lady's Tear Moss",
            [objectKeys.spawns] = {[16593] = {{58.7, 40}, {59.1, 38.4}, {59.2, 38.5}, {59.9, 39.3}, {59.9, 40.5}, {60, 40.3}, {60.1, 37.5}, {60.3, 37.4}, {60.8, 38.7}, {60.9, 37.4}, {60.9, 37.5}, {61.2, 35.3}, {61.8, 38.9}, {62, 36.5}, {62.1, 36.4}, {62.7, 39.5}, {62.8, 39.4}, {64.3, 39.3}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [619896] = { -- Forgotten Shrine : https://wowhead.com/forever/object=619896/forgotten-shrine
            [objectKeys.name] = "Forgotten Shrine",
            [objectKeys.questStarts] = {94503},
            [objectKeys.spawns] = {[40] = {{45.4, 60.1}, {45.6, 59.9}}},
        },
        [623295] = { -- Abandonded Belongings : https://wowhead.com/forever/object=623295/abandonded-belongings
            [objectKeys.name] = "Abandonded Belongings",
            [objectKeys.spawns] = {[16593] = {{56.9, 29.4}, {56.9, 33.6}, {57, 33.4}, {57.6, 31}, {57.6, 32.1}, {57.9, 26.9}, {58.4, 32.7}, {58.8, 31.1}, {59.1, 32.3}, {59.1, 34.7}, {59.2, 33.8}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [626718] = { -- Dented Chest : https://wowhead.com/forever/object=626718/dented-chest
            [objectKeys.name] = "Dented Chest",
            [objectKeys.spawns] = {[16593] = {{35.5, 22.5}, {35.8, 33.8}, {35.9, 24.7}, {36.2, 25.5}, {36.4, 33}, {36.5, 33}, {37.2, 26.2}, {37.7, 24.6}, {37.7, 34.6}, {46.9, 17.4}, {46.9, 17.5}, {47.3, 34.5}, {48.5, 20.5}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [626752] = { -- Dented Chest : https://wowhead.com/forever/object=626752/dented-chest
            [objectKeys.name] = "Dented Chest",
            [objectKeys.spawns] = {[16593] = {{35.1, 54.1}, {37.4, 53.7}, {41.9, 66.9}, {43.8, 75.4}, {43.8, 75.5}, {45, 64.5}, {49, 53.5}, {49.5, 56.2}, {49.9, 57.1}, {50, 35.1}, {50.2, 36}, {50.4, 33.1}, {50.6, 44.2}, {50.7, 34.4}, {50.7, 34.5}, {51.8, 72.8}, {55.1, 77.6}, {56, 58.7}, {66, 65.3}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [629596] = { -- Snowdrift : https://wowhead.com/forever/object=629596/snowdrift
            [objectKeys.name] = "Snowdrift",
            [objectKeys.spawns] = {[1] = {{24.3, 44.1}, {24.5, 44.2}, {25, 39.6}, {25.3, 42.7}, {25.4, 40.5}, {25.7, 39.8}, {26.1, 42}, {26.2, 43.1}, {26.2, 43.8}, {26.3, 40.5}, {26.7, 36.2}, {26.8, 42.1}, {27.1, 41.1}, {27.5, 37.4}, {27.5, 37.5}, {27.6, 40.1}, {27.6, 42.8}}},
            [objectKeys.zoneID] = zoneIDs.DUN_MOROGH,
        },
        [630871] = { -- Bottle : https://wowhead.com/forever/object=630871/bottle
            [objectKeys.name] = "Bottle",
            [objectKeys.spawns] = {[85] = {{8.6, 59.5}, {9.2, 59.1}, {9.3, 61.9}, {9.5, 62}, {9.6, 60.6}, {9.6, 63}, {9.8, 59.4}, {10.1, 70.1}}},
            [objectKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
        },
        [630885] = { -- Bottle : https://wowhead.com/forever/object=630885/bottle
            [objectKeys.name] = "Bottle",
            [objectKeys.spawns] = {[85] = {{8.6, 65.6}, {8.7, 67}, {8.9, 64.8}, {9.3, 67.7}, {9.5, 68.1}, {10, 67.2}, {10.3, 65.2}, {10.5, 65.2}, {11.1, 65.7}, {11.2, 66.5}, {11.8, 66.4}, {11.8, 66.5}}},
            [objectKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
        },
        [631197] = { -- Well : https://wowhead.com/forever/object=631197/well
            [objectKeys.name] = "Well",
            [objectKeys.spawns] = {[616] = {{14.2, 49.7}}},
            [objectKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [631299] = { -- Skyborne Portal to Stormwind : https://wowhead.com/forever/object=631299/skyborne-portal-to-stormwind
            [objectKeys.name] = "Skyborne Portal to Stormwind",
            [objectKeys.spawns] = {[36] = {{12.1, 56.4}, {12.1, 56.5}}},
            [objectKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [640104] = { -- Sprung Trap : https://wowhead.com/forever/object=640104/sprung-trap
            [objectKeys.name] = "Sprung Trap",
            [objectKeys.spawns] = {[17] = {{42.7, 13.9}, {42.7, 21.2}, {42.9, 15}, {43.1, 16.4}, {43.9, 14.4}, {43.9, 14.5}, {44.2, 13.1}, {44.8, 16.8}, {45.3, 14}, {45.4, 13.2}, {45.4, 15.3}, {45.5, 15.3}, {46.4, 13}, {47, 12.4}, {47, 13}, {47.6, 12.6}, {47.9, 11.1}, {50.2, 12.7}}},
            [objectKeys.zoneID] = zoneIDs.THE_BARRENS,
        },
        [642320] = { -- Battered Trunk : https://wowhead.com/forever/object=642320/battered-trunk
            [objectKeys.name] = "Battered Trunk",
            [objectKeys.spawns] = {[10] = {{26.2, 36.3}}},
            [objectKeys.zoneID] = zoneIDs.DUSKWOOD,
        },
        [642744] = { -- Mailbox : https://wowhead.com/forever/object=642744/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [644436] = { -- Mailbox : https://wowhead.com/forever/object=644436/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[1497] = {{71, 60.4}, {71.2, 62.6}, {71.3, 63.7}, {71.4, 60.8}, {71.4, 62.4}, {71.7, 62.3}, {71.8, 61}, {71.8, 62.8}}},
        },
        [644437] = { -- Mailbox : https://wowhead.com/forever/object=644437/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[1497] = {{69, 51.8}, {69.4, 50}, {69.5, 50.4}, {69.7, 52.8}, {70, 51.1}}},
            [objectKeys.zoneID] = zoneIDs.UNDERCITY,
        },
        [644438] = { -- Mailbox : https://wowhead.com/forever/object=644438/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[1497] = {{61.2, 51.6}, {62, 50.9}, {62.2, 52.4}, {62.3, 50.4}, {62.6, 52.5}, {62.7, 51.1}, {62.7, 52.4}}},
            [objectKeys.zoneID] = zoneIDs.UNDERCITY,
        },
        [644439] = { -- Mailbox : https://wowhead.com/forever/object=644439/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[1497] = {{61.9, 37}, {62.3, 35.4}, {62.3, 37.5}, {62.4, 35.6}, {62.5, 35.8}, {62.8, 36.5}}},
            [objectKeys.zoneID] = zoneIDs.UNDERCITY,
        },
        [644440] = { -- Mailbox : https://wowhead.com/forever/object=644440/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[1497] = {{69.3, 35.8}, {69.4, 36.9}, {69.7, 35.7}, {69.8, 37.8}, {70.1, 37.4}}},
        },
        [644441] = { -- Mailbox : https://wowhead.com/forever/object=644441/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[1497] = {{66.1, 49.8}, {66.2, 49.2}, {66.9, 49.9}, {67.2, 49.4}}},
        },
        [644442] = { -- Here Lies King Terenas Menethil II : https://wowhead.com/forever/object=644442/here-lies-king-terenas-menethil-ii
            [objectKeys.name] = "Here Lies King Terenas Menethil II",
            [objectKeys.spawns] = {[1497] = {{65.1, 44}, {65.4, 42.8}, {65.5, 42.9}, {66, 44.7}, {66.1, 43.5}, {66.5, 42.7}, {66.7, 44}}},
            [objectKeys.zoneID] = zoneIDs.UNDERCITY,
        },
        [644469] = { -- Worm : https://wowhead.com/forever/object=644469/worm
            [objectKeys.name] = "Worm",
            [objectKeys.spawns] = {[1497] = {{44.7, 62.9}, {44.8, 63.7}, {45.1, 64.7}}},
            [objectKeys.zoneID] = zoneIDs.UNDERCITY,
        },
        [644488] = { -- Mailbox : https://wowhead.com/forever/object=644488/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[1497] = {{67.2, 38.5}, {67.3, 38.4}, {67.5, 38.4}, {67.5, 38.5}}},
        },
        [645153] = { -- Offering Stone : https://wowhead.com/forever/object=645153/offering-stone
            [objectKeys.name] = "Offering Stone",
            [objectKeys.spawns] = {[130] = {{58.1, 69.8}}},
            [objectKeys.zoneID] = zoneIDs.SILVERPINE_FOREST,
        },
        [649051] = { -- Wanted: Incinerator Gar'im : https://wowhead.com/forever/object=649051/wanted-incinerator-garim
            [objectKeys.name] = "Wanted: Incinerator Gar'im",
            [objectKeys.zoneID] = zoneIDs.REDRIDGE_MOUNTAINS,
        },
        [649125] = { -- Grave Marker : https://wowhead.com/forever/object=649125/grave-marker
            [objectKeys.name] = "Grave Marker",
            [objectKeys.spawns] = {[616] = {{22.3, 50.2}}},
            [objectKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [650428] = { -- Mailbox : https://wowhead.com/forever/object=650428/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[1537] = {{70.6, 72.7}}},
        },
        [650518] = { -- The Skull of Tyrannistrasz : https://wowhead.com/forever/object=650518/the-skull-of-tyrannistrasz
            [objectKeys.name] = "The Skull of Tyrannistrasz",
            [objectKeys.spawns] = {[1537] = {{77.3, 27.5}, {77.4, 27.1}}},
            [objectKeys.zoneID] = zoneIDs.IRONFORGE,
        },
        [650519] = { -- Fossilized Egg : https://wowhead.com/forever/object=650519/fossilized-egg
            [objectKeys.name] = "Fossilized Egg",
            [objectKeys.spawns] = {[1537] = {{74.9, 24.1}, {76.2, 24.5}, {76.4, 24.2}}},
            [objectKeys.zoneID] = zoneIDs.IRONFORGE,
        },
        [650520] = { -- Roc Talon : https://wowhead.com/forever/object=650520/roc-talon
            [objectKeys.name] = "Roc Talon",
            [objectKeys.spawns] = {[1537] = {{76.2, 24.3}, {76.5, 23.4}, {76.5, 24.3}}},
            [objectKeys.zoneID] = zoneIDs.IRONFORGE,
        },
        [650521] = { -- Geru Strider : https://wowhead.com/forever/object=650521/geru-strider
            [objectKeys.name] = "Geru Strider",
            [objectKeys.spawns] = {[1537] = {{76.4, 22.3}, {76.6, 22.1}}},
            [objectKeys.zoneID] = zoneIDs.IRONFORGE,
        },
        [650522] = { -- Toothgnasher's Skeleton : https://wowhead.com/forever/object=650522/toothgnashers-skeleton
            [objectKeys.name] = "Toothgnasher's Skeleton",
            [objectKeys.spawns] = {[1537] = {{73.8, 20.2}, {74.1, 21.4}, {74.1, 21.5}, {74.7, 21.7}}},
            [objectKeys.zoneID] = zoneIDs.IRONFORGE,
        },
        [650523] = { -- Saurial Egg : https://wowhead.com/forever/object=650523/saurial-egg
            [objectKeys.name] = "Saurial Egg",
            [objectKeys.spawns] = {[1537] = {{77.8, 22.3}, {78.3, 22.8}}},
            [objectKeys.zoneID] = zoneIDs.IRONFORGE,
        },
        [650524] = { -- Pteradon Skeleton : https://wowhead.com/forever/object=650524/pteradon-skeleton
            [objectKeys.name] = "Pteradon Skeleton",
            [objectKeys.spawns] = {[1537] = {{70.3, 18.4}, {70.9, 18.2}, {71.3, 16.9}, {71.5, 16.7}, {71.7, 17.5}, {72.4, 16.3}}},
            [objectKeys.zoneID] = zoneIDs.IRONFORGE,
        },
        [650525] = { -- Highborne Astrolabe : https://wowhead.com/forever/object=650525/highborne-astrolabe
            [objectKeys.name] = "Highborne Astrolabe",
            [objectKeys.spawns] = {[1537] = {{69.4, 11.4}, {69.5, 9.5}, {69.6, 12}, {69.7, 10.5}}},
            [objectKeys.zoneID] = zoneIDs.IRONFORGE,
        },
        [650526] = { -- Uldaman Relics : https://wowhead.com/forever/object=650526/uldaman-relics
            [objectKeys.name] = "Uldaman Relics",
            [objectKeys.spawns] = {[1537] = {{68.8, 5.5}, {69, 5.3}}},
            [objectKeys.zoneID] = zoneIDs.IRONFORGE,
        },
        [650527] = { -- Horde Catapult : https://wowhead.com/forever/object=650527/horde-catapult
            [objectKeys.name] = "Horde Catapult",
            [objectKeys.spawns] = {[1537] = {{66, 6.8}, {66.7, 7}}},
            [objectKeys.zoneID] = zoneIDs.IRONFORGE,
        },
        [650528] = { -- Uldaman Reliefs : https://wowhead.com/forever/object=650528/uldaman-reliefs
            [objectKeys.name] = "Uldaman Reliefs",
            [objectKeys.spawns] = {[1537] = {{64.1, 3.7}, {64.3, 3.4}, {64.5, 3.5}, {64.6, 2.9}}},
            [objectKeys.zoneID] = zoneIDs.IRONFORGE,
        },
        [650529] = { -- Pteradon Skeleton : https://wowhead.com/forever/object=650529/pteradon-skeleton
            [objectKeys.name] = "Pteradon Skeleton",
            [objectKeys.spawns] = {[1537] = {{71.6, 13}, {72.9, 14}, {73, 13.2}, {73.5, 13.2}, {73.5, 13.6}, {73.7, 12.4}}},
            [objectKeys.zoneID] = zoneIDs.IRONFORGE,
        },
        [650577] = { -- Mailbox : https://wowhead.com/forever/object=650577/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[1537] = {{20, 53}, {21.2, 51.3}, {21.2, 53.5}, {21.3, 53.4}, {21.6, 53.4}}},
            [objectKeys.zoneID] = zoneIDs.IRONFORGE,
        },
        [650593] = { -- Mailbox : https://wowhead.com/forever/object=650593/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[1537] = {{32.2, 64.5}, {32.4, 64.3}, {32.6, 65.2}, {32.7, 64}, {32.8, 65.6}, {33.5, 65.7}}},
        },
        [650666] = { -- Mailbox : https://wowhead.com/forever/object=650666/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[1537] = {{71.4, 48.9}, {71.6, 49.5}, {71.7, 48.5}, {71.8, 48.4}, {72.6, 48.1}, {72.8, 49.8}}},
            [objectKeys.zoneID] = zoneIDs.IRONFORGE,
        },
        [651604] = { -- Mailbox : https://wowhead.com/forever/object=651604/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[36] = {{12.7, 52.4}, {12.8, 52.5}}},
            [objectKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [652323] = { -- Mailbox : https://wowhead.com/forever/object=652323/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[16593] = {{43.3, 44}, {43.5, 44.2}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [652324] = { -- Mailbox : https://wowhead.com/forever/object=652324/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[16593] = {{62.2, 73.6}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [654168] = { -- Skyborne Portal to Dalaran : https://wowhead.com/forever/object=654168/skyborne-portal-to-dalaran
            [objectKeys.name] = "Skyborne Portal to Dalaran",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [654846] = { -- Lost Journal : https://wowhead.com/forever/object=654846/lost-journal
            [objectKeys.name] = "Lost Journal",
            [objectKeys.spawns] = {[141] = {{59.1, 39.4}, {59.1, 39.5}}},
            [objectKeys.zoneID] = zoneIDs.TELDRASSIL,
        },
        [654925] = { -- Lost Journal : https://wowhead.com/forever/object=654925/lost-journal
            [objectKeys.name] = "Lost Journal",
            [objectKeys.spawns] = {[14] = {{42.8, 69.1}}},
            [objectKeys.zoneID] = zoneIDs.DUROTAR,
        },
        [655669] = { -- Mailbox : https://wowhead.com/forever/object=655669/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[616] = {{70.8, 49.8}}},
            [objectKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [656160] = { -- Wilted Peacebloom : https://wowhead.com/forever/object=656160/wilted-peacebloom
            [objectKeys.name] = "Wilted Peacebloom",
            [objectKeys.spawns] = {[1] = {{20.1, 74.8}, {20.6, 72.8}, {20.9, 77.6}, {21.5, 74.4}, {22.2, 72.8}, {22.3, 76.4}, {23, 77.1}, {23.2, 72}, {23.4, 69.4}, {23.4, 69.5}, {23.6, 75.7}, {24.1, 78.2}, {24.6, 70.8}, {25.3, 80.5}, {25.4, 76.7}, {25.5, 76.8}, {25.8, 77.5}, {25.9, 72.4}, {26, 78.9}, {26.3, 72.9}, {26.5, 72.3}, {26.7, 73.3}, {26.9, 78.1}, {26.9, 79.3}, {27.1, 71.3}, {27.7, 77.6}, {27.8, 72.3}, {28, 70.6}, {28.5, 71.7}, {28.5, 77.6}, {29, 70.9}, {29.4, 74.2}, {29.4, 76.9}, {29.5, 76.9}, {29.8, 73.3}, {29.8, 75.7}, {30.7, 75.7}, {31.1, 72.1}, {31.4, 73.1}, {31.5, 69.5}, {31.5, 73.2}, {31.6, 69.4}, {32.2, 72.4}, {32.5, 71.8}, {32.9, 72.7}, {33.6, 71.4}, {33.6, 71.5}}, [12] = {{44.2, 35.4}, {45.3, 31}, {45.4, 38.8}, {45.5, 45.5}, {45.6, 43.1}, {45.7, 45.3}, {45.8, 42.3}, {46.4, 39.8}, {46.7, 32.9}, {46.7, 42.7}, {46.8, 32.2}, {47.3, 46.1}, {48.9, 44.5}, {49.1, 48.3}, {49.4, 45.7}, {49.5, 45.7}, {49.9, 35.3}, {50, 36.9}, {50.4, 31.1}, {50.7, 50.7}, {51.1, 38.7}, {51.2, 41.7}, {51.2, 46.2}, {51.2, 48}, {51.3, 42.9}, {52.3, 46.2}, {52.4, 50.6}, {52.5, 47.7}, {52.6, 41.8}, {52.8, 34.8}, {53.1, 38.3}, {53.2, 52.2}, {53.9, 42.4}, {54.7, 38.5}, {54.8, 37}, {55.8, 39.1}, {55.8, 47.6}, {56, 41.2}, {56.1, 37.3}, {56.5, 48.5}, {56.6, 43.4}, {56.8, 50.4}, {57.5, 40}, {57.5, 46.9}, {57.7, 44.7}}, [14] = {{39, 62}, {39.8, 62.9}, {39.8, 67.1}, {40, 68.2}, {40.5, 69}, {40.6, 60.4}, {40.6, 62.3}, {40.8, 63.8}, {41.2, 58.8}, {41.2, 72.5}, {41.5, 73}, {41.6, 58.6}, {42, 63.2}, {42.5, 73.1}, {42.7, 57.6}, {42.7, 58.6}, {42.9, 56.2}, {43, 64.3}, {43.1, 57.3}, {43.4, 63}, {43.7, 62.7}, {43.8, 65.1}, {44, 67}, {44.2, 57.7}, {44.2, 69.5}, {44.6, 58.2}, {44.6, 64.8}, {44.7, 72.6}, {44.8, 67}, {44.9, 59.6}, {44.9, 61.7}, {45.4, 69}, {45.4, 71}, {45.5, 58.4}, {45.5, 58.5}, {45.5, 69}, {45.7, 64.5}, {45.7, 65.6}, {45.9, 67.6}, {46, 60.7}, {46.2, 63.3}, {46.5, 58.8}, {46.6, 69.7}, {46.9, 60.2}, {46.9, 66.2}, {47.1, 57.4}, {47.1, 57.6}, {47.2, 62.7}, {48, 69.6}}, [85] = {{29.1, 68.7}, {29.2, 62.8}, {29.3, 70.4}, {29.4, 58.9}, {29.9, 72}, {30, 60.9}, {30.3, 69.1}, {30.7, 68.3}, {31, 61.5}, {31.2, 62.6}, {32, 72.6}, {32.1, 70.5}, {32.3, 59.2}, {32.5, 69}, {32.9, 66.4}, {33, 69.6}, {33, 71.7}, {33.1, 56.1}, {33.1, 64.2}, {33.6, 69.1}, {33.7, 58.2}, {34, 63}, {34, 66.1}, {34.3, 61.6}, {34.4, 64.1}, {35, 56.2}, {35, 63.5}, {35.2, 59.4}, {35.4, 68.7}, {35.8, 65.2}, {35.9, 61.8}, {35.9, 62.8}, {35.9, 66.5}, {36.1, 70.2}, {36.4, 57.2}, {36.5, 57.2}, {37.3, 58.5}, {37.3, 67}, {37.5, 71.2}, {37.7, 60.7}, {38.2, 69.4}, {38.2, 69.5}, {38.4, 67.9}, {38.8, 66.8}}, [141] = {{53.3, 38.7}, {53.7, 38}, {53.9, 40.2}, {54.4, 43.5}, {54.4, 46.4}, {54.5, 33}, {54.5, 41.4}, {54.5, 41.5}, {54.6, 40}, {54.7, 43.1}, {54.8, 46.4}, {54.8, 46.5}, {55, 45.2}, {55.3, 37.4}, {55.3, 44.3}, {55.4, 36.3}, {55.5, 36.2}, {55.5, 41.6}, {55.5, 46.5}, {55.9, 32.3}, {56.5, 42.2}, {56.5, 44.1}, {56.8, 33.2}, {57, 37.2}, {57.1, 44.5}, {57.3, 33.5}, {57.4, 42.7}, {57.4, 46.4}, {57.5, 40.5}, {57.5, 43.7}, {58, 35.9}, {58, 38.4}, {58.1, 36.7}, {58.3, 46.3}, {58.9, 41.6}, {59, 46.9}, {59.3, 44.4}, {59.4, 46}, {60, 40.2}, {60.1, 46.1}, {60.3, 32.6}, {60.4, 36.3}, {60.5, 36.3}, {60.8, 30.3}, {60.9, 41.3}, {61, 47.4}, {61.1, 43.5}, {61.3, 38.2}, {61.4, 33.7}, {61.7, 34}, {62.3, 40}, {62.4, 40.7}, {62.5, 45.6}, {63, 36.6}, {63, 40.6}, {63.1, 38}, {63.2, 44.2}, {63.4, 35.4}, {63.8, 37.8}, {65.1, 42.8}}},
        },
        [656161] = { -- Stunted Silverleaf : https://wowhead.com/forever/object=656161/stunted-silverleaf
            [objectKeys.name] = "Stunted Silverleaf",
            [objectKeys.spawns] = {[1] = {{20.1, 74.8}, {20.6, 72.8}, {20.9, 77.7}, {21.4, 74.4}, {21.5, 74.4}, {22.2, 72.8}, {22.2, 76.4}, {22.2, 76.5}, {23, 77.1}, {23.2, 71.9}, {23.4, 69.6}, {23.6, 75.7}, {24.2, 78.1}, {24.6, 70.8}, {25.2, 80.5}, {25.4, 76.6}, {25.5, 76.7}, {25.8, 77.6}, {25.9, 72.2}, {26, 78.9}, {26.3, 72.9}, {26.6, 72.3}, {26.7, 73.3}, {26.8, 79.5}, {26.9, 78.1}, {26.9, 79.4}, {27.2, 71.2}, {27.7, 77.7}, {27.8, 72.3}, {28, 70.6}, {28.5, 71.6}, {28.5, 77.6}, {29, 70.9}, {29.4, 74.1}, {29.5, 74.2}, {29.8, 73.3}, {30.1, 76.4}, {30.1, 76.7}, {30.7, 75.7}, {31.1, 72.2}, {31.5, 69.5}, {32.2, 72.4}, {32.2, 72.5}, {32.5, 71.8}, {32.9, 72.7}, {34.1, 72}}, [12] = {{44.2, 35.3}, {45.3, 31}, {45.4, 38.8}, {45.5, 43.1}, {45.6, 45.4}, {45.9, 42.2}, {46.2, 46.7}, {46.3, 39.7}, {46.5, 39.7}, {46.7, 42.7}, {46.8, 32.1}, {46.8, 33}, {47.4, 46.2}, {48.9, 44.6}, {49.1, 48.3}, {49.4, 45.7}, {49.8, 35.4}, {50, 36.9}, {50.4, 31.1}, {50.8, 34.8}, {51, 38.7}, {51.1, 46.1}, {51.4, 43.1}, {51.9, 49.5}, {52.3, 46.3}, {52.4, 43.4}, {52.4, 43.6}, {52.4, 47.8}, {52.5, 46.3}, {52.5, 50.9}, {52.6, 41.9}, {52.8, 34.8}, {53, 38.2}, {54, 42.5}, {54.1, 42.3}, {55.3, 41}, {55.8, 47.8}, {56.1, 37.3}, {56.5, 48.6}, {56.7, 43.3}, {56.9, 50.3}, {57.5, 46.8}, {57.6, 40.1}, {57.7, 44.7}}, [14] = {{39, 62}, {39.8, 62.9}, {39.8, 67}, {40, 68.2}, {40.5, 69}, {40.6, 60.4}, {40.6, 62.4}, {40.6, 62.5}, {40.8, 63.8}, {41.2, 72.5}, {41.7, 58.6}, {42, 63.2}, {42.4, 73.1}, {42.5, 73.1}, {42.6, 57.8}, {42.7, 58.6}, {42.9, 56.2}, {43, 64.2}, {43.1, 57.3}, {43.4, 63.2}, {43.7, 62.7}, {43.7, 72.4}, {43.7, 72.6}, {43.8, 65.2}, {44, 66.8}, {44.1, 69.6}, {44.2, 57.8}, {44.6, 64.9}, {44.7, 58.3}, {44.7, 72.6}, {44.8, 61.7}, {44.8, 67}, {44.9, 59.6}, {45.4, 69.2}, {45.4, 71.1}, {45.5, 58.4}, {45.5, 58.5}, {45.5, 69}, {45.6, 64.5}, {45.6, 65.7}, {45.7, 63.5}, {45.9, 67.6}, {46, 60.7}, {46.2, 63.4}, {46.5, 58.9}, {46.6, 69.7}, {46.8, 66.3}, {46.9, 60.2}, {47.1, 57.4}, {47.1, 57.6}, {47.2, 62.7}, {47.9, 69.6}}, [85] = {{28.9, 69.2}, {29.3, 63}, {29.3, 70.5}, {29.4, 59.1}, {29.8, 71.9}, {30, 60.9}, {30.2, 68.9}, {30.8, 68.3}, {30.9, 61.5}, {31.2, 62.5}, {32, 70.6}, {32.1, 72.6}, {32.2, 59.2}, {32.8, 66.4}, {33, 69.5}, {33, 71.7}, {33.1, 56.2}, {33.1, 64.2}, {33.6, 58.3}, {33.6, 69}, {33.7, 61.6}, {33.9, 66.1}, {34, 62.9}, {34.3, 63.5}, {34.6, 68.1}, {34.8, 69.2}, {34.9, 56.1}, {35, 63.5}, {35.2, 59.4}, {35.3, 59.5}, {35.7, 65.1}, {35.8, 61.9}, {35.9, 62.7}, {35.9, 66.6}, {36, 70.2}, {36.4, 57.2}, {36.5, 57.2}, {37.1, 56}, {37.1, 60.2}, {37.1, 69.8}, {37.2, 58.5}, {37.4, 66.9}, {37.5, 67}, {37.5, 71.4}, {38.1, 61.4}, {38.2, 69.3}, {38.3, 69.5}, {38.8, 66.8}}, [141] = {{53.3, 38.6}, {53.7, 38}, {53.8, 40.1}, {54.3, 44.2}, {54.4, 45.2}, {54.4, 46.4}, {54.5, 33}, {54.7, 43.1}, {55, 45.2}, {55.2, 40.4}, {55.2, 40.5}, {55.2, 46}, {55.2, 47.3}, {55.3, 37.3}, {55.3, 44.3}, {55.4, 36.3}, {55.4, 41.5}, {55.5, 36.2}, {55.5, 41.6}, {55.5, 46.5}, {55.9, 32.3}, {56.4, 44}, {56.5, 42.2}, {56.5, 44.1}, {56.9, 33.4}, {57.1, 44.5}, {57.2, 37.2}, {57.3, 33.5}, {57.3, 40.5}, {57.4, 42.7}, {57.4, 46.4}, {57.5, 42.7}, {57.5, 43.7}, {58, 35.9}, {58, 38.4}, {58.1, 36.7}, {58.3, 46.3}, {58.6, 46.6}, {58.9, 41.6}, {59.1, 34.1}, {59.4, 44.4}, {59.4, 46.1}, {59.5, 45.9}, {59.7, 32.6}, {59.9, 40.1}, {60.2, 32.4}, {60.3, 45}, {60.4, 36.2}, {60.7, 30.3}, {60.8, 41.4}, {60.9, 43.6}, {61, 33.3}, {61, 47.4}, {61.3, 33.7}, {61.4, 38.2}, {61.7, 34.2}, {62.3, 40}, {62.4, 40.7}, {62.4, 43.6}, {62.5, 45.6}, {63, 36.6}, {63, 37.9}, {63.2, 44.2}, {63.3, 41.2}, {63.4, 35.3}, {63.5, 39.9}, {63.8, 37.8}, {65.2, 42.8}}},
        },
        [656177] = { -- Prickly Pear Fruit : https://wowhead.com/forever/object=656177/prickly-pear-fruit
            [objectKeys.name] = "Prickly Pear Fruit",
            [objectKeys.spawns] = {[14] = {{43.6, 50.5}, {43.8, 50.3}, {44.7, 49.6}, {44.8, 49.4}, {44.9, 50.5}, {46.8, 49}, {47.1, 49.9}, {47.6, 49.7}, {47.7, 48.2}, {47.8, 48.8}, {49, 49.2}, {49.3, 48.1}, {49.5, 47.7}}},
            [objectKeys.zoneID] = zoneIDs.DUROTAR,
        },
        [656180] = { -- Raider's Bow : https://wowhead.com/forever/object=656180/raiders-bow
            [objectKeys.name] = "Raider's Bow",
            [objectKeys.spawns] = {[14] = {{57.3, 57.9}}},
            [objectKeys.zoneID] = zoneIDs.DUROTAR,
        },
        [656181] = { -- Raider's Battleaxe : https://wowhead.com/forever/object=656181/raiders-battleaxe
            [objectKeys.name] = "Raider's Battleaxe",
            [objectKeys.spawns] = {[14] = {{57.4, 56.4}, {57.4, 56.5}, {57.5, 56.4}}},
            [objectKeys.zoneID] = zoneIDs.DUROTAR,
        },
        [656182] = { -- Raider's Shield : https://wowhead.com/forever/object=656182/raiders-shield
            [objectKeys.name] = "Raider's Shield",
            [objectKeys.spawns] = {[14] = {{56.6, 53}}},
            [objectKeys.zoneID] = zoneIDs.DUROTAR,
        },
        [656332] = { -- Chunk of Amber : https://wowhead.com/forever/object=656332/chunk-of-amber
            [objectKeys.name] = "Chunk of Amber",
            [objectKeys.spawns] = {[141] = {{55.5, 28.1}, {55.7, 25.3}, {55.7, 27.2}, {55.9, 26.4}, {55.9, 28.6}, {56.3, 29.7}, {56.4, 30.5}, {56.4, 31.8}, {56.5, 26.4}, {56.5, 30.7}, {56.8, 25.4}, {56.8, 27.8}, {57, 31.8}, {57.2, 29.9}, {57.4, 27.3}, {57.4, 29}, {57.5, 27.4}, {57.5, 29.8}, {57.7, 25.8}, {57.9, 27.8}, {58.2, 28.5}}},
            [objectKeys.zoneID] = zoneIDs.TELDRASSIL,
        },
        [656333] = { -- Large Chunk of Amber : https://wowhead.com/forever/object=656333/large-chunk-of-amber
            [objectKeys.name] = "Large Chunk of Amber",
            [objectKeys.spawns] = {[141] = {{37.2, 22.8}, {37.4, 23.9}, {38, 81.8}, {43, 61.6}, {43.1, 59}, {43.4, 60.6}, {43.6, 81}, {43.7, 61.9}, {44, 57}, {44.1, 59.3}, {44.2, 60.6}, {44.6, 62.6}, {44.7, 57.2}, {44.8, 58.9}, {45.4, 60.2}, {45.7, 57.7}, {46.2, 52.3}, {46.3, 51.2}, {51.1, 51}, {51.3, 49.9}, {51.4, 49.1}, {51.8, 50.1}, {52, 50.9}, {52.3, 48.8}, {52.4, 52.4}, {52.5, 50.2}, {52.8, 49.3}, {53, 78.7}, {53, 79.9}, {53.1, 52}, {53.3, 50.6}, {53.5, 50.1}, {53.6, 48.5}, {53.7, 75.4}, {53.7, 75.5}, {53.9, 51.2}, {54.4, 51.9}, {54.5, 52}, {54.6, 52.6}, {54.7, 51.2}, {70.7, 59.9}, {71.4, 64.8}, {71.6, 51.8}, {71.7, 60.1}}},
            [objectKeys.zoneID] = zoneIDs.TELDRASSIL,
        },
        [656366] = { -- Naxxramas Crystal Fragment : https://wowhead.com/forever/object=656366/naxxramas-crystal-fragment
            [objectKeys.name] = "Naxxramas Crystal Fragment",
            [objectKeys.spawns] = {[85] = {{66.4, 63.6}, {66.9, 64.4}, {66.9, 64.5}, {67.1, 62.4}, {67.3, 62.5}, {67.4, 65.6}, {67.5, 63.2}, {67.9, 66.8}, {68, 64.1}, {68.3, 65.7}, {68.4, 64.5}, {68.5, 64.6}, {68.6, 63}, {69.2, 66}}},
            [objectKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
        },
        [656700] = { -- Mailbox : https://wowhead.com/forever/object=656700/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[33] = {{26.8, 76.5}}},
            [objectKeys.zoneID] = zoneIDs.STRANGLETHORN_VALE,
        },
        [656748] = { -- Mailbox : https://wowhead.com/forever/object=656748/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[33] = {{27.4, 77.5}}},
            [objectKeys.zoneID] = zoneIDs.STRANGLETHORN_VALE,
        },
        [657380] = { -- Silverleaf : https://wowhead.com/forever/object=657380/silverleaf
            [objectKeys.name] = "Silverleaf",
            [objectKeys.zoneID] = zoneIDs.MULGORE,
        },
        [657382] = { -- Peacebloom : https://wowhead.com/forever/object=657382/peacebloom
            [objectKeys.name] = "Peacebloom",
            [objectKeys.spawns] = {[14] = {{36.4, 56.2}, {36.8, 31.8}, {37, 26.5}, {37, 50.1}, {40.6, 19.4}, {42.4, 31.2}, {51.5, 48}, {54.8, 15.4}, {64.1, 74.3}}, [16593] = {{39.6, 46.4}, {41.8, 45.5}, {41.9, 35.3}, {42.8, 40.9}, {43.8, 26.3}, {44.4, 42.9}, {44.9, 27.3}, {45.5, 21.9}, {46.8, 25.6}, {47.1, 73.8}, {47.3, 39.6}, {54.1, 75.7}, {54.2, 70.3}}},
        },
        [657383] = { -- Earthroot : https://wowhead.com/forever/object=657383/earthroot
            [objectKeys.name] = "Earthroot",
            [objectKeys.spawns] = {[14] = {{36.7, 54.6}, {37, 24.7}, {39.2, 25.4}, {41, 16.3}, {46.8, 45.9}, {53.7, 79.9}, {57, 72.1}}, [16593] = {{33.8, 53.3}, {37.2, 43.8}, {39.6, 34.8}, {41.6, 28.8}, {45.9, 29.8}, {48.4, 25.7}, {48.8, 55.3}, {62.8, 54.1}}},
        },
        [657385] = { -- Briarthorn : https://wowhead.com/forever/object=657385/briarthorn
            [objectKeys.name] = "Briarthorn",
            [objectKeys.spawns] = {[40] = {{39.5, 68.2}, {43.7, 70.4}}, [130] = {{50, 35.6}, {53.5, 46.6}}, [331] = {{22.4, 36.2}}, [406] = {{30, 63.7}}},
        },
        [657386] = { -- Bruiseweed : https://wowhead.com/forever/object=657386/bruiseweed
            [objectKeys.name] = "Bruiseweed",
            [objectKeys.spawns] = {[38] = {{73, 49}}, [40] = {{33.7, 73.9}}, [406] = {{76.6, 95.2}}},
        },
        [657394] = { -- Stranglekelp : https://wowhead.com/forever/object=657394/stranglekelp
            [objectKeys.name] = "Stranglekelp",
            [objectKeys.spawns] = {[17] = {{63.3, 38.9}, {64.6, 42.8}, {65.1, 45.4}, {65.4, 37.3}}, [130] = {{38, 80.3}}},
        },
        [657454] = { -- Wilted Peacebloom : https://wowhead.com/forever/object=657454/wilted-peacebloom
            [objectKeys.name] = "Wilted Peacebloom",
            [objectKeys.zoneID] = zoneIDs.MULGORE,
        },
        [657455] = { -- Stunted Silverleaf : https://wowhead.com/forever/object=657455/stunted-silverleaf
            [objectKeys.name] = "Stunted Silverleaf",
            [objectKeys.zoneID] = zoneIDs.MULGORE,
        },
        [657456] = { -- Peacebloom : https://wowhead.com/forever/object=657456/peacebloom
            [objectKeys.name] = "Peacebloom",
            [objectKeys.spawns] = {[17] = {{49.4, 30.1}, {49.4, 36.4}, {57.9, 24.6}}},
            [objectKeys.zoneID] = zoneIDs.THE_BARRENS,
        },
        [657457] = { -- Silverleaf : https://wowhead.com/forever/object=657457/silverleaf
            [objectKeys.name] = "Silverleaf",
            [objectKeys.spawns] = {[17] = {{40.5, 17.2}, {48.1, 36.3}, {48.2, 40.1}, {49.5, 12.8}, {50.1, 33.9}, {52.6, 32.1}, {54.7, 22}, {55.5, 17}, {58.8, 20.5}}},
            [objectKeys.zoneID] = zoneIDs.THE_BARRENS,
        },
        [657458] = { -- Earthroot : https://wowhead.com/forever/object=657458/earthroot
            [objectKeys.name] = "Earthroot",
            [objectKeys.spawns] = {[17] = {{38.2, 27.2}, {39, 17.7}, {39.1, 30.7}, {39.2, 24.5}, {39.6, 28.7}, {39.8, 12.4}, {40.4, 21.5}, {40.8, 29.6}, {41.6, 29.8}, {41.6, 60.5}, {43.2, 78.2}, {44.8, 20.8}, {48, 23}, {50, 17.3}, {59.8, 19.3}, {61.6, 15.9}, {62, 9.6}, {62.3, 30.5}, {62.9, 43.9}, {63.2, 47.1}, {64.9, 44.1}}},
            [objectKeys.zoneID] = zoneIDs.THE_BARRENS,
        },
        [657459] = { -- Mageroyal : https://wowhead.com/forever/object=657459/mageroyal
            [objectKeys.name] = "Mageroyal",
            [objectKeys.spawns] = {[17] = {{39, 15.9}, {40.3, 29.6}, {41, 16}, {42.3, 48.1}, {42.5, 80.8}, {42.8, 25.6}, {42.8, 60.2}, {42.9, 28.5}, {42.9, 55.5}, {43.1, 20.1}, {43.8, 38.4}, {44.1, 63.6}, {44.2, 56.2}, {44.2, 61.1}, {44.4, 15.2}, {44.4, 34.5}, {44.5, 15.2}, {44.5, 19.2}, {45.1, 26.1}, {45.2, 64.1}, {45.9, 63.9}, {46.1, 54.2}, {46.3, 15.8}, {46.4, 24.3}, {47, 36.1}, {47.1, 42.9}, {47.5, 45.2}, {48.2, 74.3}, {48.5, 47.2}, {48.5, 63}, {49.2, 40.9}, {49.3, 23.5}, {51.6, 46.7}, {51.7, 54.2}, {53.3, 15.3}, {53.6, 51.3}, {54.3, 36.4}, {54.4, 39.4}, {54.8, 48.7}, {54.9, 16.8}, {55.7, 13.1}, {56, 5.9}, {56.9, 34.4}, {56.9, 34.5}, {57.5, 16}, {59.9, 22.8}, {59.9, 53.3}, {60.4, 11.1}, {62.1, 15.7}, {62.2, 13}, {63.4, 5.6}}},
            [objectKeys.zoneID] = zoneIDs.THE_BARRENS,
        },
        [657460] = { -- Briarthorn : https://wowhead.com/forever/object=657460/briarthorn
            [objectKeys.name] = "Briarthorn",
            [objectKeys.spawns] = {[17] = {{37.3, 26.8}, {38.2, 13.1}, {38.9, 30.2}, {39, 13.9}, {40.2, 16}, {40.2, 19.4}, {41.6, 24.6}, {42.7, 14.1}, {43.5, 62}, {43.8, 59.8}, {44.4, 21.3}, {44.6, 49.8}, {45.2, 46}, {45.4, 30.8}, {45.5, 36.3}, {52.9, 51.1}, {53.2, 24.4}, {53.3, 24.5}, {53.8, 9.9}, {54.2, 26.9}, {57.4, 52.9}, {57.5, 50.4}, {59.3, 33.6}, {59.4, 38.3}, {60.4, 10.2}, {61.4, 2.9}, {61.4, 41}, {61.4, 47.4}, {61.8, 44.8}, {62.7, 49.4}, {63.4, 46.3}}},
            [objectKeys.zoneID] = zoneIDs.THE_BARRENS,
        },
        [657461] = { -- Bruiseweed : https://wowhead.com/forever/object=657461/bruiseweed
            [objectKeys.name] = "Bruiseweed",
            [objectKeys.spawns] = {[17] = {{43.4, 72.5}, {44.7, 83.5}, {45.1, 36}, {45.4, 86.3}, {45.5, 86.3}, {47.3, 69.3}, {61.9, 3.5}}},
            [objectKeys.zoneID] = zoneIDs.THE_BARRENS,
        },
        [658827] = { -- Mailbox : https://wowhead.com/forever/object=658827/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.zoneID] = zoneIDs.MULGORE,
        },
        [658836] = { -- On the Shal'nan : https://wowhead.com/forever/object=658836/on-the-shalnan
            [objectKeys.name] = "On the Shal'nan",
            [objectKeys.spawns] = {[16593] = {{41.9, 23.3}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [658837] = { -- The Shal'nan's Abdication : https://wowhead.com/forever/object=658837/the-shalnans-abdication
            [objectKeys.name] = "The Shal'nan's Abdication",
            [objectKeys.spawns] = {[16593] = {{45.1, 44.8}, {65.3, 32.9}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [658838] = { -- The Rebellion In Eldre'Thalas, Part 1 : https://wowhead.com/forever/object=658838/the-rebellion-in-eldrethalas-part-1
            [objectKeys.name] = "The Rebellion In Eldre'Thalas, Part 1",
            [objectKeys.spawns] = {[16593] = {{49.8, 56.4}, {49.8, 56.5}, {64.2, 34.3}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [658839] = { -- The Rebellion In Eldre'Thalas, Part 2 : https://wowhead.com/forever/object=658839/the-rebellion-in-eldrethalas-part-2
            [objectKeys.name] = "The Rebellion In Eldre'Thalas, Part 2",
            [objectKeys.spawns] = {[16593] = {{46.6, 82.3}, {64.2, 34.3}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [658840] = { -- The Rebellion In Eldre'Thalas, Part 3 : https://wowhead.com/forever/object=658840/the-rebellion-in-eldrethalas-part-3
            [objectKeys.name] = "The Rebellion In Eldre'Thalas, Part 3",
            [objectKeys.spawns] = {[16593] = {{62.1, 72.6}, {64.6, 35.1}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [658841] = { -- The Rebellion In Eldre'Thalas, Part 4 : https://wowhead.com/forever/object=658841/the-rebellion-in-eldrethalas-part-4
            [objectKeys.name] = "The Rebellion In Eldre'Thalas, Part 4",
            [objectKeys.spawns] = {[16593] = {{64.7, 34.4}, {64.7, 34.5}, {65.8, 50.6}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [658919] = { -- Mailbox : https://wowhead.com/forever/object=658919/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[1637] = {{53.3, 65.5}, {53.4, 65.4}, {53.5, 65}, {53.5, 66}, {53.5, 66.5}}},
        },
        [658920] = { -- Mailbox : https://wowhead.com/forever/object=658920/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[1637] = {{37.8, 75.2}, {38.4, 74.3}, {38.5, 74.5}}},
        },
        [658921] = { -- Mailbox : https://wowhead.com/forever/object=658921/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[1637] = {{81.1, 21.2}, {81.2, 21.6}}},
        },
        [658922] = { -- Mailbox : https://wowhead.com/forever/object=658922/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[1637] = {{47.8, 38}, {48, 38.5}, {48.4, 36.6}, {48.5, 36.4}, {48.6, 37.3}, {48.9, 37.7}}},
        },
        [658923] = { -- Mailbox : https://wowhead.com/forever/object=658923/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[1637] = {{51.4, 59.1}, {51.4, 59.6}, {51.5, 59.7}, {52, 58.7}, {52.1, 58.4}}},
            [objectKeys.zoneID] = zoneIDs.ORGRIMMAR,
        },
        [658924] = { -- Mailbox : https://wowhead.com/forever/object=658924/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[1637] = {{60.4, 54.4}, {60.4, 55.3}, {60.4, 55.6}, {60.5, 55}, {60.6, 55.5}, {60.8, 56.8}}},
            [objectKeys.zoneID] = zoneIDs.ORGRIMMAR,
        },
        [658925] = { -- Mailbox : https://wowhead.com/forever/object=658925/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[1637] = {{45.2, 54.3}, {45.2, 54.5}}},
            [objectKeys.zoneID] = zoneIDs.ORGRIMMAR,
        },
        [658926] = { -- Mailbox : https://wowhead.com/forever/object=658926/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[1637] = {{51.4, 47}, {51.9, 46.4}}},
        },
        [658927] = { -- Mailbox : https://wowhead.com/forever/object=658927/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[1637] = {{49.1, 71.4}, {49.1, 71.6}, {49.9, 70.2}, {49.9, 71.5}, {50.1, 71.4}}},
            [objectKeys.zoneID] = zoneIDs.ORGRIMMAR,
        },
        [658970] = { -- Mailbox : https://wowhead.com/forever/object=658970/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[1637] = {{62, 41}, {62.4, 39.7}, {62.5, 39.9}}},
        },
        [658980] = { -- The Armor of Mannoroth : https://wowhead.com/forever/object=658980/the-armor-of-mannoroth
            [objectKeys.name] = "The Armor of Mannoroth",
            [objectKeys.spawns] = {[1637] = {{45.4, 35}, {45.5, 35}}},
            [objectKeys.zoneID] = zoneIDs.ORGRIMMAR,
        },
        [659159] = { -- Mailbox : https://wowhead.com/forever/object=659159/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[1637] = {{50.4, 70.8}, {50.5, 70.9}, {50.9, 69.9}}},
        },
        [659167] = { -- Horde Military Ranks : https://wowhead.com/forever/object=659167/horde-military-ranks
            [objectKeys.name] = "Horde Military Ranks",
            [objectKeys.spawns] = {[1637] = {{40, 68.1}, {40.6, 68.2}, {41.7, 68}}},
            [objectKeys.zoneID] = zoneIDs.ORGRIMMAR,
        },
        [659308] = { -- Brienne Stormhart : https://wowhead.com/forever/object=659308/brienne-stormhart
            [objectKeys.name] = "Brienne Stormhart",
            [objectKeys.spawns] = {[16591] = {{60, 84.9}}},
            [objectKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [659309] = { -- Sir Howard Armstrong : https://wowhead.com/forever/object=659309/sir-howard-armstrong
            [objectKeys.name] = "Sir Howard Armstrong",
            [objectKeys.spawns] = {[16591] = {{59.9, 85.6}}},
            [objectKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [659310] = { -- Roderick the Unbroken : https://wowhead.com/forever/object=659310/roderick-the-unbroken
            [objectKeys.name] = "Roderick the Unbroken",
            [objectKeys.spawns] = {[16591] = {{59.7, 84.6}}},
            [objectKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [659311] = { -- Rosalind Ashwood : https://wowhead.com/forever/object=659311/rosalind-ashwood
            [objectKeys.name] = "Rosalind Ashwood",
            [objectKeys.spawns] = {[16591] = {{60.1, 85.2}}},
            [objectKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [659313] = { -- Alden Amberhall : https://wowhead.com/forever/object=659313/alden-amberhall
            [objectKeys.name] = "Alden Amberhall",
            [objectKeys.spawns] = {[16591] = {{59.5, 85.2}}},
            [objectKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [659816] = { -- Mailbox : https://wowhead.com/forever/object=659816/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[16591] = {{78.6, 53.8}}},
            [objectKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [659829] = { -- Mailbox : https://wowhead.com/forever/object=659829/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[16591] = {{58.8, 45.3}, {58.8, 45.5}}},
            [objectKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [659837] = { -- Mailbox : https://wowhead.com/forever/object=659837/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[16591] = {{64.4, 83.4}, {64.6, 83.4}, {64.7, 83.7}}},
            [objectKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [660331] = { -- Note : https://wowhead.com/forever/object=660331/note
            [objectKeys.name] = "Note",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [660490] = { -- Bell : https://wowhead.com/forever/object=660490/bell
            [objectKeys.name] = "Bell",
            [objectKeys.spawns] = {[12] = {{49.3, 41.1}, {49.5, 41.4}}},
            [objectKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
        },
        [660647] = { -- Forgotten Loa Idol : https://wowhead.com/forever/object=660647/forgotten-loa-idol
            [objectKeys.name] = "Forgotten Loa Idol",
            [objectKeys.spawns] = {[14] = {{64.6, 84}, {64.7, 83.3}, {64.9, 85.3}, {65, 85.8}, {65.1, 82.2}, {65.2, 87.9}, {65.5, 84.7}, {65.6, 83}, {65.6, 85.8}, {65.7, 87.2}, {66.2, 88.3}, {67, 87.8}, {67.1, 83.5}, {67.2, 86.5}, {67.4, 82.6}, {67.7, 82.1}, {67.8, 81.4}, {68.3, 83.7}, {68.4, 85.7}, {68.5, 84.3}, {68.5, 85.7}, {69, 83}, {69.1, 84.8}}},
            [objectKeys.zoneID] = zoneIDs.DUROTAR,
        },
        [660729] = { -- The Forsaken Ally : https://wowhead.com/forever/object=660729/the-forsaken-ally
            [objectKeys.name] = "The Forsaken Ally",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [660730] = { -- Trollbane Conquests : https://wowhead.com/forever/object=660730/trollbane-conquests
            [objectKeys.name] = "Trollbane Conquests",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [660731] = { -- Field Accounts of Horde Razings : https://wowhead.com/forever/object=660731/field-accounts-of-horde-razings
            [objectKeys.name] = "Field Accounts of Horde Razings",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [660732] = { -- Cycles of Morality : https://wowhead.com/forever/object=660732/cycles-of-morality
            [objectKeys.name] = "Cycles of Morality",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [660739] = { -- Ritual Fire : https://wowhead.com/forever/object=660739/ritual-fire
            [objectKeys.name] = "Ritual Fire",
            [objectKeys.zoneID] = zoneIDs.MULGORE,
        },
        [660848] = { -- Kuramaa's Stump : https://wowhead.com/forever/object=660848/kuramaas-stump
            [objectKeys.name] = "Kuramaa's Stump",
            [objectKeys.spawns] = {[16593] = {{42.5, 68.9}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [660930] = { -- Pile of Complicated Parts : https://wowhead.com/forever/object=660930/pile-of-complicated-parts
            [objectKeys.name] = "Pile of Complicated Parts",
            [objectKeys.spawns] = {[17] = {{61.4, 44.3}, {61.6, 48}, {61.6, 49.1}, {62, 45.2}, {62, 45.9}, {62.2, 44}, {62.2, 47.4}}},
            [objectKeys.zoneID] = zoneIDs.THE_BARRENS,
        },
        [660964] = { -- Misplaced Packages : https://wowhead.com/forever/object=660964/misplaced-packages
            [objectKeys.name] = "Misplaced Packages",
            [objectKeys.spawns] = {[1537] = {{71.9, 47.2}, {72.3, 48.4}, {72.4, 48.5}, {72.5, 48.3}, {72.5, 48.5}}},
            [objectKeys.zoneID] = zoneIDs.IRONFORGE,
        },
        [660999] = { -- Mysterious Letter : https://wowhead.com/forever/object=660999/mysterious-letter
            [objectKeys.name] = "Mysterious Letter",
            [objectKeys.spawns] = {[616] = {{51.4, 72.4}}},
            [objectKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [661092] = { -- Speargrass : https://wowhead.com/forever/object=661092/speargrass
            [objectKeys.name] = "Speargrass",
            [objectKeys.spawns] = {[1637] = {{65.4, 26.4}, {65.4, 26.6}, {65.5, 26.6}, {66, 28.4}, {66.2, 28.8}, {66.2, 29.6}, {67.7, 29.4}, {68, 29.6}, {69.3, 34.3}, {69.3, 34.6}, {69.5, 34.5}, {69.8, 28.6}, {70, 28.4}, {70.4, 29.5}, {70.4, 34.1}, {70.7, 33.9}, {70.8, 28.4}, {70.9, 28.5}, {70.9, 33.2}, {71.2, 32}, {71.4, 30.3}, {71.4, 30.8}, {71.5, 30.4}, {71.5, 30.6}, {71.6, 29.1}}},
            [objectKeys.zoneID] = zoneIDs.ORGRIMMAR,
        },
        [661093] = { -- Cattail : https://wowhead.com/forever/object=661093/cattail
            [objectKeys.name] = "Cattail",
            [objectKeys.spawns] = {[1637] = {{66.1, 28.9}, {66.8, 28.3}, {67.3, 32.9}, {67.6, 32.4}, {67.6, 32.5}, {68.8, 29.8}, {68.8, 35.5}, {69, 35.2}, {69.4, 30.9}, {69.7, 31.2}, {70.4, 28.7}, {70.4, 29.9}, {71, 28.4}, {71.1, 32.4}, {71.1, 32.5}, {71.4, 29.5}, {71.4, 30.8}, {71.5, 29.4}, {71.5, 30.5}, {71.5, 31.7}}},
            [objectKeys.zoneID] = zoneIDs.ORGRIMMAR,
        },
        [661446] = { -- Smooth Boulder : https://wowhead.com/forever/object=661446/smooth-boulder
            [objectKeys.name] = "Smooth Boulder",
            [objectKeys.spawns] = {[1637] = {{38.8, 26.7}, {39.6, 28.3}, {39.7, 29.3}, {39.9, 29.5}, {40.8, 34.4}, {40.8, 34.5}, {41.3, 29.3}, {41.4, 29.9}, {41.5, 29.3}, {41.8, 29.7}, {43.6, 34.6}, {43.9, 40.2}, {43.9, 40.8}, {44.3, 37.9}, {44.5, 38.2}, {44.7, 30.3}, {45, 30.5}, {45.3, 32.7}, {46.9, 32.8}, {47, 40.7}, {47.9, 37.9}, {47.9, 38.6}}},
            [objectKeys.zoneID] = zoneIDs.ORGRIMMAR,
        },
        [661448] = { -- Smooth Boulder : https://wowhead.com/forever/object=661448/smooth-boulder
            [objectKeys.name] = "Smooth Boulder",
            [objectKeys.spawns] = {[1637] = {{39.2, 26.8}, {39.9, 29.3}, {40, 29.8}, {40.2, 27.3}, {40.2, 27.5}, {40.5, 27.9}, {41.3, 34.6}, {41.6, 34.4}, {41.8, 34.6}, {41.9, 31.8}, {42.1, 32.5}, {43.8, 34.6}, {43.9, 34.3}, {43.9, 40.4}, {43.9, 40.5}, {44.3, 37.8}, {44.4, 31.5}, {44.5, 31.8}, {44.5, 38.2}, {44.8, 31.3}, {45.4, 32.7}, {45.5, 32.7}, {46.9, 33}, {47.3, 33.5}, {47.8, 39.6}, {47.9, 38.6}, {48, 38.1}}},
            [objectKeys.zoneID] = zoneIDs.ORGRIMMAR,
        },
        [661449] = { -- Smooth Boulder : https://wowhead.com/forever/object=661449/smooth-boulder
            [objectKeys.name] = "Smooth Boulder",
            [objectKeys.spawns] = {[1637] = {{38.4, 26.8}, {38.6, 26.7}, {39.2, 28.3}, {39.2, 28.5}, {39.6, 28.6}, {39.7, 28.3}, {40, 32.3}, {40.1, 32.5}, {41.1, 34.9}, {41.4, 32}, {41.5, 32.1}, {43.4, 32.3}, {43.4, 34.5}, {43.5, 34.4}, {43.7, 32.7}, {43.7, 40.2}, {43.8, 35}, {43.8, 40.9}, {44, 32.1}, {44.3, 38.6}, {44.4, 38}, {44.5, 38.3}, {45.3, 32.9}, {46.7, 33.1}, {46.9, 39.9}, {47.1, 40.6}, {47.8, 38.6}, {47.9, 37.9}}},
            [objectKeys.zoneID] = zoneIDs.ORGRIMMAR,
        },
        [664122] = { -- Gozwin's Mechanic's Log : https://wowhead.com/forever/object=664122/gozwins-mechanics-log
            [objectKeys.name] = "Gozwin's Mechanic's Log",
            [objectKeys.spawns] = {[1] = {{27.3, 62.8}}},
            [objectKeys.zoneID] = zoneIDs.DUN_MOROGH,
        },
        [665270] = { -- Purple Berry Bush : https://wowhead.com/forever/object=665270/purple-berry-bush
            [objectKeys.name] = "Purple Berry Bush",
            [objectKeys.spawns] = {[406] = {{43.7, 58.2}}},
            [objectKeys.zoneID] = zoneIDs.STONETALON_MOUNTAINS,
        },
        [665282] = { -- Excavation Tools : https://wowhead.com/forever/object=665282/excavation-tools
            [objectKeys.name] = "Excavation Tools",
            [objectKeys.spawns] = {[38] = {{66.3, 66.7}, {67, 67.6}, {68.7, 59.6}, {69.4, 67.5}, {69.5, 67.6}, {69.6, 62.7}, {70.6, 65}, {71.1, 68.3}, {72.4, 61.7}}},
            [objectKeys.zoneID] = zoneIDs.LOCH_MODAN,
        },
        [665289] = { -- Discarded Fishing Toolbox : https://wowhead.com/forever/object=665289/discarded-fishing-toolbox
            [objectKeys.name] = "Discarded Fishing Toolbox",
            [objectKeys.spawns] = {[38] = {{45.6, 43.3}, {48.1, 39.7}, {48.8, 54.5}, {48.9, 54.3}, {50.6, 53.4}}},
            [objectKeys.zoneID] = zoneIDs.LOCH_MODAN,
        },
        [667362] = { -- Mirkweed : https://wowhead.com/forever/object=667362/mirkweed
            [objectKeys.name] = "Mirkweed",
            [objectKeys.spawns] = {[406] = {{46.9, 39.3}, {47.1, 40.9}, {47.1, 41.8}, {47.4, 38.3}, {47.4, 40.1}, {47.5, 38.4}, {47.5, 41}, {47.6, 40.3}, {47.8, 42.4}, {48.2, 42.5}, {48.8, 37.5}, {48.8, 42.3}, {49, 38.5}, {49, 42.7}, {49.6, 40.1}, {49.7, 41.1}}},
            [objectKeys.zoneID] = zoneIDs.STONETALON_MOUNTAINS,
        },
        [667364] = { -- Dried Mirkweed Pile : https://wowhead.com/forever/object=667364/dried-mirkweed-pile
            [objectKeys.name] = "Dried Mirkweed Pile",
            [objectKeys.spawns] = {[406] = {{47.1, 40.2}, {48.8, 37.3}}},
            [objectKeys.zoneID] = zoneIDs.STONETALON_MOUNTAINS,
        },
        [667573] = { -- Knights of the Brotherhood : https://wowhead.com/forever/object=667573/knights-of-the-brotherhood
            [objectKeys.name] = "Knights of the Brotherhood",
            [objectKeys.spawns] = {[16591] = {{63.5, 83.4}, {63.5, 83.5}}},
            [objectKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [667574] = { -- Fern Crimsonleaf : https://wowhead.com/forever/object=667574/fern-crimsonleaf
            [objectKeys.name] = "Fern Crimsonleaf",
            [objectKeys.spawns] = {[16591] = {{61.4, 85.2}}},
            [objectKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [668482] = { -- Gnarlpine Totem : https://wowhead.com/forever/object=668482/gnarlpine-totem
            [objectKeys.name] = "Gnarlpine Totem",
            [objectKeys.spawns] = {[141] = {{54.1, 39.6}, {54.2, 39.4}, {54.5, 44.1}, {55.1, 39.7}, {55.8, 44.3}, {56, 46.1}, {56.2, 39.4}}},
            [objectKeys.zoneID] = zoneIDs.TELDRASSIL,
        },
        [668493] = { -- Gnarlpine Totem : https://wowhead.com/forever/object=668493/gnarlpine-totem
            [objectKeys.name] = "Gnarlpine Totem",
            [objectKeys.spawns] = {[141] = {{54, 38.3}, {54.3, 39.4}, {54.5, 43.7}, {55.5, 37.6}, {55.6, 37.4}, {55.6, 45.3}}},
            [objectKeys.zoneID] = zoneIDs.TELDRASSIL,
        },
        [668544] = { -- A Wartorn Land and The Brotherhood : https://wowhead.com/forever/object=668544/a-wartorn-land-and-the-brotherhood
            [objectKeys.name] = "A Wartorn Land and The Brotherhood",
            [objectKeys.spawns] = {[16591] = {{62.1, 85.6}}},
            [objectKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [670771] = { -- Khaz Modan Timber : https://wowhead.com/forever/object=670771/khaz-modan-timber
            [objectKeys.name] = "Khaz Modan Timber",
            [objectKeys.spawns] = {[11] = {{3.9, 59.8}, {4, 55.2}, {4.7, 50.8}, {5.9, 61.7}, {6, 52.8}, {7.1, 65.6}, {7.9, 50.7}, {8.1, 50.3}, {8.3, 63.4}, {9.1, 64.9}, {10.9, 50.8}, {13.3, 52.3}, {13.6, 60.7}, {14.4, 56.6}, {14.6, 56.5}, {15.4, 53.8}, {15.7, 53.8}}},
            [objectKeys.zoneID] = zoneIDs.WETLANDS,
        },
        [670773] = { -- Khaz Modan Timber : https://wowhead.com/forever/object=670773/khaz-modan-timber
            [objectKeys.name] = "Khaz Modan Timber",
            [objectKeys.spawns] = {[11] = {{3.4, 63.3}, {4.9, 67.5}, {5.1, 67.4}, {5.5, 55.6}, {5.7, 55.3}, {5.8, 58.3}, {5.9, 51.9}, {6.7, 48.3}, {6.7, 48.6}, {9.2, 48}, {12, 53.3}, {14, 53.6}, {16.8, 53.9}, {16.8, 58}}},
            [objectKeys.zoneID] = zoneIDs.WETLANDS,
        },
        [670774] = { -- Khaz Modan Iron : https://wowhead.com/forever/object=670774/khaz-modan-iron
            [objectKeys.name] = "Khaz Modan Iron",
            [objectKeys.spawns] = {[11] = {{3.1, 62.3}, {3.5, 58.6}, {5, 52.3}, {5, 52.6}, {5.3, 56.1}, {6, 58}, {6.3, 47.6}, {6.4, 47.4}, {6.7, 51.5}, {6.8, 51.4}, {7.3, 62.8}, {7.9, 64.4}, {9.4, 46.8}, {9.5, 46.8}, {9.9, 50.9}, {11.4, 53}, {11.5, 53.2}, {14, 52.7}, {14.8, 56.1}, {15.3, 60.6}, {15.9, 52.4}, {15.9, 52.6}, {16.2, 54.2}, {17.4, 58.3}}},
            [objectKeys.zoneID] = zoneIDs.WETLANDS,
        },
        [671154] = { -- Dry Branch : https://wowhead.com/forever/object=671154/dry-branch
            [objectKeys.name] = "Dry Branch",
            [objectKeys.spawns] = {[85] = {{53.8, 51.6}, {54.3, 53.3}, {54.4, 51.2}, {54.4, 53.5}, {54.5, 53.4}, {55.1, 55.4}, {55.1, 55.7}, {55.2, 53.7}, {55.4, 51}, {55.6, 50.9}, {55.9, 52}, {55.9, 57.8}, {56.1, 53.4}, {56.1, 53.5}, {56.2, 50.4}, {56.5, 50.6}, {57, 52.5}, {57.4, 52.3}, {57.4, 58.3}, {57.7, 51.2}, {58, 58.1}, {58.1, 59.2}, {58.8, 52.2}, {58.9, 52.8}, {59.8, 51.4}, {60.1, 51.6}, {60.3, 55}, {62, 53.9}}},
            [objectKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
        },
        [671478] = { -- The Sky-Touched Mystery : https://wowhead.com/forever/object=671478/the-sky-touched-mystery
            [objectKeys.name] = "The Sky-Touched Mystery",
            [objectKeys.spawns] = {[16593] = {{59.4, 34.4}, {59.5, 34.4}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [671479] = { -- On The Windlord : https://wowhead.com/forever/object=671479/on-the-windlord
            [objectKeys.name] = "On The Windlord",
            [objectKeys.spawns] = {[16593] = {{56, 58.7}, {65.7, 34.2}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [672508] = { -- Flintfire's Shipment : https://wowhead.com/forever/object=672508/flintfires-shipment
            [objectKeys.name] = "Flintfire's Shipment",
            [objectKeys.spawns] = {[1] = {{39.1, 46.5}, {39.9, 47.1}, {40.3, 46.4}, {40.7, 45.3}, {40.8, 49.2}, {41, 50.8}, {41.1, 47.2}, {41.4, 45.5}, {41.5, 45.5}, {41.8, 45.3}, {41.8, 52.8}, {42, 46.5}, {42.1, 48.5}, {42.3, 47.5}, {42.6, 50.5}, {42.9, 51.7}, {43.5, 49.4}, {43.5, 49.5}}},
            [objectKeys.zoneID] = zoneIDs.DUN_MOROGH,
        },
        [672518] = { -- Damaged Blue Crystal : https://wowhead.com/forever/object=672518/damaged-blue-crystal
            [objectKeys.name] = "Damaged Blue Crystal",
            [objectKeys.spawns] = {[490] = {{66.3, 75.2}}},
            [objectKeys.zoneID] = zoneIDs.UN_GORO_CRATER,
        },
        [672821] = { -- Relic of the Fang : https://wowhead.com/forever/object=672821/relic-of-the-fang
            [objectKeys.name] = "Relic of the Fang",
            [objectKeys.spawns] = {[493] = {{72.4, 66}, {72.6, 66.1}}},
            [objectKeys.zoneID] = zoneIDs.MOONGLADE,
        },
        [673085] = { -- Tarantula Egg : https://wowhead.com/forever/object=673085/tarantula-egg
            [objectKeys.name] = "Tarantula Egg",
            [objectKeys.zoneID] = zoneIDs.REDRIDGE_MOUNTAINS,
        },
        [673093] = { -- Relic of the Claw : https://wowhead.com/forever/object=673093/relic-of-the-claw
            [objectKeys.name] = "Relic of the Claw",
            [objectKeys.spawns] = {[493] = {{75.2, 67.2}}},
            [objectKeys.zoneID] = zoneIDs.MOONGLADE,
        },
        [673094] = { -- Relic of the Silent Shadow : https://wowhead.com/forever/object=673094/relic-of-the-silent-shadow
            [objectKeys.name] = "Relic of the Silent Shadow",
            [objectKeys.spawns] = {[493] = {{74.4, 65.4}, {74.4, 65.5}, {74.5, 65.1}, {74.5, 65.5}}},
            [objectKeys.zoneID] = zoneIDs.MOONGLADE,
        },
        [673101] = { -- Tarantula Egg : https://wowhead.com/forever/object=673101/tarantula-egg
            [objectKeys.name] = "Tarantula Egg",
            [objectKeys.zoneID] = zoneIDs.REDRIDGE_MOUNTAINS,
        },
        [673376] = { -- Meat Haunch : https://wowhead.com/forever/object=673376/meat-haunch
            [objectKeys.name] = "Meat Haunch",
            [objectKeys.zoneID] = zoneIDs.REDRIDGE_MOUNTAINS,
        },
        [673378] = { -- Oracle Tree Bark : https://wowhead.com/forever/object=673378/oracle-tree-bark
            [objectKeys.name] = "Oracle Tree Bark",
            [objectKeys.spawns] = {[141] = {{37, 34.1}}},
            [objectKeys.zoneID] = zoneIDs.TELDRASSIL,
        },
        [673384] = { -- Water Barrel : https://wowhead.com/forever/object=673384/water-barrel
            [objectKeys.name] = "Water Barrel",
            [objectKeys.zoneID] = zoneIDs.REDRIDGE_MOUNTAINS,
        },
        [673385] = { -- Grain Sack : https://wowhead.com/forever/object=673385/grain-sack
            [objectKeys.name] = "Grain Sack",
            [objectKeys.zoneID] = zoneIDs.REDRIDGE_MOUNTAINS,
        },
        [673390] = { -- Weapon Rack : https://wowhead.com/forever/object=673390/weapon-rack
            [objectKeys.name] = "Weapon Rack",
            [objectKeys.zoneID] = zoneIDs.REDRIDGE_MOUNTAINS,
        },
        [673394] = { -- Great Cat Spirit Statue : https://wowhead.com/forever/object=673394/great-cat-spirit-statue
            [objectKeys.name] = "Great Cat Spirit Statue",
            [objectKeys.spawns] = {[493] = {{71.7, 61.9}}},
            [objectKeys.zoneID] = zoneIDs.MOONGLADE,
        },
        [673399] = { -- Stolen Weapon : https://wowhead.com/forever/object=673399/stolen-weapon
            [objectKeys.name] = "Stolen Weapon",
            [objectKeys.zoneID] = zoneIDs.REDRIDGE_MOUNTAINS,
        },
        [673476] = { -- Abandoned Training Weapon : https://wowhead.com/forever/object=673476/abandoned-training-weapon
            [objectKeys.name] = "Abandoned Training Weapon",
            [objectKeys.spawns] = {[14] = {{40.6, 63.2}, {40.8, 71}, {40.9, 63.9}, {41.2, 62.4}, {41.5, 71.4}, {41.8, 72.3}, {42.2, 63.1}, {42.4, 64.4}, {42.4, 64.5}, {43, 72.6}, {43.2, 71.7}, {43.4, 62.4}, {43.4, 62.5}, {43.5, 72.5}, {43.6, 63.3}, {43.7, 72.4}, {43.8, 66.3}, {44, 67.2}, {44.1, 70.3}, {44.4, 64.6}, {44.4, 71.3}, {44.5, 62}, {44.6, 66.6}, {44.6, 72.6}, {44.9, 65.4}, {45, 63.4}, {45, 63.5}, {45.2, 66.2}, {45.3, 71.2}, {45.4, 59.3}, {45.6, 60.8}, {45.6, 62.8}, {45.7, 64.8}, {45.8, 61.6}, {47.1, 61.7}}},
            [objectKeys.zoneID] = zoneIDs.DUROTAR,
        },
        [673494] = { -- Shredder Operation Instructions : https://wowhead.com/forever/object=673494/shredder-operation-instructions
            [objectKeys.name] = "Shredder Operation Instructions",
            [objectKeys.zoneID] = zoneIDs.MULGORE,
        },
        [673496] = { -- Barrens Operations Best Practices : https://wowhead.com/forever/object=673496/barrens-operations-best-practices
            [objectKeys.name] = "Barrens Operations Best Practices",
            [objectKeys.zoneID] = zoneIDs.MULGORE,
        },
        [673497] = { -- One "Gerenzo", of Stonetalon : https://wowhead.com/forever/object=673497/one-gerenzo-of-stonetalon
            [objectKeys.name] = "One \"Gerenzo\", of Stonetalon",
            [objectKeys.zoneID] = zoneIDs.MULGORE,
        },
        [673515] = { -- Memory of Valor : https://wowhead.com/forever/object=673515/memory-of-valor
            [objectKeys.name] = "Memory of Valor",
            [objectKeys.spawns] = {[10] = {{21.1, 55.6}}},
            [objectKeys.zoneID] = zoneIDs.DUSKWOOD,
        },
        [673933] = { -- Blisterweed : https://wowhead.com/forever/object=673933/blisterweed
            [objectKeys.name] = "Blisterweed",
            [objectKeys.spawns] = {[1497] = {{54, 49.3}, {54.1, 49.5}}},
            [objectKeys.zoneID] = zoneIDs.UNDERCITY,
        },
        [674068] = { -- Burnt Page : https://wowhead.com/forever/object=674068/burnt-page
            [objectKeys.name] = "Burnt Page",
            [objectKeys.spawns] = {[45] = {{22.4, 24.2}, {22.6, 24.5}, {22.7, 24.1}}},
            [objectKeys.zoneID] = zoneIDs.ARATHI_HIGHLANDS,
        },
        [674124] = { -- Traveler's Cache : https://wowhead.com/forever/object=674124/travelers-cache
            [objectKeys.name] = "Traveler's Cache",
            [objectKeys.spawns] = {[33] = {{14.4, 27.2}}},
            [objectKeys.zoneID] = zoneIDs.STRANGLETHORN_VALE,
        },
        [674126] = { -- Hidden Stash : https://wowhead.com/forever/object=674126/hidden-stash
            [objectKeys.name] = "Hidden Stash",
            [objectKeys.spawns] = {[406] = {{40.7, 52.4}, {40.7, 52.7}}},
            [objectKeys.zoneID] = zoneIDs.STONETALON_MOUNTAINS,
        },
        [678414] = { -- Torn Page : https://wowhead.com/forever/object=678414/torn-page
            [objectKeys.name] = "Torn Page",
            [objectKeys.spawns] = {[1497] = {{23, 36.3}, {23.2, 37}, {23.3, 38.5}, {23.5, 36}, {23.6, 35.3}, {24.2, 36.6}}},
            [objectKeys.zoneID] = zoneIDs.UNDERCITY,
        },
        [678602] = { -- Book : https://wowhead.com/forever/object=678602/book
            [objectKeys.name] = "Book",
            [objectKeys.spawns] = {[1497] = {{23, 36.4}, {23.1, 36.5}}},
            [objectKeys.zoneID] = zoneIDs.UNDERCITY,
        },
        [688047] = { -- Lady Isolde Brightlance : https://wowhead.com/forever/object=688047/lady-isolde-brightlance
            [objectKeys.name] = "Lady Isolde Brightlance",
            [objectKeys.spawns] = {[16591] = {{61.3, 84.4}, {61.4, 84.7}, {61.5, 84.5}, {61.6, 84.3}}},
            [objectKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [691558] = { -- Portal to The Violet Citadel : https://wowhead.com/forever/object=691558/portal-to-the-violet-citadel
            [objectKeys.name] = "Portal to The Violet Citadel",
            [objectKeys.spawns] = {[36] = {{15.1, 55.6}}},
            [objectKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [693669] = { -- Weapon Piece : https://wowhead.com/forever/object=693669/weapon-piece
            [objectKeys.name] = "Weapon Piece",
            [objectKeys.spawns] = {[14] = {{60.1, 44.8}}},
            [objectKeys.zoneID] = zoneIDs.DUROTAR,
        },
        [693670] = { -- Strange Debris : https://wowhead.com/forever/object=693670/strange-debris
            [objectKeys.name] = "Strange Debris",
            [objectKeys.spawns] = {[14] = {{60.1, 42.4}, {60.1, 42.6}}},
            [objectKeys.zoneID] = zoneIDs.DUROTAR,
        },
        [693674] = { -- Abandoned Dagger : https://wowhead.com/forever/object=693674/abandoned-dagger
            [objectKeys.name] = "Abandoned Dagger",
            [objectKeys.spawns] = {[14] = {{58.9, 44.4}, {58.9, 44.5}}},
            [objectKeys.zoneID] = zoneIDs.DUROTAR,
        },
        [694054] = { -- Recipe: Raw Plated Armorfish : https://wowhead.com/forever/object=694054/recipe-raw-plated-armorfish
            [objectKeys.name] = "Recipe: Raw Plated Armorfish",
            [objectKeys.spawns] = {[41] = {{52.4, 34.5}, {52.5, 34.3}, {52.5, 34.5}}},
            [objectKeys.zoneID] = zoneIDs.DEADWIND_PASS,
        },
        [694732] = { -- Tomb Weed : https://wowhead.com/forever/object=694732/tomb-weed
            [objectKeys.name] = "Tomb Weed",
            [objectKeys.spawns] = {[85] = {{74.2, 60.2}, {74.4, 61.8}, {74.8, 62.7}, {74.9, 59.3}, {74.9, 61.3}, {75, 59.6}, {75, 62.1}, {75.9, 58.9}, {76, 62.3}, {76.3, 60.8}, {76.4, 59.7}, {76.4, 62.6}, {76.5, 59.7}, {76.6, 62}, {76.9, 60.9}, {77, 62.7}, {77.2, 58.8}, {77.7, 61.4}, {77.7, 61.5}, {77.9, 59.8}}},
            [objectKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
        },
        [694772] = { -- Fishing Trap : https://wowhead.com/forever/object=694772/fishing-trap
            [objectKeys.name] = "Fishing Trap",
            [objectKeys.spawns] = {[12] = {{46.6, 64.7}, {46.9, 65.9}, {47.8, 64}, {47.8, 66.4}, {47.8, 66.5}, {48.3, 58.7}, {48.3, 60.9}, {48.4, 59.5}, {48.4, 63}, {48.4, 67.6}, {48.5, 59.5}, {48.5, 63}, {48.5, 63.5}, {48.6, 59.4}, {48.6, 67.4}, {48.8, 64.7}, {48.8, 66}, {49.4, 68.1}, {49.5, 65.3}, {49.5, 65.5}, {49.5, 67.9}, {49.8, 66.5}}},
            [objectKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
        },
        [694785] = { -- Junk Pile : https://wowhead.com/forever/object=694785/junk-pile
            [objectKeys.name] = "Junk Pile",
            [objectKeys.spawns] = {[12] = {{54.3, 66.8}, {54.5, 66.8}, {54.8, 66}, {55.5, 66}, {55.6, 67}, {56, 67.6}, {56.6, 66.1}, {56.6, 67.3}, {57.4, 67.6}, {57.5, 67.4}, {57.5, 67.5}, {57.8, 66.3}}},
            [objectKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
        },
        [694855] = { -- Overgrown Duskweed : https://wowhead.com/forever/object=694855/overgrown-duskweed
            [objectKeys.name] = "Overgrown Duskweed",
            [objectKeys.spawns] = {[12] = {{31.9, 84.4}, {32, 84.6}, {32, 85.6}, {32.6, 86.1}, {32.8, 84.1}, {33.1, 86.7}, {33.4, 85.4}, {33.5, 85.4}, {34.2, 85.7}, {40.1, 86.4}, {40.1, 86.5}, {40.7, 87}, {41.1, 87.7}, {41.2, 86.1}, {41.4, 84.4}, {41.5, 84.4}, {41.7, 85.4}, {41.7, 85.5}, {42.3, 89.4}, {42.4, 87.4}, {42.4, 87.5}, {42.5, 87.7}, {43.3, 87}}},
            [objectKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
        },
        [694895] = { -- Glowing Crystal Fragment : https://wowhead.com/forever/object=694895/glowing-crystal-fragment
            [objectKeys.name] = "Glowing Crystal Fragment",
            [objectKeys.spawns] = {[85] = {{9.8, 69.3}}},
            [objectKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
        },
        [694934] = { -- Fallen Log : https://wowhead.com/forever/object=694934/fallen-log
            [objectKeys.name] = "Fallen Log",
            [objectKeys.spawns] = {[1] = {{49.8, 51.6}, {50.8, 49.9}, {51.3, 52}, {52.4, 50.4}, {52.4, 50.5}, {52.5, 50.4}, {54, 46.8}, {54.2, 45.3}, {55.4, 45.8}, {55.5, 45.8}, {55.9, 48.6}, {55.9, 53.4}, {56, 52.2}, {56, 53.5}, {56.4, 55.4}, {56.4, 55.5}, {56.5, 55.6}, {56.6, 50.9}, {57, 53.4}, {57, 53.5}, {57.2, 54.9}, {57.4, 46.4}, {57.4, 46.5}, {57.5, 46.4}, {57.6, 48.6}, {58.2, 52}, {58.3, 54.4}, {58.3, 54.5}, {58.3, 56.2}, {58.4, 58.6}, {58.5, 58.6}, {58.6, 57.1}, {59.8, 58.6}, {60.1, 53}}},
            [objectKeys.zoneID] = zoneIDs.DUN_MOROGH,
        },
        [695222] = { -- Coalbeard's Rifle : https://wowhead.com/forever/object=695222/coalbeards-rifle
            [objectKeys.name] = "Coalbeard's Rifle",
            [objectKeys.spawns] = {[1] = {{52.1, 44}}},
            [objectKeys.zoneID] = zoneIDs.DUN_MOROGH,
        },
        [695223] = { -- Sunhammer's Rifle : https://wowhead.com/forever/object=695223/sunhammers-rifle
            [objectKeys.name] = "Sunhammer's Rifle",
            [objectKeys.spawns] = {[1] = {{59.9, 50.1}}},
            [objectKeys.zoneID] = zoneIDs.DUN_MOROGH,
        },
        [695277] = { -- Stoneanvil's Rifle : https://wowhead.com/forever/object=695277/stoneanvils-rifle
            [objectKeys.name] = "Stoneanvil's Rifle",
            [objectKeys.spawns] = {[1] = {{53.2, 58.7}}},
            [objectKeys.zoneID] = zoneIDs.DUN_MOROGH,
        },
        [696267] = { -- Mailbox : https://wowhead.com/forever/object=696267/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696268] = { -- Mailbox : https://wowhead.com/forever/object=696268/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696269] = { -- Mailbox : https://wowhead.com/forever/object=696269/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696270] = { -- Mailbox : https://wowhead.com/forever/object=696270/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696272] = { -- Mailbox : https://wowhead.com/forever/object=696272/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696273] = { -- Mailbox : https://wowhead.com/forever/object=696273/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696275] = { -- Mailbox : https://wowhead.com/forever/object=696275/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696276] = { -- Mailbox : https://wowhead.com/forever/object=696276/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696277] = { -- Mailbox : https://wowhead.com/forever/object=696277/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696278] = { -- Mailbox : https://wowhead.com/forever/object=696278/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696279] = { -- Mailbox : https://wowhead.com/forever/object=696279/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696280] = { -- Mailbox : https://wowhead.com/forever/object=696280/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696281] = { -- Mailbox : https://wowhead.com/forever/object=696281/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696295] = { -- Kurdran Wildhammer : https://wowhead.com/forever/object=696295/kurdran-wildhammer
            [objectKeys.name] = "Kurdran Wildhammer",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696296] = { -- General Turalyon : https://wowhead.com/forever/object=696296/general-turalyon
            [objectKeys.name] = "General Turalyon",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696297] = { -- Ranger Captain Alleria Windrunner : https://wowhead.com/forever/object=696297/ranger-captain-alleria-windrunner
            [objectKeys.name] = "Ranger Captain Alleria Windrunner",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696298] = { -- Danath Trollbane : https://wowhead.com/forever/object=696298/danath-trollbane
            [objectKeys.name] = "Danath Trollbane",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696299] = { -- Archmage Khadgar of the Kirin Tor : https://wowhead.com/forever/object=696299/archmage-khadgar-of-the-kirin-tor
            [objectKeys.name] = "Archmage Khadgar of the Kirin Tor",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696376] = { -- Alliance Military Ranks : https://wowhead.com/forever/object=696376/alliance-military-ranks
            [objectKeys.name] = "Alliance Military Ranks",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696392] = { -- Archbishop Alonsus Faol : https://wowhead.com/forever/object=696392/archbishop-alonsus-faol
            [objectKeys.name] = "Archbishop Alonsus Faol",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696434] = { -- Mailbox : https://wowhead.com/forever/object=696434/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696503] = { -- King Llane I of the House of Wrynn : https://wowhead.com/forever/object=696503/king-llane-i-of-the-house-of-wrynn
            [objectKeys.name] = "King Llane I of the House of Wrynn",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696504] = { -- Grand Admiral Daelin Proudmoore : https://wowhead.com/forever/object=696504/grand-admiral-daelin-proudmoore
            [objectKeys.name] = "Grand Admiral Daelin Proudmoore",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696505] = { -- Lady Mara Fordragon : https://wowhead.com/forever/object=696505/lady-mara-fordragon
            [objectKeys.name] = "Lady Mara Fordragon",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696607] = { -- Mailbox : https://wowhead.com/forever/object=696607/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [697118] = { -- Windstone Formation : https://wowhead.com/forever/object=697118/windstone-formation
            [objectKeys.name] = "Windstone Formation",
            [objectKeys.spawns] = {[16593] = {{47, 69.2}, {47.3, 69.7}, {47.4, 68.3}, {47.7, 70}, {47.8, 67.5}, {48, 69.1}, {48.6, 68.5}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [701788] = { -- Knife : https://wowhead.com/forever/object=701788/knife
            [objectKeys.name] = "Knife",
            [objectKeys.spawns] = {[1497] = {{23, 36.4}, {23, 36.6}, {23.6, 35.2}, {23.7, 36}}},
            [objectKeys.zoneID] = zoneIDs.UNDERCITY,
        },
        [702301] = { -- A Small Pack : https://wowhead.com/forever/object=702301/a-small-pack
            [objectKeys.name] = "A Small Pack",
            [objectKeys.spawns] = {[46] = {{37.3, 26.6}, {37.4, 26.4}}},
            [objectKeys.zoneID] = zoneIDs.BURNING_STEPPES,
        },
    }
end
return ForeverBaseObject
