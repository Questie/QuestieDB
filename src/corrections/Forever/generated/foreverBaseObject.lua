-- Generated delta-base. Apply after inherited Static Corrections, before authored Forever Static Corrections.
-- Import provenance and refresh policy: docs/forever-delta-base.md.
local ForeverBaseObject = QuestieLoader:CreateModule("ForeverBaseObject")
local QuestieDB = QuestieLoader:ImportModule("QuestieDB")
function ForeverBaseObject:Load()
    local objectKeys = QuestieDB.objectKeys
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
        [178404] = { -- Portal to Inner Maraudon : https://wowhead.com/forever/object=178404/portal-to-inner-maraudon
            [objectKeys.name] = "Portal to Inner Maraudon",
        },
        [375548] = { -- Unlit Torch : https://wowhead.com/forever/object=375548/unlit-torch
            [objectKeys.name] = "Unlit Torch",
        },
        [386691] = { -- Library Book : https://wowhead.com/forever/object=386691/library-book
            [objectKeys.name] = "Library Book",
            [objectKeys.spawns] = {[12] = {{65.4, 70.1}}, [1537] = {{75.4, 11}, {75.6, 10.4}, {75.7, 10.5}}},
        },
        [404941] = { -- Relic Coffer : https://wowhead.com/forever/object=404941/relic-coffer
            [objectKeys.name] = "Relic Coffer",
            [objectKeys.spawns] = {[85] = {{52.5, 25.8}}},
        },
        [405201] = { -- Shipwreck Cache : https://wowhead.com/forever/object=405201/shipwreck-cache
            [objectKeys.name] = "Shipwreck Cache",
            [objectKeys.spawns] = {[85] = {{66.7, 24.6}}},
        },
        [405879] = { -- Apothecary Society Primer : https://wowhead.com/forever/object=405879/apothecary-society-primer
            [objectKeys.name] = "Apothecary Society Primer",
            [objectKeys.spawns] = {[85] = {{59.4, 52.3}, {59.5, 52.3}}},
        },
        [406918] = { -- Messenger Bag : https://wowhead.com/forever/object=406918/messenger-bag
            [objectKeys.name] = "Messenger Bag",
            [objectKeys.questStarts] = {79976},
            [objectKeys.questEnds] = {79975},
            [objectKeys.spawns] = {[45] = {{22.4, 24.2}, {22.5, 24.2}}},
        },
        [410345] = { -- Dream Portal : https://wowhead.com/forever/object=410345/dream-portal
            [objectKeys.name] = "Dream Portal",
        },
        [410847] = { -- Rusty Safe : https://wowhead.com/forever/object=410847/rusty-safe
            [objectKeys.name] = "Rusty Safe",
            [objectKeys.spawns] = {[28] = {{59.4, 84.6}, {59.5, 84.5}}},
        },
        [413778] = { -- Dark Ritual Stone : https://wowhead.com/forever/object=413778/dark-ritual-stone
            [objectKeys.name] = "Dark Ritual Stone",
        },
        [414197] = { -- Bough of Shadows : https://wowhead.com/forever/object=414197/bough-of-shadows
            [objectKeys.name] = "Bough of Shadows",
            [objectKeys.spawns] = {[331] = {{89.8, 37.3}, {89.8, 37.5}, {91.2, 37.5}, {92.5, 40.4}, {92.8, 35.7}, {94, 41.7}}},
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
        },
        [415612] = { -- Portal To Zoram Strand : https://wowhead.com/forever/object=415612/portal-to-zoram-strand
            [objectKeys.name] = "Portal To Zoram Strand",
        },
        [417072] = { -- Nailed Plank : https://wowhead.com/forever/object=417072/nailed-plank
            [objectKeys.name] = "Nailed Plank",
            [objectKeys.questStarts] = {79192},
            [objectKeys.questEnds] = {79008},
            [objectKeys.spawns] = {[17] = {{46.4, 73.8}}},
        },
        [420064] = { -- Reconstructed Staff of Des'Altek : https://wowhead.com/forever/object=420064/reconstructed-staff-of-desaltek
            [objectKeys.name] = "Reconstructed Staff of Des'Altek",
        },
        [421526] = { -- Research Notes : https://wowhead.com/forever/object=421526/research-notes
            [objectKeys.name] = "Research Notes",
            [objectKeys.spawns] = {[33] = {{41.4, 50.9}, {41.5, 50.9}}},
        },
        [422911] = { -- Sealed Barrel : https://wowhead.com/forever/object=422911/sealed-barrel
            [objectKeys.name] = "Sealed Barrel",
            [objectKeys.spawns] = {[45] = {{21.3, 84}}},
        },
        [423186] = { -- Shadow Ritual of Sacrifice : https://wowhead.com/forever/object=423186/shadow-ritual-of-sacrifice
            [objectKeys.name] = "Shadow Ritual of Sacrifice",
        },
        [424005] = { -- Pocket Litter : https://wowhead.com/forever/object=424005/pocket-litter
            [objectKeys.name] = "Pocket Litter",
            [objectKeys.questStarts] = {79980},
            [objectKeys.questEnds] = {79192},
            [objectKeys.spawns] = {[406] = {{40.7, 52.4}, {40.8, 52.5}}},
        },
        [424006] = { -- Hastily Rolled-Up Satchel : https://wowhead.com/forever/object=424006/hastily-rolled-up-satchel
            [objectKeys.name] = "Hastily Rolled-Up Satchel",
            [objectKeys.questEnds] = {79976},
            [objectKeys.spawns] = {[45] = {{22.4, 24.2}, {22.5, 24.2}}},
        },
        [424007] = { -- Carved Figurine : https://wowhead.com/forever/object=424007/carved-figurine
            [objectKeys.name] = "Carved Figurine",
            [objectKeys.questStarts] = {79975},
            [objectKeys.questEnds] = {79974},
            [objectKeys.spawns] = {[38] = {{49.4, 12.9}, {49.5, 12.8}}},
        },
        [424010] = { -- Nailed Plank : https://wowhead.com/forever/object=424010/nailed-plank
            [objectKeys.name] = "Nailed Plank",
            [objectKeys.questStarts] = {79192},
            [objectKeys.questEnds] = {79007},
            [objectKeys.spawns] = {[40] = {{37.4, 50.9}, {37.5, 50.8}}},
        },
        [424012] = { -- Mound of Dirt : https://wowhead.com/forever/object=424012/mound-of-dirt
            [objectKeys.name] = "Mound of Dirt",
            [objectKeys.questStarts] = {79974},
            [objectKeys.questEnds] = {79980},
            [objectKeys.spawns] = {[406] = {{39.6, 49.9}}},
        },
        [428349] = { -- Mailbox : https://wowhead.com/forever/object=428349/mailbox
            [objectKeys.name] = "Mailbox",
        },
        [428367] = { -- Mailbox : https://wowhead.com/forever/object=428367/mailbox
            [objectKeys.name] = "Mailbox",
        },
        [439452] = { -- Climbing Rope : https://wowhead.com/forever/object=439452/climbing-rope
            [objectKeys.name] = "Climbing Rope",
        },
        [439628] = { -- Fool's Gold Vein : https://wowhead.com/forever/object=439628/fools-gold-vein
            [objectKeys.name] = "Fool's Gold Vein",
            [objectKeys.spawns] = {[331] = {{79.2, 49.9}, {81.6, 52.1}, {82.7, 45.8}, {84.8, 55.4}, {85.8, 46.7}, {86, 49.7}, {87.7, 64.9}, {88.1, 62.1}, {89, 45.6}, {89.8, 42.9}, {91, 56.3}, {91.3, 37.4}, {91.3, 37.6}, {92.6, 35.2}, {93.4, 42.4}, {93.4, 42.5}, {94.1, 36.6}}},
        },
        [439762] = { -- Star Lotus : https://wowhead.com/forever/object=439762/star-lotus
            [objectKeys.name] = "Star Lotus",
            [objectKeys.spawns] = {[47] = {{45.1, 43.2}, {46.1, 38.4}, {46.1, 38.5}, {49.4, 38}, {49.5, 38}, {57.3, 41.9}, {58.9, 43.4}, {59.1, 43.7}, {61.7, 25.5}, {61.8, 25.3}, {66.1, 42.9}, {66.6, 32.9}, {68.4, 46.6}, {68.5, 46.6}, {70.4, 45.5}, {70.5, 45.4}, {70.5, 45.5}, {71.3, 48.4}, {71.3, 48.5}, {73, 53.2}}},
        },
        [439778] = { -- Starsilver Vein : https://wowhead.com/forever/object=439778/starsilver-vein
            [objectKeys.name] = "Starsilver Vein",
            [objectKeys.spawns] = {[47] = {{45.4, 39.4}, {45.4, 39.5}, {46.9, 34.8}, {48.8, 45.5}, {56.6, 43.3}, {56.9, 43.6}, {57.9, 49.8}, {58.1, 41}, {58.9, 43.2}, {63.7, 43.4}, {63.8, 43.5}, {66.3, 50.7}, {72.2, 52.3}, {73.6, 53.7}}},
        },
        [439810] = { -- Moonroot : https://wowhead.com/forever/object=439810/moonroot
            [objectKeys.name] = "Moonroot",
            [objectKeys.spawns] = {[357] = {{37.4, 17.3}, {37.5, 17.4}, {38.2, 11.1}, {39.1, 11.1}, {40.4, 11.5}, {40.5, 11.4}, {40.5, 11.5}, {41.6, 18.4}, {41.6, 18.5}, {41.9, 13.9}, {44.7, 23.1}, {45.4, 10.9}, {46.5, 18.3}, {50.8, 18.3}, {52, 12.1}, {53.5, 17.4}}},
        },
        [439815] = { -- Greater Moonstone Formation : https://wowhead.com/forever/object=439815/greater-moonstone-formation
            [objectKeys.name] = "Greater Moonstone Formation",
            [objectKeys.spawns] = {[357] = {{37.6, 16.8}, {40.3, 19.7}, {40.8, 9.9}, {40.8, 12.5}, {42.8, 23.2}, {47.4, 21.9}, {47.5, 21.8}, {51, 19.8}, {51.2, 14.8}, {54, 13.4}}},
        },
        [441042] = { -- Climbing Rope : https://wowhead.com/forever/object=441042/climbing-rope
            [objectKeys.name] = "Climbing Rope",
        },
        [441043] = { -- Climbing Rope : https://wowhead.com/forever/object=441043/climbing-rope
            [objectKeys.name] = "Climbing Rope",
        },
        [441248] = { -- Book : https://wowhead.com/forever/object=441248/book
            [objectKeys.name] = "Book",
            [objectKeys.spawns] = {[440] = {{72.6, 47.8}}},
        },
        [442382] = { -- Windswept Shrine : https://wowhead.com/forever/object=442382/windswept-shrine
            [objectKeys.name] = "Windswept Shrine",
        },
        [456796] = { -- Shadow Ritual of Great Sacrifice : https://wowhead.com/forever/object=456796/shadow-ritual-of-great-sacrifice
            [objectKeys.name] = "Shadow Ritual of Great Sacrifice",
        },
        [464854] = { -- Demon Portal : https://wowhead.com/forever/object=464854/demon-portal
            [objectKeys.name] = "Demon Portal",
        },
        [464856] = { -- Demon Portal : https://wowhead.com/forever/object=464856/demon-portal
            [objectKeys.name] = "Demon Portal",
        },
        [477767] = { -- Shadow Ritual of Sacrifice : https://wowhead.com/forever/object=477767/shadow-ritual-of-sacrifice
            [objectKeys.name] = "Shadow Ritual of Sacrifice",
        },
        [478061] = { -- Dark Ritual Stone : https://wowhead.com/forever/object=478061/dark-ritual-stone
            [objectKeys.name] = "Dark Ritual Stone",
        },
        [481624] = { -- Portal To The Future : https://wowhead.com/forever/object=481624/portal-to-the-future
            [objectKeys.name] = "Portal To The Future",
        },
        [494529] = { -- Climbing Rope : https://wowhead.com/forever/object=494529/climbing-rope
            [objectKeys.name] = "Climbing Rope",
        },
    }
end
return ForeverBaseObject
