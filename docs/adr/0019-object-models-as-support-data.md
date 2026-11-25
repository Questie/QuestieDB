# 19. Object models as Support data

Status: accepted.

Questie's Journey shows a 3D model for any object in the database. The client has no API that
turns an object ID into a model, so QuestieDB supplies the model's FileDataID per flavor. Its
size is not stored: the client reports it once the model is set.

## Decisions

### 1. Support data, for every object

Models ship as one generated Lua module per flavor, read through
`LibQuestieDB.GetObjectModelFileID(objectId)`. They are not a field of Object.

A field would cost no Lua memory, but needs a Source-mode provider with a row per object, another
provider for Season of Discovery objects, and gives authors a second place to set a model. Support data changes neither the entity schema
nor the storage format, and serves objects added by Dynamic Corrections without extra work.

The module holds text grouped by model, 51-149 KB per flavor. It is inverted on the first lookup,
which takes up to about 12 ms offline and then holds 0.3-1.3 MB. A plain table would cost every
session that memory, even without opening an object's page.

Shipping only quest-relevant objects was rejected: the Journey has a page for every object, and a
module that depends on quest relations would go stale with every quest change.

### 2. Display IDs are the truth, FileDataIDs ship

Sources record display IDs. The flavor's own `GameObjectDisplayInfo` resolves them, so a display
that a client lacks is noticed instead of shipping a file it may not have. Each display is
reduced to one kind (file, creature, item, none) and one ID, because alternate displays carry a
FileDataID as well. Creatures, items and hidden models have no shipped entry; adding them later
is additive.

### 3. Committed inputs, optional importers

Generation and tests read only committed files. Importers fill one source's column and cannot
change reviewed rows. Values belong to an ID and a name together, because an ID can be another
object elsewhere and Corrections invent IDs. Renaming an object therefore drops its values: an
empty spot is better than a wrong model.

### 4. Wrong fails, missing warns

CI fails when shipped models do not match their committed sources, when committed data is unusable,
or when a quarter of a flavor's models is missing, which means lost data. A missing model is a
warning: new content must never be blocked by its models. An object whose own source names a
display newer than our table stays without a model instead of borrowing another expansion's.

### 5. Contract 5

`GetObjectModelFileID` ships with contract 5's other additions and is additive, so
`minSupportedContract` stays 1. A model is decoration:
consumers should test for the function rather than require contract 5.
