---@class LibQuestieDB
local LibQuestieDB = select(2, ...)

--- Imports
local Corrections = LibQuestieDB.Corrections
local ItemMeta = Corrections.ItemMeta

---@class ItemFixesTbc
local ItemFixes = {}


C_Timer.After(0, function()
  Corrections.RegisterCorrectionStatic("item",
                                       "ItemFixes-QuestStarts-Tbc-Automatic",
                                       ItemFixes.LoadItemQuestStarts,
                                       29)

  -- Clear the table to save memory
  ItemFixes = wipe(ItemFixes)
end)

---@return table<ItemId, Correction[]>>
function ItemFixes.LoadItemQuestStarts()
  local itemKeys = ItemMeta.itemKeys

  --! This file is automatically generated from wowhead data by looking at all items that starts a quest and correcting it.
  return {
    --* Item 20483 https://tbc.wowhead.com/tbc/item=20483
    --* Starts: Tainted Arcane Sliver(8338)(https://tbc.wowhead.com/tbc/quest=8338)
    [20483] = {
      [itemKeys.startQuest] = 8338,
    },
    --* Item 20765 https://tbc.wowhead.com/tbc/item=20765
    --* Starts: Incriminating Documents(8482)(https://tbc.wowhead.com/tbc/quest=8482)
    [20765] = {
      [itemKeys.startQuest] = 8482,
    },
    --* Item 20798 https://tbc.wowhead.com/tbc/item=20798
    --* Starts: An Intact Converter(8489)(https://tbc.wowhead.com/tbc/quest=8489)
    [20798] = {
      [itemKeys.startQuest] = 8489,
    },
    --* Item 20938 https://tbc.wowhead.com/tbc/item=20938
    --* Starts: Welcome!(8547)(https://tbc.wowhead.com/tbc/quest=8547)
    [20938] = {
      [itemKeys.startQuest] = 8547,
    },
    --* Item 21776 https://tbc.wowhead.com/tbc/item=21776
    --* Starts: Captain Kelisendra's Lost Rutters(8887)(https://tbc.wowhead.com/tbc/quest=8887)
    [21776] = {
      [itemKeys.startQuest] = 8887,
    },
    --* Item 22597 https://tbc.wowhead.com/tbc/item=22597
    --* Starts: The Lady's Necklace(9175)(https://tbc.wowhead.com/tbc/quest=9175)
    [22597] = {
      [itemKeys.startQuest] = 9175,
    },
    --* Item 22888 https://tbc.wowhead.com/tbc/item=22888
    --* Starts: Welcome!(9278)(https://tbc.wowhead.com/tbc/quest=9278)
    [22888] = {
      [itemKeys.startQuest] = 9278,
    },
    --* Item 23228 https://tbc.wowhead.com/tbc/item=23228
    --* Starts: Old Whitebark's Pendant(8474)(https://tbc.wowhead.com/tbc/quest=8474)
    [23228] = {
      [itemKeys.startQuest] = 8474,
    },
    --* Item 23249 https://tbc.wowhead.com/tbc/item=23249
    --* Starts: Amani Invasion(9360)(https://tbc.wowhead.com/tbc/quest=9360)
    [23249] = {
      [itemKeys.startQuest] = 9360,
    },
    --* Item 23338 https://tbc.wowhead.com/tbc/item=23338
    --* Starts: Missing Missive(9373)(https://tbc.wowhead.com/tbc/quest=9373)
    [23338] = {
      [itemKeys.startQuest] = 9373,
    },
    --* Item 23580 https://tbc.wowhead.com/tbc/item=23580
    --* Starts: Avruu's Orb(9418)(https://tbc.wowhead.com/tbc/quest=9418)
    [23580] = {
      [itemKeys.startQuest] = 9418,
    },
    --* Item 23678 https://tbc.wowhead.com/tbc/item=23678
    --* Starts: Strange Findings(9455)(https://tbc.wowhead.com/tbc/quest=9455)
    [23678] = {
      [itemKeys.startQuest] = 9455,
    },
    --* Item 23759 https://tbc.wowhead.com/tbc/item=23759
    --* Starts: Rune Covered Tablet(9514)(https://tbc.wowhead.com/tbc/quest=9514)
    [23759] = {
      [itemKeys.startQuest] = 9514,
    },
    --* Item 23777 https://tbc.wowhead.com/tbc/item=23777
    --* Starts: Diabolical Plans(9520)(https://tbc.wowhead.com/tbc/quest=9520)
    [23777] = {
      [itemKeys.startQuest] = 9520,
    },
    --* Item 23797 https://tbc.wowhead.com/tbc/item=23797
    --* Starts: Diabolical Plans(9535)(https://tbc.wowhead.com/tbc/quest=9535)
    [23797] = {
      [itemKeys.startQuest] = 9535,
    },
    --* Item 23837 https://tbc.wowhead.com/tbc/item=23837
    --* Starts: A Map to Where?(9550)(https://tbc.wowhead.com/tbc/quest=9550)
    [23837] = {
      [itemKeys.startQuest] = 9550,
    },
    --* Item 23850 https://tbc.wowhead.com/tbc/item=23850
    --* Starts: Gurf's Dignity(9564)(https://tbc.wowhead.com/tbc/quest=9564)
    [23850] = {
      [itemKeys.startQuest] = 9564,
    },
    --* Item 23870 https://tbc.wowhead.com/tbc/item=23870
    --* Starts: Cruelfin's Necklace(9576)(https://tbc.wowhead.com/tbc/quest=9576)
    [23870] = {
      [itemKeys.startQuest] = 9576,
    },
    --* Item 23890 https://tbc.wowhead.com/tbc/item=23890
    --* Starts: Dark Tidings(9587)(https://tbc.wowhead.com/tbc/quest=9587)
    [23890] = {
      [itemKeys.startQuest] = 9587,
    },
    --* Item 23892 https://tbc.wowhead.com/tbc/item=23892
    --* Starts: Dark Tidings(9588)(https://tbc.wowhead.com/tbc/quest=9588)
    [23892] = {
      [itemKeys.startQuest] = 9588,
    },
    --* Item 23900 https://tbc.wowhead.com/tbc/item=23900
    --* Starts: Signs of the Legion(9594)(https://tbc.wowhead.com/tbc/quest=9594)
    [23900] = {
      [itemKeys.startQuest] = 9594,
    },
    --* Item 23910 https://tbc.wowhead.com/tbc/item=23910
    --* Starts: Bandits!(9616)(https://tbc.wowhead.com/tbc/quest=9616)
    [23910] = {
      [itemKeys.startQuest] = 9616,
    },
    --* Item 24132 https://tbc.wowhead.com/tbc/item=24132
    --* Starts: The Bloodcurse Legacy(9672)(https://tbc.wowhead.com/tbc/quest=9672)
    [24132] = {
      [itemKeys.startQuest] = 9672,
    },
    --* Item 24228 https://tbc.wowhead.com/tbc/item=24228
    --* Starts: The Sun King's Command(9695)(https://tbc.wowhead.com/tbc/quest=9695)
    [24228] = {
      [itemKeys.startQuest] = 9695,
    },
    --* Item 24330 https://tbc.wowhead.com/tbc/item=24330
    --* Starts: Drain Schematics(9731)(https://tbc.wowhead.com/tbc/quest=9731)
    [24330] = {
      [itemKeys.startQuest] = 9731,
    },
    --* Item 24367 https://tbc.wowhead.com/tbc/item=24367
    --* Starts: Orders from Lady Vashj(9764)(https://tbc.wowhead.com/tbc/quest=9764)
    [24367] = {
      [itemKeys.startQuest] = 9764,
    },
    --* Item 24407 https://tbc.wowhead.com/tbc/item=24407
    --* Starts: Uncatalogued Species(9875)(https://tbc.wowhead.com/tbc/quest=9875)
    [24407] = {
      [itemKeys.startQuest] = 9875,
    },
    --* Item 24414 https://tbc.wowhead.com/tbc/item=24414
    --* Starts: Blood Elf Plans(9798)(https://tbc.wowhead.com/tbc/quest=9798)
    [24414] = {
      [itemKeys.startQuest] = 9798,
    },
    --* Item 24483 https://tbc.wowhead.com/tbc/item=24483
    --* Starts: Withered Basidium(9827)(https://tbc.wowhead.com/tbc/quest=9827)
    [24483] = {
      [itemKeys.startQuest] = 9827,
    },
    --* Item 24484 https://tbc.wowhead.com/tbc/item=24484
    --* Starts: Withered Basidium(9828)(https://tbc.wowhead.com/tbc/quest=9828)
    [24484] = {
      [itemKeys.startQuest] = 9828,
    },
    --* Item 24504 https://tbc.wowhead.com/tbc/item=24504
    --* Starts: The Howling Wind(9861)(https://tbc.wowhead.com/tbc/quest=9861)
    [24504] = {
      [itemKeys.startQuest] = 9861,
    },
    --* Item 24558 https://tbc.wowhead.com/tbc/item=24558
    --* Starts: Murkblood Invaders(9872)(https://tbc.wowhead.com/tbc/quest=9872)
    [24558] = {
      [itemKeys.startQuest] = 9872,
    },
    --* Item 24559 https://tbc.wowhead.com/tbc/item=24559
    --* Starts: Murkblood Invaders(9871)(https://tbc.wowhead.com/tbc/quest=9871)
    [24559] = {
      [itemKeys.startQuest] = 9871,
    },
    --* Item 25459 https://tbc.wowhead.com/tbc/item=25459
    --* Starts: The Count of the Marshes(9911)(https://tbc.wowhead.com/tbc/quest=9911)
    [25459] = {
      [itemKeys.startQuest] = 9911,
    },
    --* Item 25705 https://tbc.wowhead.com/tbc/item=25705
    --* Starts: Host of the Hidden City(9984)(https://tbc.wowhead.com/tbc/quest=9984)
    [25705] = {
      [itemKeys.startQuest] = 9984,
    },
    --* Item 25706 https://tbc.wowhead.com/tbc/item=25706
    --* Starts: Host of the Hidden City(9985)(https://tbc.wowhead.com/tbc/quest=9985)
    [25706] = {
      [itemKeys.startQuest] = 9985,
    },
    --* Item 28113 https://tbc.wowhead.com/tbc/item=28113
    --* Starts: The Western Flank(10130)(https://tbc.wowhead.com/tbc/quest=10130)
    [28113] = {
      [itemKeys.startQuest] = 10130,
    },
    --* Item 28114 https://tbc.wowhead.com/tbc/item=28114
    --* Starts: The Western Flank(10152)(https://tbc.wowhead.com/tbc/quest=10152)
    [28114] = {
      [itemKeys.startQuest] = 10152,
    },
    --* Item 28552 https://tbc.wowhead.com/tbc/item=28552
    --* Starts: Decipher the Tome(10229)(https://tbc.wowhead.com/tbc/quest=10229)
    [28552] = {
      [itemKeys.startQuest] = 10229,
    },
    --* Item 28598 https://tbc.wowhead.com/tbc/item=28598
    --* Starts: R.T.F.R.C.M.(10244)(https://tbc.wowhead.com/tbc/quest=10244)
    [28598] = {
      [itemKeys.startQuest] = 10244,
    },
    --* Item 29233 https://tbc.wowhead.com/tbc/item=29233
    --* Starts: Battle-Mage Dathric(10182)(https://tbc.wowhead.com/tbc/quest=10182)
    [29233] = {
      [itemKeys.startQuest] = 10182,
    },
    --* Item 29234 https://tbc.wowhead.com/tbc/item=29234
    --* Starts: Abjurist Belmara(10305)(https://tbc.wowhead.com/tbc/quest=10305)
    [29234] = {
      [itemKeys.startQuest] = 10305,
    },
    --* Item 29235 https://tbc.wowhead.com/tbc/item=29235
    --* Starts: Conjurer Luminrath(10306)(https://tbc.wowhead.com/tbc/quest=10306)
    [29235] = {
      [itemKeys.startQuest] = 10306,
    },
    --* Item 29236 https://tbc.wowhead.com/tbc/item=29236
    --* Starts: Cohlien Frostweaver(10307)(https://tbc.wowhead.com/tbc/quest=10307)
    [29236] = {
      [itemKeys.startQuest] = 10307,
    },
    --* Item 29476 https://tbc.wowhead.com/tbc/item=29476
    --* Starts: Crimson Crystal Clue(10134)(https://tbc.wowhead.com/tbc/quest=10134)
    [29476] = {
      [itemKeys.startQuest] = 10134,
    },
    --* Item 29588 https://tbc.wowhead.com/tbc/item=29588
    --* Starts: The Dark Missive(10395)(https://tbc.wowhead.com/tbc/quest=10395)
    [29588] = {
      [itemKeys.startQuest] = 10395,
    },
    --* Item 29590 https://tbc.wowhead.com/tbc/item=29590
    --* Starts: Vile Plans(10393)(https://tbc.wowhead.com/tbc/quest=10393)
    [29590] = {
      [itemKeys.startQuest] = 10393,
    },
    --* Item 29738 https://tbc.wowhead.com/tbc/item=29738
    --* Starts: The Horrors of Pollution(10413)(https://tbc.wowhead.com/tbc/quest=10413)
    [29738] = {
      [itemKeys.startQuest] = 10413,
    },
    --* Item 30431 https://tbc.wowhead.com/tbc/item=30431
    --* Starts: Thunderlord Clan Artifacts(10524)(https://tbc.wowhead.com/tbc/quest=10524)
    [30431] = {
      [itemKeys.startQuest] = 10524,
    },
    --* Item 30579 https://tbc.wowhead.com/tbc/item=30579
    --* Starts: Illidari-Bane Shard(10623)(https://tbc.wowhead.com/tbc/quest=10623)
    [30579] = {
      [itemKeys.startQuest] = 10623,
    },
    --* Item 30756 https://tbc.wowhead.com/tbc/item=30756
    --* Starts: Illidari-Bane Shard(10621)(https://tbc.wowhead.com/tbc/quest=10621)
    [30756] = {
      [itemKeys.startQuest] = 10621,
    },
    --* Item 31120 https://tbc.wowhead.com/tbc/item=31120
    --* Starts: Did You Get The Note?(10719)(https://tbc.wowhead.com/tbc/quest=10719)
    [31120] = {
      [itemKeys.startQuest] = 10719,
    },
    --* Item 31239 https://tbc.wowhead.com/tbc/item=31239
    --* Starts: Entry Into the Citadel(10754)(https://tbc.wowhead.com/tbc/quest=10754)
    [31239] = {
      [itemKeys.startQuest] = 10754,
    },
    --* Item 31241 https://tbc.wowhead.com/tbc/item=31241
    --* Starts: Entry Into the Citadel(10755)(https://tbc.wowhead.com/tbc/quest=10755)
    [31241] = {
      [itemKeys.startQuest] = 10755,
    },
    --* Item 31345 https://tbc.wowhead.com/tbc/item=31345
    --* Starts: The Journal of Val'zareq: Portends of War(10793)(https://tbc.wowhead.com/tbc/quest=10793)
    [31345] = {
      [itemKeys.startQuest] = 10793,
    },
    --* Item 31363 https://tbc.wowhead.com/tbc/item=31363
    --* Starts: Favor of the Gronn(10797)(https://tbc.wowhead.com/tbc/quest=10797)
    [31363] = {
      [itemKeys.startQuest] = 10797,
    },
    --* Item 31384 https://tbc.wowhead.com/tbc/item=31384
    --* Starts: Damaged Mask(10810)(https://tbc.wowhead.com/tbc/quest=10810)
    [31384] = {
      [itemKeys.startQuest] = 10810,
    },
    --* Item 31489 https://tbc.wowhead.com/tbc/item=31489
    --* Starts: The Truth Unorbed(10825)(https://tbc.wowhead.com/tbc/quest=10825)
    [31489] = {
      [itemKeys.startQuest] = 10825,
    },
    --* Item 31707 https://tbc.wowhead.com/tbc/item=31707
    --* Starts: Cabal Orders(10880)(https://tbc.wowhead.com/tbc/quest=10880)
    [31707] = {
      [itemKeys.startQuest] = 10880,
    },
    --* Item 31890 https://tbc.wowhead.com/tbc/item=31890
    --* Starts: Darkmoon Blessings Deck(10938)(https://tbc.wowhead.com/tbc/quest=10938)
    [31890] = {
      [itemKeys.startQuest] = 10938,
    },
    --* Item 31891 https://tbc.wowhead.com/tbc/item=31891
    --* Starts: Darkmoon Storms Deck(10939)(https://tbc.wowhead.com/tbc/quest=10939)
    [31891] = {
      [itemKeys.startQuest] = 10939,
    },
    --* Item 31907 https://tbc.wowhead.com/tbc/item=31907
    --* Starts: Darkmoon Furies Deck(10940)(https://tbc.wowhead.com/tbc/quest=10940)
    [31907] = {
      [itemKeys.startQuest] = 10940,
    },
    --* Item 31914 https://tbc.wowhead.com/tbc/item=31914
    --* Starts: Darkmoon Lunacy Deck(10941)(https://tbc.wowhead.com/tbc/quest=10941)
    [31914] = {
      [itemKeys.startQuest] = 10941,
    },
    --* Item 32385 https://tbc.wowhead.com/tbc/item=32385
    --* Starts: The Fall of Magtheridon(11002)(https://tbc.wowhead.com/tbc/quest=11002)
    [32385] = {
      [itemKeys.startQuest] = 11002,
    },
    --* Item 32386 https://tbc.wowhead.com/tbc/item=32386
    --* Starts: The Fall of Magtheridon(11003)(https://tbc.wowhead.com/tbc/quest=11003)
    [32386] = {
      [itemKeys.startQuest] = 11003,
    },
    --* Item 32405 https://tbc.wowhead.com/tbc/item=32405
    --* Starts: Kael'thas and the Verdant Sphere(11007)(https://tbc.wowhead.com/tbc/quest=11007)
    [32405] = {
      [itemKeys.startQuest] = 11007,
    },
    --* Item 32523 https://tbc.wowhead.com/tbc/item=32523
    --* Starts: Ishaal's Almanac(11021)(https://tbc.wowhead.com/tbc/quest=11021)
    [32523] = {
      [itemKeys.startQuest] = 11021,
    },
    --* Item 32621 https://tbc.wowhead.com/tbc/item=32621
    --* Starts: A Job Unfinished...(11041)(https://tbc.wowhead.com/tbc/quest=11041)
    [32621] = {
      [itemKeys.startQuest] = 11041,
    },
    --* Item 32726 https://tbc.wowhead.com/tbc/item=32726
    --* Starts: The Great Murkblood Revolt(11081)(https://tbc.wowhead.com/tbc/quest=11081)
    [32726] = {
      [itemKeys.startQuest] = 11081,
    },
    --* Item 33102 https://tbc.wowhead.com/tbc/item=33102
    --* Starts: Blood of the Warlord(11178)(https://tbc.wowhead.com/tbc/quest=11178)
    [33102] = {
      [itemKeys.startQuest] = 11178,
    },
    --* Item 33114 https://tbc.wowhead.com/tbc/item=33114
    --* Starts: The Apothecary's Letter(11185)(https://tbc.wowhead.com/tbc/quest=11185)
    [33114] = {
      [itemKeys.startQuest] = 11185,
    },
    --* Item 33115 https://tbc.wowhead.com/tbc/item=33115
    --* Starts: Signs of Treachery?(11186)(https://tbc.wowhead.com/tbc/quest=11186)
    [33115] = {
      [itemKeys.startQuest] = 11186,
    },
    --* Item 33978 https://tbc.wowhead.com/tbc/item=33978
    --* Starts: Brewfest Riding Rams(11400)(https://tbc.wowhead.com/tbc/quest=11400)
    [33978] = {
      [itemKeys.startQuest] = 11400,
    },
    --* Item 34028 https://tbc.wowhead.com/tbc/item=34028
    --* Starts: Brewfest Riding Rams(11419)(https://tbc.wowhead.com/tbc/quest=11419)
    [34028] = {
      [itemKeys.startQuest] = 11419,
    },
    --* Item 34469 https://tbc.wowhead.com/tbc/item=34469
    --* Starts: Strange Engine Part(11531)(https://tbc.wowhead.com/tbc/quest=11531)
    [34469] = {
      [itemKeys.startQuest] = 11531,
    },
    --* Item 35568 https://tbc.wowhead.com/tbc/item=35568
    --* Starts: Stealing Silvermoon's Flame(11935)(https://tbc.wowhead.com/tbc/quest=11935)
    [35568] = {
      [itemKeys.startQuest] = 11935,
    },
    --* Item 35569 https://tbc.wowhead.com/tbc/item=35569
    --* Starts: Stealing the Exodar's Flame(11933)(https://tbc.wowhead.com/tbc/quest=11933)
    [35569] = {
      [itemKeys.startQuest] = 11933,
    },
    --* Item 35723 https://tbc.wowhead.com/tbc/item=35723
    --* Starts: Shards of Ahune(11972)(https://tbc.wowhead.com/tbc/quest=11972)
    [35723] = {
      [itemKeys.startQuest] = 11972,
    },
    --* Item 37571 https://tbc.wowhead.com/tbc/item=37571
    --* Starts: Brew of the Month Club(12278)(https://tbc.wowhead.com/tbc/quest=12278)
    [37571] = {
      [itemKeys.startQuest] = 12278,
    },
    --* Item 37599 https://tbc.wowhead.com/tbc/item=37599
    --* Starts: Brew of the Month Club(12306)(https://tbc.wowhead.com/tbc/quest=12306)
    [37599] = {
      [itemKeys.startQuest] = 12306,
    },
    --* Item 37736 https://tbc.wowhead.com/tbc/item=37736
    --* Starts: Brew of the Month Club(12420)(https://tbc.wowhead.com/tbc/quest=12420)
    [37736] = {
      [itemKeys.startQuest] = 12420,
    },
    --* Item 37737 https://tbc.wowhead.com/tbc/item=37737
    --* Starts: Brew of the Month Club(12421)(https://tbc.wowhead.com/tbc/quest=12421)
    [37737] = {
      [itemKeys.startQuest] = 12421,
    },
    --* Item 38280 https://tbc.wowhead.com/tbc/item=38280
    --* Starts: Direbrew's Dire Brew(12491)(https://tbc.wowhead.com/tbc/quest=12491)
    [38280] = {
      [itemKeys.startQuest] = 12491,
    },
    --* Item 38281 https://tbc.wowhead.com/tbc/item=38281
    --* Starts: Direbrew's Dire Brew(12492)(https://tbc.wowhead.com/tbc/quest=12492)
    [38281] = {
      [itemKeys.startQuest] = 12492,
    },
  }
end
