# Pet food tool

`generate.py` writes the pet food support data that `LibQuestieDB.Support.Get("PetFood")` publishes.
It is never run by Generation or CI; run it when a client update may have changed pet food, then
review the diff and commit it.

```sh
./questiedb.sh food-type                                  # all flavors, newest builds
./questiedb.sh food-type Forever                          # one flavor
./questiedb.sh food-type --build Forever=1.60.1.71091     # pin a build; repeat for more flavors
```

It needs Python 3.8+ and its standard library, and writes nothing when a table is missing or malformed.

## Sources

The generator downloads these tables from wago.tools. Each generated file names the builds it was made from.

| Fact | Table and column |
| --- | --- |
| Which items a flavor has | Its own `Item` table |
| Which food type an item is | Forever's `Item.ItemPetFoodID`. For items Forever does not have: the saved PTR values below |
| Which food types a pet family eats | The flavor's own `CreatureFamily.PetFoodMask` |
| What the client calls a food type | The flavor's own `ItemPetFood`, in every language |

On Era, TBC and Wrath only the server knows an item's food type; their clients do not have the column. Type 9,
Mechanical Bits, is left out: it feeds mechanical pets, which none of these flavors have.

The column name is the community's guess in WoWDBDefs, marked with a question mark there.

wago.tools answers in English for a language an export does not have, without saying so. The generator
treats a table that is mostly equal to the English one as missing. None of these flavors has Italian.

Cata and Mists have no file. Patch 4.1.0 removed pet happiness, so their players do not have to feed pets.

## Saved PTR values

`ptr-item-pet-food.12.1.7.71087.csv` holds every item that retail's test realm build 12.1.7.71087 (20 November
2026) calls food. Live retail 12.1.5 does not have the column, and wago.tools may stop offering the build, so the
values are kept here and never downloaded. They are only used for items that Forever does not have, which today
are TBC and Wrath items: every Vanilla food is in Forever's table.

The file is the `ID` and `ItemPetFoodID` of the 1,859 rows with a food type, sorted by ID, out of the 214,957 rows
of `https://wago.tools/db2/Item/csv?build=12.1.7.71087`. That download had the SHA-256
`1f2a76acefedce29b55608a11756af151f5e14efade521b80c618900b3df4806`. The values were the same in all seven 12.1.7
builds from 15 October to 20 November.

## Accuracy

Questie's 2022 database still had food types, taken from the cmangos server emulator. One comparison with it, made
with Forever 1.60.1.71091:

| | Vanilla | TBC | Wrath |
| --- | --- | --- | --- |
| Foods sold by a vendor | 51 of 51 | 73 of 74 | 94 of 97 |
| All foods | 186 of 198 | 249 of 265 | 342 of 363 |

The vendor differences are Simple Flour (bread there, no pet food here) and, in Wrath only, Homemade Cherry Pie and
Steaming Chicken Soup. The generated lists also name many foods that database had no type for: 15 sold ones in TBC and
22 in Wrath are known from the PTR alone.
