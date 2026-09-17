# QuestieDB

The database Questie consumes. Stores entity data as WoW addon TOC metadata, readable at
runtime with no file I/O, and owns the offline generator that produces it.

Quests, NPCs, items and objects for Classic Era, TBC, Wrath, Cataclysm and Mists. Baked
artifacts include nine generated Base locales as compressed CBOR column blocks. Dynamic
Translation Corrections can also supply any custom non-English locale. Source and Baked modes
return the same base entity values.

---

## Two modes, and the client picks

The client searches for flavour-suffixed TOCs first and falls back to `QuestieDB.toc` only if
none are found. That rule selects the mode at no cost: **a generated artifact wins simply by
existing.**

| | Source mode | Baked mode |
| --- | --- | --- |
| TOC | `QuestieDB.toc` (committed) | `QuestieDB_Vanilla.toc` etc. (generated, gitignored) |
| Reads resolve from | raw entity data | CBOR rows and tables in the TOC metadata store |
| Static Corrections | applied live | already folded in |
| Base translations | unavailable | generated Localization blocks |
| Dynamic Translation Corrections | any active non-English locale | any active non-English locale |
| Requires | nothing but a clone | one bootstrap command, or local Generation |

A fresh clone junctioned into `AddOns` is a working development environment — no download, no
Lua toolchain. Generating an artifact switches the same folder to baked mode with no code
change. Generation reads the owned localization sources in `l10n/` and needs no Questie
checkout or network access. It fails before writing output if required lookup files are missing.
Use `--no-l10n` only for an intentional partial artifact.

---

## For consumers

Start at **[`docs/api.md`](docs/api.md)**. It is written so a third-party addon author needs no
source reading. Release zips also include LuaLS declarations under `QuestieDB/Types`; point the
consumer's `workspace.library` at that folder for completion and diagnostics.

```lua
QuestDB.name(2)                                  --> "Sharptalon's Claw"
QuestDB.Get(2, "requiredLevel")                  --> 20
NpcDB.spawns(30)                                 --> { [12] = { {36.43, 55.89}, ... } }

LibQuestieDB.l10n.SetLocale("deDE")
QuestDB.name(2)                                  --> "Klaue von Scharfkralle"

LibQuestieDB.GetRegistrar("MyAddon")
    .Set("Quest", "my-fix", { [2] = { [1] = "A better name" } })  -- data slot; publishes immediately

LibQuestieDB.GetRegistrar("MyAddon")
    .RegisterRuntimeCorrection("Quest", "fixes", function() ... end, 10)  -- function form, for large sets

LibQuestieDB.l10n.SetCorrection("MyAddon", "deDE", "Quest", "text", {
    [2] = { [LibQuestieDB.Meta.Quest.keys.name] = "Klaue von Scharfkralle" },
})
```

Three behaviours to internalise before writing anything:

* **Numeric getters return `0`, never `nil`.** Test `~= 0`, not truthiness.
* **Every table read returns a fresh, deeply independent copy you own.** Mutate it freely;
  the next read is unaffected, and `CopyTable` is wasted work. `GetAllIds` is the one
  exception: it hands back a shared table, so treat that one as read-only.
* **Non-English translations are authoritative for translatable fields.** Publish translated
  entity text through `LibQuestieDB.l10n.SetCorrection`, not an ordinary entity Correction.
  The locale may be one of the nine generated locales or a custom non-English locale.

---

## For contributors

Use the root command for generation and validation workflows:

```sh
./questiedb.sh generate                    # generate every flavor
./questiedb.sh generate Vanilla            # generate one flavor
./questiedb.sh check Vanilla               # standard validation bundle for one flavor
./questiedb.sh verify equivalence Vanilla Mists
./questiedb.sh all                         # Generation, standard gates, Golden, and unit tests
```

Run `./questiedb.sh --help` for every gate and option. It requires Bash 5.1 or newer and selects
`lua5.1`, or a `lua` command that reports Lua 5.1. `LUA` and `--lua=` can select another Lua
5.1-compatible executable explicitly. The `freeze` gate supports Vanilla and Mists.

The individual entry points remain useful while developing a gate:

```sh
lua5.1 generate.lua all
lua5.1 verify.lua
lua5.1 equivalence.lua
lua5.1 reconstruct.lua Vanilla
lua5.1 validators/run.lua
lua5.1 test.lua
lua-language-server --check=src/types --checklevel=Warning --check_format=pretty

python3 tools/differential/golden.py check Vanilla
python3 tools/differential/compiler_diff.py Vanilla

tools/cli/check.sh                    # verify, equivalence, reconstruct, validators, differential
tools/cli/check.sh all                # Generation, standard gates, Golden, and unit tests
tools/cli/check.sh verify --flavors=Vanilla,Mists
tools/cli/check.sh determinism freeze --flavors=Vanilla
```

