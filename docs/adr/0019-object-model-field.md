# 19. Object models are a field of Object

Status: accepted.

Questie's Journey shows a 3D model for any object in the database. The client has no API that
turns an object ID into a model, so QuestieDB supplies the model's FileDataID per flavor. Its
size is not stored: the client reports it once the model is set.

## Decisions

### 1. `Object.modelFileId`, for every object

The model is a scalar field, read like any other: `ObjectDB.modelFileId(objectId)`. It costs no Lua
memory, decodes with the object's Scalar row, and adds 52 to 143 KB to a Baked TOC. Corrections,
provenance, Source/Baked equivalence and reconstruction cover it without extra work. 0 means that a
known object has no plain model to show, as for every absent number.

A Support data table was built first and replaced before release. It was looked up per object, kept
up to 1.3 MB of Lua memory after the first lookup, needed its own decoder, and was the only Support
data that is not consumed as a whole table.

Shipping only quest-relevant objects was rejected: the Journey has a page for every object, and data
that depends on quest relations would go stale with every quest change.

### 2. The tool generates Corrections

`tools/object-models` keeps its inputs beside itself and generates providers that fill the field.
Static ones apply after every other Static Correction, create no object and overwrite no value, so an
authored Correction always wins. Generation folds them into the TOC, and Source mode loads them.

Objects that only Season of Discovery adds get theirs from a Dynamic provider behind the season gate.
A Dynamic row creates its object, so that provider skips objects the other SoD providers do not add.

### 3. Display IDs are the truth, FileDataIDs ship

Sources record display IDs. The flavor's own `GameObjectDisplayInfo` resolves them, so a display
that a client lacks is noticed instead of shipping a file it may not have. Each display is
reduced to one kind (file, creature, item, none) and one ID, because alternate displays carry a
FileDataID as well. Creatures, items and hidden models have no value; adding them later is additive.

### 4. Committed inputs, optional importers

Generation and tests read only committed files. Importers fill one source's column and cannot
change reviewed rows. Values belong to an ID and a name together, because an ID can be another
object elsewhere and Corrections invent IDs. Renaming an object therefore drops its values: an
empty spot is better than a wrong model.

### 5. Wrong fails, missing warns

CI fails when generated providers do not match their committed sources, when committed data is
unusable, or when a quarter of a flavor's models is missing, which means lost data. A missing model
is a warning: new content must never be blocked by its models. An object whose own source names a
display newer than our table stays without a model instead of borrowing another expansion's.

### 6. Contract 6

The field is additive, so `minSupportedContract` stays 1. A model is decoration: consumers should
test for the getter rather than require contract 6.
