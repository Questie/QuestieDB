# QuestieDB

The database Questie consumes. Stores entity data as WoW addon TOC metadata, readable at
runtime with no file I/O, and owns the offline generator that produces it.

Quests, NPCs, items and objects for Classic Era, TBC, Wrath, Cataclysm, Mists and Forever. Baked
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
| Requires | a clone and native per-file game-type selection | one bootstrap command, or local Generation |

On clients with native per-file game-type selection, a fresh clone needs no download or
Lua toolchain. Historical Interface metadata alone does not establish that support; older-client
Source acceptance and exact Camelot TOC recognition remain pending. See
[Forever and client acceptance](docs/forever.md#client-support-and-acceptance) for the limited
mixed-token live-probe result and outstanding checks. Generation reads the owned localization
sources in `l10n/` and needs no Questie checkout or network access. It fails before writing output if required lookup files are missing.
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

There are two tiers of tooling. Correction work needs only a Lua interpreter, on any
operating system. The full validation and release toolchain adds Python.

### Working on corrections

Corrections are maintained under `src/corrections/<expansion>/`. Their original format came
from Questie's `Database/Corrections`, and the
[Questie wiki page on corrections](https://github.com/Questie/Questie/wiki/Corrections) still
applies. On clients supporting native file selection, a clone junctioned or symlinked into
`Interface/AddOns` runs your edits live in Source mode; nothing needs generating for that.
Generation produces the Baked artifact and lets you run offline checks against your change.

Windows x64 and Linux x64 include Lua 5.1.5 in
[`tools/lua-binary/`](tools/lua-binary/README.md). From Bash:

```sh
./generate.sh Vanilla
```

| Shell/platform | Interpreter selected by `generate.sh` |
| --- | --- |
| Git Bash on Windows | Bundled `tools/lua-binary/lua.exe` |
| Linux/WSL x64 | Bundled static `tools/lua-binary/linux-x64/lua` |
| macOS | Installed `lua5.1`, `lua`, or `luajit` reporting Lua 5.1; otherwise an error |

On macOS, install Lua 5.1 or LuaJIT, for example `brew install luajit`. Other architectures
can use an installed Lua 5.1 interpreter by setting `LUA=/path/to/lua5.1`.

From Windows Command Prompt or PowerShell, use `generate.cmd`:

```powershell
.\generate.cmd Vanilla
.\tools\lua-binary\lua.exe verify.lua Vanilla
```

Omitting the flavor generates all six. Double-clicking `generate.cmd` also keeps the results
visible afterward. Both Generation shortcuts honor an explicit `LUA` and forward options to
`generate.lua`. Ordinary Generation needs no Python, LuaRocks or runtime installation on the
bundled platforms.

For direct Lua commands below, substitute the bundled path on Windows/Linux, or your installed
Lua 5.1-compatible command on macOS. LuaJIT reports `_VERSION` as Lua 5.1 and is accepted.

The loop, from the repository root:

```sh
lua5.1 generate.lua Vanilla          # regenerate one flavor (Vanilla also serves SoD)
lua5.1 verify.lua Vanilla            # every read of the artifact matches the corrected input
lua5.1 validators/run.lua Vanilla    # cross-entity invariants; fails only on findings not in the baseline
```

Flavors are `Vanilla TBC Wrath Cata Mists Forever`; `generate.lua all` does all six, which takes
several minutes and up to a couple of gigabytes of memory for Mists, so generate only the
flavor you are testing. Every script prints its options with `--help`. Nothing here needs
Python, Git, Bash, or network access; Git only adds the commit hash to the artifact's version
when it is present.

Generation writes `QuestieDB_<Flavor>.toc` for all six flavors. Forever additionally produces
its byte-identical `QuestieDB_Camelot.toc` compatibility alias. These files are gitignored;
a client that recognizes its suffixed TOC selects Baked mode. Remove the matching generated
TOCs, including both Forever names, to return to Source mode. Forever filename recognition
still needs the live acceptance checks linked above.

### The full toolchain

The root command orchestrates generation and every validation gate, in parallel, with per-job
logs under `.out/checks/`:

```sh
./questiedb.sh generate                    # generate every flavor
./questiedb.sh generate Vanilla            # generate one flavor
./questiedb.sh check Forever               # standard validation bundle for one flavor
./questiedb.sh check Vanilla
./questiedb.sh test Wrath                  # shared tests and existing Wrath artifact tests
./questiedb.sh verify equivalence Vanilla Mists
./questiedb.sh all                         # Generation, standard gates, and unit tests
./questiedb.sh package all                 # package already-generated artifacts
```

It needs Python 3.8+ in addition to Lua. On Windows, use the same arguments with
`./questiedb.ps1`, or invoke `py -3 tools/cli/questiedb.py` directly if PowerShell script
execution is restricted. The POSIX-shell and PowerShell launchers only locate Python and
forward arguments and exit codes. Command parsing, scheduling, timing, logging, and checksums
live in one Python standard-library implementation. No Bash installation, GNU utilities, or
pip packages are needed.

Run `./questiedb.sh --help` for every gate and option. On Windows/Linux x64, the runner prefers
the matching bundled interpreter. Otherwise it tries `lua5.1`, `lua`, then `luajit` on `PATH`,
accepting only an interpreter that reports Lua 5.1.
`LUA` and `--lua=` can select another Lua 5.1-compatible executable explicitly. The `freeze`
gate supports Vanilla and Mists. `all` validates but does not package;
packaging and bootstrap are separate commands, and bootstrap does not require Lua.
The `test` task runs shared Lua suites once, artifact suites for each selected flavor, and
Python CLI, scope-selection, DBC and Forever distribution tests as separate jobs.
Generate the selected artifacts first. No test scope requires a Questie checkout.

The individual entry points remain useful while developing a gate. The Lua ones need only Lua:

```sh
lua5.1 generate.lua all
lua5.1 verify.lua
lua5.1 equivalence.lua
lua5.1 reconstruct.lua Vanilla
lua5.1 validators/run.lua
lua5.1 test.lua
lua-language-server --check=src/types --checklevel=Warning --check_format=pretty
```

Generation and the Lua validation commands use only this repository's owned inputs.

### Independent test scopes

CI and Release run shared checks alongside six independent flavor pipelines. A flavor pipeline
never requires another flavor's generated output. Shared sources and configuration remain inputs.

The Lua harness exposes the same test scopes locally:

```sh
lua5.1 test.lua --shared                 # no generated TOCs required or discovered
lua5.1 test.lua --flavor=Wrath           # requires a complete, localized Wrath TOC
lua5.1 test.lua --flavor=Forever         # requires a complete, localized Forever TOC
lua5.1 test.lua --flavor=Wrath --list     # list selected suites without running them
```

Each flavor scope runs generic artifact checks and its own behavior tests. Vanilla owns the
Vanilla/SoD cases; Wrath owns Titan. Missing or incomplete selected artifacts fail rather than
skip. Forever's dataset and native TOC selection checks run in the shared scope; its flavor
scope runs the generic artifact checks. Shared and flavor tests use owned inputs and require
no external Questie checkout.

For fast checks of structured data through both real readers, run
`lua5.1 test.lua storage-contract`. Its [fixed behavior fixtures](docs/behavior-fixtures.md)
cover observed data shapes without loading production data or refreshing snapshots.

Named-suite and unfiltered `test.lua` runs retain opportunistic checks of available artifacts.
Use explicit scopes for required artifact coverage. The local command runner still uses phase
barriers: selected Generation jobs finish before Determinism, and both finish before checks.
It does not advance each flavor through those phases independently.

### Era-to-Forever coordinate conversion

Forever's coordinate-adjusted inputs are already adopted and selected by the runtime.
The DBC tools are for a deliberate new migration, not normal Generation or routine validation.
They compare explicit builds and create separate entity/Correction files without changing
Era inputs or runtime registration. Run a new migration only in an isolated workspace:

```sh
./questiedb.sh dbc-coordinates --from-build 1.15.9.69722 --to-build 1.60.1.69893 --allow-untracked-source --ui-map 1412 --point 44.18 76.06
./questiedb.sh convert-forever --from-build 1.15.9.69722 --to-build 1.60.1.69893 --allow-untracked-source --keep-unmapped --dry-run
```

Use the same arguments with `./questiedb.ps1` on Windows. Both commands download the DBC
SQLite to `.cache/dbc/dbc-source.db` only if missing; the private release needs an authenticated
`gh` login. Conversion also requires Lua 5.1. `--dry-run` validates temporary copies without
installing outputs, though it may populate that cache.

Review unmapped points before removing `--dry-run`. `--keep-unmapped` explicitly leaves those
coordinates unchanged; omitting it makes unresolved points block conversion. See
[DBC coordinate tools](tools/dbc/README.md) for all ten output paths, coverage flags,
provenance and overwrite protection. Existing authored Forever changes must be preserved.
The [current support-map workflow](docs/forever-data.md#how-it-works-now) is separate from
coordinate conversion and documents consumer compatibility links that later imports must review.

### Local packages on Linux, macOS, and Windows

Generation creates Baked TOCs; packaging creates installable ZIPs:

```sh
./questiedb.sh generate && ./questiedb.sh package all
# Or one flavor (Vanilla also serves SoD):
./questiedb.sh generate Vanilla && ./questiedb.sh package Vanilla
```

Packages go into `.out/dist/`: one ZIP per requested flavor, `release.json`, and release
notes. Selecting all six also creates `QuestieDB-all.zip`, for seven ZIPs in total. Both the
Forever ZIP and combined ZIP contain `QuestieDB_Forever.toc` and `QuestieDB_Camelot.toc`.
Packaging copies the alias from the completed staged primary, not an existing workspace alias.
ZIPs contain a `QuestieDB/` folder ready to extract into `Interface/AddOns/`, including
`QuestieDB/CHANGELOG.md` for that release. Packaging never installs or publishes.
It checks prerequisites and requested inputs before replacing `.out/dist/` and `.out/stage/`;
a later packaging failure can still leave incomplete output. Missing requested TOCs are errors,
not silently skipped flavors. Run the validation gates separately before distributing a build.

The manifest's `questiedb` object records the packaged addon `version`, `contractVersion`, and
`minSupportedContract`, alongside commit provenance and ZIP checksums. The version comes
from the Baked TOCs, not the current Source TOC or a moving release tag. Packaging rejects
mixed flavor versions, malformed version/contract headers, and TOC contracts that differ
from the runtime configuration it ships, before clearing previous output. Consumers require
an integer contract within the inclusive supported range; a higher current contract alone
is not proof of compatibility.

The Python standard library handles ZIP creation, archive inspection, file sizes, timestamps,
and SHA-256. Python needs its standard `zlib` module, not any installed Python packages.
No `zip`, `unzip`, GNU coreutils, or `jq` is required for packaging. Lua 5.1 is still needed
for Static Correction stripping and its behavior-parity check. Packaging honors `LUA`, then
prefers the matching Windows/Linux x64 bundle before trying `lua5.1`/`lua`/`luajit` on `PATH`.
Git supplies commit provenance and the release changelog when available. Packages built without
Git or from shallow checkouts explicitly report that a complete changelog is unavailable. The
bundled interpreter and other contributor tools are not included in addon ZIPs.

On macOS, no shell upgrade is needed. For example, Homebrew provides Python and the
Lua 5.1-compatible LuaJIT:

```sh
brew install python luajit
export LUA=luajit
./questiedb.sh generate
./questiedb.sh package all
```

On Windows, the full toolchain needs Python 3.8+; Lua is already bundled:

```powershell
.\questiedb.ps1 generate
if ($LASTEXITCODE -eq 0) { .\questiedb.ps1 package all }
```

An existing Lua 5.1 installation can likewise be selected with `LUA=/path/to/lua5.1` on POSIX.
To bypass Python orchestration, invoke Lua's `generate.lua` directly. The engine remains plain
Lua. Python runs parallel jobs on every platform; `--sequential` opts out. Without Linux memory
information the runner uses a fixed 4 GiB available-memory estimate; set `--budget-mb` explicitly
if needed. Determinism checks use `hashlib`, not an external checksum command.

The Lua unit suite, `lua5.1 test.lua`, needs only Lua; its few filesystem operations go
through the platform's own shell commands. The Python tooling tests use the standard library
for temporary files and subprocesses, and real Lua for database behavior. Substantial Lua
test code lives in `.lua` files, not escaped Python strings. The fixtures need no POSIX
commands or symlink privileges. Run them with Python or `uv run`; all writes and installations
use temporary fixtures:

```sh
python3 tools/cli/questiedb.test.py
python3 tools/distribution/package.test.py
python3 tools/distribution/bootstrap.test.py
python3 tools/validation/version.test.py
python3 tools/validation/test-scopes.test.py
python3 tools/validation/localization-inputs.test.py
```

The launcher and packaging fixtures cover Linux and Windows behavior. This Forever branch's
recorded checks do not establish native Windows/macOS or live-client acceptance. See the
[acceptance checklist](docs/forever.md#client-support-and-acceptance).

### Owned inputs

Generation, Reconstruction, and all validation gates read this repository's inputs. No Questie
checkout or migration pin is required. Edit the canonical schema in `src/meta/`, Corrections
in `src/corrections/`, translations in `l10n/`, and support data under `support/`.
See [localization inputs](l10n/README.md) and [support data](docs/support-data.md).

Generation validates the data files' field-key enums against the owned schema. When changing a
field, update its schema, affected data keys and correction constants, and public declarations
in the same change. Public `compilerTypes` metadata remains for compatibility; it does not
select a compiler or derive the schema.

### Keeping LuaLS declarations in sync

The files in `src/types/` are shipped to consumers and are part of the public API. Update them
when a change affects an entity schema or getter, a public function signature or overload,
return nilability, a structured value such as objectives or Correction entries, or the
`LibQuestieDB` and Corrections interfaces. Pure implementation changes that preserve those
contracts do not need a type edit.

Update `src/types/consumer.test.lua` when the changed contract needs a semantic LuaLS check.
Run the `lua-types` suite and LuaLS command above before packaging. `AGENTS.md` maps each kind
of public change to the declaration files that own it.

`questiedb.sh` and `questiedb.ps1` are the full-toolchain entry points. Both delegate to
`tools/cli/questiedb.py`; no arguments prints help, and `check` selects the standard check bundle.
`generate.sh` and Windows' `generate.cmd` are Lua-only Generation shortcuts, not separate
orchestration runners.

The sweep parallelises by memory budget rather than core count, because the jobs are wildly
uneven — equivalence on Mists peaks at 1.66 GB and 57 s, on Vanilla at 0.42 GB and 19 s — so a
flat `-j N` either thrashes a laptop or leaves a workstation idle. `all` finishes Generation
for every selected flavor before any artifact reader or unit test starts. Determinism and
freeze checks remain available as explicit gates. The budget comes from `MemAvailable` at
startup on Linux, with the fallback described above on other platforms; `--budget-mb=N` overrides it
with a value from 1 to 2147483647 MB, and `--sequential`
turns fan-out off. Per-job logs land in `.out/checks/`.

Small, explicit behavior fixtures protect against shared Source/Baked mistakes, including
correction ordering, expansion and season admission, localization, and storage semantics.
Ordinary data edits need no golden refresh or compiler-divergence allowance. The full-database
checks still protect data invariants and generated reads. See
[ADR 0014](docs/adr/0014-owned-data-after-migration.md) for the retired migration checks and checkpoint.

Generation and runtime database logic use plain Lua 5.1 with no `lfs`, LuaRocks, or C dependency.
Inputs are enumerated in `src/config.lua` rather than discovered by scanning directories.
Python's standard library handles orchestration and distribution.

To refresh a local install instead of regenerating:

```sh
./questiedb.sh bootstrap "/path/to/Interface/AddOns"           # latest stable release
./questiedb.sh bootstrap "/path/to/Interface/AddOns" preview   # rolling development build
```

Bootstrap uses the same Python implementation from either launcher. It installs `QuestieDB-all.zip`
only, so a release from before the combined archive existed cannot be bootstrapped. Five-flavor
combined releases using the nested `questiedb` manifest remain accepted; if either Forever TOC is present, both must
be present and byte-identical. Bootstrap verifies the checksum and validates archive paths
and extraction before changing the install. Installing an older five-flavor release removes
stale Forever/Camelot TOCs. [Issue #23](https://github.com/Questie/QuestieDB/issues/23) tracks
retiring the Camelot name without breaking older-release handling.
The final file merge is not transactional. Matching runtime files are replaced, while unrelated
files are retained. Back up local edits before bootstrapping over a source clone; returning to Source
mode then requires restoring its full runtime sources as well as removing the generated TOCs.

### Releases

Successful default-branch builds recreate the **Unstable Pre-Release Build** at tag `preview`
so each build has a fresh publication date. The moving tag identifies the commit used to build
its assets; older runs cannot roll it back. Preview downloads are briefly unavailable during replacement. Preview
never becomes GitHub's latest stable release, but remains publicly visible in the releases list.
Direct normal users to the [latest stable release](https://github.com/Questie/QuestieDB/releases/latest).
Preview notes warn at the top and directly above the download assets that the build is for testing
only. CI still provides per-run artifacts.

Release notes recommend `QuestieDB-all.zip`, list the smaller per-flavor downloads, and explain
installation. Commit provenance, API contracts, and checksum instructions live in a collapsed
build-details section.

Every release ZIP includes `QuestieDB/CHANGELOG.md`. The separate `release.json` asset lists
addon-manager downloads under `releases` and keeps build metadata, ZIP checksums, and structured
changelog entries under `questiedb`. See the [manifest format](tools/distribution/README.md#release-manifest).

For contributors and release maintainers, see the distribution guide:

- [Dry-run release previews](tools/distribution/README.md#dry-runs), enabled by default for manual runs
- [Writing changelog entries](tools/distribution/README.md#changelog-entries)
- [Changelog format and author credits](tools/distribution/README.md#packaged-and-structured-changelogs)
- [Publishing and failure recovery](tools/distribution/README.md#publishing)

### Maintaining owned data

Edit the sources here rather than re-importing Questie's retired database. The Correction
manifest declares each provider's Static/Dynamic classification and expansion applicability;
the compatibility shim supports the existing module-based authoring format.

After changing file lists, regenerate the committed Source TOC:

```sh
lua5.1 generate.lua toc
lua5.1 test.lua --shared
```

Generate and validate affected flavors using the [correction loop](#working-on-corrections).
For runtime or storage changes, exercise the relevant [flavor test scopes](#independent-test-scopes)
as well. Check inherited Corrections on later expansions when their applicability changes.

Titan Corrections remain Dynamic over Wrath and require active season 109. Consumer policy,
such as quest availability blacklists and content-phase selection, stays in Questie.
[Localization inputs](l10n/README.md) documents whole-row translation overrides and
[support data](docs/support-data.md) documents flavor selection.

---

## Layout

```text
QuestieDB.toc            base TOC — source mode (committed)
QuestieDB_<Flavor>.toc   generated Baked TOCs for all six flavors (gitignored)
QuestieDB_Camelot.toc    exact temporary Forever alias (gitignored)

src/
  config.lua              flavors, entity types, file lists, l10n block contract
  flavors/                native-selected Source flavor initializers
  meta/                   schema, nil/empty semantics, chunk markers
  types/                  distributable LuaLS declarations, never loaded by a TOC
  read/                   shared getters + the two backends that differ
  corrections/            registry, compat shim, owned correction sets
  l10n/                   active-locale blocks and Dynamic Translation Corrections
  support/                whole-table game reference data
  ui/                     the source-mode indicator

data/                     raw entity data
l10n/                     owned entity translations and static lookup overrides
support/                  zones, quest XP, drop tables, faction templates

questiedb.sh / .ps1        thin contributor launchers for the shared Python command
generate.lua              data + Static Corrections -> TOC
verify.lua                round-trip verification
equivalence.lua           source/baked equivalence, every read form, self-proving
reconstruct.lua           byte-exact artifact reconstruction against the generator
test.lua                  unit tests and negative controls
generator/                offline internals, deterministic CBOR and vendored codecs
emulator/                 metadata and C_EncodingUtil stand-ins, client stubs, freeze substitute
validators/               data-invariant checks
tools/                    Python orchestration, distribution, DBC tools, behavior fixtures
docs/                     api.md, storage-format.md, adr/
```

`src/read/` is the only place the two modes diverge. Both backends expose field reads and ID
lists; Baked mode also exposes scalar rows and table producers for its cache fast paths.

---

## Documentation

| | |
| --- | --- |
| [`docs/forever.md`](docs/forever.md) | Forever inputs, selection, tooling and client acceptance |
| [`docs/api.md`](docs/api.md) | the public surface, for consumers |
| [`docs/release-format.md`](docs/release-format.md) | shared release metadata and addon composition rules |
| [`tools/README.md`](tools/README.md) | tooling categories and ownership |
| [`docs/storage-format.md`](docs/storage-format.md) | the on-disk contract and the nil/empty rules |
| [`docs/support-data.md`](docs/support-data.md) | support-data selection, shapes, and validation |
| [`DESIGN.md`](DESIGN.md) | architecture, locked decisions, rejected alternatives |
| [`CONTEXT.md`](CONTEXT.md) | vocabulary |
| [`docs/adr/`](docs/adr/) | decision records |
| [`docs/adr/0005-element-level-nil-semantics.md`](docs/adr/0005-element-level-nil-semantics.md) | never-nil structures and element-level nil→0, which amend the storage contract |
| [`docs/adr/0014-owned-data-after-migration.md`](docs/adr/0014-owned-data-after-migration.md) | migration checkpoint and owned-data workflow |
| [`PROVENANCE.md`](PROVENANCE.md) | source references and prototype lineage |
| [`docs/behavior-fixtures.md`](docs/behavior-fixtures.md) | fixed examples and validation coverage |
| [`docs/read-performance.md`](docs/read-performance.md) | what a read costs and why, measured in a live client against the prototype and Questie's compiler |
| [`docs/client-metadata-probes.md`](docs/client-metadata-probes.md) | how the client's metadata store actually behaves |
| [`docs/table.freeze.md`](docs/table.freeze.md) | live-client freeze research |