### Local inputs and remaining Questie checks

`lua5.1 generate.lua all` reads entity data, Corrections, support data, and localization from
this repository. Reconstruction also reads local sources. Neither command checks out Questie;
`QUESTIE_PATH` does not select their translations. Localized Generation still reads the committed
`QUESTIE_COMMIT` to stamp the legacy import/schema baseline, not to fetch localization.
See [`l10n/README.md`](l10n/README.md) for the translation layout and import provenance.

Only schema materialization (`lua5.1 generate.lua meta`) automatically fetches the exact commit
in `QUESTIE_COMMIT` into `.cache/questie/<sha>` on first use. The shallow, tag-free snapshot is
gitignored and reused offline. Git and a POSIX shell with `mktemp` are required for that fetch.
Changing the pin creates a separate checkout rather than resetting an existing one.

For `meta`, `--questie=<path>` overrides `QUESTIE_PATH` and opts out of automatic fetching.
The generator validates an explicit checkout but never fetches, switches, or cleans it.
The option has no effect on flavor Generation. Reconstruction no longer accepts `--questie`.

Correction imports, migration fidelity tests, and the compiler differential still need the
pinned Questie checkout, defaulting to `../Questie`. Point `QUESTIE_PATH` or the check runner's
`--questie` option at `.cache/questie/<sha>` to reuse the schema checkout.

Focused offline checks:

```sh
lua5.1 tools/validation/localization-inputs.test.lua
lua5.1 tools/questie-sync/questie-checkout.test.lua
```

### Keeping LuaLS declarations in sync

The files in `src/types/` are shipped to consumers and are part of the public API. Update them
when a change affects an entity schema or getter, a public function signature or overload,
return nilability, a structured value such as objectives or Correction entries, or the
`LibQuestieDB` and Corrections interfaces. Pure implementation changes that preserve those
contracts do not need a type edit.

Update `src/types/consumer.test.lua` when the changed contract needs a semantic LuaLS check.
Run the `lua-types` suite and LuaLS command above before packaging. `AGENTS.md` maps each kind
of public change to the declaration files that own it.

`tools/cli/check.sh` remains the direct orchestration engine for automation and existing scripts.
It accepts the previous gate syntax and `--flavors=Vanilla,Mists`.

The sweep parallelises by memory budget rather than core count, because the jobs are wildly
uneven — equivalence on Mists peaks at 1.66 GB and 57 s, on Vanilla at 0.42 GB and 19 s — so a
flat `-j N` either thrashes a laptop or leaves a workstation idle. `all` finishes Generation
for every selected flavor before any artifact reader or unit test starts. Determinism and
freeze checks remain available as explicit gates. The budget comes from `MemAvailable` at
startup; `--budget-mb=N` overrides it with a value from 1 to 2147483647 MB, and `--sequential`
turns fan-out off. Per-job logs land in `.out/checks/`.

The golden gate is the successor to the cross-implementation differential (built to
compare this tree against the independent `-pi` sibling, where it caught the Era-gating,
constants, and Titan Reforged defect chain). It guards the one class the other gates
cannot: generator and source mode being consistently wrong *together*. After an
intentional data change, `golden.py refresh <Flavor>` regenerates the snapshot for
review and commit.

`compiler_diff.py` is the reference-implementation differential DESIGN.md phase 6 called
for. It runs Questie's real compile path offline — the one `cli/validate-era.lua` already
drives — and compares `QuestieDB.Query<Type>Single` against this database's composed reads,
id by id and field by field. The golden snapshot can only catch drift from *this* tree;
this gate is the only one that can say whether the database still matches the thing it
replaces. It needs a Questie checkout (`--questie=../Questie`, the default) and `bit32` on
the Lua path, which it picks up from luarocks automatically. Accepted divergences live in
`tools/differential/compiler-baseline/`; `--update-baseline` re-records them for review.

Generation and the addon tooling use plain Lua 5.1 with no `lfs`, luarocks, or C dependency.
Inputs are enumerated in `src/config.lua` rather than discovered by scanning directories. The
compiler differential is the one exception because Questie's mocks require `bit32`.
`tools/cli/check.sh --questie=` selects the checkout for fidelity tests and the compiler
differential; `QUESTIE_PATH` provides the same default for nested migration tools. Generation,
Determinism, Reconstruction, Verification, and Equivalence need no external checkout.

To refresh a local install instead of regenerating:

```sh
tools/distribution/bootstrap.sh "/path/to/Interface/AddOns"           # latest stable release
tools/distribution/bootstrap.sh "/path/to/Interface/AddOns" preview   # rolling development build
```

