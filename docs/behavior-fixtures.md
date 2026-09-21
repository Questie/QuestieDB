# Behavior fixtures

The `storage-contract` suite uses fixed examples with separately authored expected reads.
It tests each real backend against those expectations, not just Source/Baked agreement.
There is no snapshot generator or refresh command.

```sh
lua5.1 test.lua storage-contract
lua5.1 test.lua --shared
```

Both commands work without generated flavor TOCs. The fixture writes a tiny temporary
metadata store and removes it after the test, including on failure.

## Inventory and scope

The initial audit used QuestieDB `f8447241f739506a1e2b2c13d5747bbf4f44def0`. It inspected
all 20 raw entity files across Vanilla, TBC, Wrath, Cata, and Mists, plus invoked Quest
correction providers across expansions, factions, SoD, and Titan. Source IDs in
[`storage-cases.lua`](../tools/validation/storage-cases.lua) identify representative origins;
some lists and text are shortened while preserving their shape. Synthetic cases are labeled.

The 54 cases represent every current schema structure, with additional scalar/default cases.
They do not enumerate every field combination, every localization file, or every non-Quest
correction output. Arbitrary different IDs, text, and coordinates are not separate behaviors.

| Structure | Variants covered through both readers |
| --- | --- |
| `objectives` | All six groups; sparse group positions; single/multiple entries; absent numeric tuple slots; explicit zero/nonzero icons and spell items; absent/empty text; missing/empty field |
| `questgivers` | All seven nonempty starter-group combinations; multiple IDs; mixed NPC/object finishers; missing/empty field |
| `extraobjectives` | References only; coordinates only; explicit index; coordinates and references; multiple entries; missing/zero/nonzero index |
| `trigger` | Text alone and text with coordinates |
| `idarray` | Single/multiple IDs, missing/empty field, large chunked table |
| `pair` | Zero-pair absence, zero second component, signed reputation value |
| `pairs` | Single and multiple reputation rewards |
| `stringarray` | Multiple elements including genuine empty strings |
| `spawnlist` | Phased spawn, instance sentinel, zero phase, zero/sub-grid coordinates |
| `waypointlist` | Multiple paths and removal of non-coordinate tuple slots |
| Scalars and defaults | Missing/zero number, missing/empty string, faction values; default-only/scalar-only/table-only entities; known versus unknown IDs |

The raw-data scan found ordinary, sentinel, and nonzero-phase coordinates, but no `{0,0}`
or explicit phase-zero spawn rows. It found no sparse ordinary ID/string/pair-list arrays or
bare waypoint paths. These are not inferred to be impossible: existing synthetic codec,
normalization, and Derived Pass tests retain their boundary coverage.

## What the fixture executes

[`storage-fixture.lua`](../tools/validation/storage-fixture.lua) supplies authored rows to the
real schema, Scalar row builder, field encoder, compressed ID headers, metadata writer/parser,
and readers. Localization goes through the real column builder, compression, and overlay.
Expectations never come from those components.

[`storage-contract.test.lua`](../tools/validation/storage-contract.test.lua) checks public
reads, nested caller-owned copies, actual chunk reassembly, clearing a cached populated field,
correction-added entities, enumeration, and withdrawal. Translation IDs deliberately differ
from their stored positions. It checks translated scalar/list values, missing-translation
fallback, and locale switching. Source mode correctly has no ordinary Base translations.

This suite does not load production correction providers or Derived Pass sets, and it does
not invoke the full `generate.lua` orchestration. Existing tests cover those boundaries:

| Contract | Existing suites |
| --- | --- |
| Expansion inheritance, static-before-derived order, waypoint simplification/subdivision and city scale | `derived-waypoints` |
| Expansion-varying constants and correction admission/order | `corrections` |
| Required-race inference and SoD masks | `derived-required-races`, `sod-required-races` |
| Flavor/season admission and correction-file loading | `objective-first`, `objective-first-source`, `objective-first-addon`, `personas`, `personas-titan` |
| Owner precedence, refresh, clearing, cache invalidation | `overlay`, `set-corrections` |
| Locale precedence, custom locales, withdrawal and invalid inputs | `translation-corrections`, `titan-translations` |
| Whole-row localization overrides versus native field corrections | `localization-overrides` |
| CBOR holes, presence-mask limits, chunk boundaries, malformed/unsafe metadata, constant fields | `cbor`, `rows`, `chunking`, `wire-safety`, `constant-fields` |

Some existing integration suites require their flavor's generated artifact. Full Generation,
verification, equivalence, reconstruction, and validators continue to run on actual data in CI.
They complement these independent fixtures rather than supplying their expected results.

## Maintaining coverage

- Production corrections do not update these fixtures. Their extracted inputs are fixed test data.
- Add a small named case when introducing a new structure or discovering a meaningful branch.
- Review expected results against the documented contract and consumer requirements. Do not
  regenerate expectations from the implementation to make a failing test green.
- Update an expectation only when the behavior contract intentionally changes, explaining why.
- Keep invalid inputs and boundary cases synthetic. Real data cannot demonstrate every failure mode.

The suite protects observed structural variants and selected behavioral boundaries. It does
not prove every gameplay fact correct or claim exhaustive coverage of all possible combinations.
