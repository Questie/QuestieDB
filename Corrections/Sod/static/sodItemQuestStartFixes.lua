---@class LibQuestieDB
local LibQuestieDB = select(2, ...)

--- Imports
local Corrections = LibQuestieDB.Corrections
local ItemMeta = Corrections.ItemMeta

---@class ItemFixesSod
local ItemFixes = {}


C_Timer.After(0, function()
  if LibQuestieDB.IsSoD then
    Corrections.RegisterCorrectionDynamic("item",
                                          "ItemFixes-QuestStarts-Sod-Automatic",
                                          ItemFixes.LoadItemQuestStarts,
                                          80)
  end

  -- Clear the table to save memory
  ItemFixes = wipe(ItemFixes)
end)

---@return table<ItemId, Correction[]>>
function ItemFixes.LoadItemQuestStarts()
  local itemKeys = ItemMeta.itemKeys

  --! This file is automatically generated from wowhead data by looking at all items that starts a quest and correcting it.
  return {
    --* Item 191613 https://classic.wowhead.com/classic/item=191613
    --* Starts: Book of Deathstones(66294)(https://classic.wowhead.com/classic/quest=66294)
    [191613] = {
      [itemKeys.startQuest] = 66294,
    },
    --* Item 209693 https://classic.wowhead.com/classic/item=209693
    --* Starts: The Heart of the Void(78916)(https://classic.wowhead.com/classic/quest=78916)
    [209693] = {
      [itemKeys.startQuest] = 78916,
    },
    --* Item 211269 https://classic.wowhead.com/classic/item=211269
    --* Starts: Terror of the Desert Skies(78823)(https://classic.wowhead.com/classic/quest=78823)
    [211269] = {
      [itemKeys.startQuest] = 78823,
    },
    --* Item 211452 https://classic.wowhead.com/classic/item=211452
    --* Starts: The Heart of the Void(78917)(https://classic.wowhead.com/classic/quest=78917)
    [211452] = {
      [itemKeys.startQuest] = 78917,
    },
    --* Item 211454 https://classic.wowhead.com/classic/item=211454
    --* Starts: Baron Aquanis(78920)(https://classic.wowhead.com/classic/quest=78920)
    [211454] = {
      [itemKeys.startQuest] = 78920,
    },
    --* Item 211813 https://classic.wowhead.com/classic/item=211813
    --* Starts: Clear the Forest!(79098)(https://classic.wowhead.com/classic/quest=79098)
    [211813] = {
      [itemKeys.startQuest] = 79098,
    },
    --* Item 211814 https://classic.wowhead.com/classic/item=211814
    --* Starts: Repelling Invaders(79090)(https://classic.wowhead.com/classic/quest=79090)
    [211814] = {
      [itemKeys.startQuest] = 79090,
    },
    --* Item 212693 https://classic.wowhead.com/classic/item=212693
    --* Starts: The Lost Ancient(79348)(https://classic.wowhead.com/classic/quest=79348)
    [212693] = {
      [itemKeys.startQuest] = 79348,
    },
    --* Item 212748 https://classic.wowhead.com/classic/item=212748
    --* Starts: Tattered Note(79358)(https://classic.wowhead.com/classic/quest=79358)
    [212748] = {
      [itemKeys.startQuest] = 79358,
    },
    --* Item 213422 https://classic.wowhead.com/classic/item=213422
    --* Starts: Anyone Can Cook(79624)(https://classic.wowhead.com/classic/quest=79624)
    [213422] = {
      [itemKeys.startQuest] = 79624,
    },
    --* Item 213736 https://classic.wowhead.com/classic/item=213736
    --* Starts: The Corroded Core(79981)(https://classic.wowhead.com/classic/quest=79981)
    [213736] = {
      [itemKeys.startQuest] = 79981,
    },
    --* Item 215441 https://classic.wowhead.com/classic/item=215441
    --* Starts: The Broken Hammer(79939)(https://classic.wowhead.com/classic/quest=79939)
    [215441] = {
      [itemKeys.startQuest] = 79939,
    },
    --* Item 215468 https://classic.wowhead.com/classic/item=215468
    --* Starts: Orders from the Grand Crusader(79945)(https://classic.wowhead.com/classic/quest=79945)
    [215468] = {
      [itemKeys.startQuest] = 79945,
    },
    --* Item 216661 https://classic.wowhead.com/classic/item=216661
    --* Starts: Grime-Encrusted Ring(79986)(https://classic.wowhead.com/classic/quest=79986)
    [216661] = {
      [itemKeys.startQuest] = 79986,
    },
    --* Item 216880 https://classic.wowhead.com/classic/item=216880
    --* Starts: The Troll Scroll(79731)(https://classic.wowhead.com/classic/quest=79731)
    [216880] = {
      [itemKeys.startQuest] = 79731,
    },
    --* Item 217350 https://classic.wowhead.com/classic/item=217350
    --* Starts: The Mad King(80324)(https://classic.wowhead.com/classic/quest=80324)
    [217350] = {
      [itemKeys.startQuest] = 80324,
    },
    --* Item 217351 https://classic.wowhead.com/classic/item=217351
    --* Starts: The Mad King(80325)(https://classic.wowhead.com/classic/quest=80325)
    [217351] = {
      [itemKeys.startQuest] = 80325,
    },
    --* Item 220526 https://classic.wowhead.com/classic/item=220526
    --* Starts: More Junk for Ziri(81974)(https://classic.wowhead.com/classic/quest=81974)
    [220526] = {
      [itemKeys.startQuest] = 81974,
    },
    --* Item 221272 https://classic.wowhead.com/classic/item=221272
    --* Starts: Darkmoon Wilds Deck(82058)(https://classic.wowhead.com/classic/quest=82058)
    [221272] = {
      [itemKeys.startQuest] = 82058,
    },
    --* Item 221280 https://classic.wowhead.com/classic/item=221280
    --* Starts: Darkmoon Plagues Deck(82057)(https://classic.wowhead.com/classic/quest=82057)
    [221280] = {
      [itemKeys.startQuest] = 82057,
    },
    --* Item 221289 https://classic.wowhead.com/classic/item=221289
    --* Starts: Darkmoon Dunes Deck(82055)(https://classic.wowhead.com/classic/quest=82055)
    [221289] = {
      [itemKeys.startQuest] = 82055,
    },
    --* Item 221299 https://classic.wowhead.com/classic/item=221299
    --* Starts: Darkmoon Nightmares Deck(82056)(https://classic.wowhead.com/classic/quest=82056)
    [221299] = {
      [itemKeys.startQuest] = 82056,
    },
  }
end