### Releases

Successful default-branch builds update one **Development preview** pre-release at tag
`preview`. Its tag identifies the commit used to build its assets; older runs cannot roll it
back. Preview never becomes GitHub's latest stable release. CI still provides per-run artifacts.

To publish a real release:

1. Set `## Version: X.X.X` in `QuestieDB.toc` and commit it to the default branch. Use three
   numeric components without leading zeros. TOC regeneration preserves this maintained value.
2. Open **Actions → Release → Run workflow**, select the default branch, and check `release`.
3. Leave `override` unchecked. An existing `vX.X.X` tag or release fails before building, and
   publication checks again after all quality gates pass.

`override` explicitly replaces that version's assets and moves its tag to the selected commit.
Use it only to repair a release; normally bump the version instead. GitHub-immutable releases
cannot be overridden. Repository-wide release immutability is incompatible with rolling preview.

Baked addon versions are `X.X.X` for full releases and `X.X.X-dev.<short SHA>` otherwise.
Local Generation follows the same rule; `QUESTIEDB_RELEASE=true` selects the full-release form.
The manifest and TOCs retain the exact producing commit and legacy Questie import/schema
baseline. The producing commit identifies the owned localization sources.

The release flow lives in [`.github/workflows/release.yml`](.github/workflows/release.yml):
choose the tag, build/check/package, then publish. Only GitHub publication is configured.
Publication jobs queue without cancelling active or pending releases. The publisher checks the
handoff's commit and ZIP checksums before any mutation, then rejects stale preview builds.

**Replacement is not atomic.** Existing releases stay public while ZIPs are replaced by name.
The tag moves after the ZIP uploads; `release.json` uploads last. Downloads during an update
may fail, and interruption can leave mixed assets or a tag ahead of the manifest. Bootstrap
rejects checksum mismatches before installing; direct ZIP downloads do not have that protection.
First publication uses a draft until every asset is uploaded. Build/check failures never touch
an existing release.

After a preview publication failure, rerun the failed workflow at the same commit. Do not rerun
an older preview to repair a newer one. For a full release, dispatch again with `release` and
`override` checked: GitHub reruns retain the original inputs, so they cannot enable override.
Review the current default-branch commit and TOC version first; a new dispatch builds that
commit, not necessarily the failed run's commit. Resolve tag-rule or permission errors before
retrying. Divergent preview history (for example after a force-push) requires deliberate tag
repair; the workflow will not guess which history to keep. Existing `build-*` releases and
unrelated manually attached assets are left alone.

Repository tag rules must allow the workflow token to create release tags and move `preview`
(and version tags only when overriding). The preflight job needs Contents write permission to
see drafts, but only reads GitHub state. No live publication is covered by the offline tests;
GitHub permissions and replacement behavior should first be exercised in a disposable repository,
not against an installed development or production channel.

Run the focused offline version checks with `lua5.1 tools/validation/version.test.lua`.

### Re-syncing with Questie

Entity schema, Corrections, and support data derive from Questie and are committed here, so
drift is a build failure rather than a discovery months later. Entity translations are now
stored locally in `l10n/` and synchronized with the Questie revision recorded in
[`QUESTIE_COMMIT`](QUESTIE_COMMIT). The input adapter preserves their executable lookup format
and whole-row override semantics without changing
runtime localization or storage.

The migration fidelity gate still compares the local translations against independent inputs
from pinned Questie. This deliberately rejects unexplained translation changes until the
migration checks are retired. The current snapshot is not declared final: future
`QUESTIE_COMMIT` bumps may require another reviewed localization sync. Bumping the pin does not
update `l10n/` automatically; review and import translation differences rather than assuming
Generation fetches them.

```sh
git -C ../Questie checkout "$(cat QUESTIE_COMMIT)"
lua5.1 generate.lua meta --questie=../Questie # schema -> src/meta/*Meta.lua
lua5.1 tools/questie-sync/port-corrections.lua ../Questie  # corrections + constants
lua5.1 generate.lua toc                      # refresh the committed Source-mode file list
lua5.1 test.lua support support-fidelity     # check all copied support data and flavor selection
lua5.1 test.lua objective-first              # check pinned hint contents and scope boundaries
lua5.1 test.lua objective-first-addon        # check generated and static-stripped addons
lua5.1 test.lua localization-overrides translation-corrections titan-translations
```

`objective-first` runs without generated entity artifacts. It compares all five published hint
tables with the pinned correction sources across base flavors, SoD, Titan Reforged, and negative
season cases. `objective-first-addon` requires all five generated artifacts and compares Source,
Baked, and a staged package after Static Correction stripping. Issue #19 can invoke these two
suites as its ObjectiveFirst release check rather than duplicate their persona matrix.

