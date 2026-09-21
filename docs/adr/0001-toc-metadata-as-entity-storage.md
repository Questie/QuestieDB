# Entity data is stored as addon TOC metadata

Entity fields are stored as `## X-<id>-<field>` metadata lines in the addon's `.toc` and read
at runtime via `C_AddOns.GetAddOnMetadata`, rather than compiled into a binary blob held in
SavedVariables. TOC metadata lives in client-side storage rather than the Lua heap, so no
value materialises until a getter decodes it — which removes the compile step entirely, along
with its per-login cost and its SavedVariables footprint.

## Considered options

- **Keep the binary compiler.** Rejected: it is the source of the recompile-at-login cost,
  the locale-change recompile, and a 1367-line format nobody else can read.
- **Plain Lua data files.** Rejected: the client parses and materialises the whole table into
  the Lua heap regardless of how little of it is used.
- **An in-band schema manifest for every type and field.** Not adopted from the parallel
  prototype: supported releases package the reader, schema, and generated TOCs together.
  Repeating the schema would add metadata and startup parsing without replacing the need for
  contract-version discipline. Revisit if data is distributed independently of its reader,
  third-party readers consume the TOC directly, or reader/artifact skew becomes a demonstrated
  problem. This does not imply that an arbitrary artifact is safe with an older checkout.

## Consequences

- Generated `.toc` files are large — 20.4 MB (Vanilla) to 84.5 MB (Mists). **In-client parse
  time and metadata memory at that scale is an unvalidated risk and gates this decision.**
- Values arrive as strings and need decoding, so table-valued fields cost a `loadstring` on
  first access. The decoded field cache exists to make that once-per-field.
- Long values must be split into chunked metadata values and reassembled.
- Entity localization can live in the same store at no Lua-memory cost, since unused locales
  are never decoded.
