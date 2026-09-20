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

There are two tiers of tooling. Correction work needs only a Lua interpreter, on any
operating system. The full validation and release toolchain adds Python.

### Working on corrections

Corrections are the same files as Questie's `Database/Corrections`, under
`src/corrections/<expansion>/`, and the
[Questie wiki page on corrections](https://github.com/Questie/Questie/wiki/Corrections) still
applies. A clone junctioned or symlinked into `Interface/AddOns` already runs your edits live in
Source mode; nothing needs generating for that. Generation is how you produce the Baked
artifact Questie ships, and how you run the offline checks against your change.

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

Omitting the flavor generates all five. Double-clicking `generate.cmd` also keeps the results
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

Flavors are `Vanilla TBC Wrath Cata Mists`; `generate.lua all` does all five, which takes
several minutes and up to a couple of gigabytes of memory for Mists, so generate only the
flavor you are testing. Every script prints its options with `--help`. Nothing here needs
Python, Git, Bash, or network access; Git only adds the commit hash to the artifact's version
when it is present.

Generation writes `QuestieDB_<Flavor>.toc` next to `QuestieDB.toc`. Those files are gitignored,
and a clone in `AddOns` switches to Baked mode on the next `/reload` simply because they exist.
Delete them to return to Source mode.

### The full toolchain

The root command orchestrates generation and every validation gate, in parallel, with per-job
logs under `.out/checks/`:

```sh
./questiedb.sh generate                    # generate every flavor
./questiedb.sh generate Vanilla            # generate one flavor
./questiedb.sh check Vanilla               # standard validation bundle for one flavor
./questiedb.sh test Wrath                  # shared tests and tests of the existing Wrath artifact
./questiedb.sh verify equivalence Vanilla Mists
./questiedb.sh all                         # Generation, standard gates, Golden, and unit tests
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
`LUA` and `--lua=` can select another Lua 5.1-compatible executable explicitly. The `freeze` gate supports Vanilla and Mists. `all` validates but does not package;
packaging and bootstrap are separate commands, and bootstrap does not require Lua.
The `test` task runs shared Lua suites once, artifact suites for each selected flavor, and
Python CLI, scope-selection, and DBC tests as separate jobs. Generate the selected artifacts first.

The individual entry points remain useful while developing a gate. The Lua ones need only Lua:

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
```

The one Lua command that reaches for Python is `generate.lua meta`, which fetches the pinned
Questie checkout to re-derive the schema; pass `--questie=<checkout>` to avoid that too.

### Independent test scopes

CI and Release run shared checks alongside five independent flavor pipelines. A flavor pipeline
never requires another flavor's generated output. Shared sources, configuration, and the pinned
Questie checkout remain inputs.

The Lua harness exposes the same test scopes locally:

```sh
lua5.1 test.lua --shared                 # no generated TOCs required or discovered
lua5.1 test.lua --flavor=Wrath           # requires a complete, localized Wrath TOC
lua5.1 test.lua --flavor=Wrath --list     # list selected suites without running them
```

Each flavor scope runs generic artifact checks and its own behavior tests. Vanilla owns the
Vanilla/SoD cases; Wrath owns Titan. Missing or incomplete selected artifacts fail rather than
skip. Both shared and flavor scopes include migration fidelity checks that need the
[pinned Questie checkout](#local-inputs-and-remaining-questie-checks).

Named-suite and unfiltered `test.lua` runs retain opportunistic checks of available artifacts.
Use explicit scopes for required artifact coverage. The local command runner still uses phase
barriers: selected Generation jobs finish before Determinism, and both finish before checks.
It does not advance each flavor through those phases independently.

### Era-to-Forever coordinate conversion

The DBC tools compare explicit builds and create separate Forever entity/correction files
without changing Era inputs or activating a runtime flavor. Run from this repository:

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
provenance, overwrite protection and remaining Forever integration work.

### Local packages on Linux, macOS, and Windows

Generation creates Baked TOCs; packaging creates installable ZIPs:

```sh
./questiedb.sh generate && ./questiedb.sh package all
# Or one flavor (Vanilla also serves SoD):
./questiedb.sh generate Vanilla && ./questiedb.sh package Vanilla
```

Packages go into `.out/dist/`: one ZIP per requested flavor, `release.json`, and release
notes. Selecting all five also creates `QuestieDB-all.zip`. The ZIPs contain a `QuestieDB/`
folder ready to extract into `Interface/AddOns/`, including `QuestieDB/CHANGELOG.md` for
that release. Packaging never installs or publishes.
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
python3 tools/questie-sync/questie-checkout.test.py
```

The launchers and packaging tests run on Linux and Windows. Native macOS acceptance and
end-to-end database Generation acceptance remain to be run.

### Local inputs and remaining Questie checks

`lua5.1 generate.lua all` reads entity data, Corrections, support data, and localization from
this repository. Reconstruction also reads local sources. Neither command checks out Questie;
`QUESTIE_PATH` does not select their translations. Localized Generation still reads the committed
`QUESTIE_COMMIT` to stamp the legacy import/schema baseline, not to fetch localization.
See [`l10n/README.md`](l10n/README.md) for the translation layout and import provenance.

Only schema materialization (`lua5.1 generate.lua meta`) automatically fetches the exact commit
in `QUESTIE_COMMIT` into `.cache/questie/<sha>` on first use. The shallow, tag-free snapshot is
gitignored and reused offline. Git and Python 3.8+ are required for that fetch; the Python
helper owns temporary directories, argument-safe Git calls, and cleanup. Changing the pin
creates a separate checkout rather than resetting an existing one.

For `meta`, `--questie=<path>` overrides `QUESTIE_PATH` and opts out of automatic fetching.
The generator validates an explicit checkout but never fetches, switches, or cleans it.
The option has no effect on flavor Generation. Reconstruction no longer accepts `--questie`.

Correction imports, migration fidelity tests, and the compiler differential still need the
pinned Questie checkout, defaulting to `../Questie`. Point `QUESTIE_PATH` or the check runner's
`--questie` option at `.cache/questie/<sha>` to reuse the schema checkout.

Focused offline checks:

```sh
python3 tools/validation/localization-inputs.test.py
python3 tools/questie-sync/questie-checkout.test.py
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
replaces. It needs a Questie checkout (`--questie=../Questie`, the default) and `bit32`.
Both bundled interpreters include `bit32`; an installed interpreter can obtain it through
LuaRocks, whose paths the differential discovers automatically. Accepted divergences live in
`tools/differential/compiler-baseline/`; `--update-baseline` re-records them for review.

Generation and runtime database logic use plain Lua 5.1 with no `lfs`, luarocks, or C dependency.
Inputs are enumerated in `src/config.lua` rather than discovered by scanning directories.
Python's standard library handles orchestration, packaging, and the pinned Questie fetch. The
migration compiler differential additionally requires `bit32` for Questie's mocks, already
included in both bundled interpreters.
`./questiedb.sh check --questie=` selects the checkout for fidelity tests and the compiler
differential; `QUESTIE_PATH` provides the same default for nested migration tools. Generation,
Determinism, Reconstruction, Verification, and Equivalence need no external checkout.

To refresh a local install instead of regenerating:

```sh
./questiedb.sh bootstrap "/path/to/Interface/AddOns"           # latest stable release
./questiedb.sh bootstrap "/path/to/Interface/AddOns" preview   # rolling development build
```

Bootstrap uses the same Python implementation from either launcher. It installs `QuestieDB-all.zip`
only, so a release from before the combined archive existed cannot be bootstrapped. It
verifies the checksum and validates archive paths and extraction before changing the install.
The final file merge is not transactional. Matching runtime files are replaced, while unrelated
files are retained. Back up local edits before bootstrapping over a source clone; returning to Source
mode then requires restoring its full runtime sources as well as removing the generated TOCs.

### Releases

Successful default-branch builds update one **Unstable Pre-Release Build** at tag `preview`.
Its tag identifies the commit used to build its assets; older runs cannot roll it back. Preview
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
season cases. It also checks emitted TOCs when present. `objective-first-addon` compares Source,
Baked, and a staged package after Static Correction stripping for available artifacts.
The explicit [flavor scopes](#independent-test-scopes) require these artifact checks for their
selected flavor; the shared scope retains the cross-expansion Source checks. Issue #19 can
reuse these checks rather than duplicate their persona matrix.

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

questiedb.sh / .ps1        thin contributor launchers for the shared Python command
generate.lua              data + Static Corrections -> TOC
verify.lua                round-trip verification
equivalence.lua           source/baked equivalence, every read form, self-proving
reconstruct.lua           byte-exact artifact reconstruction against the generator
test.lua                  unit tests and negative controls
generator/                offline internals, deterministic CBOR and vendored codecs
emulator/                 metadata and C_EncodingUtil stand-ins, client stubs, freeze substitute
validators/               data-invariant checks
tools/                    Python orchestration, packaging, bootstrap, imports, differential gates
docs/                     api.md, storage-format.md, adr/
```

`src/read/` is the only place the two modes diverge. Both backends expose field reads and ID
lists; Baked mode also exposes scalar rows and table producers for its cache fast paths.

---

## Documentation

| | |
| --- | --- |
| [`docs/api.md`](docs/api.md) | the public surface, for consumers |
| [`docs/release-format.md`](docs/release-format.md) | shared release metadata and addon composition rules |
| [`tools/README.md`](tools/README.md) | tooling categories and ownership |
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
