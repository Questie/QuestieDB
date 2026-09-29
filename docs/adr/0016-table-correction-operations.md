# 16. Shape-aware table Correction operations

Status: accepted.

Whole-field Corrections make a small relationship change repeat an entire list and
can discard data supplied by earlier layers. Add `_add` and `_remove` authoring
keys for table fields, using one schema-aware implementation for Static and Dynamic
Corrections. Keep ordinary replacements and the stored entity schema unchanged.

## Why this interface

Authors describe the intended change without copying the current baseline:

```lua
[questKeys.finishedBy_add] = {[2] = {424005}},
[itemKeys.relatedQuests_remove] = {7786},
```

The correction enums provide the names. The merger interprets the operations;
enums alone cannot implement the change. Internally, addition uses the canonical
index plus 1000 and removal uses the index minus 1000. These reserved indices do
not enter canonical schema keys, getters, field counts or encoded entity data.
Callers use the named aliases rather than doing index arithmetic.

Aliases also exist for scalar fields so misuse can raise a contextual error rather
than failing with an unexplained nil table key. Scalar operations are not supported;
ordinary scalar replacements remain valid.

## Reuse shape rules, not per-field special cases

Support all current canonical table shapes from the start, grouped into three
behaviors:

- **Lists:** add missing complete values; remove exact complete matches. Preserve
  surviving order and append additions in operand order.
- **Grouped values:** apply the appropriate rule only within supplied groups,
  preserving omitted groups. Quest giver slots retain their entity-kind meaning;
  spawn zones retain their keys. Objective group 4 is a fixed reputation pair,
  unlike the other objective groups.
- **Fixed records:** treat a pair or trigger as one atomic value. Add when absent
  or already equal; reject a different existing value. Remove only an exact match.
  Use ordinary replacement to change the record.

Nested coordinates, objective rows and extra-objective rows match as complete
values, not by list position or their first ID. Waypoint paths are complete ordered
entries; repeated points inside a path survive. Canonical schema metadata chooses
the rule, because an empty Lua table cannot reveal its intended shape.

**Rejected:** A universal recursive merge. Numeric keys can mean list positions,
entity-kind slots, tuple fields or zone IDs. Treating them alike would silently
change meaning. A separate implementation for every field would instead duplicate
the same few rules and make additions harder to review.

The [public API](../api.md#table-addremove-operations) contains the complete shape
matrix and authoring examples.

## Strict operands and deterministic conflicts

Require a table-valued field, a valid table operand and a valid existing table when
there is an existing value. Reject scalar misuse, malformed shapes, unknown operation
indices, and replacement plus operation on the same field in one Correction row.
Reject the same value requested for both addition and removal; never let Lua's
`pairs` iteration order decide the result.

Disjoint list/group operations coexist. Top-level pairs and triggers cannot carry
both nonempty operations in one row. Objective group 4 permits disjoint remove-old
then add-new. Empty operation operands do nothing, including no backend read.
Ordinary `[key] = {}` retains its existing deletion meaning.

Validate operands before normalization so malformed slots cannot disappear. Compare
using normalized read semantics so Static raw tuples and Baked values agree, such
as an absent objective icon versus zero, or an omitted spawn phase versus phase zero.

**Why:** These operations must be repeatable and predictable across modes. Permissive
coercion or order-dependent conflict resolution would turn authoring mistakes into
data changes that are difficult to diagnose.

## One application path, independent values

Static application during Generation and Source loading shares the operation engine
with Dynamic composition. A Dynamic operation reads the earlier composed value,
including an explicit deletion, or the backend value without localization. Reapply
and withdrawal rebuild from the underlying layers rather than accumulating changes.

Do not mutate operands, prior Correction values or backend tables. Stage Dynamic
composition before publication. Failed validation preserves the previous reads,
provenance and caches. Failed data-slot writes restore an independent last-successful
snapshot, including when a caller mutated and resubmitted the same table. Failed
function providers can be corrected and retried without retaining invalid memos.

This extends [ADR 0009](0009-data-shaped-correction-slots.md); it is not a general
transaction system for provider side effects or an all-row rollback for Static
merges. Ordinary replacement behavior and entity-creation policies remain intact.
Older Baked manifests without the operation module continue to accept replacements
but explicitly reject operations until their manifests are updated.

## Validation and ownership

The shared provider audit executes manifest-declared providers across supported
flavor/season scenarios and documented character personas. Test-only strict enum
lookups catch misspelled aliases, while the real operation engine validates operands
and conflicts. In-memory invalid providers prove the audit fails for those mistakes.
CI and Release use the existing shared gate rather than a separate validation engine.

**Why:** Synthetic merger tests alone would not find a typo inside a real faction or
class branch. The audit is still an authoring check, not gameplay verification or
proof that an atomic addition agrees with a particular existing baseline.

Operations do not automatically create inverse relationships. Producers remain
responsible for both sides of an intended relationship change. Source completeness,
removal evidence and deciding whether a correction is useful belong to the author
or extractor, not the merger.

The external Forever generator uses plain fields for new records and absent/empty
fields, reserving operations for modifications to populated fields. This keeps
initialization readable without weakening the generic operation contract.