The localization suites compare every effective entity translation against pinned Questie across
all five flavors and nine locales, exercise Dynamic Translation Correction lifecycle and
precedence, and check Titan's Wrath season 109 zhCN set. Issue #19 can invoke these three suites as
its focused localization gate.

During import, Questie's `lookupOverrides.lua` whole-row replacements become named Static
Translation Correction fields. The internal value `false` explicitly clears an omitted field
before the result is filtered to existing entities and encoded. This sentinel belongs only to
the Generation adapter; it is not part of `LibQuestieDB.l10n.SetCorrection`.

The 24 support inputs, their pinned Questie paths, published fields, and Lua-source-string
fields are listed in [`tools/questie-sync/support-inventory.lua`](tools/questie-sync/support-inventory.lua). See
[`docs/support-data.md`](docs/support-data.md) before changing that inventory or support-file
selection.

The ported correction files preserve Questie's bytes except for explicit whole-function
ownership exclusions in `tools/questie-sync/port-corrections.lua`; a compat shim supplies the module surface
they import. The fidelity test compares every non-excluded byte and the port fails if an
excluded block is absent or duplicated. To advance Questie, change `QUESTIE_COMMIT` first,
check out that commit, then review schema drift, the Correction re-port, validators, compiler
differential, and Golden snapshots in the same working tree. Automation reads the same pin
through `.github/actions/checkout-questie`.

The port requires Questie's four Titan entity files under `Database/Corrections/`. QuestieDB
ports them under `src/corrections/Titan/` and applies every provider dynamically over the Wrath
base, gated by Wrath plus active season 109. Titan quest tags and availability blacklists remain
in Questie because they are consumer policy.

---

## Layout

```text
QuestieDB.toc            base TOC — source mode (committed)
QuestieDB_<Flavor>.toc   generated, baked mode (gitignored)

src/
  config.lua              flavors, entity types, file lists, l10n block contract
  meta/                   schema, nil/empty semantics, chunk markers
  types/                  distributable LuaLS declarations, never loaded by a TOC
  read/                   shared getters + the two backends that differ
  corrections/            registry, compat shim, ported correction sets
  l10n/                   active-locale blocks and Dynamic Translation Corrections
  support/                whole-table game reference data
  ui/                     the source-mode indicator

data/                     raw entity data
l10n/                     owned entity translations and static lookup overrides
support/                  zones, quest XP, drop tables, faction templates

questiedb.sh             contributor command for generation and validation
generate.lua              data + Static Corrections -> TOC
verify.lua                round-trip verification
equivalence.lua           source/baked equivalence, every read form, self-proving
reconstruct.lua           byte-exact artifact reconstruction against the generator
test.lua                  unit tests and negative controls
generator/                offline internals, deterministic CBOR and vendored codecs
emulator/                 metadata and C_EncodingUtil stand-ins, client stubs, freeze substitute
validators/               data-invariant checks
tools/                    port, package, bootstrap, differential golden gate
docs/                     api.md, storage-format.md, adr/
```

`src/read/` is the only place the two modes diverge. Both backends expose field reads and ID
lists; Baked mode also exposes scalar rows and table producers for its cache fast paths.

---

## Documentation

| | |
| --- | --- |
| [`docs/api.md`](docs/api.md) | the public surface, for consumers |
| [`docs/storage-format.md`](docs/storage-format.md) | the on-disk contract and the nil/empty rules |
| [`docs/support-data.md`](docs/support-data.md) | support-data selection, shapes, inventory, and drift checks |
| [`DESIGN.md`](DESIGN.md) | architecture, locked decisions, rejected alternatives |
| [`CONTEXT.md`](CONTEXT.md) | vocabulary |
| [`docs/adr/`](docs/adr/) | decision records |
| [`docs/adr/0005-element-level-nil-semantics.md`](docs/adr/0005-element-level-nil-semantics.md) | never-nil structures and element-level nil→0, which amend the storage contract |
| [`docs/questie-handover.md`](docs/questie-handover.md) | every known divergence from Questie's compiler, its disposition, and the switch-over checklist |
| [`docs/read-performance.md`](docs/read-performance.md) | what a read costs and why, measured in a live client against the prototype and Questie's compiler |
| [`docs/client-metadata-probes.md`](docs/client-metadata-probes.md) | how the client's metadata store actually behaves |
| [`docs/table.freeze.md`](docs/table.freeze.md) | live-client freeze research |
| [`docs/retiring-the-prototypes.md`](docs/retiring-the-prototypes.md) | what was mined from `Getters` and `toc-database` |
