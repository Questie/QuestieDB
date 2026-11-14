---@class QuestieItemDropGenerated
local QuestieItemDropGenerated = QuestieLoader:CreateModule("QuestieItemDropGenerated")
-------------------------
--Import modules.
-------------------------
---@type DropDB
local DropDB = QuestieLoader:ImportModule("DropDB")

local DropKeys = DropDB.correctionKeys

-- Generated Forever drop overrides (Wowhead Forever XML / listview census).
-- Manual hand-edits belong in itemDropCorrections.lua, which wins on conflict.

QuestieItemDropGenerated.Era = {
    [182] = { -- Garrick's Head; cmangos→Wowhead Forever peer
        [103] = DropKeys.WOWHEAD,
    },
    [742] = { -- A Sycamore Branch; cmangos→Wowhead Forever peer
        [5881] = DropKeys.WOWHEAD,
    },
    [750] = { -- Tough Wolf Meat; cmangos→Wowhead Forever peer
        [69] = DropKeys.WOWHEAD,
        [299] = DropKeys.WOWHEAD,
        [704] = DropKeys.WOWHEAD,
        [705] = DropKeys.WOWHEAD,
    },
    [752] = { -- Red Burlap Bandana; cmangos→Wowhead Forever peer
        [38] = DropKeys.WOWHEAD,
    },
    [772] = { -- Large Candle; cmangos→Wowhead Forever peer
        [40] = DropKeys.WOWHEAD,
        [327] = DropKeys.WOWHEAD,
        [475] = DropKeys.WOWHEAD,
        [476] = DropKeys.WOWHEAD,
    },
    [773] = { -- Gold Dust; cmangos→Wowhead Forever peer
        [40] = DropKeys.WOWHEAD,
        [327] = DropKeys.WOWHEAD,
        [475] = DropKeys.WOWHEAD,
        [476] = DropKeys.WOWHEAD,
    },
    [780] = { -- Torn Murloc Fin; cmangos→Wowhead Forever peer
        [46] = DropKeys.WOWHEAD,
        [732] = DropKeys.WOWHEAD,
    },
    [782] = { -- Painted Gnoll Armband; cmangos→Wowhead Forever peer
        [97] = DropKeys.WOWHEAD,
        [478] = DropKeys.WOWHEAD,
    },
    [829] = { -- Red Leather Bandana
        [121] = DropKeys.WOWHEAD,
        [122] = DropKeys.WOWHEAD,
        [449] = DropKeys.WOWHEAD,
        [450] = DropKeys.WOWHEAD,
        [481] = DropKeys.WOWHEAD,
        [6180] = DropKeys.WOWHEAD,
    },
    [915] = { -- Red Silk Bandana; cmangos→Wowhead Forever peer
        [594] = DropKeys.WOWHEAD,
        [598] = DropKeys.WOWHEAD,
        [619] = DropKeys.WOWHEAD,
        [634] = DropKeys.WOWHEAD,
        [636] = DropKeys.WOWHEAD,
        [657] = DropKeys.WOWHEAD,
        [824] = DropKeys.WOWHEAD,
        [1725] = DropKeys.WOWHEAD,
        [1726] = DropKeys.WOWHEAD,
        [1727] = DropKeys.WOWHEAD,
        [1729] = DropKeys.WOWHEAD,
        [1732] = DropKeys.WOWHEAD,
        [4416] = DropKeys.WOWHEAD,
        [4417] = DropKeys.WOWHEAD,
        [4418] = DropKeys.WOWHEAD,
    },
    [981] = { -- Bernice's Necklace; cmangos→Wowhead Forever peer
        [327] = DropKeys.WOWHEAD,
    },
    [1006] = { -- Brass Collar; cmangos→Wowhead Forever peer
        [330] = DropKeys.WOWHEAD,
    },
    [1013] = { -- Iron Rivet; cmangos→Wowhead Forever peer
        [426] = DropKeys.WOWHEAD,
        [430] = DropKeys.WOWHEAD,
        [446] = DropKeys.WOWHEAD,
        [580] = DropKeys.WOWHEAD,
        [14271] = DropKeys.WOWHEAD,
    },
    [1019] = { -- Red Linen Bandana; cmangos→Wowhead Forever peer
        [116] = DropKeys.WOWHEAD,
        [473] = DropKeys.WOWHEAD,
        [474] = DropKeys.WOWHEAD,
        [583] = DropKeys.WOWHEAD,
        [880] = DropKeys.WOWHEAD,
        [881] = DropKeys.WOWHEAD,
        [6846] = DropKeys.WOWHEAD,
        [6866] = DropKeys.WOWHEAD,
        [6927] = DropKeys.WOWHEAD,
    },
    [1075] = { -- Shadowhide Pendant; cmangos→Wowhead Forever peer
        [429] = DropKeys.WOWHEAD,
        [431] = DropKeys.WOWHEAD,
        [432] = DropKeys.WOWHEAD,
        [433] = DropKeys.WOWHEAD,
        [434] = DropKeys.WOWHEAD,
        [568] = DropKeys.WOWHEAD,
        [579] = DropKeys.WOWHEAD,
        [703] = DropKeys.WOWHEAD,
        [947] = DropKeys.WOWHEAD,
    },
    [1221] = { -- Underbelly Whelp Scale; cmangos→Wowhead Forever peer
        [441] = DropKeys.WOWHEAD,
        [14272] = DropKeys.WOWHEAD,
    },
    [1256] = { -- Crystal Kelp Frond; cmangos→Wowhead Forever peer
        [285] = DropKeys.WOWHEAD,
        [735] = DropKeys.WOWHEAD,
    },
    [1260] = { -- Tharil'zun's Head; cmangos→Wowhead Forever peer
        [486] = DropKeys.WOWHEAD,
    },
    [1261] = { -- Midnight Orb; cmangos→Wowhead Forever peer
        [436] = DropKeys.WOWHEAD,
    },
    [1381] = { -- A Mysterious Message; cmangos→Wowhead Forever peer
        [550] = DropKeys.WOWHEAD,
    },
    [1467] = { -- Spotted Sunfish; cmangos→Wowhead Forever peer
        [422] = DropKeys.WOWHEAD,
        [544] = DropKeys.WOWHEAD,
        [545] = DropKeys.WOWHEAD,
        [548] = DropKeys.WOWHEAD,
        [578] = DropKeys.WOWHEAD,
        [1083] = DropKeys.WOWHEAD,
        [14270] = DropKeys.WOWHEAD,
    },
    [1524] = { -- Skullsplitter Tusk; cmangos→Wowhead Forever peer
        [667] = DropKeys.WOWHEAD,
        [669] = DropKeys.WOWHEAD,
        [670] = DropKeys.WOWHEAD,
        [672] = DropKeys.WOWHEAD,
        [696] = DropKeys.WOWHEAD,
        [780] = DropKeys.WOWHEAD,
        [781] = DropKeys.WOWHEAD,
        [782] = DropKeys.WOWHEAD,
        [783] = DropKeys.WOWHEAD,
        [784] = DropKeys.WOWHEAD,
        [1059] = DropKeys.WOWHEAD,
    },
    [1532] = { -- Shrunken Head; cmangos→Wowhead Forever peer
        [671] = DropKeys.WOWHEAD,
    },
    [1875] = { -- Thistlenettle's Badge; cmangos→Wowhead Forever peer
        [626] = DropKeys.WOWHEAD,
    },
    [1931] = { -- Huge Gnoll Claw; cmangos→Wowhead Forever peer
        [448] = DropKeys.WOWHEAD,
    },
    [1946] = { -- Mary's Looking Glass; cmangos→Wowhead Forever peer
        [511] = DropKeys.WOWHEAD,
    },
    [1968] = { -- Ogre's Monocle; cmangos→Wowhead Forever peer
        [300] = DropKeys.WOWHEAD,
    },
    [2004] = { -- Grelin Whitebeard's Journal; cmangos→Wowhead Forever peer
        [808] = DropKeys.WOWHEAD,
    },
    [2382] = { -- The Embalmer's Heart; cmangos→Wowhead Forever peer
        [314] = DropKeys.WOWHEAD,
    },
    [2466] = { -- Skullsplitter Fetish; cmangos→Wowhead Forever peer
        [670] = DropKeys.WOWHEAD,
        [780] = DropKeys.WOWHEAD,
    },
    [2476] = { -- Chilled Basilisk Haunch; cmangos→Wowhead Forever peer
        [690] = DropKeys.WOWHEAD,
    },
    [2536] = { -- Trogg Stone Tooth; cmangos→Wowhead Forever peer
        [1161] = DropKeys.WOWHEAD,
        [1162] = DropKeys.WOWHEAD,
        [1163] = DropKeys.WOWHEAD,
        [1164] = DropKeys.WOWHEAD,
        [1165] = DropKeys.WOWHEAD,
        [1166] = DropKeys.WOWHEAD,
        [1167] = DropKeys.WOWHEAD,
        [1197] = DropKeys.WOWHEAD,
    },
    [2561] = { -- Chok'sul's Head; cmangos→Wowhead Forever peer
        [1210] = DropKeys.WOWHEAD,
    },
    [2606] = { -- Lurker Venom; cmangos→Wowhead Forever peer
        [1184] = DropKeys.WOWHEAD,
        [1185] = DropKeys.WOWHEAD,
        [1195] = DropKeys.WOWHEAD,
        [14266] = DropKeys.WOWHEAD,
    },
    [2607] = { -- Mo'grosh Crystal; cmangos→Wowhead Forever peer
        [1178] = DropKeys.WOWHEAD,
        [1179] = DropKeys.WOWHEAD,
        [1180] = DropKeys.WOWHEAD,
        [1181] = DropKeys.WOWHEAD,
        [1183] = DropKeys.WOWHEAD,
        [14267] = DropKeys.WOWHEAD,
    },
    [2611] = { -- Crude Flint; cmangos→Wowhead Forever peer
        [1009] = DropKeys.WOWHEAD,
        [1010] = DropKeys.WOWHEAD,
        [1011] = DropKeys.WOWHEAD,
        [1012] = DropKeys.WOWHEAD,
        [1013] = DropKeys.WOWHEAD,
        [1014] = DropKeys.WOWHEAD,
        [14425] = DropKeys.WOWHEAD,
    },
    [2629] = { -- Intrepid Strongbox Key; cmangos→Wowhead Forever peer
        [1160] = DropKeys.WOWHEAD,
    },
    [2636] = { -- Carved Stone Idol; cmangos→Wowhead Forever peer
        [1165] = DropKeys.WOWHEAD,
        [1167] = DropKeys.WOWHEAD,
        [1393] = DropKeys.WOWHEAD,
    },
    [2671] = { -- Wendigo Mane; cmangos→Wowhead Forever peer
        [1134] = DropKeys.WOWHEAD,
        [1135] = DropKeys.WOWHEAD,
        [1137] = DropKeys.WOWHEAD,
    },
    [2702] = { -- Lightforge Ingot; cmangos→Wowhead Forever peer
        [1418] = DropKeys.WOWHEAD,
    },
    [2713] = { -- Ol' Sooty's Head; cmangos→Wowhead Forever peer
        [1225] = DropKeys.WOWHEAD,
    },
    [2797] = { -- Heart of Mokk; cmangos→Wowhead Forever peer
        [1514] = DropKeys.WOWHEAD,
    },
    [2828] = { -- Nissa's Remains; cmangos→Wowhead Forever peer
        [1655] = DropKeys.WOWHEAD,
    },
    [2829] = { -- Gregor's Remains; cmangos→Wowhead Forever peer
        [1654] = DropKeys.WOWHEAD,
    },
    [2830] = { -- Thurman's Remains; cmangos→Wowhead Forever peer
        [1656] = DropKeys.WOWHEAD,
    },
    [2831] = { -- Devlin's Remains; cmangos→Wowhead Forever peer
        [1657] = DropKeys.WOWHEAD,
    },
    [2834] = { -- Embalming Ichor; cmangos→Wowhead Forever peer
        [1674] = DropKeys.WOWHEAD,
        [1675] = DropKeys.WOWHEAD,
        [1941] = DropKeys.WOWHEAD,
    },
    [2855] = { -- Putrid Claw; cmangos→Wowhead Forever peer
        [1525] = DropKeys.WOWHEAD,
        [1526] = DropKeys.WOWHEAD,
    },
    [2856] = { -- Iron Pike; cmangos→Wowhead Forever peer
        [426] = DropKeys.WOWHEAD,
        [430] = DropKeys.WOWHEAD,
        [446] = DropKeys.WOWHEAD,
        [580] = DropKeys.WOWHEAD,
        [14271] = DropKeys.WOWHEAD,
    },
    [2858] = { -- Darkhound Blood; cmangos→Wowhead Forever peer
        [1547] = DropKeys.WOWHEAD,
        [1548] = DropKeys.WOWHEAD,
    },
    [2859] = { -- Vile Fin Scale; cmangos→Wowhead Forever peer
        [1543] = DropKeys.WOWHEAD,
        [1544] = DropKeys.WOWHEAD,
        [1545] = DropKeys.WOWHEAD,
    },
    [2872] = { -- Vicious Night Web Spider Venom; cmangos→Wowhead Forever peer
        [1555] = DropKeys.WOWHEAD,
    },
    [2875] = { -- Scarlet Insignia Ring; cmangos→Wowhead Forever peer
        [1535] = DropKeys.WOWHEAD,
        [1536] = DropKeys.WOWHEAD,
        [1537] = DropKeys.WOWHEAD,
        [1538] = DropKeys.WOWHEAD,
        [1539] = DropKeys.WOWHEAD,
        [1540] = DropKeys.WOWHEAD,
        [1660] = DropKeys.WOWHEAD,
        [1662] = DropKeys.WOWHEAD,
        [1664] = DropKeys.WOWHEAD,
        [1665] = DropKeys.WOWHEAD,
    },
    [2876] = { -- Duskbat Pelt; cmangos→Wowhead Forever peer
        [1553] = DropKeys.WOWHEAD,
        [1554] = DropKeys.WOWHEAD,
    },
    [2885] = { -- Scarlet Crusade Documents; cmangos→Wowhead Forever peer
        [1667] = DropKeys.WOWHEAD,
    },
    [2909] = { -- Red Wool Bandana; cmangos→Wowhead Forever peer
        [1663] = DropKeys.WOWHEAD,
        [1706] = DropKeys.WOWHEAD,
        [1707] = DropKeys.WOWHEAD,
        [1708] = DropKeys.WOWHEAD,
        [1711] = DropKeys.WOWHEAD,
        [1715] = DropKeys.WOWHEAD,
        [1716] = DropKeys.WOWHEAD,
        [1720] = DropKeys.WOWHEAD,
    },
    [2925] = { -- Crocolisk Skin; cmangos→Wowhead Forever peer
        [1693] = DropKeys.WOWHEAD,
        [2476] = DropKeys.WOWHEAD,
    },
    [2926] = { -- Head of Bazil Thredd; cmangos→Wowhead Forever peer
        [1716] = DropKeys.WOWHEAD,
    },
    [2939] = { -- Crocolisk Tear; cmangos→Wowhead Forever peer
        [1693] = DropKeys.WOWHEAD,
        [2476] = DropKeys.WOWHEAD,
    },
    [3014] = { -- Battleworn Axe; cmangos→Wowhead Forever peer
        [435] = DropKeys.WOWHEAD,
        [436] = DropKeys.WOWHEAD,
        [437] = DropKeys.WOWHEAD,
        [440] = DropKeys.WOWHEAD,
        [485] = DropKeys.WOWHEAD,
        [615] = DropKeys.WOWHEAD,
        [4064] = DropKeys.WOWHEAD,
        [4065] = DropKeys.WOWHEAD,
        [4462] = DropKeys.WOWHEAD,
        [4463] = DropKeys.WOWHEAD,
        [4464] = DropKeys.WOWHEAD,
    },
    [3082] = { -- Dargol's Skull; cmangos→Wowhead Forever peer
        [1658] = DropKeys.WOWHEAD,
    },
    [3083] = { -- Restabilization Cog; cmangos→Wowhead Forever peer
        [1211] = DropKeys.WOWHEAD,
        [8503] = DropKeys.WOWHEAD,
    },
    [3084] = { -- Gyromechanic Gear; cmangos→Wowhead Forever peer
        [1211] = DropKeys.WOWHEAD,
        [8503] = DropKeys.WOWHEAD,
    },
    [3110] = { -- Tunnel Rat Ear; cmangos→Wowhead Forever peer
        [1172] = DropKeys.WOWHEAD,
        [1173] = DropKeys.WOWHEAD,
        [1174] = DropKeys.WOWHEAD,
        [1175] = DropKeys.WOWHEAD,
        [1176] = DropKeys.WOWHEAD,
        [1177] = DropKeys.WOWHEAD,
    },
    [3156] = { -- Glutton Shackle; cmangos→Wowhead Forever peer
        [1779] = DropKeys.WOWHEAD,
    },
    [3157] = { -- Darksoul Shackle; cmangos→Wowhead Forever peer
        [1782] = DropKeys.WOWHEAD,
    },
    [3162] = { -- Notched Rib; cmangos→Wowhead Forever peer
        [1520] = DropKeys.WOWHEAD,
        [1523] = DropKeys.WOWHEAD,
    },
    [3163] = { -- Blackened Skull; cmangos→Wowhead Forever peer
        [1522] = DropKeys.WOWHEAD,
    },
    [3183] = { -- Mangy Claw; cmangos→Wowhead Forever peer
        [1961] = DropKeys.WOWHEAD,
    },
    [3218] = { -- Pyrewood Shackle; cmangos→Wowhead Forever peer
        [1891] = DropKeys.WOWHEAD,
        [1892] = DropKeys.WOWHEAD,
        [1893] = DropKeys.WOWHEAD,
        [1894] = DropKeys.WOWHEAD,
        [1895] = DropKeys.WOWHEAD,
        [1896] = DropKeys.WOWHEAD,
        [3528] = DropKeys.WOWHEAD,
        [3529] = DropKeys.WOWHEAD,
        [3530] = DropKeys.WOWHEAD,
        [3531] = DropKeys.WOWHEAD,
        [3532] = DropKeys.WOWHEAD,
        [3533] = DropKeys.WOWHEAD,
    },
    [3236] = { -- Rot Hide Ichor; cmangos→Wowhead Forever peer
        [1939] = DropKeys.WOWHEAD,
        [1940] = DropKeys.WOWHEAD,
        [1942] = DropKeys.WOWHEAD,
        [1943] = DropKeys.WOWHEAD,
        [1944] = DropKeys.WOWHEAD,
    },
    [3253] = { -- Grizzled Bear Heart; cmangos→Wowhead Forever peer
        [1778] = DropKeys.WOWHEAD,
        [1797] = DropKeys.WOWHEAD,
        [12432] = DropKeys.WOWHEAD,
    },
    [3254] = { -- Skittering Blood; cmangos→Wowhead Forever peer
        [1780] = DropKeys.WOWHEAD,
        [1781] = DropKeys.WOWHEAD,
        [12433] = DropKeys.WOWHEAD,
    },
    [3256] = { -- Lake Skulker Moss; cmangos→Wowhead Forever peer
        [1953] = DropKeys.WOWHEAD,
        [1954] = DropKeys.WOWHEAD,
    },
    [3257] = { -- Lake Creeper Moss; cmangos→Wowhead Forever peer
        [1955] = DropKeys.WOWHEAD,
        [1956] = DropKeys.WOWHEAD,
    },
    [3258] = { -- Hardened Tumor; cmangos→Wowhead Forever peer
        [1767] = DropKeys.WOWHEAD,
        [1768] = DropKeys.WOWHEAD,
        [1908] = DropKeys.WOWHEAD,
        [1909] = DropKeys.WOWHEAD,
        [1957] = DropKeys.WOWHEAD,
        [1958] = DropKeys.WOWHEAD,
    },
    [3264] = { -- Duskbat Wing; cmangos→Wowhead Forever peer
        [1512] = DropKeys.WOWHEAD,
        [1513] = DropKeys.WOWHEAD,
    },
    [3265] = { -- Scavenger Paw; cmangos→Wowhead Forever peer
        [1508] = DropKeys.WOWHEAD,
        [1509] = DropKeys.WOWHEAD,
    },
    [3266] = { -- Scarlet Armband; cmangos→Wowhead Forever peer
        [1506] = DropKeys.WOWHEAD,
        [1507] = DropKeys.WOWHEAD,
        [1667] = DropKeys.WOWHEAD,
    },
    [3297] = { -- Fel Moss
        [1989] = DropKeys.WOWHEAD,
    },
    [3337] = { -- Dragonmaw War Banner; cmangos→Wowhead Forever peer
        [1034] = DropKeys.WOWHEAD,
        [1035] = DropKeys.WOWHEAD,
        [1036] = DropKeys.WOWHEAD,
        [1037] = DropKeys.WOWHEAD,
        [1038] = DropKeys.WOWHEAD,
        [1057] = DropKeys.WOWHEAD,
        [2091] = DropKeys.WOWHEAD,
    },
    [3349] = { -- Sida's Bag; cmangos→Wowhead Forever peer
        [1031] = DropKeys.WOWHEAD,
        [1032] = DropKeys.WOWHEAD,
        [1033] = DropKeys.WOWHEAD,
    },
    [3354] = { -- Dalaran Pendant; cmangos→Wowhead Forever peer
        [1912] = DropKeys.WOWHEAD,
        [1914] = DropKeys.WOWHEAD,
        [1915] = DropKeys.WOWHEAD,
    },
    [3397] = { -- Young Crocolisk Skin; cmangos→Wowhead Forever peer
        [1417] = DropKeys.WOWHEAD,
    },
    [3409] = { -- Nightsaber Fang; cmangos→Wowhead Forever peer
        [2042] = DropKeys.WOWHEAD,
        [2043] = DropKeys.WOWHEAD,
        [14430] = DropKeys.WOWHEAD,
    },
    [3411] = { -- Strigid Owl Feather; cmangos→Wowhead Forever peer
        [1995] = DropKeys.WOWHEAD,
        [1996] = DropKeys.WOWHEAD,
    },
    [3412] = { -- Webwood Spider Silk; cmangos→Wowhead Forever peer
        [1998] = DropKeys.WOWHEAD,
        [1999] = DropKeys.WOWHEAD,
        [2000] = DropKeys.WOWHEAD,
    },
    [3467] = { -- Dull Iron Key; cmangos→Wowhead Forever peer
        [2427] = DropKeys.WOWHEAD,
    },
    [3496] = { -- Mountain Lion Blood; cmangos→Wowhead Forever peer
        [2384] = DropKeys.WOWHEAD,
        [2385] = DropKeys.WOWHEAD,
        [2406] = DropKeys.WOWHEAD,
        [2407] = DropKeys.WOWHEAD,
    },
    [3499] = { -- Burnished Gold Key; cmangos→Wowhead Forever peer
        [2428] = DropKeys.WOWHEAD,
    },
    [3505] = { -- Alterac Signet Ring; cmangos→Wowhead Forever peer
        [2242] = DropKeys.WOWHEAD,
        [2243] = DropKeys.WOWHEAD,
        [2245] = DropKeys.WOWHEAD,
        [2246] = DropKeys.WOWHEAD,
        [2247] = DropKeys.WOWHEAD,
        [2319] = DropKeys.WOWHEAD,
        [14221] = DropKeys.WOWHEAD,
    },
    [3509] = { -- Daggerspine Scale; cmangos→Wowhead Forever peer
        [2368] = DropKeys.WOWHEAD,
        [2369] = DropKeys.WOWHEAD,
        [2370] = DropKeys.WOWHEAD,
        [2371] = DropKeys.WOWHEAD,
        [14277] = DropKeys.WOWHEAD,
    },
    [3510] = { -- Torn Fin Eye; cmangos→Wowhead Forever peer
        [2374] = DropKeys.WOWHEAD,
        [2375] = DropKeys.WOWHEAD,
        [2376] = DropKeys.WOWHEAD,
        [2377] = DropKeys.WOWHEAD,
        [14276] = DropKeys.WOWHEAD,
    },
    [3514] = { -- Mor'Ladim's Skull; cmangos→Wowhead Forever peer
        [522] = DropKeys.WOWHEAD,
    },
    [3515] = { -- Ataeric's Staff; cmangos→Wowhead Forever peer
        [2120] = DropKeys.WOWHEAD,
    },
    [3550] = { -- Targ's Head; cmangos→Wowhead Forever peer
        [2420] = DropKeys.WOWHEAD,
    },
    [3551] = { -- Muckrake's Head; cmangos→Wowhead Forever peer
        [2421] = DropKeys.WOWHEAD,
    },
    [3552] = { -- Glommus's Head; cmangos→Wowhead Forever peer
        [2422] = DropKeys.WOWHEAD,
    },
    [3553] = { -- Mug'thol's Head; cmangos→Wowhead Forever peer
        [2257] = DropKeys.WOWHEAD,
    },
    [3554] = { -- Crown of Will; cmangos→Wowhead Forever peer
        [2257] = DropKeys.WOWHEAD,
    },
    [3601] = { -- Syndicate Missive; cmangos→Wowhead Forever peer
        [2240] = DropKeys.WOWHEAD,
        [2241] = DropKeys.WOWHEAD,
    },
    [3613] = { -- Valdred's Hands; cmangos→Wowhead Forever peer
        [2332] = DropKeys.WOWHEAD,
    },
    [3614] = { -- Yowler's Paw; cmangos→Wowhead Forever peer
        [518] = DropKeys.WOWHEAD,
    },
    [3615] = { -- Kurzen's Head; cmangos→Wowhead Forever peer
        [813] = DropKeys.WOWHEAD,
    },
    [3616] = { -- Mind's Eye; cmangos→Wowhead Forever peer
        [818] = DropKeys.WOWHEAD,
    },
    [3617] = { -- Pendant of Shadow; cmangos→Wowhead Forever peer
        [397] = DropKeys.WOWHEAD,
    },
    [3618] = { -- Gobbler's Head; cmangos→Wowhead Forever peer
        [1259] = DropKeys.WOWHEAD,
    },
    [3619] = { -- Snellig's Snuffbox; cmangos→Wowhead Forever peer
        [1159] = DropKeys.WOWHEAD,
    },
    [3621] = { -- Ivar's Head; cmangos→Wowhead Forever peer
        [1971] = DropKeys.WOWHEAD,
    },
    [3622] = { -- Essence of Nightlash; cmangos→Wowhead Forever peer
        [1983] = DropKeys.WOWHEAD,
    },
    [3623] = { -- Thule's Head; cmangos→Wowhead Forever peer
        [1947] = DropKeys.WOWHEAD,
    },
    [3625] = { -- Nek'rosh's Head; cmangos→Wowhead Forever peer
        [2091] = DropKeys.WOWHEAD,
    },
    [3626] = { -- Head of Baron Vardus; cmangos→Wowhead Forever peer
        [2306] = DropKeys.WOWHEAD,
    },
    [3627] = { -- Fang of Vagash; cmangos→Wowhead Forever peer
        [1388] = DropKeys.WOWHEAD,
    },
    [3628] = { -- Hand of Dextren Ward; cmangos→Wowhead Forever peer
        [1663] = DropKeys.WOWHEAD,
    },
    [3629] = { -- Mistmantle Family Ring; cmangos→Wowhead Forever peer
        [315] = DropKeys.WOWHEAD,
    },
    [3630] = { -- Head of Targorr; cmangos→Wowhead Forever peer
        [1696] = DropKeys.WOWHEAD,
    },
    [3631] = { -- Bellygrub's Tusk; cmangos→Wowhead Forever peer
        [345] = DropKeys.WOWHEAD,
    },
    [3632] = { -- Fangore's Paw; cmangos→Wowhead Forever peer
        [703] = DropKeys.WOWHEAD,
    },
    [3633] = { -- Head of Gath'Ilzogg; cmangos→Wowhead Forever peer
        [334] = DropKeys.WOWHEAD,
    },
    [3634] = { -- Head of Grimson; cmangos→Wowhead Forever peer
        [1972] = DropKeys.WOWHEAD,
    },
    [3635] = { -- Maggot Eye's Paw; cmangos→Wowhead Forever peer
        [1753] = DropKeys.WOWHEAD,
    },
    [3636] = { -- Scale of Old Murk-Eye; cmangos→Wowhead Forever peer
        [391] = DropKeys.WOWHEAD,
    },
    [3637] = { -- Head of VanCleef; cmangos→Wowhead Forever peer
        [639] = DropKeys.WOWHEAD,
    },
    [3638] = { -- Sarltooth's Talon; cmangos→Wowhead Forever peer
        [1353] = DropKeys.WOWHEAD,
    },
    [3639] = { -- Ear of Balgaras; cmangos→Wowhead Forever peer
        [1364] = DropKeys.WOWHEAD,
    },
    [3640] = { -- Head of Deepfury; cmangos→Wowhead Forever peer
        [1666] = DropKeys.WOWHEAD,
    },
    [3658] = { -- Recovered Tome; cmangos→Wowhead Forever peer
        [2252] = DropKeys.WOWHEAD,
        [2253] = DropKeys.WOWHEAD,
        [2254] = DropKeys.WOWHEAD,
        [2255] = DropKeys.WOWHEAD,
        [2256] = DropKeys.WOWHEAD,
        [2287] = DropKeys.WOWHEAD,
        [2416] = DropKeys.WOWHEAD,
    },
    [3672] = { -- Head of Nagaz; cmangos→Wowhead Forever peer
        [2320] = DropKeys.WOWHEAD,
    },
    [3684] = { -- Perenolde Tiara; cmangos→Wowhead Forever peer
        [2417] = DropKeys.WOWHEAD,
    },
    [3688] = { -- Bloodstone Oval; cmangos→Wowhead Forever peer
        [2414] = DropKeys.WOWHEAD,
    },
    [3689] = { -- Bloodstone Marble; cmangos→Wowhead Forever peer
        [2411] = DropKeys.WOWHEAD,
    },
    [3690] = { -- Bloodstone Shard; cmangos→Wowhead Forever peer
        [2412] = DropKeys.WOWHEAD,
    },
    [3691] = { -- Bloodstone Wedge; cmangos→Wowhead Forever peer
        [2413] = DropKeys.WOWHEAD,
    },
    [3693] = { -- Humbert's Sword; cmangos→Wowhead Forever peer
        [2344] = DropKeys.WOWHEAD,
        [2345] = DropKeys.WOWHEAD,
        [2346] = DropKeys.WOWHEAD,
        [14275] = DropKeys.WOWHEAD,
    },
    [3704] = { -- Rusted Iron Key; cmangos→Wowhead Forever peer
        [2431] = DropKeys.WOWHEAD,
    },
    [3708] = { -- Helcular's Rod; cmangos→Wowhead Forever peer
        [2248] = DropKeys.WOWHEAD,
        [2249] = DropKeys.WOWHEAD,
        [2250] = DropKeys.WOWHEAD,
        [2251] = DropKeys.WOWHEAD,
    },
    [3715] = { -- Bracers of Earth Binding; cmangos→Wowhead Forever peer
        [2359] = DropKeys.WOWHEAD,
    },
    [3716] = { -- Murloc Head; cmangos→Wowhead Forever peer
        [2374] = DropKeys.WOWHEAD,
        [2375] = DropKeys.WOWHEAD,
        [2376] = DropKeys.WOWHEAD,
        [2377] = DropKeys.WOWHEAD,
        [14276] = DropKeys.WOWHEAD,
    },
    [3720] = { -- Yeti Fur; cmangos→Wowhead Forever peer
        [2248] = DropKeys.WOWHEAD,
        [2249] = DropKeys.WOWHEAD,
        [2250] = DropKeys.WOWHEAD,
        [2251] = DropKeys.WOWHEAD,
        [2452] = DropKeys.WOWHEAD,
        [4504] = DropKeys.WOWHEAD,
    },
    [3838] = { -- Shadowmaw Claw; cmangos→Wowhead Forever peer
        [684] = DropKeys.WOWHEAD,
        [1713] = DropKeys.WOWHEAD,
    },
    [3839] = { -- Pristine Tigress Fang; cmangos→Wowhead Forever peer
        [772] = DropKeys.WOWHEAD,
    },
    [3862] = { -- Aged Gorilla Sinew; cmangos→Wowhead Forever peer
        [1557] = DropKeys.WOWHEAD,
    },
    [3863] = { -- Jungle Stalker Feather; cmangos→Wowhead Forever peer
        [687] = DropKeys.WOWHEAD,
    },
    [3876] = { -- Fang of Bhag'thera; cmangos→Wowhead Forever peer
        [728] = DropKeys.WOWHEAD,
    },
    [3877] = { -- Talon of Tethis; cmangos→Wowhead Forever peer
        [730] = DropKeys.WOWHEAD,
    },
    [3879] = { -- Paw of Sin'Dall; cmangos→Wowhead Forever peer
        [729] = DropKeys.WOWHEAD,
    },
    [3880] = { -- Head of Bangalash; cmangos→Wowhead Forever peer
        [731] = DropKeys.WOWHEAD,
    },
    [3897] = { -- Dizzy's Eye; cmangos→Wowhead Forever peer
        [1561] = DropKeys.WOWHEAD,
        [1562] = DropKeys.WOWHEAD,
        [1563] = DropKeys.WOWHEAD,
        [1564] = DropKeys.WOWHEAD,
        [1565] = DropKeys.WOWHEAD,
        [1653] = DropKeys.WOWHEAD,
        [2546] = DropKeys.WOWHEAD,
        [2548] = DropKeys.WOWHEAD,
        [2549] = DropKeys.WOWHEAD,
        [2550] = DropKeys.WOWHEAD,
        [2551] = DropKeys.WOWHEAD,
        [4505] = DropKeys.WOWHEAD,
        [4506] = DropKeys.WOWHEAD,
    },
    [3901] = { -- Bloodscalp Tusk; cmangos→Wowhead Forever peer
        [587] = DropKeys.WOWHEAD,
        [588] = DropKeys.WOWHEAD,
        [595] = DropKeys.WOWHEAD,
        [597] = DropKeys.WOWHEAD,
        [660] = DropKeys.WOWHEAD,
        [671] = DropKeys.WOWHEAD,
        [694] = DropKeys.WOWHEAD,
        [697] = DropKeys.WOWHEAD,
        [699] = DropKeys.WOWHEAD,
        [701] = DropKeys.WOWHEAD,
        [702] = DropKeys.WOWHEAD,
    },
    [3904] = { -- Gan'zulah's Head; cmangos→Wowhead Forever peer
        [1061] = DropKeys.WOWHEAD,
    },
    [3905] = { -- Nezzliok's Head; cmangos→Wowhead Forever peer
        [1062] = DropKeys.WOWHEAD,
    },
    [3909] = { -- Broken Armor of Ana'thek; cmangos→Wowhead Forever peer
        [1059] = DropKeys.WOWHEAD,
    },
    [3910] = { -- Snuff; cmangos→Wowhead Forever peer
        [1561] = DropKeys.WOWHEAD,
        [1562] = DropKeys.WOWHEAD,
        [1563] = DropKeys.WOWHEAD,
        [1564] = DropKeys.WOWHEAD,
        [1565] = DropKeys.WOWHEAD,
        [1653] = DropKeys.WOWHEAD,
        [2545] = DropKeys.WOWHEAD,
        [2546] = DropKeys.WOWHEAD,
        [2547] = DropKeys.WOWHEAD,
        [2548] = DropKeys.WOWHEAD,
        [2549] = DropKeys.WOWHEAD,
        [2550] = DropKeys.WOWHEAD,
        [2551] = DropKeys.WOWHEAD,
        [4505] = DropKeys.WOWHEAD,
        [4506] = DropKeys.WOWHEAD,
    },
    [3911] = { -- Pulsing Blue Shard; cmangos→Wowhead Forever peer
        [1551] = DropKeys.WOWHEAD,
    },
    [3915] = { -- Bloody Bone Necklace; cmangos→Wowhead Forever peer
        [587] = DropKeys.WOWHEAD,
        [588] = DropKeys.WOWHEAD,
        [595] = DropKeys.WOWHEAD,
        [597] = DropKeys.WOWHEAD,
        [660] = DropKeys.WOWHEAD,
        [671] = DropKeys.WOWHEAD,
        [694] = DropKeys.WOWHEAD,
        [697] = DropKeys.WOWHEAD,
        [699] = DropKeys.WOWHEAD,
        [701] = DropKeys.WOWHEAD,
        [702] = DropKeys.WOWHEAD,
    },
    [3916] = { -- Split Bone Necklace; cmangos→Wowhead Forever peer
        [667] = DropKeys.WOWHEAD,
        [669] = DropKeys.WOWHEAD,
        [670] = DropKeys.WOWHEAD,
        [672] = DropKeys.WOWHEAD,
        [696] = DropKeys.WOWHEAD,
        [780] = DropKeys.WOWHEAD,
        [781] = DropKeys.WOWHEAD,
        [782] = DropKeys.WOWHEAD,
        [783] = DropKeys.WOWHEAD,
        [784] = DropKeys.WOWHEAD,
        [1059] = DropKeys.WOWHEAD,
    },
    [3919] = { -- Mistvale Giblets; cmangos→Wowhead Forever peer
        [1557] = DropKeys.WOWHEAD,
    },
    [3923] = { -- Water Elemental Bracers; cmangos→Wowhead Forever peer
        [691] = DropKeys.WOWHEAD,
    },
    [3924] = { -- Maury's Clubbed Foot; cmangos→Wowhead Forever peer
        [2535] = DropKeys.WOWHEAD,
    },
    [3925] = { -- Jon-Jon's Golden Spyglass; cmangos→Wowhead Forever peer
        [2536] = DropKeys.WOWHEAD,
    },
    [3926] = { -- Chucky's Huge Ring; cmangos→Wowhead Forever peer
        [2537] = DropKeys.WOWHEAD,
    },
    [3930] = { -- Maury's Key; cmangos→Wowhead Forever peer
        [678] = DropKeys.WOWHEAD,
        [679] = DropKeys.WOWHEAD,
        [680] = DropKeys.WOWHEAD,
        [709] = DropKeys.WOWHEAD,
        [710] = DropKeys.WOWHEAD,
        [723] = DropKeys.WOWHEAD,
    },
    [3932] = { -- Smotts' Chest; cmangos→Wowhead Forever peer
        [1492] = DropKeys.WOWHEAD,
    },
    [3935] = { -- Smotts' Cutlass; cmangos→Wowhead Forever peer
        [1494] = DropKeys.WOWHEAD,
    },
    [4016] = { -- Zanzil's Mixture; cmangos→Wowhead Forever peer
        [1488] = DropKeys.WOWHEAD,
        [1489] = DropKeys.WOWHEAD,
        [1490] = DropKeys.WOWHEAD,
        [1491] = DropKeys.WOWHEAD,
        [2534] = DropKeys.WOWHEAD,
        [2536] = DropKeys.WOWHEAD,
        [2537] = DropKeys.WOWHEAD,
    },
    [4027] = { -- Catelyn's Blade; cmangos→Wowhead Forever peer
        [2545] = DropKeys.WOWHEAD,
    },
    [4029] = { -- Akiris Reed; cmangos→Wowhead Forever peer
        [1907] = DropKeys.WOWHEAD,
    },
    [4034] = { -- Stone of the Tides; cmangos→Wowhead Forever peer
        [2624] = DropKeys.WOWHEAD,
    },
    [4053] = { -- Large River Crocolisk Skin; cmangos→Wowhead Forever peer
        [1150] = DropKeys.WOWHEAD,
    },
    [4103] = { -- Shackle Key; cmangos→Wowhead Forever peer
        [1559] = DropKeys.WOWHEAD,
    },
    [4104] = { -- Snapjaw Crocolisk Skin; cmangos→Wowhead Forever peer
        [1152] = DropKeys.WOWHEAD,
    },
    [4106] = { -- Tumbled Crystal; cmangos→Wowhead Forever peer
        [1096] = DropKeys.WOWHEAD,
    },
    [4435] = { -- Mote of Myzrael; cmangos→Wowhead Forever peer
        [2572] = DropKeys.WOWHEAD,
        [2573] = DropKeys.WOWHEAD,
        [2574] = DropKeys.WOWHEAD,
    },
    [4440] = { -- Sigil of Strom; cmangos→Wowhead Forever peer
        [2588] = DropKeys.WOWHEAD,
        [2590] = DropKeys.WOWHEAD,
        [2591] = DropKeys.WOWHEAD,
    },
    [4450] = { -- Sigil Fragment; cmangos→Wowhead Forever peer
        [2583] = DropKeys.WOWHEAD,
        [2584] = DropKeys.WOWHEAD,
        [2585] = DropKeys.WOWHEAD,
    },
    [4458] = { -- Sigil of Arathor; cmangos→Wowhead Forever peer
        [2612] = DropKeys.WOWHEAD,
    },
    [4466] = { -- Sigil of Trollbane; cmangos→Wowhead Forever peer
        [2607] = DropKeys.WOWHEAD,
    },
    [4469] = { -- Rod of Order; cmangos→Wowhead Forever peer
        [2611] = DropKeys.WOWHEAD,
    },
    [4473] = { -- Eldritch Shackles; cmangos→Wowhead Forever peer
        [2755] = DropKeys.WOWHEAD,
    },
    [4482] = { -- Sealed Folder; cmangos→Wowhead Forever peer
        [2714] = DropKeys.WOWHEAD,
    },
    [4495] = { -- Bloodstone Amulet; cmangos→Wowhead Forever peer
        [2586] = DropKeys.WOWHEAD,
        [2587] = DropKeys.WOWHEAD,
        [2589] = DropKeys.WOWHEAD,
    },
    [4503] = { -- Witherbark Tusk; cmangos→Wowhead Forever peer
        [2552] = DropKeys.WOWHEAD,
        [2553] = DropKeys.WOWHEAD,
        [2554] = DropKeys.WOWHEAD,
        [2555] = DropKeys.WOWHEAD,
        [2556] = DropKeys.WOWHEAD,
        [2557] = DropKeys.WOWHEAD,
        [2558] = DropKeys.WOWHEAD,
        [2605] = DropKeys.WOWHEAD,
    },
    [4506] = { -- Stromgarde Badge; cmangos→Wowhead Forever peer
        [2588] = DropKeys.WOWHEAD,
        [2590] = DropKeys.WOWHEAD,
        [2591] = DropKeys.WOWHEAD,
    },
    [4510] = { -- Befouled Bloodstone Orb; cmangos→Wowhead Forever peer
        [2783] = DropKeys.WOWHEAD,
    },
    [4512] = { -- Highland Raptor Eye; cmangos→Wowhead Forever peer
        [2559] = DropKeys.WOWHEAD,
        [2560] = DropKeys.WOWHEAD,
    },
    [4513] = { -- Raptor Heart; cmangos→Wowhead Forever peer
        [2561] = DropKeys.WOWHEAD,
    },
    [4515] = { -- Marez's Head; cmangos→Wowhead Forever peer
        [2783] = DropKeys.WOWHEAD,
    },
    [4516] = { -- Otto's Head; cmangos→Wowhead Forever peer
        [2599] = DropKeys.WOWHEAD,
    },
    [4517] = { -- Falconcrest's Head; cmangos→Wowhead Forever peer
        [2597] = DropKeys.WOWHEAD,
    },
    [4518] = { -- Torn Scroll Fragment; cmangos→Wowhead Forever peer
        [2791] = DropKeys.WOWHEAD,
    },
    [4519] = { -- Crumpled Scroll Fragment; cmangos→Wowhead Forever peer
        [2791] = DropKeys.WOWHEAD,
    },
    [4520] = { -- Singed Scroll Fragment; cmangos→Wowhead Forever peer
        [2791] = DropKeys.WOWHEAD,
    },
    [4522] = { -- Witherbark Medicine Pouch; cmangos→Wowhead Forever peer
        [2555] = DropKeys.WOWHEAD,
    },
    [4525] = { -- Trelane's Wand of Invocation; cmangos→Wowhead Forever peer
        [2793] = DropKeys.WOWHEAD,
    },
    [4527] = { -- Azure Agate; cmangos→Wowhead Forever peer
        [2570] = DropKeys.WOWHEAD,
    },
    [4551] = { -- Or'Kalar's Head; cmangos→Wowhead Forever peer
        [2773] = DropKeys.WOWHEAD,
    },
    [4612] = { -- Black Drake's Heart; cmangos→Wowhead Forever peer
        [2725] = DropKeys.WOWHEAD,
        [2726] = DropKeys.WOWHEAD,
    },
    [4615] = { -- Blacklash's Bindings; cmangos→Wowhead Forever peer
        [2757] = DropKeys.WOWHEAD,
    },
    [4616] = { -- Ryedol's Lucky Pick; cmangos→Wowhead Forever peer
        [2739] = DropKeys.WOWHEAD,
        [2740] = DropKeys.WOWHEAD,
        [2742] = DropKeys.WOWHEAD,
        [2743] = DropKeys.WOWHEAD,
        [2744] = DropKeys.WOWHEAD,
    },
    [4621] = { -- Ambassador Infernus' Bracer; cmangos→Wowhead Forever peer
        [2745] = DropKeys.WOWHEAD,
    },
    [4626] = { -- Small Stone Shard; cmangos→Wowhead Forever peer
        [2735] = DropKeys.WOWHEAD,
    },
    [4630] = { -- Scrap Metal; cmangos→Wowhead Forever peer
        [2701] = DropKeys.WOWHEAD,
        [2715] = DropKeys.WOWHEAD,
        [2716] = DropKeys.WOWHEAD,
        [2717] = DropKeys.WOWHEAD,
        [2718] = DropKeys.WOWHEAD,
        [2719] = DropKeys.WOWHEAD,
        [2720] = DropKeys.WOWHEAD,
        [2906] = DropKeys.WOWHEAD,
        [2907] = DropKeys.WOWHEAD,
    },
    [4635] = { -- Hammertoe's Amulet; cmangos→Wowhead Forever peer
        [2932] = DropKeys.WOWHEAD,
    },
    [4640] = { -- Sign of the Earth; cmangos→Wowhead Forever peer
        [2944] = DropKeys.WOWHEAD,
    },
    [4641] = { -- Hand of Dagun; cmangos→Wowhead Forever peer
        [2937] = DropKeys.WOWHEAD,
    },
    [4644] = { -- The Legacy Heart; cmangos→Wowhead Forever peer
        [1060] = DropKeys.WOWHEAD,
    },
    [4645] = { -- Chains of Hematus; cmangos→Wowhead Forever peer
        [2759] = DropKeys.WOWHEAD,
    },
    [4646] = { -- Star of Xil'yeh; cmangos→Wowhead Forever peer
        [2417] = DropKeys.WOWHEAD,
    },
    [4702] = { -- Prospector's Pick; cmangos→Wowhead Forever peer
        [2989] = DropKeys.WOWHEAD,
        [2990] = DropKeys.WOWHEAD,
    },
    [4739] = { -- Plainstrider Meat; cmangos→Wowhead Forever peer
        [2955] = DropKeys.WOWHEAD,
    },
    [4740] = { -- Plainstrider Feather; cmangos→Wowhead Forever peer
        [2955] = DropKeys.WOWHEAD,
    },
    [4742] = { -- Mountain Cougar Pelt; cmangos→Wowhead Forever peer
        [2961] = DropKeys.WOWHEAD,
    },
    [4751] = { -- Windfury Talon; cmangos→Wowhead Forever peer
        [2962] = DropKeys.WOWHEAD,
        [2963] = DropKeys.WOWHEAD,
    },
    [4752] = { -- Azure Feather; cmangos→Wowhead Forever peer
        [2964] = DropKeys.WOWHEAD,
    },
    [4753] = { -- Bronze Feather; cmangos→Wowhead Forever peer
        [2965] = DropKeys.WOWHEAD,
    },
    [4758] = { -- Prairie Wolf Paw; cmangos→Wowhead Forever peer
        [2958] = DropKeys.WOWHEAD,
        [2959] = DropKeys.WOWHEAD,
        [2960] = DropKeys.WOWHEAD,
    },
    [4759] = { -- Plainstrider Talon; cmangos→Wowhead Forever peer
        [2956] = DropKeys.WOWHEAD,
        [2957] = DropKeys.WOWHEAD,
        [3068] = DropKeys.WOWHEAD,
    },
    [4769] = { -- Trophy Swoop Quill; cmangos→Wowhead Forever peer
        [2969] = DropKeys.WOWHEAD,
        [2970] = DropKeys.WOWHEAD,
    },
    [4770] = { -- Bristleback Belt; cmangos→Wowhead Forever peer
        [2952] = DropKeys.WOWHEAD,
        [2953] = DropKeys.WOWHEAD,
    },
    [4801] = { -- Stalker Claws; cmangos→Wowhead Forever peer
        [2959] = DropKeys.WOWHEAD,
    },
    [4802] = { -- Cougar Claws; cmangos→Wowhead Forever peer
        [3035] = DropKeys.WOWHEAD,
    },
    [4803] = { -- Prairie Alpha Tooth; cmangos→Wowhead Forever peer
        [2960] = DropKeys.WOWHEAD,
    },
    [4804] = { -- Prairie Wolf Heart; cmangos→Wowhead Forever peer
        [2958] = DropKeys.WOWHEAD,
        [2959] = DropKeys.WOWHEAD,
        [2960] = DropKeys.WOWHEAD,
    },
    [4805] = { -- Flatland Cougar Femur; cmangos→Wowhead Forever peer
        [3035] = DropKeys.WOWHEAD,
    },
    [4806] = { -- Plainstrider Scale; cmangos→Wowhead Forever peer
        [2956] = DropKeys.WOWHEAD,
        [2957] = DropKeys.WOWHEAD,
        [3068] = DropKeys.WOWHEAD,
    },
    [4807] = { -- Swoop Gizzard; cmangos→Wowhead Forever peer
        [2969] = DropKeys.WOWHEAD,
        [2970] = DropKeys.WOWHEAD,
        [2971] = DropKeys.WOWHEAD,
    },
    [4819] = { -- Fizsprocket's Clipboard; cmangos→Wowhead Forever peer
        [3051] = DropKeys.WOWHEAD,
    },
    [4841] = { -- Horn of Arra'chea; cmangos→Wowhead Forever peer
        [3058] = DropKeys.WOWHEAD,
    },
    [4847] = { -- Lotwil's Shackles of Elemental Binding; cmangos→Wowhead Forever peer
        [2919] = DropKeys.WOWHEAD,
    },
    [4848] = { -- Battleboar Snout; cmangos→Wowhead Forever peer
        [2954] = DropKeys.WOWHEAD,
        [2966] = DropKeys.WOWHEAD,
    },
    [4849] = { -- Battleboar Flank; cmangos→Wowhead Forever peer
        [2954] = DropKeys.WOWHEAD,
        [2966] = DropKeys.WOWHEAD,
    },
    [4859] = { -- Burning Blade Medallion; cmangos→Wowhead Forever peer
        [3183] = DropKeys.WOWHEAD,
    },
    [4862] = { -- Scorpid Worker Tail; cmangos→Wowhead Forever peer
        [3124] = DropKeys.WOWHEAD,
        [3281] = DropKeys.WOWHEAD,
    },
    [4866] = { -- Zalazane's Head; cmangos→Wowhead Forever peer
        [3205] = DropKeys.WOWHEAD,
    },
    [4869] = { -- Fizzle's Claw; cmangos→Wowhead Forever peer
        [3203] = DropKeys.WOWHEAD,
    },
    [4870] = { -- Canvas Scraps; cmangos→Wowhead Forever peer
        [3119] = DropKeys.WOWHEAD,
        [3120] = DropKeys.WOWHEAD,
        [3128] = DropKeys.WOWHEAD,
        [3129] = DropKeys.WOWHEAD,
        [3192] = DropKeys.WOWHEAD,
        [5808] = DropKeys.WOWHEAD,
        [5809] = DropKeys.WOWHEAD,
    },
    [4871] = { -- Searing Collar; cmangos→Wowhead Forever peer
        [3195] = DropKeys.WOWHEAD,
        [3196] = DropKeys.WOWHEAD,
        [3197] = DropKeys.WOWHEAD,
        [3198] = DropKeys.WOWHEAD,
        [3199] = DropKeys.WOWHEAD,
    },
    [4886] = { -- Venomtail Poison Sac; cmangos→Wowhead Forever peer
        [3127] = DropKeys.WOWHEAD,
        [3226] = DropKeys.WOWHEAD,
        [5823] = DropKeys.WOWHEAD,
    },
    [4887] = { -- Intact Makrura Eye; cmangos→Wowhead Forever peer
        [3103] = DropKeys.WOWHEAD,
        [3104] = DropKeys.WOWHEAD,
        [3105] = DropKeys.WOWHEAD,
        [3141] = DropKeys.WOWHEAD,
    },
    [4888] = { -- Crawler Mucus; cmangos→Wowhead Forever peer
        [3106] = DropKeys.WOWHEAD,
        [3107] = DropKeys.WOWHEAD,
        [3108] = DropKeys.WOWHEAD,
        [3228] = DropKeys.WOWHEAD,
    },
    [4891] = { -- Kron's Amulet; cmangos→Wowhead Forever peer
        [3110] = DropKeys.WOWHEAD,
        [3231] = DropKeys.WOWHEAD,
    },
    [4892] = { -- Durotar Tiger Fur; cmangos→Wowhead Forever peer
        [3121] = DropKeys.WOWHEAD,
    },
    [4893] = { -- Savannah Lion Tusk; cmangos→Wowhead Forever peer
        [3241] = DropKeys.WOWHEAD,
        [3243] = DropKeys.WOWHEAD,
        [3415] = DropKeys.WOWHEAD,
        [3416] = DropKeys.WOWHEAD,
        [3425] = DropKeys.WOWHEAD,
        [5865] = DropKeys.WOWHEAD,
    },
    [4894] = { -- Plainstrider Kidney; cmangos→Wowhead Forever peer
        [3244] = DropKeys.WOWHEAD,
        [3245] = DropKeys.WOWHEAD,
        [3246] = DropKeys.WOWHEAD,
    },
    [4895] = { -- Thunder Lizard Horn; cmangos→Wowhead Forever peer
        [3238] = DropKeys.WOWHEAD,
        [3239] = DropKeys.WOWHEAD,
        [3240] = DropKeys.WOWHEAD,
        [3473] = DropKeys.WOWHEAD,
    },
    [4896] = { -- Kodo Liver; cmangos→Wowhead Forever peer
        [3234] = DropKeys.WOWHEAD,
        [3235] = DropKeys.WOWHEAD,
        [3236] = DropKeys.WOWHEAD,
        [3237] = DropKeys.WOWHEAD,
        [3474] = DropKeys.WOWHEAD,
        [5827] = DropKeys.WOWHEAD,
    },
    [4897] = { -- Thunderhawk Saliva Gland; cmangos→Wowhead Forever peer
        [3249] = DropKeys.WOWHEAD,
    },
    [4898] = { -- Lightning Gland; cmangos→Wowhead Forever peer
        [3238] = DropKeys.WOWHEAD,
    },
    [5006] = { -- Khazgorm's Journal; cmangos→Wowhead Forever peer
        [3392] = DropKeys.WOWHEAD,
    },
    [5017] = { -- Nitroglycerin; cmangos→Wowhead Forever peer
        [3376] = DropKeys.WOWHEAD,
        [3377] = DropKeys.WOWHEAD,
        [3378] = DropKeys.WOWHEAD,
        [6668] = DropKeys.WOWHEAD,
    },
    [5018] = { -- Wood Pulp; cmangos→Wowhead Forever peer
        [3376] = DropKeys.WOWHEAD,
        [3377] = DropKeys.WOWHEAD,
        [3378] = DropKeys.WOWHEAD,
        [6668] = DropKeys.WOWHEAD,
    },
    [5019] = { -- Sodium Nitrate; cmangos→Wowhead Forever peer
        [3376] = DropKeys.WOWHEAD,
        [3377] = DropKeys.WOWHEAD,
        [3378] = DropKeys.WOWHEAD,
        [6668] = DropKeys.WOWHEAD,
    },
    [5022] = { -- Barak's Head; cmangos→Wowhead Forever peer
        [3394] = DropKeys.WOWHEAD,
    },
    [5023] = { -- Verog's Head; cmangos→Wowhead Forever peer
        [3395] = DropKeys.WOWHEAD,
    },
    [5025] = { -- Hezrul's Head; cmangos→Wowhead Forever peer
        [3396] = DropKeys.WOWHEAD,
    },
    [5040] = { -- Shadow Hunter Knife; cmangos→Wowhead Forever peer
        [2557] = DropKeys.WOWHEAD,
    },
    [5050] = { -- Ignition Key; cmangos→Wowhead Forever peer
        [3445] = DropKeys.WOWHEAD,
    },
    [5063] = { -- Kreenig Snarlsnout's Tusk; cmangos→Wowhead Forever peer
        [3438] = DropKeys.WOWHEAD,
    },
    [5064] = { -- Witchwing Talon; cmangos→Wowhead Forever peer
        [3276] = DropKeys.WOWHEAD,
        [3277] = DropKeys.WOWHEAD,
        [3278] = DropKeys.WOWHEAD,
        [3279] = DropKeys.WOWHEAD,
        [3280] = DropKeys.WOWHEAD,
        [3452] = DropKeys.WOWHEAD,
    },
    [5065] = { -- Harpy Lieutenant Ring; cmangos→Wowhead Forever peer
        [3278] = DropKeys.WOWHEAD,
    },
    [5067] = { -- Serena's Head; cmangos→Wowhead Forever peer
        [3452] = DropKeys.WOWHEAD,
    },
    [5072] = { -- Lok's Skull; cmangos→Wowhead Forever peer
        [3435] = DropKeys.WOWHEAD,
    },
    [5073] = { -- Nak's Skull; cmangos→Wowhead Forever peer
        [3434] = DropKeys.WOWHEAD,
    },
    [5074] = { -- Kuz's Skull; cmangos→Wowhead Forever peer
        [3436] = DropKeys.WOWHEAD,
    },
    [5084] = { -- Baron Longshore's Head; cmangos→Wowhead Forever peer
        [3467] = DropKeys.WOWHEAD,
    },
    [5085] = { -- Bristleback Quilboar Tusk; full Forever Dropped-by inventory
        [3258] = 100, -- Bristleback Hunter
        [3259] = 100, -- Bristleback Defender
        [3260] = 100, -- Bristleback Water Seeker
        [3261] = 100, -- Bristleback Thornweaver
        [3262] = 100, -- Bristleback Mystic
        [3263] = 100, -- Bristleback Geomancer
        [268624] = 8.0711, -- Razormane Raider; Wowhead Forever 767/9503
    },
    [5087] = { -- Plainstrider Beak; cmangos→Wowhead Forever peer
        [3244] = DropKeys.WOWHEAD,
        [3245] = DropKeys.WOWHEAD,
        [3246] = DropKeys.WOWHEAD,
    },
    [5089] = { -- Console Key; cmangos→Wowhead Forever peer
        [3471] = DropKeys.WOWHEAD,
    },
    [5096] = { -- Prowler Claws; cmangos→Wowhead Forever peer
        [3425] = DropKeys.WOWHEAD,
    },
    [5097] = { -- Cats Eye Emerald; cmangos→Wowhead Forever peer
        [3283] = DropKeys.WOWHEAD,
        [3286] = DropKeys.WOWHEAD,
        [9336] = DropKeys.WOWHEAD,
    },
    [5098] = { -- Altered Snapjaw Shell; cmangos→Wowhead Forever peer
        [3461] = DropKeys.WOWHEAD,
    },
    [5100] = { -- Echeyakee's Hide; cmangos→Wowhead Forever peer
        [3475] = DropKeys.WOWHEAD,
    },
    [5101] = { -- Ishamuhale's Fang; cmangos→Wowhead Forever peer
        [3257] = DropKeys.WOWHEAD,
    },
    [5104] = { -- Heart of Isha Awak; cmangos→Wowhead Forever peer
        [3476] = DropKeys.WOWHEAD,
    },
    [5143] = { -- Thunder Lizard Blood; Wowhead Forever listview (override cmangos 80%)
        [3240] = 15.8577, -- Stormsnout; 7573/47756
        [3239] = 15.2531, -- Thunderhead; 9321/61109
        [3238] = 0.8149, -- Stormhide; 386/47367
    },
    [5164] = { -- Thunderhawk Wings; cmangos→Wowhead Forever peer
        [3247] = DropKeys.WOWHEAD,
        [3249] = DropKeys.WOWHEAD,
        [3424] = DropKeys.WOWHEAD,
    },
    [5165] = { -- Sunscale Feather; cmangos→Wowhead Forever peer
        [3254] = DropKeys.WOWHEAD,
        [3255] = DropKeys.WOWHEAD,
        [3256] = DropKeys.WOWHEAD,
    },
    [5166] = { -- Webwood Venom Sac; cmangos→Wowhead Forever peer
        [1986] = DropKeys.WOWHEAD,
    },
    [5168] = { -- Timberling Seed; cmangos→Wowhead Forever peer
        [2022] = DropKeys.WOWHEAD,
        [2025] = DropKeys.WOWHEAD,
        [2027] = DropKeys.WOWHEAD,
        [2030] = DropKeys.WOWHEAD,
        [2166] = DropKeys.WOWHEAD,
    },
    [5203] = { -- Flatland Prowler Claw; cmangos→Wowhead Forever peer
        [3566] = DropKeys.WOWHEAD,
    },
    [5204] = { -- Bloodfeather Belt; cmangos→Wowhead Forever peer
        [2015] = DropKeys.WOWHEAD,
        [2017] = DropKeys.WOWHEAD,
        [2018] = DropKeys.WOWHEAD,
        [2019] = DropKeys.WOWHEAD,
        [2020] = DropKeys.WOWHEAD,
        [2021] = DropKeys.WOWHEAD,
        [14431] = DropKeys.WOWHEAD,
    },
    [5221] = { -- Melenas' Head; cmangos→Wowhead Forever peer
        [2038] = DropKeys.WOWHEAD,
    },
    [5334] = { -- 99-Year-Old Port; cmangos→Wowhead Forever peer
        [3655] = DropKeys.WOWHEAD,
    },
    [5336] = { -- Grell Earring; cmangos→Wowhead Forever peer
        [2189] = DropKeys.WOWHEAD,
        [2190] = DropKeys.WOWHEAD,
    },
    [5338] = { -- Ancient Moonstone Seal; cmangos→Wowhead Forever peer
        [2212] = DropKeys.WOWHEAD,
    },
    [5348] = { -- Worn Parchment; cmangos→Wowhead Forever peer
        [2336] = DropKeys.WOWHEAD,
    },
    [5360] = { -- Highborne Relic; cmangos→Wowhead Forever peer
        [2176] = DropKeys.WOWHEAD,
        [2177] = DropKeys.WOWHEAD,
        [2178] = DropKeys.WOWHEAD,
    },
    [5382] = { -- Anaya's Pendant; cmangos→Wowhead Forever peer
        [3667] = DropKeys.WOWHEAD,
    },
    [5383] = { -- Athrikus Narassin's Head; cmangos→Wowhead Forever peer
        [3660] = DropKeys.WOWHEAD,
    },
    [5385] = { -- Crawler Leg; cmangos→Wowhead Forever peer
        [2231] = DropKeys.WOWHEAD,
        [2232] = DropKeys.WOWHEAD,
        [2234] = DropKeys.WOWHEAD,
        [2235] = DropKeys.WOWHEAD,
        [2236] = DropKeys.WOWHEAD,
    },
    [5386] = { -- Fine Moonstalker Pelt; cmangos→Wowhead Forever peer
        [2071] = DropKeys.WOWHEAD,
        [2237] = DropKeys.WOWHEAD,
    },
    [5388] = { -- Ran Bloodtooth's Skull; cmangos→Wowhead Forever peer
        [3696] = DropKeys.WOWHEAD,
    },
    [5412] = { -- Thresher Eye; cmangos→Wowhead Forever peer
        [2185] = DropKeys.WOWHEAD,
        [2187] = DropKeys.WOWHEAD,
    },
    [5413] = { -- Moonstalker Fang; cmangos→Wowhead Forever peer
        [2069] = DropKeys.WOWHEAD,
        [2070] = DropKeys.WOWHEAD,
        [2071] = DropKeys.WOWHEAD,
        [2237] = DropKeys.WOWHEAD,
    },
    [5414] = { -- Grizzled Scalp; cmangos→Wowhead Forever peer
        [2165] = DropKeys.WOWHEAD,
        [6788] = DropKeys.WOWHEAD,
    },
    [5442] = { -- Head of Arugal; cmangos→Wowhead Forever peer
        [4275] = DropKeys.WOWHEAD,
    },
    [5445] = { -- Ring of Zoram; cmangos→Wowhead Forever peer
        [3943] = DropKeys.WOWHEAD,
        [10559] = DropKeys.WOWHEAD,
    },
    [5461] = { -- Branch of Cenarius; cmangos→Wowhead Forever peer
        [4619] = DropKeys.WOWHEAD,
    },
    [5463] = { -- Glowing Gem; cmangos→Wowhead Forever peer
        [3737] = DropKeys.WOWHEAD,
        [3739] = DropKeys.WOWHEAD,
        [3740] = DropKeys.WOWHEAD,
        [3742] = DropKeys.WOWHEAD,
    },
    [5481] = { -- Satyr Horns; cmangos→Wowhead Forever peer
        [3752] = DropKeys.WOWHEAD,
        [3754] = DropKeys.WOWHEAD,
        [3755] = DropKeys.WOWHEAD,
        [3757] = DropKeys.WOWHEAD,
        [3758] = DropKeys.WOWHEAD,
        [3759] = DropKeys.WOWHEAD,
        [3762] = DropKeys.WOWHEAD,
        [3763] = DropKeys.WOWHEAD,
        [3765] = DropKeys.WOWHEAD,
        [3767] = DropKeys.WOWHEAD,
        [3770] = DropKeys.WOWHEAD,
        [3771] = DropKeys.WOWHEAD,
        [3898] = DropKeys.WOWHEAD,
        [3899] = DropKeys.WOWHEAD,
        [3900] = DropKeys.WOWHEAD,
        [4619] = DropKeys.WOWHEAD,
        [10647] = DropKeys.WOWHEAD,
    },
    [5490] = { -- Wrathtail Head; cmangos→Wowhead Forever peer
        [3711] = DropKeys.WOWHEAD,
        [3712] = DropKeys.WOWHEAD,
        [3713] = DropKeys.WOWHEAD,
        [3715] = DropKeys.WOWHEAD,
        [3717] = DropKeys.WOWHEAD,
        [3944] = DropKeys.WOWHEAD,
    },
    [5508] = { -- Fallen Moonstone; cmangos→Wowhead Forever peer
        [3931] = DropKeys.WOWHEAD,
    },
    [5533] = { -- Ilkrud Magthrull's Tome; cmangos→Wowhead Forever peer
        [3664] = DropKeys.WOWHEAD,
    },
    [5537] = { -- Sarilus Foulborne's Head; cmangos→Wowhead Forever peer
        [3986] = DropKeys.WOWHEAD,
    },
    [5538] = { -- Vorrel's Wedding Ring; cmangos→Wowhead Forever peer
        [3984] = DropKeys.WOWHEAD,
    },
    [5544] = { -- Dal Bloodclaw's Skull; cmangos→Wowhead Forever peer
        [3987] = DropKeys.WOWHEAD,
    },
    [5582] = { -- Stonetalon Sap; cmangos→Wowhead Forever peer
        [4020] = DropKeys.WOWHEAD,
    },
    [5583] = { -- Fey Dragon Scale; cmangos→Wowhead Forever peer
        [4016] = DropKeys.WOWHEAD,
        [4017] = DropKeys.WOWHEAD,
        [4066] = DropKeys.WOWHEAD,
    },
    [5584] = { -- Twilight Whisker; cmangos→Wowhead Forever peer
        [4067] = DropKeys.WOWHEAD,
    },
    [5585] = { -- Courser Eye; cmangos→Wowhead Forever peer
        [4018] = DropKeys.WOWHEAD,
        [4019] = DropKeys.WOWHEAD,
    },
    [5620] = { -- Vial of Innocent Blood; cmangos→Wowhead Forever peer
        [2244] = DropKeys.WOWHEAD,
    },
    [5659] = { -- Smoldering Embers; cmangos→Wowhead Forever peer
        [4036] = DropKeys.WOWHEAD,
        [4037] = DropKeys.WOWHEAD,
        [4038] = DropKeys.WOWHEAD,
    },
    [5664] = { -- Corroded Shrapnel; cmangos→Wowhead Forever peer
        [4028] = DropKeys.WOWHEAD,
        [4029] = DropKeys.WOWHEAD,
        [4030] = DropKeys.WOWHEAD,
    },
    [5675] = { -- Crystalized Scales; cmangos→Wowhead Forever peer
        [4041] = DropKeys.WOWHEAD,
        [4042] = DropKeys.WOWHEAD,
        [4044] = DropKeys.WOWHEAD,
        [4147] = DropKeys.WOWHEAD,
    },
    [5686] = { -- Ordanus' Head; cmangos→Wowhead Forever peer
        [4273] = DropKeys.WOWHEAD,
    },
    [5734] = { -- Super Reaper 6000 Blueprints; cmangos→Wowhead Forever peer
        [3988] = DropKeys.WOWHEAD,
    },
    [5736] = { -- Gerenzo's Mechanical Arm; cmangos→Wowhead Forever peer
        [4202] = DropKeys.WOWHEAD,
    },
    [5792] = { -- Razorflank's Medallion; cmangos→Wowhead Forever peer
        [4421] = DropKeys.WOWHEAD,
    },
    [5793] = { -- Razorflank's Heart; cmangos→Wowhead Forever peer
        [4421] = DropKeys.WOWHEAD,
    },
    [5794] = { -- Salty Scorpid Venom; cmangos→Wowhead Forever peer
        [4139] = DropKeys.WOWHEAD,
        [4140] = DropKeys.WOWHEAD,
        [5937] = DropKeys.WOWHEAD,
    },
    [5795] = { -- Hardened Tortoise Shell; cmangos→Wowhead Forever peer
        [4142] = DropKeys.WOWHEAD,
        [4143] = DropKeys.WOWHEAD,
        [4144] = DropKeys.WOWHEAD,
    },
    [5796] = { -- Encrusted Tail Fin; cmangos→Wowhead Forever peer
        [871] = DropKeys.WOWHEAD,
        [873] = DropKeys.WOWHEAD,
        [875] = DropKeys.WOWHEAD,
        [877] = DropKeys.WOWHEAD,
        [879] = DropKeys.WOWHEAD,
    },
    [5797] = { -- Indurium Flake; cmangos→Wowhead Forever peer
        [2892] = DropKeys.WOWHEAD,
        [2893] = DropKeys.WOWHEAD,
        [2894] = DropKeys.WOWHEAD,
        [6733] = DropKeys.WOWHEAD,
    },
    [5803] = { -- Speck of Dream Dust; cmangos→Wowhead Forever peer
        [740] = DropKeys.WOWHEAD,
        [741] = DropKeys.WOWHEAD,
        [742] = DropKeys.WOWHEAD,
        [744] = DropKeys.WOWHEAD,
        [745] = DropKeys.WOWHEAD,
        [746] = DropKeys.WOWHEAD,
        [14445] = DropKeys.WOWHEAD,
    },
    [5805] = { -- Heart of Zeal; cmangos→Wowhead Forever peer
        [3974] = DropKeys.WOWHEAD,
        [3975] = DropKeys.WOWHEAD,
        [3976] = DropKeys.WOWHEAD,
        [3977] = DropKeys.WOWHEAD,
        [3983] = DropKeys.WOWHEAD,
        [4280] = DropKeys.WOWHEAD,
        [4281] = DropKeys.WOWHEAD,
        [4282] = DropKeys.WOWHEAD,
        [4283] = DropKeys.WOWHEAD,
        [4284] = DropKeys.WOWHEAD,
        [4285] = DropKeys.WOWHEAD,
        [4286] = DropKeys.WOWHEAD,
        [4287] = DropKeys.WOWHEAD,
        [4288] = DropKeys.WOWHEAD,
        [4289] = DropKeys.WOWHEAD,
        [4290] = DropKeys.WOWHEAD,
        [4291] = DropKeys.WOWHEAD,
        [4292] = DropKeys.WOWHEAD,
        [4293] = DropKeys.WOWHEAD,
        [4294] = DropKeys.WOWHEAD,
        [4295] = DropKeys.WOWHEAD,
        [4296] = DropKeys.WOWHEAD,
        [4297] = DropKeys.WOWHEAD,
        [4298] = DropKeys.WOWHEAD,
        [4299] = DropKeys.WOWHEAD,
        [4300] = DropKeys.WOWHEAD,
        [4301] = DropKeys.WOWHEAD,
        [4302] = DropKeys.WOWHEAD,
        [4303] = DropKeys.WOWHEAD,
        [4306] = DropKeys.WOWHEAD,
        [4540] = DropKeys.WOWHEAD,
        [6487] = DropKeys.WOWHEAD,
    },
    [5808] = { -- Pridewing Venom Sac; cmangos→Wowhead Forever peer
        [4011] = DropKeys.WOWHEAD,
        [4012] = DropKeys.WOWHEAD,
        [4013] = DropKeys.WOWHEAD,
        [4014] = DropKeys.WOWHEAD,
        [4015] = DropKeys.WOWHEAD,
        [5928] = DropKeys.WOWHEAD,
    },
    [5809] = { -- Highperch Venom Sac; cmangos→Wowhead Forever peer
        [4107] = DropKeys.WOWHEAD,
        [4109] = DropKeys.WOWHEAD,
        [4110] = DropKeys.WOWHEAD,
        [5934] = DropKeys.WOWHEAD,
    },
    [5810] = { -- Fresh Carcass; cmangos→Wowhead Forever peer
        [2384] = DropKeys.WOWHEAD,
        [2385] = DropKeys.WOWHEAD,
        [2406] = DropKeys.WOWHEAD,
        [2407] = DropKeys.WOWHEAD,
    },
    [5811] = { -- Frostmaw's Mane; cmangos→Wowhead Forever peer
        [4504] = DropKeys.WOWHEAD,
    },
    [5825] = { -- Treshala's Pendant; cmangos→Wowhead Forever peer
        [4420] = DropKeys.WOWHEAD,
        [4424] = DropKeys.WOWHEAD,
        [4427] = DropKeys.WOWHEAD,
        [4428] = DropKeys.WOWHEAD,
        [4435] = DropKeys.WOWHEAD,
        [4436] = DropKeys.WOWHEAD,
        [4437] = DropKeys.WOWHEAD,
        [4438] = DropKeys.WOWHEAD,
        [4440] = DropKeys.WOWHEAD,
        [4442] = DropKeys.WOWHEAD,
        [4515] = DropKeys.WOWHEAD,
        [4516] = DropKeys.WOWHEAD,
        [4517] = DropKeys.WOWHEAD,
        [4518] = DropKeys.WOWHEAD,
        [4519] = DropKeys.WOWHEAD,
        [4520] = DropKeys.WOWHEAD,
        [4522] = DropKeys.WOWHEAD,
        [4523] = DropKeys.WOWHEAD,
        [4525] = DropKeys.WOWHEAD,
        [4530] = DropKeys.WOWHEAD,
        [4531] = DropKeys.WOWHEAD,
        [4532] = DropKeys.WOWHEAD,
        [4623] = DropKeys.WOWHEAD,
        [4842] = DropKeys.WOWHEAD,
        [6035] = DropKeys.WOWHEAD,
        [6168] = DropKeys.WOWHEAD,
    },
    [5830] = { -- Kenata's Head; cmangos→Wowhead Forever peer
        [4480] = DropKeys.WOWHEAD,
    },
    [5831] = { -- Fardel's Head; cmangos→Wowhead Forever peer
        [4479] = DropKeys.WOWHEAD,
    },
    [5832] = { -- Marcel's Head; cmangos→Wowhead Forever peer
        [4481] = DropKeys.WOWHEAD,
    },
    [5837] = { -- Steelsnap's Rib; cmangos→Wowhead Forever peer
        [4548] = DropKeys.WOWHEAD,
    },
    [5840] = { -- Searing Tongue; cmangos→Wowhead Forever peer
        [4323] = DropKeys.WOWHEAD,
        [4324] = DropKeys.WOWHEAD,
    },
    [5841] = { -- Searing Heart; cmangos→Wowhead Forever peer
        [4323] = DropKeys.WOWHEAD,
        [4324] = DropKeys.WOWHEAD,
    },
    [5842] = { -- Unrefined Ore Sample; cmangos→Wowhead Forever peer
        [4113] = DropKeys.WOWHEAD,
        [4116] = DropKeys.WOWHEAD,
        [14427] = DropKeys.WOWHEAD,
    },
    [5843] = { -- Grenka's Claw; cmangos→Wowhead Forever peer
        [4490] = DropKeys.WOWHEAD,
    },
    [5844] = { -- Fragments of Rok'Alim; cmangos→Wowhead Forever peer
        [4499] = DropKeys.WOWHEAD,
    },
    [5847] = { -- Mirefin Head; cmangos→Wowhead Forever peer
        [4358] = DropKeys.WOWHEAD,
        [4359] = DropKeys.WOWHEAD,
        [4360] = DropKeys.WOWHEAD,
        [4361] = DropKeys.WOWHEAD,
        [4362] = DropKeys.WOWHEAD,
        [4363] = DropKeys.WOWHEAD,
        [14230] = DropKeys.WOWHEAD,
    },
    [5848] = { -- Hollow Vulture Bone; cmangos→Wowhead Forever peer
        [4154] = DropKeys.WOWHEAD,
        [4158] = DropKeys.WOWHEAD,
    },
    [5851] = { -- Cozzle's Key; cmangos→Wowhead Forever peer
        [4723] = DropKeys.WOWHEAD,
    },
    [5853] = { -- Intact Silithid Carapace; cmangos→Wowhead Forever peer
        [4130] = DropKeys.WOWHEAD,
        [4131] = DropKeys.WOWHEAD,
        [4132] = DropKeys.WOWHEAD,
        [4133] = DropKeys.WOWHEAD,
    },
    [5854] = { -- Silithid Talon; cmangos→Wowhead Forever peer
        [4130] = DropKeys.WOWHEAD,
        [4131] = DropKeys.WOWHEAD,
        [4132] = DropKeys.WOWHEAD,
        [4133] = DropKeys.WOWHEAD,
    },
    [5855] = { -- Silithid Heart; cmangos→Wowhead Forever peer
        [4130] = DropKeys.WOWHEAD,
        [4131] = DropKeys.WOWHEAD,
        [4132] = DropKeys.WOWHEAD,
        [4133] = DropKeys.WOWHEAD,
    },
    [5879] = { -- Twilight Pendant; cmangos→Wowhead Forever peer
        [4809] = DropKeys.WOWHEAD,
        [4810] = DropKeys.WOWHEAD,
        [4811] = DropKeys.WOWHEAD,
        [4812] = DropKeys.WOWHEAD,
        [4813] = DropKeys.WOWHEAD,
        [4814] = DropKeys.WOWHEAD,
    },
    [5881] = { -- Head of Kelris; cmangos→Wowhead Forever peer
        [4832] = DropKeys.WOWHEAD,
    },
    [5883] = { -- Forked Mudrock Tongue; cmangos→Wowhead Forever peer
        [4396] = DropKeys.WOWHEAD,
        [4397] = DropKeys.WOWHEAD,
        [4398] = DropKeys.WOWHEAD,
        [4399] = DropKeys.WOWHEAD,
        [4400] = DropKeys.WOWHEAD,
    },
    [5884] = { -- Unpopped Darkmist Eye; cmangos→Wowhead Forever peer
        [4376] = DropKeys.WOWHEAD,
        [4377] = DropKeys.WOWHEAD,
        [4378] = DropKeys.WOWHEAD,
        [4379] = DropKeys.WOWHEAD,
        [4380] = DropKeys.WOWHEAD,
    },
    [5938] = { -- Pristine Crawler Leg; cmangos→Wowhead Forever peer
        [922] = DropKeys.WOWHEAD,
        [1088] = DropKeys.WOWHEAD,
    },
    [5942] = { -- Jeweled Pendant; cmangos→Wowhead Forever peer
        [4401] = DropKeys.WOWHEAD,
        [4402] = DropKeys.WOWHEAD,
        [4403] = DropKeys.WOWHEAD,
        [4404] = DropKeys.WOWHEAD,
        [4405] = DropKeys.WOWHEAD,
        [14236] = DropKeys.WOWHEAD,
    },
    [5945] = { -- Deadmire's Tooth; cmangos→Wowhead Forever peer
        [4841] = DropKeys.WOWHEAD,
    },
    [5952] = { -- Corrupted Brain Stem; cmangos→Wowhead Forever peer
        [4788] = DropKeys.WOWHEAD,
        [4789] = DropKeys.WOWHEAD,
        [4798] = DropKeys.WOWHEAD,
        [4799] = DropKeys.WOWHEAD,
        [4802] = DropKeys.WOWHEAD,
        [4803] = DropKeys.WOWHEAD,
        [4805] = DropKeys.WOWHEAD,
        [4807] = DropKeys.WOWHEAD,
        [4831] = DropKeys.WOWHEAD,
    },
    [5959] = { -- Acidic Venom Sac; cmangos→Wowhead Forever peer
        [4411] = DropKeys.WOWHEAD,
        [4412] = DropKeys.WOWHEAD,
        [4413] = DropKeys.WOWHEAD,
        [4414] = DropKeys.WOWHEAD,
        [4415] = DropKeys.WOWHEAD,
    },
    [6065] = { -- Khadgar's Essays on Dimensional Convergence; cmangos→Wowhead Forever peer
        [764] = DropKeys.WOWHEAD,
        [765] = DropKeys.WOWHEAD,
        [766] = DropKeys.WOWHEAD,
        [1081] = DropKeys.WOWHEAD,
    },
    [6066] = { -- Khan Dez'hepah's Head; cmangos→Wowhead Forever peer
        [5600] = DropKeys.WOWHEAD,
    },
    [6067] = { -- Centaur Ear; cmangos→Wowhead Forever peer
        [4632] = DropKeys.WOWHEAD,
        [4633] = DropKeys.WOWHEAD,
        [4634] = DropKeys.WOWHEAD,
        [4635] = DropKeys.WOWHEAD,
        [4636] = DropKeys.WOWHEAD,
        [4637] = DropKeys.WOWHEAD,
        [4638] = DropKeys.WOWHEAD,
        [4639] = DropKeys.WOWHEAD,
        [4640] = DropKeys.WOWHEAD,
        [4641] = DropKeys.WOWHEAD,
        [4642] = DropKeys.WOWHEAD,
        [4643] = DropKeys.WOWHEAD,
        [4644] = DropKeys.WOWHEAD,
        [4645] = DropKeys.WOWHEAD,
        [4646] = DropKeys.WOWHEAD,
        [4647] = DropKeys.WOWHEAD,
        [4648] = DropKeys.WOWHEAD,
        [4649] = DropKeys.WOWHEAD,
        [4651] = DropKeys.WOWHEAD,
        [4652] = DropKeys.WOWHEAD,
        [4653] = DropKeys.WOWHEAD,
        [4654] = DropKeys.WOWHEAD,
        [4655] = DropKeys.WOWHEAD,
        [4656] = DropKeys.WOWHEAD,
        [4657] = DropKeys.WOWHEAD,
        [4658] = DropKeys.WOWHEAD,
        [4659] = DropKeys.WOWHEAD,
        [5402] = DropKeys.WOWHEAD,
        [5600] = DropKeys.WOWHEAD,
        [5601] = DropKeys.WOWHEAD,
        [5602] = DropKeys.WOWHEAD,
        [6068] = DropKeys.WOWHEAD,
        [6069] = DropKeys.WOWHEAD,
        [11559] = DropKeys.WOWHEAD,
        [12976] = DropKeys.WOWHEAD,
        [12977] = DropKeys.WOWHEAD,
    },
    [6072] = { -- Khan Jehn's Head; cmangos→Wowhead Forever peer
        [5601] = DropKeys.WOWHEAD,
    },
    [6073] = { -- Khan Shaka's Head; cmangos→Wowhead Forever peer
        [5602] = DropKeys.WOWHEAD,
    },
    [6074] = { -- War Horn Mouthpiece; cmangos→Wowhead Forever peer
        [4654] = DropKeys.WOWHEAD,
        [4655] = DropKeys.WOWHEAD,
        [4656] = DropKeys.WOWHEAD,
        [4657] = DropKeys.WOWHEAD,
        [4658] = DropKeys.WOWHEAD,
        [4659] = DropKeys.WOWHEAD,
        [6069] = DropKeys.WOWHEAD,
        [6070] = DropKeys.WOWHEAD,
    },
    [6077] = { -- Maraudine Key Fragment; cmangos→Wowhead Forever peer
        [5402] = DropKeys.WOWHEAD,
    },
    [6079] = { -- Crude Charm; cmangos→Wowhead Forever peer
        [4632] = DropKeys.WOWHEAD,
        [4633] = DropKeys.WOWHEAD,
        [4634] = DropKeys.WOWHEAD,
        [4635] = DropKeys.WOWHEAD,
        [4636] = DropKeys.WOWHEAD,
        [4637] = DropKeys.WOWHEAD,
        [12976] = DropKeys.WOWHEAD,
        [12977] = DropKeys.WOWHEAD,
    },
    [6080] = { -- Shadow Panther Heart; cmangos→Wowhead Forever peer
        [768] = DropKeys.WOWHEAD,
    },
    [6081] = { -- Mire Lord Fungus; cmangos→Wowhead Forever peer
        [1081] = DropKeys.WOWHEAD,
    },
    [6082] = { -- Deepstrider Tumor; cmangos→Wowhead Forever peer
        [4686] = DropKeys.WOWHEAD,
        [4687] = DropKeys.WOWHEAD,
    },
    [6166] = { -- Coyote Jawbone; cmangos→Wowhead Forever peer
        [2727] = DropKeys.WOWHEAD,
        [2728] = DropKeys.WOWHEAD,
        [2729] = DropKeys.WOWHEAD,
        [2730] = DropKeys.WOWHEAD,
    },
    [6168] = { -- Sawtooth Snapper Claw; cmangos→Wowhead Forever peer
        [1087] = DropKeys.WOWHEAD,
    },
    [6169] = { -- Unprepared Sawtooth Flank; cmangos→Wowhead Forever peer
        [1082] = DropKeys.WOWHEAD,
        [1087] = DropKeys.WOWHEAD,
    },
    [6181] = { -- Fetish of Hakkar; cmangos→Wowhead Forever peer
        [5243] = DropKeys.WOWHEAD,
        [5256] = DropKeys.WOWHEAD,
        [5259] = DropKeys.WOWHEAD,
        [5261] = DropKeys.WOWHEAD,
        [5263] = DropKeys.WOWHEAD,
        [5267] = DropKeys.WOWHEAD,
        [5269] = DropKeys.WOWHEAD,
        [5270] = DropKeys.WOWHEAD,
        [5271] = DropKeys.WOWHEAD,
        [5273] = DropKeys.WOWHEAD,
        [5399] = DropKeys.WOWHEAD,
        [5400] = DropKeys.WOWHEAD,
        [5401] = DropKeys.WOWHEAD,
        [5710] = DropKeys.WOWHEAD,
        [5711] = DropKeys.WOWHEAD,
        [5712] = DropKeys.WOWHEAD,
        [5713] = DropKeys.WOWHEAD,
        [5714] = DropKeys.WOWHEAD,
        [5715] = DropKeys.WOWHEAD,
        [5716] = DropKeys.WOWHEAD,
        [5717] = DropKeys.WOWHEAD,
        [8580] = DropKeys.WOWHEAD,
    },
    [6184] = { -- Monstrous Crawler Leg; cmangos→Wowhead Forever peer
        [1088] = DropKeys.WOWHEAD,
    },
    [6190] = { -- Draenethyst Shard; cmangos→Wowhead Forever peer
        [5622] = DropKeys.WOWHEAD,
    },
    [6212] = { -- Head of Jammal'an; cmangos→Wowhead Forever peer
        [5710] = DropKeys.WOWHEAD,
    },
    [6245] = { -- Karnitol's Satchel; cmangos→Wowhead Forever peer
        [4716] = DropKeys.WOWHEAD,
        [4719] = DropKeys.WOWHEAD,
    },
    [6246] = { -- Hatefury Claw; cmangos→Wowhead Forever peer
        [4670] = DropKeys.WOWHEAD,
        [4671] = DropKeys.WOWHEAD,
        [4672] = DropKeys.WOWHEAD,
        [4673] = DropKeys.WOWHEAD,
        [4674] = DropKeys.WOWHEAD,
        [4675] = DropKeys.WOWHEAD,
        [14225] = DropKeys.WOWHEAD,
    },
    [6247] = { -- Hatefury Horn; cmangos→Wowhead Forever peer
        [4670] = DropKeys.WOWHEAD,
        [4671] = DropKeys.WOWHEAD,
        [4672] = DropKeys.WOWHEAD,
        [4673] = DropKeys.WOWHEAD,
        [4674] = DropKeys.WOWHEAD,
        [4675] = DropKeys.WOWHEAD,
        [14225] = DropKeys.WOWHEAD,
    },
    [6248] = { -- Scorpashi Venom; cmangos→Wowhead Forever peer
        [4696] = DropKeys.WOWHEAD,
        [4697] = DropKeys.WOWHEAD,
        [4699] = DropKeys.WOWHEAD,
    },
    [6249] = { -- Aged Kodo Hide; cmangos→Wowhead Forever peer
        [4700] = DropKeys.WOWHEAD,
    },
    [6281] = { -- Rattlecage Skull; cmangos→Wowhead Forever peer
        [1890] = DropKeys.WOWHEAD,
    },
    [6312] = { -- Dalin's Heart; cmangos→Wowhead Forever peer
        [5682] = DropKeys.WOWHEAD,
    },
    [6313] = { -- Comar's Heart; cmangos→Wowhead Forever peer
        [5683] = DropKeys.WOWHEAD,
    },
    [6441] = { -- Shadowstalker Scalp; cmangos→Wowhead Forever peer
        [4674] = DropKeys.WOWHEAD,
    },
    [6442] = { -- Oracle Crystal; cmangos→Wowhead Forever peer
        [4718] = DropKeys.WOWHEAD,
    },
    [6464] = { -- Wailing Essence; cmangos→Wowhead Forever peer
        [3638] = DropKeys.WOWHEAD,
        [3640] = DropKeys.WOWHEAD,
        [5763] = DropKeys.WOWHEAD,
    },
    [6486] = { -- Singed Scale; cmangos→Wowhead Forever peer
        [3130] = DropKeys.WOWHEAD,
        [3131] = DropKeys.WOWHEAD,
    },
    [6487] = { -- Vile Familiar Head; cmangos→Wowhead Forever peer
        [3101] = DropKeys.WOWHEAD,
    },
    [6634] = { -- Ritual Salve; cmangos→Wowhead Forever peer
        [2953] = DropKeys.WOWHEAD,
    },
    [6640] = { -- Felstalker Hoof; cmangos→Wowhead Forever peer
        [3102] = DropKeys.WOWHEAD,
    },
    [6655] = { -- Glowing Ember; cmangos→Wowhead Forever peer
        [5893] = DropKeys.WOWHEAD,
    },
    [6753] = { -- Feather Charm; cmangos→Wowhead Forever peer
        [946] = DropKeys.WOWHEAD,
    },
    [6767] = { -- Tyranis' Pendant; cmangos→Wowhead Forever peer
        [5643] = DropKeys.WOWHEAD,
    },
    [6783] = { -- Dead-tooth's Key; cmangos→Wowhead Forever peer
        [6093] = DropKeys.WOWHEAD,
    },
    [6799] = { -- Vejrek's Head; cmangos→Wowhead Forever peer
        [6113] = DropKeys.WOWHEAD,
    },
    [6805] = { -- Horn of Vorlus; cmangos→Wowhead Forever peer
        [6128] = DropKeys.WOWHEAD,
    },
    [6809] = { -- Elura's Medallion; cmangos→Wowhead Forever peer
        [6133] = DropKeys.WOWHEAD,
    },
    [6810] = { -- Surena's Choker; cmangos→Wowhead Forever peer
        [881] = DropKeys.WOWHEAD,
    },
    [6838] = { -- Scorched Spider Fang; cmangos→Wowhead Forever peer
        [1111] = DropKeys.WOWHEAD,
        [4040] = DropKeys.WOWHEAD,
    },
    [6839] = { -- Charred Horn; cmangos→Wowhead Forever peer
        [4031] = DropKeys.WOWHEAD,
        [4032] = DropKeys.WOWHEAD,
    },
    [6840] = { -- Galvanized Horn; cmangos→Wowhead Forever peer
        [6167] = DropKeys.WOWHEAD,
    },
    [6841] = { -- Vial of Phlogiston; cmangos→Wowhead Forever peer
        [6168] = DropKeys.WOWHEAD,
    },
    [6844] = { -- Burning Blood; cmangos→Wowhead Forever peer
        [205] = DropKeys.WOWHEAD,
        [206] = DropKeys.WOWHEAD,
        [533] = DropKeys.WOWHEAD,
        [898] = DropKeys.WOWHEAD,
        [920] = DropKeys.WOWHEAD,
    },
    [6845] = { -- Burning Rock; cmangos→Wowhead Forever peer
        [6170] = DropKeys.WOWHEAD,
    },
    [6846] = { -- Defias Script; cmangos→Wowhead Forever peer
        [474] = DropKeys.WOWHEAD,
    },
    [6847] = { -- Dark Iron Script; cmangos→Wowhead Forever peer
        [6123] = DropKeys.WOWHEAD,
    },
    [6894] = { -- Whirlwind Heart; cmangos→Wowhead Forever peer
        [6239] = DropKeys.WOWHEAD,
    },
    [6914] = { -- Soran'ruk Fragment; cmangos→Wowhead Forever peer
        [4809] = DropKeys.WOWHEAD,
    },
    [6930] = { -- Rod of Channeling; cmangos→Wowhead Forever peer
        [1038] = DropKeys.WOWHEAD,
        [1057] = DropKeys.WOWHEAD,
    },
    [6952] = { -- Thick Bear Fur; cmangos→Wowhead Forever peer
        [1128] = DropKeys.WOWHEAD,
        [1196] = DropKeys.WOWHEAD,
    },
    [6989] = { -- Vial of Hatefury Blood; cmangos→Wowhead Forever peer
        [4670] = DropKeys.WOWHEAD,
        [4671] = DropKeys.WOWHEAD,
        [4672] = DropKeys.WOWHEAD,
        [4673] = DropKeys.WOWHEAD,
        [4674] = DropKeys.WOWHEAD,
        [4675] = DropKeys.WOWHEAD,
        [14225] = DropKeys.WOWHEAD,
    },
    [6990] = { -- Lesser Infernal Stone; cmangos→Wowhead Forever peer
        [4676] = DropKeys.WOWHEAD,
        [11937] = DropKeys.WOWHEAD,
    },
    [6991] = { -- Smoldering Coal; cmangos→Wowhead Forever peer
        [2760] = DropKeys.WOWHEAD,
    },
    [6994] = { -- Whitestone Oak Lumber; cmangos→Wowhead Forever peer
        [641] = DropKeys.WOWHEAD,
    },
    [6995] = { -- Corrupted Kor Gem; cmangos→Wowhead Forever peer
        [4802] = DropKeys.WOWHEAD,
        [4803] = DropKeys.WOWHEAD,
        [4805] = DropKeys.WOWHEAD,
    },
    [7119] = { -- Twitching Antenna; cmangos→Wowhead Forever peer
        [3250] = DropKeys.WOWHEAD,
        [3251] = DropKeys.WOWHEAD,
        [3252] = DropKeys.WOWHEAD,
        [3253] = DropKeys.WOWHEAD,
        [3503] = DropKeys.WOWHEAD,
    },
    [7126] = { -- Smoky Iron Ingot; cmangos→Wowhead Forever peer
        [3998] = DropKeys.WOWHEAD,
        [3999] = DropKeys.WOWHEAD,
        [4001] = DropKeys.WOWHEAD,
        [4002] = DropKeys.WOWHEAD,
        [4003] = DropKeys.WOWHEAD,
        [4004] = DropKeys.WOWHEAD,
    },
    [7127] = { -- Powdered Azurite; cmangos→Wowhead Forever peer
        [2269] = DropKeys.WOWHEAD,
    },
    [7128] = { -- Uncloven Satyr Hoof; cmangos→Wowhead Forever peer
        [3752] = DropKeys.WOWHEAD,
        [3754] = DropKeys.WOWHEAD,
        [3755] = DropKeys.WOWHEAD,
        [3757] = DropKeys.WOWHEAD,
        [3758] = DropKeys.WOWHEAD,
        [3759] = DropKeys.WOWHEAD,
        [3762] = DropKeys.WOWHEAD,
        [3763] = DropKeys.WOWHEAD,
        [3765] = DropKeys.WOWHEAD,
        [3767] = DropKeys.WOWHEAD,
        [3770] = DropKeys.WOWHEAD,
        [3771] = DropKeys.WOWHEAD,
    },
    [7131] = { -- Dragonmaw Shinbone; cmangos→Wowhead Forever peer
        [1034] = DropKeys.WOWHEAD,
        [1035] = DropKeys.WOWHEAD,
        [1036] = DropKeys.WOWHEAD,
        [1037] = DropKeys.WOWHEAD,
        [1038] = DropKeys.WOWHEAD,
        [1057] = DropKeys.WOWHEAD,
        [2108] = DropKeys.WOWHEAD,
    },
    [7209] = { -- Tazan's Satchel; cmangos→Wowhead Forever peer
        [6494] = DropKeys.WOWHEAD,
    },
    [7231] = { -- Astor's Letter of Introduction; cmangos→Wowhead Forever peer
        [6497] = DropKeys.WOWHEAD,
    },
    [7270] = { -- Laughing Sister's Hair; cmangos→Wowhead Forever peer
        [4054] = DropKeys.WOWHEAD,
    },
    [7273] = { -- Witherbark Totem Stick; cmangos→Wowhead Forever peer
        [2552] = DropKeys.WOWHEAD,
        [2553] = DropKeys.WOWHEAD,
        [2554] = DropKeys.WOWHEAD,
        [2555] = DropKeys.WOWHEAD,
        [2556] = DropKeys.WOWHEAD,
        [2557] = DropKeys.WOWHEAD,
        [2558] = DropKeys.WOWHEAD,
    },
    [7293] = { -- Dalaran Mana Gem; cmangos→Wowhead Forever peer
        [1867] = DropKeys.WOWHEAD,
        [1888] = DropKeys.WOWHEAD,
        [1889] = DropKeys.WOWHEAD,
        [1912] = DropKeys.WOWHEAD,
        [1913] = DropKeys.WOWHEAD,
        [1914] = DropKeys.WOWHEAD,
        [1915] = DropKeys.WOWHEAD,
        [3577] = DropKeys.WOWHEAD,
        [3578] = DropKeys.WOWHEAD,
    },
    [7306] = { -- Fenwick's Head; cmangos→Wowhead Forever peer
        [6570] = DropKeys.WOWHEAD,
    },
    [7365] = { -- Gnoam Sprecklesprocket; cmangos→Wowhead Forever peer
        [642] = DropKeys.WOWHEAD,
    },
    [7498] = { -- Top of Gelkak's Key; cmangos→Wowhead Forever peer
        [2323] = DropKeys.WOWHEAD,
    },
    [7499] = { -- Middle of Gelkak's Key; cmangos→Wowhead Forever peer
        [2201] = DropKeys.WOWHEAD,
        [2202] = DropKeys.WOWHEAD,
        [2203] = DropKeys.WOWHEAD,
        [2204] = DropKeys.WOWHEAD,
        [2205] = DropKeys.WOWHEAD,
        [2206] = DropKeys.WOWHEAD,
        [2207] = DropKeys.WOWHEAD,
        [2208] = DropKeys.WOWHEAD,
        [10323] = DropKeys.WOWHEAD,
    },
    [7500] = { -- Bottom of Gelkak's Key; cmangos→Wowhead Forever peer
        [2233] = DropKeys.WOWHEAD,
        [2236] = DropKeys.WOWHEAD,
    },
    [7670] = { -- Shattered Necklace Sapphire; cmangos→Wowhead Forever peer
        [4854] = DropKeys.WOWHEAD,
    },
    [7672] = { -- Shattered Necklace Power Source; cmangos→Wowhead Forever peer
        [2748] = DropKeys.WOWHEAD,
    },
    [7812] = { -- Corrupt Manifestation's Bracers; cmangos→Wowhead Forever peer
        [5894] = DropKeys.WOWHEAD,
    },
    [7846] = { -- Crag Coyote Fang; cmangos→Wowhead Forever peer
        [2727] = DropKeys.WOWHEAD,
        [2728] = DropKeys.WOWHEAD,
        [2729] = DropKeys.WOWHEAD,
        [2730] = DropKeys.WOWHEAD,
    },
    [7847] = { -- Buzzard Gizzard; cmangos→Wowhead Forever peer
        [2829] = DropKeys.WOWHEAD,
        [2830] = DropKeys.WOWHEAD,
        [2831] = DropKeys.WOWHEAD,
    },
    [7848] = { -- Rock Elemental Shard; cmangos→Wowhead Forever peer
        [92] = DropKeys.WOWHEAD,
        [2735] = DropKeys.WOWHEAD,
        [2736] = DropKeys.WOWHEAD,
        [2745] = DropKeys.WOWHEAD,
        [2752] = DropKeys.WOWHEAD,
        [2791] = DropKeys.WOWHEAD,
        [2919] = DropKeys.WOWHEAD,
        [8278] = DropKeys.WOWHEAD,
    },
    [7906] = { -- Horns of Nez'ra; cmangos→Wowhead Forever peer
        [437] = DropKeys.WOWHEAD,
        [485] = DropKeys.WOWHEAD,
        [615] = DropKeys.WOWHEAD,
    },
    [7923] = { -- Defias Tower Key; cmangos→Wowhead Forever peer
        [7051] = DropKeys.WOWHEAD,
    },
    [8009] = { -- Dentrium Power Stone; cmangos→Wowhead Forever peer
        [4844] = DropKeys.WOWHEAD,
        [4845] = DropKeys.WOWHEAD,
        [4846] = DropKeys.WOWHEAD,
        [4847] = DropKeys.WOWHEAD,
        [4848] = DropKeys.WOWHEAD,
        [4849] = DropKeys.WOWHEAD,
        [7030] = DropKeys.WOWHEAD,
        [7091] = DropKeys.WOWHEAD,
        [7290] = DropKeys.WOWHEAD,
    },
    [8049] = { -- Gnarlpine Necklace; cmangos→Wowhead Forever peer
        [7234] = DropKeys.WOWHEAD,
    },
    [8052] = { -- An'Alleum Power Stone; cmangos→Wowhead Forever peer
        [4844] = DropKeys.WOWHEAD,
        [4845] = DropKeys.WOWHEAD,
        [4846] = DropKeys.WOWHEAD,
        [4847] = DropKeys.WOWHEAD,
        [4848] = DropKeys.WOWHEAD,
        [4849] = DropKeys.WOWHEAD,
        [7030] = DropKeys.WOWHEAD,
        [7091] = DropKeys.WOWHEAD,
        [7290] = DropKeys.WOWHEAD,
    },
    [8053] = { -- Obsidian Power Source; cmangos→Wowhead Forever peer
        [7023] = DropKeys.WOWHEAD,
    },
    [8074] = { -- Gallywix's Head; cmangos→Wowhead Forever peer
        [7288] = DropKeys.WOWHEAD,
    },
    [8136] = { -- Gargantuan Tumor; cmangos→Wowhead Forever peer
        [2166] = DropKeys.WOWHEAD,
    },
    [8344] = { -- Silvery Spinnerets; cmangos→Wowhead Forever peer
        [7319] = DropKeys.WOWHEAD,
    },
    [8363] = { -- Shaman Voodoo Charm; cmangos→Wowhead Forever peer
        [2009] = DropKeys.WOWHEAD,
    },
    [8428] = { -- Laden Dew Gland; cmangos→Wowhead Forever peer
        [5481] = DropKeys.WOWHEAD,
    },
    [8463] = { -- Warchief's Orders; cmangos→Wowhead Forever peer
        [950] = DropKeys.WOWHEAD,
    },
    [8548] = { -- Divino-matic Rod; cmangos→Wowhead Forever peer
        [7604] = DropKeys.WOWHEAD,
    },
    [8587] = { -- Centipaar Insect Parts; cmangos→Wowhead Forever peer
        [5455] = DropKeys.WOWHEAD,
        [5456] = DropKeys.WOWHEAD,
        [5457] = DropKeys.WOWHEAD,
        [5458] = DropKeys.WOWHEAD,
        [5459] = DropKeys.WOWHEAD,
        [5460] = DropKeys.WOWHEAD,
    },
    [8707] = { -- Gahz'rilla's Electrified Scale; cmangos→Wowhead Forever peer
        [7273] = DropKeys.WOWHEAD,
    },
    [8723] = { -- Caliph Scorpidsting's Head; cmangos→Wowhead Forever peer
        [7847] = DropKeys.WOWHEAD,
    },
    [8973] = { -- Thick Yeti Hide; cmangos→Wowhead Forever peer
        [5292] = DropKeys.WOWHEAD,
        [5293] = DropKeys.WOWHEAD,
        [5295] = DropKeys.WOWHEAD,
        [5346] = DropKeys.WOWHEAD,
        [7848] = DropKeys.WOWHEAD,
    },
    [9234] = { -- Tiara of the Deep; cmangos→Wowhead Forever peer
        [7795] = DropKeys.WOWHEAD,
    },
    [9237] = { -- Woodpaw Gnoll Mane; cmangos→Wowhead Forever peer
        [5249] = DropKeys.WOWHEAD,
        [5251] = DropKeys.WOWHEAD,
        [5253] = DropKeys.WOWHEAD,
        [5254] = DropKeys.WOWHEAD,
        [5255] = DropKeys.WOWHEAD,
        [5258] = DropKeys.WOWHEAD,
    },
    [9238] = { -- Uncracked Scarab Shell; cmangos→Wowhead Forever peer
        [7269] = DropKeys.WOWHEAD,
    },
    [9246] = { -- Firebeard's Head; cmangos→Wowhead Forever peer
        [7883] = DropKeys.WOWHEAD,
    },
    [9247] = { -- Hatecrest Naga Scale; cmangos→Wowhead Forever peer
        [5331] = DropKeys.WOWHEAD,
        [5332] = DropKeys.WOWHEAD,
        [5333] = DropKeys.WOWHEAD,
        [5334] = DropKeys.WOWHEAD,
        [5335] = DropKeys.WOWHEAD,
        [5336] = DropKeys.WOWHEAD,
        [5337] = DropKeys.WOWHEAD,
        [5343] = DropKeys.WOWHEAD,
        [8136] = DropKeys.WOWHEAD,
    },
    [9248] = { -- Mysterious Relic; cmangos→Wowhead Forever peer
        [8136] = DropKeys.WOWHEAD,
    },
    [9259] = { -- Troll Tribal Necklace; cmangos→Wowhead Forever peer
        [2639] = DropKeys.WOWHEAD,
        [2640] = DropKeys.WOWHEAD,
        [2641] = DropKeys.WOWHEAD,
        [2642] = DropKeys.WOWHEAD,
        [2643] = DropKeys.WOWHEAD,
        [2644] = DropKeys.WOWHEAD,
        [2645] = DropKeys.WOWHEAD,
        [2646] = DropKeys.WOWHEAD,
        [2647] = DropKeys.WOWHEAD,
        [2648] = DropKeys.WOWHEAD,
        [2649] = DropKeys.WOWHEAD,
        [2650] = DropKeys.WOWHEAD,
        [2651] = DropKeys.WOWHEAD,
        [2652] = DropKeys.WOWHEAD,
        [2653] = DropKeys.WOWHEAD,
        [2654] = DropKeys.WOWHEAD,
        [4465] = DropKeys.WOWHEAD,
        [4466] = DropKeys.WOWHEAD,
        [4467] = DropKeys.WOWHEAD,
        [7809] = DropKeys.WOWHEAD,
        [7995] = DropKeys.WOWHEAD,
        [7996] = DropKeys.WOWHEAD,
        [8216] = DropKeys.WOWHEAD,
        [8217] = DropKeys.WOWHEAD,
        [8218] = DropKeys.WOWHEAD,
        [8219] = DropKeys.WOWHEAD,
        [8636] = DropKeys.WOWHEAD,
        [10802] = DropKeys.WOWHEAD,
    },
    [9275] = { -- Cuergo's Key; cmangos→Wowhead Forever peer
        [7899] = DropKeys.WOWHEAD,
        [7901] = DropKeys.WOWHEAD,
        [7902] = DropKeys.WOWHEAD,
    },
    [9277] = { -- Techbot's Memory Core; cmangos→Wowhead Forever peer
        [6231] = DropKeys.WOWHEAD,
    },
    [9299] = { -- Thermaplugg's Safe Combination; cmangos→Wowhead Forever peer
        [7800] = DropKeys.WOWHEAD,
    },
    [9309] = { -- Robo-mechanical Guts; cmangos→Wowhead Forever peer
        [6206] = DropKeys.WOWHEAD,
        [6207] = DropKeys.WOWHEAD,
        [6208] = DropKeys.WOWHEAD,
        [6211] = DropKeys.WOWHEAD,
        [6212] = DropKeys.WOWHEAD,
        [6213] = DropKeys.WOWHEAD,
        [6218] = DropKeys.WOWHEAD,
        [6219] = DropKeys.WOWHEAD,
        [6220] = DropKeys.WOWHEAD,
        [6222] = DropKeys.WOWHEAD,
        [6223] = DropKeys.WOWHEAD,
        [6224] = DropKeys.WOWHEAD,
        [6225] = DropKeys.WOWHEAD,
        [6226] = DropKeys.WOWHEAD,
        [6227] = DropKeys.WOWHEAD,
        [6229] = DropKeys.WOWHEAD,
        [6230] = DropKeys.WOWHEAD,
        [6231] = DropKeys.WOWHEAD,
        [6232] = DropKeys.WOWHEAD,
        [6233] = DropKeys.WOWHEAD,
        [6234] = DropKeys.WOWHEAD,
        [6235] = DropKeys.WOWHEAD,
        [6329] = DropKeys.WOWHEAD,
        [7603] = DropKeys.WOWHEAD,
        [7800] = DropKeys.WOWHEAD,
    },
    [9320] = { -- Witherbark Skull; cmangos→Wowhead Forever peer
        [2649] = DropKeys.WOWHEAD,
        [2650] = DropKeys.WOWHEAD,
        [2651] = DropKeys.WOWHEAD,
        [2652] = DropKeys.WOWHEAD,
        [2653] = DropKeys.WOWHEAD,
        [2654] = DropKeys.WOWHEAD,
    },
    [9322] = { -- Undamaged Venom Sac; cmangos→Wowhead Forever peer
        [2686] = DropKeys.WOWHEAD,
    },
    [9324] = { -- Shadra's Venom; cmangos→Wowhead Forever peer
        [2707] = DropKeys.WOWHEAD,
    },
    [9371] = { -- Gordunni Orb; cmangos→Wowhead Forever peer
        [5239] = DropKeys.WOWHEAD,
    },
    [9437] = { -- Untested Basilisk Sample; cmangos→Wowhead Forever peer
        [5419] = DropKeys.WOWHEAD,
        [5420] = DropKeys.WOWHEAD,
        [5421] = DropKeys.WOWHEAD,
    },
    [9439] = { -- Untested Hyena Sample; cmangos→Wowhead Forever peer
        [5425] = DropKeys.WOWHEAD,
        [5426] = DropKeys.WOWHEAD,
        [5427] = DropKeys.WOWHEAD,
        [8208] = DropKeys.WOWHEAD,
    },
    [9442] = { -- Untested Scorpid Sample; cmangos→Wowhead Forever peer
        [5422] = DropKeys.WOWHEAD,
        [5423] = DropKeys.WOWHEAD,
        [5424] = DropKeys.WOWHEAD,
        [7803] = DropKeys.WOWHEAD,
    },
    [9460] = { -- Grimtotem Horn; cmangos→Wowhead Forever peer
        [7725] = DropKeys.WOWHEAD,
        [7726] = DropKeys.WOWHEAD,
        [7727] = DropKeys.WOWHEAD,
    },
    [9471] = { -- Nekrum's Medallion; cmangos→Wowhead Forever peer
        [7796] = DropKeys.WOWHEAD,
    },
    [9472] = { -- Hexx's Key; cmangos→Wowhead Forever peer
        [7995] = DropKeys.WOWHEAD,
    },
    [9523] = { -- Troll Temper; cmangos→Wowhead Forever peer
        [5648] = DropKeys.WOWHEAD,
        [5649] = DropKeys.WOWHEAD,
        [5650] = DropKeys.WOWHEAD,
        [7246] = DropKeys.WOWHEAD,
        [7247] = DropKeys.WOWHEAD,
        [7267] = DropKeys.WOWHEAD,
        [7272] = DropKeys.WOWHEAD,
        [7274] = DropKeys.WOWHEAD,
        [7276] = DropKeys.WOWHEAD,
        [7286] = DropKeys.WOWHEAD,
        [7796] = DropKeys.WOWHEAD,
        [7797] = DropKeys.WOWHEAD,
        [8127] = DropKeys.WOWHEAD,
        [10080] = DropKeys.WOWHEAD,
        [10081] = DropKeys.WOWHEAD,
        [10082] = DropKeys.WOWHEAD,
    },
    [9528] = { -- Edana's Dark Heart; cmangos→Wowhead Forever peer
        [8075] = DropKeys.WOWHEAD,
    },
    [9530] = { -- Horn of Hatetalon; cmangos→Wowhead Forever peer
        [5362] = DropKeys.WOWHEAD,
        [5363] = DropKeys.WOWHEAD,
        [5364] = DropKeys.WOWHEAD,
        [5366] = DropKeys.WOWHEAD,
    },
    [9589] = { -- Encrusted Minerals; cmangos→Wowhead Forever peer
        [5276] = DropKeys.WOWHEAD,
        [5278] = DropKeys.WOWHEAD,
        [5357] = DropKeys.WOWHEAD,
        [5358] = DropKeys.WOWHEAD,
        [7997] = DropKeys.WOWHEAD,
    },
    [9590] = { -- Splintered Log; cmangos→Wowhead Forever peer
        [7584] = DropKeys.WOWHEAD,
    },
    [9591] = { -- Resilient Sinew; cmangos→Wowhead Forever peer
        [2927] = DropKeys.WOWHEAD,
        [2928] = DropKeys.WOWHEAD,
        [2929] = DropKeys.WOWHEAD,
        [5300] = DropKeys.WOWHEAD,
        [5304] = DropKeys.WOWHEAD,
        [5305] = DropKeys.WOWHEAD,
        [5306] = DropKeys.WOWHEAD,
        [5347] = DropKeys.WOWHEAD,
        [7808] = DropKeys.WOWHEAD,
    },
    [9592] = { -- Metallic Fragments; cmangos→Wowhead Forever peer
        [2927] = DropKeys.WOWHEAD,
        [2928] = DropKeys.WOWHEAD,
        [2929] = DropKeys.WOWHEAD,
        [5300] = DropKeys.WOWHEAD,
        [5304] = DropKeys.WOWHEAD,
        [5305] = DropKeys.WOWHEAD,
        [5306] = DropKeys.WOWHEAD,
        [5347] = DropKeys.WOWHEAD,
        [5357] = DropKeys.WOWHEAD,
        [5358] = DropKeys.WOWHEAD,
        [7584] = DropKeys.WOWHEAD,
        [7808] = DropKeys.WOWHEAD,
    },
    [9738] = { -- Gem of Cobrahn; cmangos→Wowhead Forever peer
        [3669] = DropKeys.WOWHEAD,
    },
    [9739] = { -- Gem of Anacondra; cmangos→Wowhead Forever peer
        [3671] = DropKeys.WOWHEAD,
    },
    [9740] = { -- Gem of Pythas; cmangos→Wowhead Forever peer
        [3670] = DropKeys.WOWHEAD,
    },
    [9741] = { -- Gem of Serpentis; cmangos→Wowhead Forever peer
        [3673] = DropKeys.WOWHEAD,
    },
    [10338] = { -- Fresh Zhevra Carcass; cmangos→Wowhead Forever peer
        [3242] = DropKeys.WOWHEAD,
        [3426] = DropKeys.WOWHEAD,
        [3466] = DropKeys.WOWHEAD,
    },
    [10420] = { -- Skull of the Coldbringer; cmangos→Wowhead Forever peer
        [7358] = DropKeys.WOWHEAD,
    },
    [10446] = { -- Heart of Obsidion; cmangos→Wowhead Forever peer
        [8400] = DropKeys.WOWHEAD,
    },
    [10447] = { -- Head of Lathoric the Black; cmangos→Wowhead Forever peer
        [8391] = DropKeys.WOWHEAD,
    },
    [10459] = { -- Chief Sharptusk Thornmantle's Head; cmangos→Wowhead Forever peer
        [8554] = DropKeys.WOWHEAD,
    },
    [10467] = { -- Trader's Satchel; cmangos→Wowhead Forever peer
        [8444] = DropKeys.WOWHEAD,
    },
    [10509] = { -- Heart of Flame; cmangos→Wowhead Forever peer
        [5850] = DropKeys.WOWHEAD,
        [5852] = DropKeys.WOWHEAD,
        [5855] = DropKeys.WOWHEAD,
    },
    [10511] = { -- Golem Oil; cmangos→Wowhead Forever peer
        [5853] = DropKeys.WOWHEAD,
        [5854] = DropKeys.WOWHEAD,
        [5855] = DropKeys.WOWHEAD,
    },
    [10597] = { -- Head of Magus Rimtori; cmangos→Wowhead Forever peer
        [8578] = DropKeys.WOWHEAD,
    },
    [10598] = { -- Hetaera's Bloodied Head; cmangos→Wowhead Forever peer
        [6140] = DropKeys.WOWHEAD,
    },
    [10599] = { -- Hetaera's Beaten Head; cmangos→Wowhead Forever peer
        [6140] = DropKeys.WOWHEAD,
    },
    [10600] = { -- Hetaera's Bruised Head; cmangos→Wowhead Forever peer
        [6140] = DropKeys.WOWHEAD,
    },
    [10639] = { -- Hyacinth Mushroom
        [1989] = DropKeys.WOWHEAD,
    },
    [10640] = { -- Webwood Ichor; cmangos→Wowhead Forever peer
        [1986] = DropKeys.WOWHEAD,
    },
    [10660] = { -- First Mosh'aru Tablet; cmangos→Wowhead Forever peer
        [7272] = DropKeys.WOWHEAD,
    },
    [10661] = { -- Second Mosh'aru Tablet; cmangos→Wowhead Forever peer
        [7795] = DropKeys.WOWHEAD,
    },
    [10663] = { -- Essence of Hakkar; cmangos→Wowhead Forever peer
        [8443] = DropKeys.WOWHEAD,
    },
    [10753] = { -- Amulet of Grol; cmangos→Wowhead Forever peer
        [7665] = DropKeys.WOWHEAD,
    },
    [10754] = { -- Amulet of Sevine; cmangos→Wowhead Forever peer
        [7667] = DropKeys.WOWHEAD,
    },
    [10755] = { -- Amulet of Allistarj; cmangos→Wowhead Forever peer
        [7666] = DropKeys.WOWHEAD,
    },
    [10759] = { -- Severed Horn of the Defiler; cmangos→Wowhead Forever peer
        [7664] = DropKeys.WOWHEAD,
    },
    [10999] = { -- Ironfel; cmangos→Wowhead Forever peer
        [9056] = DropKeys.WOWHEAD,
    },
    [11058] = { -- Sha'ni's Nose-Ring; cmangos→Wowhead Forever peer
        [8977] = DropKeys.WOWHEAD,
    },
    [11080] = { -- Gor'tesh's Lopped Off Head; cmangos→Wowhead Forever peer
        [9176] = DropKeys.WOWHEAD,
    },
    [11114] = { -- Dinosaur Bone; cmangos→Wowhead Forever peer
        [6501] = DropKeys.WOWHEAD,
        [6502] = DropKeys.WOWHEAD,
        [6503] = DropKeys.WOWHEAD,
        [6504] = DropKeys.WOWHEAD,
        [9162] = DropKeys.WOWHEAD,
        [9163] = DropKeys.WOWHEAD,
        [9164] = DropKeys.WOWHEAD,
    },
    [11126] = { -- Tablet of Kurniya; cmangos→Wowhead Forever peer
        [9017] = DropKeys.WOWHEAD,
    },
    [11129] = { -- Essence of the Elements; cmangos→Wowhead Forever peer
        [8281] = DropKeys.WOWHEAD,
        [8905] = DropKeys.WOWHEAD,
        [8906] = DropKeys.WOWHEAD,
        [8908] = DropKeys.WOWHEAD,
        [8909] = DropKeys.WOWHEAD,
        [8910] = DropKeys.WOWHEAD,
        [8911] = DropKeys.WOWHEAD,
        [8923] = DropKeys.WOWHEAD,
        [9017] = DropKeys.WOWHEAD,
        [9025] = DropKeys.WOWHEAD,
        [9026] = DropKeys.WOWHEAD,
        [9156] = DropKeys.WOWHEAD,
    },
    [11147] = { -- Samophlange Manual Cover; cmangos→Wowhead Forever peer
        [9336] = DropKeys.WOWHEAD,
    },
    [11148] = { -- Samophlange Manual Page; cmangos→Wowhead Forever peer
        [3283] = DropKeys.WOWHEAD,
        [3286] = DropKeys.WOWHEAD,
    },
    [11172] = { -- Silvery Claws; cmangos→Wowhead Forever peer
        [8956] = DropKeys.WOWHEAD,
        [8957] = DropKeys.WOWHEAD,
        [8958] = DropKeys.WOWHEAD,
        [8959] = DropKeys.WOWHEAD,
        [8960] = DropKeys.WOWHEAD,
        [8961] = DropKeys.WOWHEAD,
        [14339] = DropKeys.WOWHEAD,
        [14344] = DropKeys.WOWHEAD,
    },
    [11173] = { -- Irontree Heart; cmangos→Wowhead Forever peer
        [7138] = DropKeys.WOWHEAD,
        [7139] = DropKeys.WOWHEAD,
    },
    [11266] = { -- Fractured Elemental Shard; cmangos→Wowhead Forever peer
        [7032] = DropKeys.WOWHEAD,
        [7039] = DropKeys.WOWHEAD,
        [8981] = DropKeys.WOWHEAD,
    },
    [11268] = { -- Head of Argelmach; cmangos→Wowhead Forever peer
        [8983] = DropKeys.WOWHEAD,
    },
    [11269] = { -- Intact Elemental Core; cmangos→Wowhead Forever peer
        [8905] = DropKeys.WOWHEAD,
        [8906] = DropKeys.WOWHEAD,
        [8907] = DropKeys.WOWHEAD,
        [8908] = DropKeys.WOWHEAD,
    },
    [11312] = { -- Lost Thunderbrew Recipe; cmangos→Wowhead Forever peer
        [9537] = DropKeys.WOWHEAD,
        [9541] = DropKeys.WOWHEAD,
    },
    [11313] = { -- Ribbly's Head; cmangos→Wowhead Forever peer
        [9543] = DropKeys.WOWHEAD,
    },
    [11315] = { -- Bloodpetal Sprout; cmangos→Wowhead Forever peer
        [6560] = DropKeys.WOWHEAD,
    },
    [11316] = { -- Bloodpetal; cmangos→Wowhead Forever peer
        [6509] = DropKeys.WOWHEAD,
        [6510] = DropKeys.WOWHEAD,
        [6511] = DropKeys.WOWHEAD,
        [6512] = DropKeys.WOWHEAD,
    },
    [11318] = { -- Atal'ai Haze; cmangos→Wowhead Forever peer
        [5226] = DropKeys.WOWHEAD,
        [5228] = DropKeys.WOWHEAD,
        [8384] = DropKeys.WOWHEAD,
    },
    [11464] = { -- Marshal Windsor's Lost Information; cmangos→Wowhead Forever peer
        [9033] = DropKeys.WOWHEAD,
    },
    [11465] = { -- Marshal Windsor's Lost Information; cmangos→Wowhead Forever peer
        [8983] = DropKeys.WOWHEAD,
    },
    [11467] = { -- Blackrock Medallion; cmangos→Wowhead Forever peer
        [7025] = DropKeys.WOWHEAD,
        [7026] = DropKeys.WOWHEAD,
        [7027] = DropKeys.WOWHEAD,
        [7028] = DropKeys.WOWHEAD,
        [7029] = DropKeys.WOWHEAD,
        [7055] = DropKeys.WOWHEAD,
        [9690] = DropKeys.WOWHEAD,
        [9694] = DropKeys.WOWHEAD,
        [9697] = DropKeys.WOWHEAD,
        [10077] = DropKeys.WOWHEAD,
    },
    [11468] = { -- Dark Iron Fanny Pack; cmangos→Wowhead Forever peer
        [8889] = DropKeys.WOWHEAD,
        [8891] = DropKeys.WOWHEAD,
        [8892] = DropKeys.WOWHEAD,
        [8893] = DropKeys.WOWHEAD,
        [8894] = DropKeys.WOWHEAD,
        [8895] = DropKeys.WOWHEAD,
        [8896] = DropKeys.WOWHEAD,
        [8897] = DropKeys.WOWHEAD,
        [8898] = DropKeys.WOWHEAD,
        [8899] = DropKeys.WOWHEAD,
        [8900] = DropKeys.WOWHEAD,
        [8902] = DropKeys.WOWHEAD,
        [8903] = DropKeys.WOWHEAD,
        [8904] = DropKeys.WOWHEAD,
        [8983] = DropKeys.WOWHEAD,
        [9019] = DropKeys.WOWHEAD,
        [9033] = DropKeys.WOWHEAD,
        [9056] = DropKeys.WOWHEAD,
        [9438] = DropKeys.WOWHEAD,
        [9439] = DropKeys.WOWHEAD,
        [9441] = DropKeys.WOWHEAD,
        [9442] = DropKeys.WOWHEAD,
        [9443] = DropKeys.WOWHEAD,
        [9445] = DropKeys.WOWHEAD,
        [9476] = DropKeys.WOWHEAD,
        [9537] = DropKeys.WOWHEAD,
        [9541] = DropKeys.WOWHEAD,
        [9545] = DropKeys.WOWHEAD,
        [9547] = DropKeys.WOWHEAD,
        [9554] = DropKeys.WOWHEAD,
        [9680] = DropKeys.WOWHEAD,
        [10043] = DropKeys.WOWHEAD,
    },
    [11472] = { -- Silvermane Stalker Flank; cmangos→Wowhead Forever peer
        [2926] = DropKeys.WOWHEAD,
    },
    [11476] = { -- U'cha's Pelt; cmangos→Wowhead Forever peer
        [9622] = DropKeys.WOWHEAD,
    },
    [11477] = { -- White Ravasaur Claw; cmangos→Wowhead Forever peer
        [6505] = DropKeys.WOWHEAD,
        [6506] = DropKeys.WOWHEAD,
        [6507] = DropKeys.WOWHEAD,
        [6508] = DropKeys.WOWHEAD,
        [6581] = DropKeys.WOWHEAD,
        [9683] = DropKeys.WOWHEAD,
        [9684] = DropKeys.WOWHEAD,
    },
    [11509] = { -- Ravasaur Pheromone Gland; cmangos→Wowhead Forever peer
        [9683] = DropKeys.WOWHEAD,
    },
    [11510] = { -- Lar'korwi's Head; cmangos→Wowhead Forever peer
        [9684] = DropKeys.WOWHEAD,
    },
    [11674] = { -- Jadefire Felbind; cmangos→Wowhead Forever peer
        [7105] = DropKeys.WOWHEAD,
        [7106] = DropKeys.WOWHEAD,
        [7107] = DropKeys.WOWHEAD,
        [7108] = DropKeys.WOWHEAD,
        [7109] = DropKeys.WOWHEAD,
        [7110] = DropKeys.WOWHEAD,
        [7111] = DropKeys.WOWHEAD,
        [14340] = DropKeys.WOWHEAD,
    },
    [11723] = { -- Goodsteel's Balanced Flameberge; cmangos→Wowhead Forever peer
        [9916] = DropKeys.WOWHEAD,
    },
    [11830] = { -- Webbed Diemetradon Scale; cmangos→Wowhead Forever peer
        [9162] = DropKeys.WOWHEAD,
        [9163] = DropKeys.WOWHEAD,
        [9164] = DropKeys.WOWHEAD,
    },
    [11831] = { -- Webbed Pterrordax Scale; cmangos→Wowhead Forever peer
        [9165] = DropKeys.WOWHEAD,
        [9166] = DropKeys.WOWHEAD,
        [9167] = DropKeys.WOWHEAD,
    },
    [11834] = { -- Super Sticky Tar; cmangos→Wowhead Forever peer
        [6517] = DropKeys.WOWHEAD,
        [6518] = DropKeys.WOWHEAD,
        [6519] = DropKeys.WOWHEAD,
        [6527] = DropKeys.WOWHEAD,
    },
    [11835] = { -- Gorishi Queen Brain; cmangos→Wowhead Forever peer
        [10041] = DropKeys.WOWHEAD,
    },
    [11837] = { -- Gorishi Scent Gland; cmangos→Wowhead Forever peer
        [6551] = DropKeys.WOWHEAD,
        [6552] = DropKeys.WOWHEAD,
        [6553] = DropKeys.WOWHEAD,
        [6554] = DropKeys.WOWHEAD,
        [6555] = DropKeys.WOWHEAD,
        [10040] = DropKeys.WOWHEAD,
    },
    [12220] = { -- Intact Elemental Bracer; cmangos→Wowhead Forever peer
        [3917] = DropKeys.WOWHEAD,
        [12759] = DropKeys.WOWHEAD,
    },
    [12230] = { -- Felwood Slime Sample; cmangos→Wowhead Forever peer
        [7086] = DropKeys.WOWHEAD,
        [7092] = DropKeys.WOWHEAD,
        [14345] = DropKeys.WOWHEAD,
    },
    [12235] = { -- Un'Goro Slime Sample; cmangos→Wowhead Forever peer
        [6556] = DropKeys.WOWHEAD,
        [6557] = DropKeys.WOWHEAD,
        [6559] = DropKeys.WOWHEAD,
    },
    [12237] = { -- Fine Crab Chunks; cmangos→Wowhead Forever peer
        [2233] = DropKeys.WOWHEAD,
        [2235] = DropKeys.WOWHEAD,
    },
    [12334] = { -- Frostmaul Shards; cmangos→Wowhead Forever peer
        [7428] = DropKeys.WOWHEAD,
        [7429] = DropKeys.WOWHEAD,
        [10198] = DropKeys.WOWHEAD,
    },
    [12366] = { -- Thick Yeti Fur; cmangos→Wowhead Forever peer
        [7457] = DropKeys.WOWHEAD,
        [7458] = DropKeys.WOWHEAD,
    },
    [12367] = { -- Pristine Yeti Horn; cmangos→Wowhead Forever peer
        [7459] = DropKeys.WOWHEAD,
        [7460] = DropKeys.WOWHEAD,
    },
    [12444] = { -- Uncracked Chillwind Horn; cmangos→Wowhead Forever peer
        [7447] = DropKeys.WOWHEAD,
        [7448] = DropKeys.WOWHEAD,
        [7449] = DropKeys.WOWHEAD,
    },
    [12622] = { -- Shardtooth Meat; cmangos→Wowhead Forever peer
        [7443] = DropKeys.WOWHEAD,
        [7444] = DropKeys.WOWHEAD,
        [7445] = DropKeys.WOWHEAD,
        [7446] = DropKeys.WOWHEAD,
    },
    [12623] = { -- Chillwind Meat; cmangos→Wowhead Forever peer
        [7447] = DropKeys.WOWHEAD,
        [7448] = DropKeys.WOWHEAD,
        [7449] = DropKeys.WOWHEAD,
    },
    [12630] = { -- Head of Rend Blackhand; cmangos→Wowhead Forever peer
        [10429] = DropKeys.WOWHEAD,
    },
    [12712] = { -- Warosh's Mojo; cmangos→Wowhead Forever peer
        [10584] = DropKeys.WOWHEAD,
    },
    [12722] = { -- Good Luck Other-Half-Charm; cmangos→Wowhead Forever peer
        [10801] = DropKeys.WOWHEAD,
    },
    [12822] = { -- Toxic Horror Droplet; cmangos→Wowhead Forever peer
        [7132] = DropKeys.WOWHEAD,
    },
    [12829] = { -- Winterfall Crate; cmangos→Wowhead Forever peer
        [10916] = DropKeys.WOWHEAD,
    },
    [12884] = { -- Arnak's Hoof; cmangos→Wowhead Forever peer
        [10896] = DropKeys.WOWHEAD,
    },
    [12925] = { -- Arikara Serpent Skin; cmangos→Wowhead Forever peer
        [10882] = DropKeys.WOWHEAD,
    },
    [12946] = { -- Hypercapacitor Gizmo; cmangos→Wowhead Forever peer
        [10992] = DropKeys.WOWHEAD,
    },
    [13157] = { -- Fetid Skull; cmangos→Wowhead Forever peer
        [8529] = DropKeys.WOWHEAD,
    },
    [13172] = { -- Siabi's Premium Tobacco; cmangos→Wowhead Forever peer
        [11058] = DropKeys.WOWHEAD,
    },
    [13174] = { -- Plagued Flesh Sample; cmangos→Wowhead Forever peer
        [10381] = DropKeys.WOWHEAD,
        [10382] = DropKeys.WOWHEAD,
        [10405] = DropKeys.WOWHEAD,
        [10406] = DropKeys.WOWHEAD,
        [10407] = DropKeys.WOWHEAD,
        [10412] = DropKeys.WOWHEAD,
        [10413] = DropKeys.WOWHEAD,
        [10414] = DropKeys.WOWHEAD,
        [10416] = DropKeys.WOWHEAD,
        [10417] = DropKeys.WOWHEAD,
        [10435] = DropKeys.WOWHEAD,
        [10436] = DropKeys.WOWHEAD,
        [10437] = DropKeys.WOWHEAD,
        [10439] = DropKeys.WOWHEAD,
        [10440] = DropKeys.WOWHEAD,
        [10463] = DropKeys.WOWHEAD,
        [10516] = DropKeys.WOWHEAD,
        [10558] = DropKeys.WOWHEAD,
        [10808] = DropKeys.WOWHEAD,
        [11143] = DropKeys.WOWHEAD,
    },
    [13194] = { -- Felstone Field Cauldron Key; cmangos→Wowhead Forever peer
        [11075] = DropKeys.WOWHEAD,
    },
    [13195] = { -- Dalson's Tears Cauldron Key; cmangos→Wowhead Forever peer
        [11077] = DropKeys.WOWHEAD,
    },
    [13196] = { -- Gahrron's Withering Cauldron Key; cmangos→Wowhead Forever peer
        [11078] = DropKeys.WOWHEAD,
    },
    [13197] = { -- Writhing Haunt Cauldron Key; cmangos→Wowhead Forever peer
        [11076] = DropKeys.WOWHEAD,
    },
    [13207] = { -- Shadow Lord Fel'dan's Head; cmangos→Wowhead Forever peer
        [9517] = DropKeys.WOWHEAD,
    },
    [13251] = { -- Head of Baron Rivendare; cmangos→Wowhead Forever peer
        [10440] = DropKeys.WOWHEAD,
    },
    [13350] = { -- Insignia of the Black Guard; cmangos→Wowhead Forever peer
        [11121] = DropKeys.WOWHEAD,
    },
    [13351] = { -- Crimson Hammersmith's Apron; cmangos→Wowhead Forever peer
        [11120] = DropKeys.WOWHEAD,
    },
    [13352] = { -- Vosh'gajin's Snakestone; cmangos→Wowhead Forever peer
        [9236] = DropKeys.WOWHEAD,
    },
    [13469] = { -- Head of Weldon Barov; cmangos→Wowhead Forever peer
        [11023] = DropKeys.WOWHEAD,
    },
    [13470] = { -- Head of Alexi Barov; cmangos→Wowhead Forever peer
        [11022] = DropKeys.WOWHEAD,
    },
    [13542] = { -- Demon Box; cmangos→Wowhead Forever peer
        [11876] = DropKeys.WOWHEAD,
    },
    [13626] = { -- Human Head of Ras Frostwhisper; cmangos→Wowhead Forever peer
        [10508] = DropKeys.WOWHEAD,
    },
    [13725] = { -- Krastinov's Bag of Horrors; cmangos→Wowhead Forever peer
        [10503] = DropKeys.WOWHEAD,
    },
    [13815] = { -- Some Rune; cmangos→Wowhead Forever peer
        [6195] = DropKeys.WOWHEAD,
        [6196] = DropKeys.WOWHEAD,
        [7885] = DropKeys.WOWHEAD,
        [7886] = DropKeys.WOWHEAD,
    },
    [13853] = { -- Slab of Carrion Worm Meat; cmangos→Wowhead Forever peer
        [8603] = DropKeys.WOWHEAD,
        [8605] = DropKeys.WOWHEAD,
    },
    [14395] = { -- Spells of Shadow; cmangos→Wowhead Forever peer
        [11322] = DropKeys.WOWHEAD,
        [11324] = DropKeys.WOWHEAD,
    },
    [14396] = { -- Incantations from the Nether; cmangos→Wowhead Forever peer
        [11322] = DropKeys.WOWHEAD,
        [11324] = DropKeys.WOWHEAD,
    },
    [14540] = { -- Taragaman the Hungerer's Heart; cmangos→Wowhead Forever peer
        [11520] = DropKeys.WOWHEAD,
    },
    [14544] = { -- Lieutenant's Insignia; cmangos→Wowhead Forever peer
        [3197] = DropKeys.WOWHEAD,
        [3198] = DropKeys.WOWHEAD,
    },
    [14613] = { -- Taelan's Hammer; cmangos→Wowhead Forever peer
        [11886] = DropKeys.WOWHEAD,
    },
    [14619] = { -- Skeletal Fragments; cmangos→Wowhead Forever peer
        [1783] = DropKeys.WOWHEAD,
        [1784] = DropKeys.WOWHEAD,
        [1785] = DropKeys.WOWHEAD,
        [1787] = DropKeys.WOWHEAD,
        [1788] = DropKeys.WOWHEAD,
        [1789] = DropKeys.WOWHEAD,
    },
    [15447] = { -- Living Rot; cmangos→Wowhead Forever peer
        [8525] = DropKeys.WOWHEAD,
        [8526] = DropKeys.WOWHEAD,
        [8531] = DropKeys.WOWHEAD,
        [8538] = DropKeys.WOWHEAD,
        [8541] = DropKeys.WOWHEAD,
        [8543] = DropKeys.WOWHEAD,
        [12262] = DropKeys.WOWHEAD,
    },
    [15750] = { -- Sceptre of Light; cmangos→Wowhead Forever peer
        [13019] = DropKeys.WOWHEAD,
    },
    [15767] = { -- Hameya's Key; cmangos→Wowhead Forever peer
        [12248] = DropKeys.WOWHEAD,
    },
    [15785] = { -- Zaeldarr's Head; cmangos→Wowhead Forever peer
        [12250] = DropKeys.WOWHEAD,
    },
    [15803] = { -- Book of the Ancients; cmangos→Wowhead Forever peer
        [12369] = DropKeys.WOWHEAD,
    },
    [15850] = { -- Patch of Duskwing's Fur; cmangos→Wowhead Forever peer
        [11897] = DropKeys.WOWHEAD,
    },
    [15868] = { -- The Grand Crusader's Command; cmangos→Wowhead Forever peer
        [12337] = DropKeys.WOWHEAD,
    },
    [15878] = { -- Rackmore's Silver Key; cmangos→Wowhead Forever peer
        [11562] = DropKeys.WOWHEAD,
        [11563] = DropKeys.WOWHEAD,
    },
    [15879] = { -- Overlord Ror's Claw; cmangos→Wowhead Forever peer
        [9464] = DropKeys.WOWHEAD,
    },
    [15880] = { -- Head of Ramstein the Gorger; cmangos→Wowhead Forever peer
        [10439] = DropKeys.WOWHEAD,
    },
    [16190] = { -- Bloodfury Ripper's Remains; cmangos→Wowhead Forever peer
        [12579] = DropKeys.WOWHEAD,
    },
    [16192] = { -- Besseleth's Fang; cmangos→Wowhead Forever peer
        [11921] = DropKeys.WOWHEAD,
    },
    [16312] = { -- Incendrites; cmangos→Wowhead Forever peer
        [4036] = DropKeys.WOWHEAD,
        [4037] = DropKeys.WOWHEAD,
        [4038] = DropKeys.WOWHEAD,
    },
    [16333] = { -- Samuel's Remains; cmangos→Wowhead Forever peer
        [1919] = DropKeys.WOWHEAD,
    },
    [16663] = { -- Blood of the Black Dragon Champion; cmangos→Wowhead Forever peer
        [10363] = DropKeys.WOWHEAD,
    },
    [16743] = { -- Logging Rope; cmangos→Wowhead Forever peer
        [3743] = DropKeys.WOWHEAD,
        [3745] = DropKeys.WOWHEAD,
        [3746] = DropKeys.WOWHEAD,
        [3748] = DropKeys.WOWHEAD,
        [3749] = DropKeys.WOWHEAD,
        [3750] = DropKeys.WOWHEAD,
        [3921] = DropKeys.WOWHEAD,
        [3922] = DropKeys.WOWHEAD,
        [3923] = DropKeys.WOWHEAD,
        [3924] = DropKeys.WOWHEAD,
        [3925] = DropKeys.WOWHEAD,
        [3926] = DropKeys.WOWHEAD,
    },
    [16786] = { -- Black Dragonspawn Eye; cmangos→Wowhead Forever peer
        [9096] = DropKeys.WOWHEAD,
        [9568] = DropKeys.WOWHEAD,
        [10083] = DropKeys.WOWHEAD,
        [10258] = DropKeys.WOWHEAD,
        [10264] = DropKeys.WOWHEAD,
        [10366] = DropKeys.WOWHEAD,
        [10371] = DropKeys.WOWHEAD,
        [10372] = DropKeys.WOWHEAD,
        [10683] = DropKeys.WOWHEAD,
        [12463] = DropKeys.WOWHEAD,
        [12464] = DropKeys.WOWHEAD,
        [12465] = DropKeys.WOWHEAD,
        [12467] = DropKeys.WOWHEAD,
        [12468] = DropKeys.WOWHEAD,
    },
    [16869] = { -- The Skull of Scryer; cmangos→Wowhead Forever peer
        [10664] = DropKeys.WOWHEAD,
    },
    [16870] = { -- The Skull of Somnus; cmangos→Wowhead Forever peer
        [12900] = DropKeys.WOWHEAD,
    },
    [16871] = { -- The Skull of Chronalis; cmangos→Wowhead Forever peer
        [8197] = DropKeys.WOWHEAD,
    },
    [16872] = { -- The Skull of Axtroz; cmangos→Wowhead Forever peer
        [12899] = DropKeys.WOWHEAD,
    },
    [17009] = { -- Ambassador Malcin's Head; cmangos→Wowhead Forever peer
        [12865] = DropKeys.WOWHEAD,
    },
    [17306] = { -- Stormpike Soldier's Blood; cmangos→Wowhead Forever peer
        [12047] = DropKeys.WOWHEAD,
        [12048] = DropKeys.WOWHEAD,
        [12050] = DropKeys.WOWHEAD,
        [12127] = DropKeys.WOWHEAD,
        [12159] = DropKeys.WOWHEAD,
        [13138] = DropKeys.WOWHEAD,
        [13139] = DropKeys.WOWHEAD,
        [13151] = DropKeys.WOWHEAD,
        [13153] = DropKeys.WOWHEAD,
        [13176] = DropKeys.WOWHEAD,
        [13180] = DropKeys.WOWHEAD,
        [13218] = DropKeys.WOWHEAD,
        [13256] = DropKeys.WOWHEAD,
        [13296] = DropKeys.WOWHEAD,
        [13297] = DropKeys.WOWHEAD,
        [13298] = DropKeys.WOWHEAD,
        [13299] = DropKeys.WOWHEAD,
        [13300] = DropKeys.WOWHEAD,
        [13318] = DropKeys.WOWHEAD,
        [13319] = DropKeys.WOWHEAD,
        [13320] = DropKeys.WOWHEAD,
        [13324] = DropKeys.WOWHEAD,
        [13325] = DropKeys.WOWHEAD,
        [13326] = DropKeys.WOWHEAD,
        [13327] = DropKeys.WOWHEAD,
        [13331] = DropKeys.WOWHEAD,
        [13333] = DropKeys.WOWHEAD,
        [13335] = DropKeys.WOWHEAD,
        [13336] = DropKeys.WOWHEAD,
        [13358] = DropKeys.WOWHEAD,
        [13419] = DropKeys.WOWHEAD,
        [13424] = DropKeys.WOWHEAD,
        [13437] = DropKeys.WOWHEAD,
        [13438] = DropKeys.WOWHEAD,
        [13439] = DropKeys.WOWHEAD,
        [13441] = DropKeys.WOWHEAD,
        [13442] = DropKeys.WOWHEAD,
        [13443] = DropKeys.WOWHEAD,
        [13446] = DropKeys.WOWHEAD,
        [13525] = DropKeys.WOWHEAD,
        [13576] = DropKeys.WOWHEAD,
        [13577] = DropKeys.WOWHEAD,
        [13617] = DropKeys.WOWHEAD,
        [13797] = DropKeys.WOWHEAD,
        [14187] = DropKeys.WOWHEAD,
        [14188] = DropKeys.WOWHEAD,
        [14763] = DropKeys.WOWHEAD,
    },
    [17322] = { -- Eye of the Emberseer; cmangos→Wowhead Forever peer
        [9816] = DropKeys.WOWHEAD,
    },
    [17326] = { -- Stormpike Soldier's Flesh; cmangos→Wowhead Forever peer
        [12047] = DropKeys.WOWHEAD,
        [12048] = DropKeys.WOWHEAD,
        [12050] = DropKeys.WOWHEAD,
        [12127] = DropKeys.WOWHEAD,
        [12159] = DropKeys.WOWHEAD,
        [13153] = DropKeys.WOWHEAD,
        [13176] = DropKeys.WOWHEAD,
        [13180] = DropKeys.WOWHEAD,
        [13218] = DropKeys.WOWHEAD,
        [13256] = DropKeys.WOWHEAD,
        [13320] = DropKeys.WOWHEAD,
        [13324] = DropKeys.WOWHEAD,
        [13325] = DropKeys.WOWHEAD,
        [13326] = DropKeys.WOWHEAD,
        [13327] = DropKeys.WOWHEAD,
        [13331] = DropKeys.WOWHEAD,
        [13333] = DropKeys.WOWHEAD,
        [13358] = DropKeys.WOWHEAD,
        [13419] = DropKeys.WOWHEAD,
        [13424] = DropKeys.WOWHEAD,
        [13437] = DropKeys.WOWHEAD,
        [13438] = DropKeys.WOWHEAD,
        [13446] = DropKeys.WOWHEAD,
        [13797] = DropKeys.WOWHEAD,
        [14187] = DropKeys.WOWHEAD,
        [14188] = DropKeys.WOWHEAD,
        [14763] = DropKeys.WOWHEAD,
    },
    [17327] = { -- Stormpike Lieutenant's Flesh; cmangos→Wowhead Forever peer
        [12047] = DropKeys.WOWHEAD,
        [12048] = DropKeys.WOWHEAD,
        [12050] = DropKeys.WOWHEAD,
        [12127] = DropKeys.WOWHEAD,
        [13078] = DropKeys.WOWHEAD,
        [13138] = DropKeys.WOWHEAD,
        [13139] = DropKeys.WOWHEAD,
        [13153] = DropKeys.WOWHEAD,
        [13154] = DropKeys.WOWHEAD,
        [13176] = DropKeys.WOWHEAD,
        [13180] = DropKeys.WOWHEAD,
        [13256] = DropKeys.WOWHEAD,
        [13296] = DropKeys.WOWHEAD,
        [13297] = DropKeys.WOWHEAD,
        [13298] = DropKeys.WOWHEAD,
        [13299] = DropKeys.WOWHEAD,
        [13300] = DropKeys.WOWHEAD,
        [13318] = DropKeys.WOWHEAD,
        [13319] = DropKeys.WOWHEAD,
        [13320] = DropKeys.WOWHEAD,
        [13324] = DropKeys.WOWHEAD,
        [13326] = DropKeys.WOWHEAD,
        [13331] = DropKeys.WOWHEAD,
        [13335] = DropKeys.WOWHEAD,
        [13358] = DropKeys.WOWHEAD,
        [13419] = DropKeys.WOWHEAD,
        [13424] = DropKeys.WOWHEAD,
        [13437] = DropKeys.WOWHEAD,
        [13438] = DropKeys.WOWHEAD,
        [13439] = DropKeys.WOWHEAD,
        [13442] = DropKeys.WOWHEAD,
        [13443] = DropKeys.WOWHEAD,
        [13446] = DropKeys.WOWHEAD,
        [13576] = DropKeys.WOWHEAD,
        [13617] = DropKeys.WOWHEAD,
        [13797] = DropKeys.WOWHEAD,
        [14187] = DropKeys.WOWHEAD,
        [14188] = DropKeys.WOWHEAD,
    },
    [17328] = { -- Stormpike Commander's Flesh; cmangos→Wowhead Forever peer
        [12159] = DropKeys.WOWHEAD,
        [13138] = DropKeys.WOWHEAD,
        [13139] = DropKeys.WOWHEAD,
        [13176] = DropKeys.WOWHEAD,
        [13180] = DropKeys.WOWHEAD,
        [13256] = DropKeys.WOWHEAD,
        [13296] = DropKeys.WOWHEAD,
        [13297] = DropKeys.WOWHEAD,
        [13298] = DropKeys.WOWHEAD,
        [13299] = DropKeys.WOWHEAD,
        [13300] = DropKeys.WOWHEAD,
        [13318] = DropKeys.WOWHEAD,
        [13319] = DropKeys.WOWHEAD,
        [13320] = DropKeys.WOWHEAD,
        [13419] = DropKeys.WOWHEAD,
        [13438] = DropKeys.WOWHEAD,
        [13439] = DropKeys.WOWHEAD,
        [13442] = DropKeys.WOWHEAD,
        [13443] = DropKeys.WOWHEAD,
        [13446] = DropKeys.WOWHEAD,
        [13797] = DropKeys.WOWHEAD,
    },
    [17329] = { -- Hand of Lucifron; cmangos→Wowhead Forever peer
        [12118] = DropKeys.WOWHEAD,
    },
    [17330] = { -- Hand of Sulfuron; cmangos→Wowhead Forever peer
        [12098] = DropKeys.WOWHEAD,
    },
    [17331] = { -- Hand of Gehennas; cmangos→Wowhead Forever peer
        [12259] = DropKeys.WOWHEAD,
    },
    [17332] = { -- Hand of Shazzrah; cmangos→Wowhead Forever peer
        [12264] = DropKeys.WOWHEAD,
    },
    [17346] = { -- Encrusted Silithid Object; cmangos→Wowhead Forever peer
        [13301] = DropKeys.WOWHEAD,
    },
    [17502] = { -- Frostwolf Soldier's Medal; cmangos→Wowhead Forever peer
        [12051] = DropKeys.WOWHEAD,
        [12052] = DropKeys.WOWHEAD,
        [12053] = DropKeys.WOWHEAD,
        [12159] = DropKeys.WOWHEAD,
        [13153] = DropKeys.WOWHEAD,
        [13154] = DropKeys.WOWHEAD,
        [13176] = DropKeys.WOWHEAD,
        [13180] = DropKeys.WOWHEAD,
        [13256] = DropKeys.WOWHEAD,
        [13328] = DropKeys.WOWHEAD,
        [13329] = DropKeys.WOWHEAD,
        [13330] = DropKeys.WOWHEAD,
        [13332] = DropKeys.WOWHEAD,
        [13334] = DropKeys.WOWHEAD,
        [13337] = DropKeys.WOWHEAD,
        [13359] = DropKeys.WOWHEAD,
        [13419] = DropKeys.WOWHEAD,
        [13425] = DropKeys.WOWHEAD,
        [13428] = DropKeys.WOWHEAD,
        [13442] = DropKeys.WOWHEAD,
        [13798] = DropKeys.WOWHEAD,
        [14185] = DropKeys.WOWHEAD,
        [14186] = DropKeys.WOWHEAD,
    },
    [17503] = { -- Frostwolf Lieutenant's Medal; cmangos→Wowhead Forever peer
        [12051] = DropKeys.WOWHEAD,
        [12052] = DropKeys.WOWHEAD,
        [12053] = DropKeys.WOWHEAD,
        [12159] = DropKeys.WOWHEAD,
        [13140] = DropKeys.WOWHEAD,
        [13143] = DropKeys.WOWHEAD,
        [13144] = DropKeys.WOWHEAD,
        [13145] = DropKeys.WOWHEAD,
        [13146] = DropKeys.WOWHEAD,
        [13147] = DropKeys.WOWHEAD,
        [13152] = DropKeys.WOWHEAD,
        [13153] = DropKeys.WOWHEAD,
        [13154] = DropKeys.WOWHEAD,
        [13176] = DropKeys.WOWHEAD,
        [13179] = DropKeys.WOWHEAD,
        [13180] = DropKeys.WOWHEAD,
        [13181] = DropKeys.WOWHEAD,
        [13218] = DropKeys.WOWHEAD,
        [13236] = DropKeys.WOWHEAD,
        [13256] = DropKeys.WOWHEAD,
        [13328] = DropKeys.WOWHEAD,
        [13329] = DropKeys.WOWHEAD,
        [13332] = DropKeys.WOWHEAD,
        [13334] = DropKeys.WOWHEAD,
        [13359] = DropKeys.WOWHEAD,
        [13419] = DropKeys.WOWHEAD,
        [13428] = DropKeys.WOWHEAD,
        [13440] = DropKeys.WOWHEAD,
        [13442] = DropKeys.WOWHEAD,
        [13798] = DropKeys.WOWHEAD,
        [14185] = DropKeys.WOWHEAD,
        [14186] = DropKeys.WOWHEAD,
    },
    [17504] = { -- Frostwolf Commander's Medal; cmangos→Wowhead Forever peer
        [13140] = DropKeys.WOWHEAD,
        [13143] = DropKeys.WOWHEAD,
        [13144] = DropKeys.WOWHEAD,
        [13145] = DropKeys.WOWHEAD,
        [13146] = DropKeys.WOWHEAD,
        [13147] = DropKeys.WOWHEAD,
        [13152] = DropKeys.WOWHEAD,
        [13153] = DropKeys.WOWHEAD,
        [13154] = DropKeys.WOWHEAD,
        [13176] = DropKeys.WOWHEAD,
        [13179] = DropKeys.WOWHEAD,
        [13180] = DropKeys.WOWHEAD,
        [13181] = DropKeys.WOWHEAD,
        [13218] = DropKeys.WOWHEAD,
        [13236] = DropKeys.WOWHEAD,
        [13256] = DropKeys.WOWHEAD,
        [13319] = DropKeys.WOWHEAD,
        [13441] = DropKeys.WOWHEAD,
    },
    [17662] = { -- Stolen Treats; cmangos→Wowhead Forever peer
        [13602] = DropKeys.WOWHEAD,
    },
    [17684] = { -- Theradric Crystal Carving; cmangos→Wowhead Forever peer
        [11688] = DropKeys.WOWHEAD,
        [11790] = DropKeys.WOWHEAD,
        [11791] = DropKeys.WOWHEAD,
        [11792] = DropKeys.WOWHEAD,
        [11793] = DropKeys.WOWHEAD,
        [11794] = DropKeys.WOWHEAD,
        [12201] = DropKeys.WOWHEAD,
        [12203] = DropKeys.WOWHEAD,
        [12206] = DropKeys.WOWHEAD,
        [12207] = DropKeys.WOWHEAD,
        [12216] = DropKeys.WOWHEAD,
        [12218] = DropKeys.WOWHEAD,
        [12219] = DropKeys.WOWHEAD,
        [12220] = DropKeys.WOWHEAD,
        [12221] = DropKeys.WOWHEAD,
        [12222] = DropKeys.WOWHEAD,
        [12223] = DropKeys.WOWHEAD,
        [12224] = DropKeys.WOWHEAD,
        [12225] = DropKeys.WOWHEAD,
        [12236] = DropKeys.WOWHEAD,
        [12237] = DropKeys.WOWHEAD,
        [12258] = DropKeys.WOWHEAD,
        [13282] = DropKeys.WOWHEAD,
        [13596] = DropKeys.WOWHEAD,
        [13601] = DropKeys.WOWHEAD,
        [13696] = DropKeys.WOWHEAD,
        [13718] = DropKeys.WOWHEAD,
    },
    [17702] = { -- Celebrian Rod; cmangos→Wowhead Forever peer
        [13282] = DropKeys.WOWHEAD,
    },
    [17703] = { -- Celebrian Diamond; cmangos→Wowhead Forever peer
        [12236] = DropKeys.WOWHEAD,
    },
    [17756] = { -- Shadowshard Fragment; cmangos→Wowhead Forever peer
        [11777] = DropKeys.WOWHEAD,
        [11778] = DropKeys.WOWHEAD,
    },
    [17757] = { -- Amulet of Spirits; cmangos→Wowhead Forever peer
        [13718] = DropKeys.WOWHEAD,
    },
    [18261] = { -- Book of Incantations; cmangos→Wowhead Forever peer
        [14354] = DropKeys.WOWHEAD,
    },
    [18299] = { -- Hydrospawn Essence; cmangos→Wowhead Forever peer
        [13280] = DropKeys.WOWHEAD,
    },
    [18426] = { -- Lethtendris's Web; cmangos→Wowhead Forever peer
        [14327] = DropKeys.WOWHEAD,
    },
    [18590] = { -- Raging Beast's Blood; cmangos→Wowhead Forever peer
        [7450] = DropKeys.WOWHEAD,
        [7451] = DropKeys.WOWHEAD,
        [7452] = DropKeys.WOWHEAD,
        [7453] = DropKeys.WOWHEAD,
        [7454] = DropKeys.WOWHEAD,
    },
    [18603] = { -- Satyr Blood; cmangos→Wowhead Forever peer
        [11451] = DropKeys.WOWHEAD,
        [11452] = DropKeys.WOWHEAD,
        [11453] = DropKeys.WOWHEAD,
        [11454] = DropKeys.WOWHEAD,
        [11455] = DropKeys.WOWHEAD,
        [11456] = DropKeys.WOWHEAD,
        [11457] = DropKeys.WOWHEAD,
    },
    [18604] = { -- Tears of the Hederine; cmangos→Wowhead Forever peer
        [7461] = DropKeys.WOWHEAD,
        [7462] = DropKeys.WOWHEAD,
        [7463] = DropKeys.WOWHEAD,
    },
    [18622] = { -- Flawless Fel Essence (Jaedenar); cmangos→Wowhead Forever peer
        [9862] = DropKeys.WOWHEAD,
    },
    [18623] = { -- Flawless Fel Essence (Dark Portal); cmangos→Wowhead Forever peer
        [6011] = DropKeys.WOWHEAD,
    },
    [18624] = { -- Flawless Fel Essence (Azshara); cmangos→Wowhead Forever peer
        [6200] = DropKeys.WOWHEAD,
        [6201] = DropKeys.WOWHEAD,
        [6202] = DropKeys.WOWHEAD,
    },
    [18625] = { -- Kroshius' Infernal Core; cmangos→Wowhead Forever peer
        [14467] = DropKeys.WOWHEAD,
    },
    [18719] = { -- The Traitor's Heart; cmangos→Wowhead Forever peer
        [14523] = DropKeys.WOWHEAD,
    },
    [18749] = { -- Charger's Lost Soul; cmangos→Wowhead Forever peer
        [14516] = DropKeys.WOWHEAD,
    },
    [18880] = { -- Darkreaver's Head; cmangos→Wowhead Forever peer
        [14516] = DropKeys.WOWHEAD,
    },
    [18946] = { -- Head of Overseer Maltorius; cmangos→Wowhead Forever peer
        [14621] = DropKeys.WOWHEAD,
    },
    [18947] = { -- Rage Scar Yeti Hide; cmangos→Wowhead Forever peer
        [5296] = DropKeys.WOWHEAD,
        [5297] = DropKeys.WOWHEAD,
        [5299] = DropKeys.WOWHEAD,
    },
    [18958] = { -- Water Elemental Core; cmangos→Wowhead Forever peer
        [5461] = DropKeys.WOWHEAD,
        [5462] = DropKeys.WOWHEAD,
    },
    [18959] = { -- Smithing Tuyere; cmangos→Wowhead Forever peer
        [5840] = DropKeys.WOWHEAD,
    },
    [18960] = { -- Lookout's Spyglass; cmangos→Wowhead Forever peer
        [8566] = DropKeys.WOWHEAD,
    },
    [18961] = { -- Zukk'ash Carapace; cmangos→Wowhead Forever peer
        [5244] = DropKeys.WOWHEAD,
        [5245] = DropKeys.WOWHEAD,
        [5246] = DropKeys.WOWHEAD,
        [5247] = DropKeys.WOWHEAD,
        [14661] = DropKeys.WOWHEAD,
    },
    [18962] = { -- Stinglasher's Glands; cmangos→Wowhead Forever peer
        [14661] = DropKeys.WOWHEAD,
    },
    [19017] = { -- Essence of the Firelord; cmangos→Wowhead Forever peer
        [11502] = DropKeys.WOWHEAD,
    },
    [19023] = { -- Katoom's Best Lure; cmangos→Wowhead Forever peer
        [7977] = DropKeys.WOWHEAD,
    },
    [19025] = { -- Skylord Plume; cmangos→Wowhead Forever peer
        [2659] = DropKeys.WOWHEAD,
    },
    [19034] = { -- Lard's Lunch; cmangos→Wowhead Forever peer
        [14748] = DropKeys.WOWHEAD,
    },
    [19064] = { -- Shackle Key; cmangos→Wowhead Forever peer
        [10802] = DropKeys.WOWHEAD,
    },
    [19881] = { -- Channeler's Head; cmangos→Wowhead Forever peer
        [14507] = DropKeys.WOWHEAD,
        [14509] = DropKeys.WOWHEAD,
        [14510] = DropKeys.WOWHEAD,
        [14515] = DropKeys.WOWHEAD,
        [14517] = DropKeys.WOWHEAD,
    },
    [20017] = { -- Perfect Courser Antler; cmangos→Wowhead Forever peer
        [8761] = DropKeys.WOWHEAD,
    },
    [20019] = { -- Tooth of Morphaz; cmangos→Wowhead Forever peer
        [5719] = DropKeys.WOWHEAD,
    },
    [20022] = { -- Azure Key; cmangos→Wowhead Forever peer
        [5719] = DropKeys.WOWHEAD,
    },
    [20023] = { -- Encoded Fragment; cmangos→Wowhead Forever peer
        [8766] = DropKeys.WOWHEAD,
    },
    [20025] = { -- Blood of Morphaz; cmangos→Wowhead Forever peer
        [5719] = DropKeys.WOWHEAD,
    },
    [20027] = { -- Healthy Courser Gland; cmangos→Wowhead Forever peer
        [8761] = DropKeys.WOWHEAD,
    },
    [20085] = { -- Arcane Shard; cmangos→Wowhead Forever peer
        [5719] = DropKeys.WOWHEAD,
    },
    [20087] = { -- Wavethrasher Scales; cmangos→Wowhead Forever peer
        [6347] = DropKeys.WOWHEAD,
        [6348] = DropKeys.WOWHEAD,
        [6349] = DropKeys.WOWHEAD,
    },
    [20383] = { -- Head of the Broodlord Lashlayer; cmangos→Wowhead Forever peer
        [12017] = DropKeys.WOWHEAD,
    },
    [20385] = { -- Deathclasp's Pincer; cmangos→Wowhead Forever peer
        [15196] = DropKeys.WOWHEAD,
    },
    [20394] = { -- Twilight Lexicon - Chapter 1; cmangos→Wowhead Forever peer
        [15200] = DropKeys.WOWHEAD,
    },
    [20395] = { -- Twilight Lexicon - Chapter 2; cmangos→Wowhead Forever peer
        [11803] = DropKeys.WOWHEAD,
    },
    [20396] = { -- Twilight Lexicon - Chapter 3; cmangos→Wowhead Forever peer
        [11804] = DropKeys.WOWHEAD,
    },
    [20457] = { -- Hive'Ashi Silithid Brain; cmangos→Wowhead Forever peer
        [11698] = DropKeys.WOWHEAD,
        [11721] = DropKeys.WOWHEAD,
        [11722] = DropKeys.WOWHEAD,
        [11723] = DropKeys.WOWHEAD,
        [11724] = DropKeys.WOWHEAD,
        [13136] = DropKeys.WOWHEAD,
        [13301] = DropKeys.WOWHEAD,
    },
    [20458] = { -- Hive'Zora Silithid Brain; cmangos→Wowhead Forever peer
        [11725] = DropKeys.WOWHEAD,
        [11726] = DropKeys.WOWHEAD,
        [11727] = DropKeys.WOWHEAD,
        [11728] = DropKeys.WOWHEAD,
        [11729] = DropKeys.WOWHEAD,
    },
    [20459] = { -- Hive'Regal Silithid Brain; cmangos→Wowhead Forever peer
        [11730] = DropKeys.WOWHEAD,
        [11731] = DropKeys.WOWHEAD,
        [11732] = DropKeys.WOWHEAD,
        [11733] = DropKeys.WOWHEAD,
        [11734] = DropKeys.WOWHEAD,
    },
    [20465] = { -- Crystal Unlocking Mechanism; cmangos→Wowhead Forever peer
        [14862] = DropKeys.WOWHEAD,
    },
    [20466] = { -- Vyral's Signet Ring; cmangos→Wowhead Forever peer
        [15202] = DropKeys.WOWHEAD,
    },
    [20519] = { -- Southsea Pirate Hat; cmangos→Wowhead Forever peer
        [7855] = DropKeys.WOWHEAD,
        [7856] = DropKeys.WOWHEAD,
        [7857] = DropKeys.WOWHEAD,
        [7858] = DropKeys.WOWHEAD,
        [7883] = DropKeys.WOWHEAD,
        [8203] = DropKeys.WOWHEAD,
    },
    [20606] = { -- Amber Voodoo Feather; cmangos→Wowhead Forever peer
        [5713] = DropKeys.WOWHEAD,
        [5716] = DropKeys.WOWHEAD,
    },
    [20607] = { -- Blue Voodoo Feather; cmangos→Wowhead Forever peer
        [5715] = DropKeys.WOWHEAD,
        [5717] = DropKeys.WOWHEAD,
    },
    [20608] = { -- Green Voodoo Feather; cmangos→Wowhead Forever peer
        [5712] = DropKeys.WOWHEAD,
        [5714] = DropKeys.WOWHEAD,
    },
    [20610] = { -- Bloodshot Spider Eye; cmangos→Wowhead Forever peer
        [1809] = DropKeys.WOWHEAD,
        [1821] = DropKeys.WOWHEAD,
        [1822] = DropKeys.WOWHEAD,
        [1824] = DropKeys.WOWHEAD,
    },
    [20611] = { -- Thick Black Claw; cmangos→Wowhead Forever peer
        [1809] = DropKeys.WOWHEAD,
        [1815] = DropKeys.WOWHEAD,
        [1816] = DropKeys.WOWHEAD,
    },
    [20613] = { -- Rotting Wood; cmangos→Wowhead Forever peer
        [7138] = DropKeys.WOWHEAD,
        [7139] = DropKeys.WOWHEAD,
        [7149] = DropKeys.WOWHEAD,
    },
    [20614] = { -- Bloodvenom Essence; cmangos→Wowhead Forever peer
        [7092] = DropKeys.WOWHEAD,
    },
    [20803] = { -- Twilight Battle Orders; cmangos→Wowhead Forever peer
        [15308] = DropKeys.WOWHEAD,
    },
    [20951] = { -- Narain's Scrying Goggles; cmangos→Wowhead Forever peer
        [11658] = DropKeys.WOWHEAD,
        [11659] = DropKeys.WOWHEAD,
        [11661] = DropKeys.WOWHEAD,
        [11662] = DropKeys.WOWHEAD,
        [11663] = DropKeys.WOWHEAD,
        [11664] = DropKeys.WOWHEAD,
        [11665] = DropKeys.WOWHEAD,
        [11666] = DropKeys.WOWHEAD,
        [11668] = DropKeys.WOWHEAD,
        [11673] = DropKeys.WOWHEAD,
        [12076] = DropKeys.WOWHEAD,
        [12098] = DropKeys.WOWHEAD,
        [12100] = DropKeys.WOWHEAD,
        [12101] = DropKeys.WOWHEAD,
        [12119] = DropKeys.WOWHEAD,
        [12264] = DropKeys.WOWHEAD,
    },
    [21027] = { -- Lakmaeran's Carcass; cmangos→Wowhead Forever peer
        [12803] = DropKeys.WOWHEAD,
    },
    [21137] = { -- Blue Scepter Shard; cmangos→Wowhead Forever peer
        [15571] = DropKeys.WOWHEAD,
    },
    [21146] = { -- Fragment of the Nightmare's Corruption; cmangos→Wowhead Forever peer
        [12477] = DropKeys.WOWHEAD,
        [12478] = DropKeys.WOWHEAD,
        [12479] = DropKeys.WOWHEAD,
    },
    [21147] = { -- Fragment of the Nightmare's Corruption; cmangos→Wowhead Forever peer
        [12474] = DropKeys.WOWHEAD,
        [12475] = DropKeys.WOWHEAD,
        [12476] = DropKeys.WOWHEAD,
    },
    [21148] = { -- Fragment of the Nightmare's Corruption; cmangos→Wowhead Forever peer
        [5317] = DropKeys.WOWHEAD,
        [5319] = DropKeys.WOWHEAD,
        [5320] = DropKeys.WOWHEAD,
    },
    [21149] = { -- Fragment of the Nightmare's Corruption; cmangos→Wowhead Forever peer
        [15625] = DropKeys.WOWHEAD,
    },
    [21928] = { -- Winterspring Blood Sample; cmangos→Wowhead Forever peer
        [7430] = DropKeys.WOWHEAD,
        [7431] = DropKeys.WOWHEAD,
        [7432] = DropKeys.WOWHEAD,
        [7433] = DropKeys.WOWHEAD,
        [7434] = DropKeys.WOWHEAD,
        [7443] = DropKeys.WOWHEAD,
        [7444] = DropKeys.WOWHEAD,
        [7445] = DropKeys.WOWHEAD,
        [7446] = DropKeys.WOWHEAD,
    },
    [21938] = { -- Magma Core; cmangos→Wowhead Forever peer
        [16043] = DropKeys.WOWHEAD,
    },
    [21982] = { -- Ogre Warbeads; cmangos→Wowhead Forever peer
        [9196] = DropKeys.WOWHEAD,
        [9197] = DropKeys.WOWHEAD,
        [9198] = DropKeys.WOWHEAD,
        [9199] = DropKeys.WOWHEAD,
        [9200] = DropKeys.WOWHEAD,
        [9201] = DropKeys.WOWHEAD,
        [9216] = DropKeys.WOWHEAD,
        [9217] = DropKeys.WOWHEAD,
        [9218] = DropKeys.WOWHEAD,
        [10584] = DropKeys.WOWHEAD,
        [11440] = DropKeys.WOWHEAD,
        [11441] = DropKeys.WOWHEAD,
        [11442] = DropKeys.WOWHEAD,
        [11443] = DropKeys.WOWHEAD,
        [11444] = DropKeys.WOWHEAD,
        [11445] = DropKeys.WOWHEAD,
        [11448] = DropKeys.WOWHEAD,
        [11450] = DropKeys.WOWHEAD,
        [14351] = DropKeys.WOWHEAD,
    },
    [21984] = { -- Left Piece of Lord Valthalak's Amulet; cmangos→Wowhead Forever peer
        [16080] = DropKeys.WOWHEAD,
        [16097] = DropKeys.WOWHEAD,
        [16101] = DropKeys.WOWHEAD,
        [16102] = DropKeys.WOWHEAD,
        [16118] = DropKeys.WOWHEAD,
    },
    [21987] = { -- Incendicite of Incendius; cmangos→Wowhead Forever peer
        [9017] = DropKeys.WOWHEAD,
    },
    [21988] = { -- Ember of Emberseer; cmangos→Wowhead Forever peer
        [9816] = DropKeys.WOWHEAD,
    },
    [21989] = { -- Cinder of Cynders; cmangos→Wowhead Forever peer
        [15206] = DropKeys.WOWHEAD,
    },
    [22046] = { -- Right Piece of Lord Valthalak's Amulet; cmangos→Wowhead Forever peer
        [16080] = DropKeys.WOWHEAD,
        [16097] = DropKeys.WOWHEAD,
        [16101] = DropKeys.WOWHEAD,
        [16102] = DropKeys.WOWHEAD,
        [16118] = DropKeys.WOWHEAD,
    },
    [22047] = { -- Top Piece of Lord Valthalak's Amulet; cmangos→Wowhead Forever peer
        [16059] = DropKeys.WOWHEAD,
    },
    [22094] = { -- Bloodkelp; cmangos→Wowhead Forever peer
        [4364] = DropKeys.WOWHEAD,
        [4366] = DropKeys.WOWHEAD,
        [4368] = DropKeys.WOWHEAD,
        [4370] = DropKeys.WOWHEAD,
        [4371] = DropKeys.WOWHEAD,
        [16072] = DropKeys.WOWHEAD,
    },
    [22138] = { -- Blackrock Bracer; cmangos→Wowhead Forever peer
        [9044] = DropKeys.WOWHEAD,
        [9045] = DropKeys.WOWHEAD,
        [9097] = DropKeys.WOWHEAD,
        [9098] = DropKeys.WOWHEAD,
        [9257] = DropKeys.WOWHEAD,
        [9258] = DropKeys.WOWHEAD,
        [9259] = DropKeys.WOWHEAD,
        [9260] = DropKeys.WOWHEAD,
        [9261] = DropKeys.WOWHEAD,
        [9262] = DropKeys.WOWHEAD,
        [9263] = DropKeys.WOWHEAD,
        [9264] = DropKeys.WOWHEAD,
        [9583] = DropKeys.WOWHEAD,
        [9596] = DropKeys.WOWHEAD,
        [9692] = DropKeys.WOWHEAD,
        [9693] = DropKeys.WOWHEAD,
        [9716] = DropKeys.WOWHEAD,
        [9717] = DropKeys.WOWHEAD,
        [9718] = DropKeys.WOWHEAD,
        [9736] = DropKeys.WOWHEAD,
        [9817] = DropKeys.WOWHEAD,
        [9818] = DropKeys.WOWHEAD,
        [9819] = DropKeys.WOWHEAD,
        [10316] = DropKeys.WOWHEAD,
        [10317] = DropKeys.WOWHEAD,
        [10318] = DropKeys.WOWHEAD,
        [10319] = DropKeys.WOWHEAD,
        [10429] = DropKeys.WOWHEAD,
        [10509] = DropKeys.WOWHEAD,
        [10742] = DropKeys.WOWHEAD,
        [10899] = DropKeys.WOWHEAD,
    },
    [22216] = { -- Venoxis's Venom Sac; cmangos→Wowhead Forever peer
        [14507] = DropKeys.WOWHEAD,
    },
    [22217] = { -- Kurinnaxx's Venom Sac; cmangos→Wowhead Forever peer
        [15348] = DropKeys.WOWHEAD,
    },
    [22224] = { -- Jeering Spectre's Essence; cmangos→Wowhead Forever peer
        [11469] = DropKeys.WOWHEAD,
        [11470] = DropKeys.WOWHEAD,
        [11471] = DropKeys.WOWHEAD,
        [11472] = DropKeys.WOWHEAD,
        [11473] = DropKeys.WOWHEAD,
        [11474] = DropKeys.WOWHEAD,
        [14690] = DropKeys.WOWHEAD,
    },
    [22226] = { -- Druidical Remains; cmangos→Wowhead Forever peer
        [11730] = DropKeys.WOWHEAD,
        [11731] = DropKeys.WOWHEAD,
        [11732] = DropKeys.WOWHEAD,
        [11733] = DropKeys.WOWHEAD,
        [11734] = DropKeys.WOWHEAD,
    },
    [22227] = { -- Starbreeze Village Relic; cmangos→Wowhead Forever peer
        [7428] = DropKeys.WOWHEAD,
        [7429] = DropKeys.WOWHEAD,
    },
    [22228] = { -- Brilliant Sword of Zealotry; cmangos→Wowhead Forever peer
        [9448] = DropKeys.WOWHEAD,
    },
    [22229] = { -- Soul Ashes of the Banished; cmangos→Wowhead Forever peer
        [7068] = DropKeys.WOWHEAD,
        [7069] = DropKeys.WOWHEAD,
        [7071] = DropKeys.WOWHEAD,
        [7072] = DropKeys.WOWHEAD,
        [7075] = DropKeys.WOWHEAD,
    },
    [22381] = { -- Silithus Venom Sample; cmangos→Wowhead Forever peer
        [11735] = DropKeys.WOWHEAD,
        [11736] = DropKeys.WOWHEAD,
        [11737] = DropKeys.WOWHEAD,
        [11738] = DropKeys.WOWHEAD,
        [11739] = DropKeys.WOWHEAD,
    },
    [22435] = { -- Gorishi Sting; cmangos→Wowhead Forever peer
        [6551] = DropKeys.WOWHEAD,
        [6554] = DropKeys.WOWHEAD,
        [10041] = DropKeys.WOWHEAD,
    },
    [22444] = { -- Putrid Vine; cmangos→Wowhead Forever peer
        [8580] = DropKeys.WOWHEAD,
    },
    [22708] = { -- Fate of Ramaladni; cmangos→Wowhead Forever peer
        [15974] = DropKeys.WOWHEAD,
        [15975] = DropKeys.WOWHEAD,
        [15976] = DropKeys.WOWHEAD,
        [15978] = DropKeys.WOWHEAD,
        [15979] = DropKeys.WOWHEAD,
        [15980] = DropKeys.WOWHEAD,
        [15981] = DropKeys.WOWHEAD,
        [16017] = DropKeys.WOWHEAD,
        [16020] = DropKeys.WOWHEAD,
        [16021] = DropKeys.WOWHEAD,
        [16022] = DropKeys.WOWHEAD,
        [16067] = DropKeys.WOWHEAD,
        [16145] = DropKeys.WOWHEAD,
        [16154] = DropKeys.WOWHEAD,
        [16163] = DropKeys.WOWHEAD,
        [16164] = DropKeys.WOWHEAD,
        [16165] = DropKeys.WOWHEAD,
        [16167] = DropKeys.WOWHEAD,
        [16168] = DropKeys.WOWHEAD,
        [16193] = DropKeys.WOWHEAD,
        [16194] = DropKeys.WOWHEAD,
        [16244] = DropKeys.WOWHEAD,
        [16368] = DropKeys.WOWHEAD,
        [16446] = DropKeys.WOWHEAD,
        [16447] = DropKeys.WOWHEAD,
        [16449] = DropKeys.WOWHEAD,
        [16453] = DropKeys.WOWHEAD,
    },
    [22733] = { -- Staff Head of Atiesh; cmangos→Wowhead Forever peer
        [15990] = DropKeys.WOWHEAD,
    },
    [22892] = { -- Dim Necrotic Stone; cmangos→Wowhead Forever peer
        [16422] = DropKeys.WOWHEAD,
        [16423] = DropKeys.WOWHEAD,
        [16437] = DropKeys.WOWHEAD,
        [16438] = DropKeys.WOWHEAD,
    },
    [23250] = { -- Prismatic Shell; cmangos→Wowhead Forever peer
        [8408] = DropKeys.WOWHEAD,
    },
    [190179] = { -- Avelina's Heart; Wowhead Forever XML 54.69%
        [185333] = 54.69, -- Avelina Lilly
    },
    [190180] = { -- Isaac's Heart; Wowhead Forever XML 55.26%
        [185334] = 55.26, -- Isaac Pearson
    },
    [212792] = { -- Eye of the Tempest; Wowhead Forever XML 100%
        [216474] = 100, -- Ravaging Tempest
    },
    [213127] = { -- Partial Mystical Notes; Wowhead Forever XML 0.01%
        [780] = 0.01, -- Skullsplitter Mystic
    },
    [247886] = { -- Sack of; Wowhead Forever XML 69.85%
        [248362] = 69.85, -- Shinyfinder Narf
    },
    [248002] = { -- Picture Book: Fun with Elementals; Wowhead Forever XML 63.64%
        [248464] = 63.64, -- Nimsy
    },
    [248003] = { -- Geomancy for Curious Young Wizards; Wowhead Forever XML 55.17%
        [248474] = 55.17, -- Geosculptor Yip
    },
    [248004] = { -- Arcane Explainer: Magical Stuff in Simple Words; Wowhead Forever XML 39.28%
        [471] = 39.28, -- Mother Fang
    },
    [251918] = { -- Scrawny Ursera Claw; Wowhead Forever XML 44.65%
        [250926] = 44.65, -- Scrawny Ursera
    },
    [252661] = { -- Commander Cyclas's Head; Wowhead Forever XML 94.27%
        [251966] = 94.27, -- Commander Cyclas
    },
    [252665] = { -- Head of Urs'anah; Wowhead Forever XML 85.95%
        [251115] = 85.95, -- Urs'anah
    },
    [252670] = { -- Prideclaw Pelt; Wowhead Forever XML 47.82%
        [251245] = 47.82, -- Prideclaw
    },
    [253596] = { -- Blood-Stained Bandit Mask; Wowhead Forever XML 35.79%
        [252820] = 35.79, -- Bandit Highwayman
    },
    [253597] = { -- Lowlands Galestrider Tenderloin; Wowhead Forever XML 28.29%
        [251707] = 28.29, -- Ornery Galestrider
    },
    [253710] = { -- Bruuz's Dorsal Fin; Wowhead Forever XML 96.79%
        [209797] = 96.79, -- Bruuz
    },
    [257107] = { -- Shriekling Matriarch's Head; Wowhead Forever XML 68.85%
        [253283] = 68.85, -- Shriekling Matriarch
    },
    [257941] = { -- Windsong Crawler Meat; Wowhead Forever XML 46.94%
        [254588] = 46.94, -- Windsong Crawler
    },
    [257942] = { -- Vulgara's Head; Wowhead Forever XML 86.15%
        [254589] = 86.15, -- Vulgara the Insatiable
    },
    [258530] = { -- Lucky Lure; Wowhead Forever XML 1.03%
        [757] = 1.03, -- Lost One Fisherman
    },
    [262357] = { -- Wind Hollow Essence; Wowhead Forever XML 27.95%
        [251676] = 27.95, -- Wind Hollow
    },
    [263993] = { -- Skybreaker Bulwark; Wowhead Forever XML 70.82%
        [257196] = 70.82, -- Zaal Stormshield
    },
    [265140] = { -- Pristine Shriekling Feather; Wowhead Forever XML 27.92%
        [256092] = 27.92, -- Shadowgale Shriekling
    },
    [265475] = { -- Commander Haalien's Severed Head; Wowhead Forever XML 50.67%
        [253622] = 50.67, -- Commander Haalien
    },
    [267414] = { -- Pristine Leopard Pelt; Wowhead Forever XML 41.33%
        [260157] = 41.33, -- Elder Snow Leopard
    },
    [267416] = { -- Toughened Boar Hide; Wowhead Forever XML 4.04%
        [1689] = 4.04, -- Scarred Crag Boar
    },
    [268518] = { -- Head of the Baron; Wowhead Forever XML 18.16%
        [250660] = 18.16, -- ?
    },
    [268812] = { -- Whispering Horror Residue; Wowhead Forever XML 100%
        [260396] = 100, -- Whispering Horror
    },
    [270151] = { -- Benedict's Orders; Wowhead Forever XML 81.3%
        [262119] = 81.3, -- Corporal Adamore
    },
    [270180] = { -- Horrible Rootcore; Wowhead Forever XML 65.33%
        [260808] = 65.33, -- ?
    },
    [270302] = { -- Chakuyak's Pelt; Wowhead Forever XML 87.53%
        [268558] = 87.53, -- Chakuyak
    },
    [270305] = { -- Brinescale Trident; Wowhead Forever XML 35%
        [262397] = 35, -- Brinescale Skirmisher
    },
    [270435] = { -- Rudolph Gelhardt's Head; Wowhead Forever XML 100%
        [259431] = 100, -- Rudolph Gelhardt
    },
    [270865] = { -- Titan Relic; Wowhead Forever XML 27.02%
        [260326] = 27.02, -- ?
    },
    [270866] = { -- Titan Relic; Wowhead Forever XML 27.09%
        [260326] = 27.09, -- ?
    },
    [271872] = { -- Broken Staff of Incinerator Gar'im; Wowhead Forever XML 84.91%
        [214519] = 84.91, -- Incinerator Gar'im
    },
    [273001] = { -- Gloomrise Toxin Sample; Wowhead Forever XML 78.66%
        [264096] = 78.66, -- Gnawed Corpse
    },
    [273181] = { -- Crystalline Silk; Wowhead Forever XML 45.02%
        [264081] = 45.02, -- Gloomrise Spinner
    },
    [274286] = { -- Durgen Dirgehammer's Head; Wowhead Forever XML 55.08%
        [261319] = 55.08, -- ?
    },
    [274463] = { -- Tattered Note; Wowhead Forever XML 0.76%
        [4421] = 0.76, -- ?
    },
    [275443] = { -- Highly Toxic Strain; Wowhead Forever XML 30.55%
        [250483] = 30.55, -- ?
    },
    [276070] = { -- Chol'aruk's Head; Wowhead Forever XML 94.09%
        [267307] = 94.09, -- Chol'aruk
    },
    [277128] = { -- Bloodtalon Matriarch Eggs; Wowhead Forever XML 87.55%
        [268530] = 87.55, -- Bloodtalon Matriarch
    },
    [277267] = { -- Faladiel's Heart; Wowhead Forever XML 100%
        [268602] = 100, -- Skypriest Faladiel
    },
    [277269] = { -- Kuramaa's Mask; Wowhead Forever XML 100%
        [268605] = 100, -- Kuramaa
    },
    [277277] = { -- Olgra's Adornments; Wowhead Forever XML 34.28% (2166/6319)
        [268624] = 34.28, -- Razormane Raider
    },
    [277986] = { -- Drum of Crude Oil; Wowhead Forever XML 0.01%
        [1097] = 0.01, -- Venture Co. Mechanic
    },
    [279186] = { -- Stormheart's Still-beating Heart; Wowhead Forever XML 100%
        [270094] = 100, -- Stormheart
    },
    [279472] = { -- Pristine Pesterhide Pelt; Wowhead Forever XML 0.25%
        [4249] = 0.25, -- Pesterhide Snarler
    },
    [279505] = { -- Jagged Orcish Sword; Wowhead Forever XML 16.87%
        [11682] = 16.87, -- Horde Grunt
    },
    [279507] = { -- Curved Orcish Dagger; Wowhead Forever XML 2.15%
        [11680] = 2.15, -- Horde Scout
    },
    [279591] = { -- Marek's Croc-Hunting Knife; Wowhead Forever XML 50%
        [270693] = 50, -- Daggerfang
    },
    [279993] = { -- Titanic Keystone; Wowhead Forever XML 88.44%
        [270892] = 88.44, -- Goaz Warder
    },
    [280087] = { -- Soft Nightsaber Pelt; Wowhead Forever XML 9.66%
        [2042] = 9.66, -- Nightsaber
    },
    [280330] = { -- Carnage's Head; Wowhead Forever XML 92.22%
        [271336] = 92.22, -- Carnage
    },
    [280331] = { -- Malignant Rotclaw Flesh; Wowhead Forever XML 27.64%
        [271334] = 27.64, -- Maddened Rotclaw
    },
    [280375] = { -- Worgen Bits; Wowhead Forever XML 20.31%
        [1924] = 20.31, -- Moonrage Bloodhowler
    },
    [280395] = { -- Heart of Ados; Wowhead Forever XML 82.28%
        [271338] = 82.28, -- Ados
    },
    [280396] = { -- Heart of Modr; Wowhead Forever XML 84.69%
        [271460] = 84.69, -- Modr
    },
    [280397] = { -- Heart of Golm; Wowhead Forever XML 88.16%
        [271462] = 88.16, -- Golm
    },
    [280398] = { -- Heart of Neru; Wowhead Forever XML 82%
        [271458] = 82, -- Neru
    },
    [280426] = { -- Sack of Fish; Wowhead Forever XML 73.89%
        [271587] = 73.89, -- Frosthowl
    },
    [280686] = { -- Rod of Deep Dominion; Wowhead Forever XML 69.87%
        [271903] = 69.87, -- Stormscale Beastmistress
    },
    [280831] = { -- Hatescreech's Amulet; Wowhead Forever XML 81.64%
        [272034] = 81.64, -- Hatescreech
    },
    [280832] = { -- Windmistress Gaedress' Amulet; Wowhead Forever XML 84.87%
        [272044] = 84.87, -- Windmistress Gaedress
    },
    [280834] = { -- Witchmother Arysa's Amulet; Wowhead Forever XML 73.32%
        [272046] = 73.32, -- Witchmother Arysa
    },
    [280911] = { -- Spiked Collar; Wowhead Forever XML 10.85%
        [712] = 10.85, -- Redridge Thrasher
    },
    [281023] = { -- Mature Fel Moss; Wowhead Forever XML 92.42%
        [272116] = 92.42, -- Xethorr the Wicked
    },
    [281038] = { -- Feather of Jai'vhanel; Wowhead Forever XML 94.54%
        [270196] = 94.54, -- Jai'vhanel
    },
    [281048] = { -- Clearcutter Key; Wowhead Forever XML 88.44%
        [272173] = 88.44, -- Venture Co. Clearclutter
    },
    [286009] = { -- Aggor's Belt; Wowhead Forever XML 94.87%
        [275666] = 94.87, -- Aggor the Young
    },
    [286075] = { -- Herak's Head; Wowhead Forever XML 92.36%
        [275767] = 92.36, -- Herak the Pillager
    },
    [286325] = { -- Avala's Core; Wowhead Forever XML 96.59%
        [276009] = 96.59, -- Avala
    },
    [286326] = { -- Riptear's Heart; Wowhead Forever XML 91.24%
        [276020] = 91.24, -- Riptear
    },
}

QuestieItemDropGenerated.Tbc = {}
QuestieItemDropGenerated.Wotlk = {}
QuestieItemDropGenerated.Cata = {}
QuestieItemDropGenerated.MoP = {}

-- Merge into QuestieItemDropCorrections for DropDB. Manual corrections win.
---@type QuestieItemDropCorrections
local Corrections = QuestieLoader:ImportModule("QuestieItemDropCorrections")

local function mergeGenerated(dest, src)
    for itemId, npcMap in pairs(src) do
        local destItem = dest[itemId]
        if not destItem then
            dest[itemId] = npcMap
        else
            for npcId, rate in pairs(npcMap) do
                if destItem[npcId] == nil then
                    destItem[npcId] = rate
                end
            end
        end
    end
end

mergeGenerated(Corrections.Era, QuestieItemDropGenerated.Era)
