# Inherited Forever corrections

These six providers are the converted Classic baseline. They remain active; this is not
an archive. Leave them unchanged for ordinary correction work. The separate
`Legacy corrections unchanged` CI check rejects added, modified, deleted or renamed Lua
files here on every push and PR. README edits are allowed. An intentional baseline refresh
requires maintainer review and an update to the pinned commit in
`.github/workflows/legacy-corrections.yml`.

Add new corrections in the parent directory's `forever*Fixes.lua` files instead.
See [Correction authoring](../../../../docs/forever.md#correction-authoring) for entry points
and static/dynamic precedence. The opt-in Era-to-Forever converter targets this directory;
`data/Forever/conversion.json` retains its output hashes.
