# Forever

Forever is an independent flavor with owned inputs in `data/Forever`,
`src/corrections/Forever`, `l10n/Forever` and `support/Forever`. It shares schemas,
algorithms and initial Classic rules, not live Era data or future Era imports.
The public entity, Correction, localization and support APIs and LuaLS types are unchanged.

The adopted set includes four raw entity files and six Correction files plus
`data/Forever/conversion.json`. Coordinate conversion changed 13,691 pairs and explicitly
retained six unresolved points. The reviewed faction-template export and completed map handoff
are also adopted. Current maps contain 1,064 forward and 54 canonical reverse DBC relationships,
plus 40 compatibility pairs for consumer instance-entrance handling. Those retired floor UiMaps
are not native Forever maps. See [current maintenance guidance](forever-data.md#how-it-works-now)
and the [map audit](forever-map-override-audit.md) for provenance, dispositions and gaps.
The [coordinate audit](forever-coordinate-audit.md) also covers the converted Era-framed
entrances and Questie's Mulgore Darkmoon replacements. This is not complete new Forever
content: later-expansion entrance frames, synthetic coordinates, live placement, new entities
and race/class policy still need separate review.

## Source selection

The committed `QuestieDB.toc` uses native per-file `AllowLoadGameType` conditions.
`src/flavors/Forever.lua` selects Forever through `[AllowLoadGameType camelot, forever]`
before its Source reader and payloads load. Configuration maps both names to the same owned
files, and the emulator tests both personas. This does not establish independent live recognition
of each token; `camelot` remains the default emulator persona. Owned folder names need not match native
game-type names.

Native selection replaces cross-flavor Lua discard selectors and their marker files.
The loader shim still captures deferred entity strings, materializes them lazily and
restores the previous loader after each input phase. Support and Correction setup/teardown
remain ordered around their payloads. Lua still handles faction and season gates.

Legacy Corrections remain cumulative from Era through Mists. Forever loads only its owned
providers, including its own Item-start provider. SoD applies only to Vanilla season 2;
Titan Reforged applies only to Wrath season 109, not Forever.

## Correction authoring

Add new corrections in `src/corrections/Forever/`:

- `foreverQuestFixes.lua`
- `foreverNPCFixes.lua`
- `foreverItemFixes.lua`
- `foreverObjectFixes.lua`

Each file is already registered with two entry points:

- `Load()` returns Static Corrections, applied in Source mode and folded into Generation.
- `LoadDynamic()` returns Dynamic Corrections selected from generic character/game facts,
  such as faction, race or class. Consumer settings and policy stay with the consumer.

Both return `[entityId] = { [fieldKey] = correctedValue }` tables. The six files in `legacy/`
remain the inherited baseline; leave them unchanged for ordinary correction work. New Static
Corrections apply after legacy Static Corrections. New Dynamic Corrections apply after legacy
Dynamic Corrections. Dynamic Corrections still outrank all static data, so a replacement for
an inherited Dynamic Correction belongs in `LoadDynamic()`, even if its new value is unconditional.

Conversion only targets the inherited baseline and raw data, never `forever*Fixes.lua`.

## Baked artifacts

`generate.lua Forever` writes `QuestieDB_Forever.toc` and a byte-identical temporary
`QuestieDB_Camelot.toc` alias after Localization blocks are complete. Packaging creates the
alias again from the staged canonical TOC after Static Correction stripping; it does not
trust an old workspace alias. Legacy underscore filenames are unchanged. Baked file lists
remain resolved plain paths, without native file conditions or conditional entity metadata.

All six flavors produce six flavor ZIPs plus `QuestieDB-all.zip`. Bootstrap still accepts
five-flavor combined releases using the nested `questiedb` manifest; the old flat manifest
format is not accepted. A combined release containing either Forever TOC must contain both,
byte-identically. Camelot is not a selectable database flavor or a separate ZIP.
[Issue #23](https://github.com/Questie/QuestieDB/issues/23) tracks removal of the temporary token
and filename handling, including workflow handoffs and older-release bootstrap compatibility.

All nine generated locales remain in Baked artifacts so `LibQuestieDB.l10n.SetLocale()` can
switch locales. There is no client-locale filtering. Source Base translations are still
unavailable; Dynamic Translation Corrections continue to work in either mode.

## Offline workflow

```sh
./questiedb.sh generate Forever
./questiedb.sh check Forever
lua5.1 test.lua --flavor=Forever
./questiedb.sh package Forever
```

Run these commands in a disposable copy if the checkout is linked to a client. Use the bundled
Lua path or another Lua 5.1-compatible interpreter for the direct test command.

`check Forever` includes Verification, Equivalence, Reconstruction and validators.
The `test Forever` command also runs shared behavior fixtures and tooling tests. All flavors
use owned inputs, without a Questie checkout or golden refresh. See
[test scopes](../README.md#independent-test-scopes).

[Fixed behavior fixtures](behavior-fixtures.md) check explicit expected reads independently
of Source/Baked agreement. These and the full-data checks protect implementation contracts;
they do not establish that every gameplay fact is correct.

The opt-in `dbc-coordinates` and `convert-forever` commands reuse the owned
[DBC tools](../tools/dbc/README.md). They are not Generation steps. Pass an explicit existing
`--database` path when working offline: even a dry run can download a missing cache.
Conversion always starts from Era inputs, validates all ten outputs and protects edited
Forever files. Do not rerun an installing conversion merely to validate the adopted set;
use the [adopted-byte checks](forever-data.md#focused-validation). Support-map refreshes are
separate: retain the reviewed compatibility links until the consumer resolves instance markers
before UiMap indexing. The external exporter's generation can overwrite the manually completed
handoff, so review new exports rather than copying them wholesale.

## Client support and acceptance

Source mode now requires native per-file game-type selection. Historical Interface metadata
alone does not prove this feature is supported. There is no untested Lua fallback. Older
supported-client Source acceptance and exact Camelot suffixed-TOC recognition remain pending.
[TOC selection research](toc-flavor-selection.md) records source evidence and parser questions;
its proposed implementation and tooling sections predate this integration. A subsequent user-run
probe reported `camelot, forever selected`. The probe only prints success when that mixed list
loads its file and a Vanilla-only control is excluded. The reported result did not include the
client build. It establishes that the mixed list works on that client, not that `forever` is
recognized separately or that all supported clients behave the same way. Full integration
acceptance remains pending; offline emulator and distribution tests cannot establish it.

Before release or installation into a daily-driver client, obtain authorization and complete
these checks in a disposable client/addon setup:

- Record the actual client build, Interface value and native game type. Check positive and
  negative per-file selection on Forever and each supported older client.
- Compare the loaded file set and order with the emulator: one initializer, only applicable
  raw/support/provider files, cumulative legacy ordering, seasonal gates and loader restoration.
- Check suffixed-TOC recognition and Baked precedence over the base TOC on each supported
  client build. Confirm both Forever filenames carry identical complete metadata and plain
  file lists. Before removing Camelot, verify `QuestieDB_Forever.toc` works without that alias.
- Retain the mixed-token probe result with the exact client build, and check the `forever`
  token by itself when Blizzard completes the rename. Do not generalize to arbitrary unknown tokens.
- Check several separated static landmarks on Mulgore, Eastern Plaguelands, Redridge Mountains
  and Stormwind City. Record map identity and measured placement, not just one NPC. Review
  retained synthetic-area points and deferred Cata/MoP entrance frames separately.

The adopted DBC target is **1.60.1.69893**; the researched Forever UI source is
**1.60.1.69913**. They are not the same build, and neither establishes the running client's
map geometry. No production release or client installation is authorized by these offline checks.
