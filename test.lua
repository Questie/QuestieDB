#!/usr/bin/env lua
-- test.lua
--
-- Storage codecs, read semantics, workflow contracts, and the negative controls that prove
-- the verification gates can fail.
--
-- Deliberately dependency-free: plain Lua 5.1, no busted, no luarocks, no Python. The few
-- filesystem operations Lua lacks go through tools/validation/test-files.lua, which uses the
-- platform's own shell commands. The guard has to be present in CI rather than conditional
-- on a toolchain being installed.
--
-- Usage:
--   lua test.lua                 every suite
--   lua test.lua serialize cbor  one or more suites by name
--   lua test.lua --shared        no generated artifacts
--   lua test.lua --flavor=Wrath  only this complete, localized artifact
--   lua test.lua --shared --list  list selected suites without running them

local lib = dofile("generator/lib.lua")
local testFiles = dofile("tools/validation/test-files.lua")
local serialize = dofile("generator/serialize.lua")
local codec = dofile("src/meta/codec.lua")
local encode = dofile("generator/encode.lua")
local rowBuilder = dofile("generator/rows.lua")
local base64 = dofile("generator/base64.lua")
local cbor = dofile("generator/cbor.lua")
local vendoredCBOR = dofile("generator/vendor/BlizzardCBOR.lua")
local cborCases = dofile("generator/vendor/BlizzardCBORCompatibilityCases.lua")
local cborFixtures = dofile("generator/vendor/BlizzardCBORCompatibilityFixtures.lua")
local LibDeflate = dofile("generator/vendor/LibDeflate.lua")
local normalize = dofile("src/meta/normalize.lua")
local emulator = dofile("emulator/metadata.lua")
local client = dofile("emulator/client.lua")
local config = dofile("src/config.lua")

local LUA_BIN = os.getenv("LUA") or "lua5.1"

--------------------------------------------------------------------------------------------
-- Harness
--------------------------------------------------------------------------------------------

local suites, order, scopes = {}, {}, {}
local selectedFlavor
local artifactFlavors = config.flavors

---@param name string
---@param scope string|table<string, boolean> shared, artifact, an owning flavor, or explicit flavor set.
---@param fn function
---@return nil
local function suite(name, scope, fn)
  scopes[name] = scope
  suites[name] = fn
  order[#order + 1] = name
end

local current

---Quote an argument for the platform shell used by direct Lua test subprocesses.
---@param value string
---@return string quoted
local function shellQuote(value)
  return lib.shellQuote(value)
end

---Run a platform-shell command and normalize Lua 5.1/5.2 exit-status shapes.
---@param command string
---@return boolean succeeded
local function commandSucceeded(command)
  local ok = lib.execute(command)
  if type(ok) == "number" then return ok == 0 end
  return ok == true
end

local function check(condition, message)
  current.total = current.total + 1
  if not condition then
    current.failed = current.failed + 1
    io.write("  FAIL ", current.name, ": ", message, "\n")
  end
end

local function equal(actual, expected, message)
  check(lib.deepEqual(actual, expected),
    ("%s\n    expected: %s\n    actual:   %s"):format(message, lib.show(expected), lib.show(actual)))
end

---@param value string Lua literal produced by generator/serialize.lua.
---@return any decoded
local function decodeLiteral(value)
  local chunk = assert(loadstring("return " .. value))
  return chunk()
end

local function roundTrip(value, message)
  local encoded = serialize.value(value)
  local decoded = decodeLiteral(encoded)
  equal(decoded, value, (message or "round trip") .. "  [" .. encoded .. "]")
  return encoded
end

---Replace one scalar in an unchunked CBOR row while keeping the corruption fixture decodable.
---@param content string TOC contents.
---@param entityName string Metadata key entity name.
---@param id number Entity ID.
---@param fieldIndex number Scalar field index.
---@param value any Replacement value.
---@return string content
---@return integer replacements
local function replaceScalarInRow(content, entityName, id, fieldIndex, value)
  local pattern = "(## X%-" .. entityName .. "%-" .. id .. "%-S: )([^\n]+)"
  return content:gsub(pattern, function(prefix, encodedRow)
    if encodedRow:sub(1, 1) == "~" then
      error("test fixture expected an unchunked scalar row", 0)
    end
    local row = cbor.decode(base64.decode(encodedRow))
    row[fieldIndex] = value
    return prefix .. encode.row(row)
  end, 1)
end

--------------------------------------------------------------------------------------------
-- Offline binary codecs
--------------------------------------------------------------------------------------------

suite("base64", "shared", function()
  local cases = {
    { "", "" },
    { "f", "Zg==" },
    { "fo", "Zm8=" },
    { "foo", "Zm9v" },
    { "\0\1\127\128\255", "AAF/gP8=" },
  }
  for _, case in ipairs(cases) do
    equal(base64.encode(case[1]), case[2], "base64 encoding with every padding shape")
    equal(base64.decode(case[2]), case[1], "base64 round trip with every padding shape")
  end

  for _, invalid in ipairs({ "A", "A===", "AA=A", "AA==AAAA", "AA?=" }) do
    local ok = pcall(base64.decode, invalid)
    check(not ok, "invalid base64 was accepted: " .. invalid)
  end
end)

suite("cbor", "shared", function()
  local function toHex(bytes)
    return (bytes:gsub(".", function(character)
      return string.format("%02x", string.byte(character))
    end))
  end

  local compared = 0
  for _, compatibilityCase in ipairs(cborCases.GetCases()) do
    local fixture = cborFixtures.cases[compatibilityCase.id]
    check(fixture ~= nil, "CBOR compatibility case has a captured fixture: " .. compatibilityCase.id)
    if fixture then
      local ok, output = cborCases.CallSerialize(vendoredCBOR.SerializeCBOR, compatibilityCase)
      if fixture.blizzardError ~= nil then
        check(not ok, "CBOR case should fail like the client: " .. compatibilityCase.id)
        compared = compared + 1
      elseif fixture.blizzardHex ~= nil and
             (not compatibilityCase.mapOrderUnstable or fixture.compareLocally == true) then
        check(ok, "CBOR case failed locally: " .. compatibilityCase.id .. ": " .. tostring(output))
        if ok then equal(toHex(output), fixture.blizzardHex, "CBOR client fixture: " .. compatibilityCase.id) end
        compared = compared + 1
      end
    end
  end
  check(compared > 0, "CBOR compatibility suite compared captured client fixtures")

  local first = {}
  first.z, first.a, first[7], first[2] = "last", "first", true, false
  local second = {}
  second[2], second[7], second.a, second.z = false, true, "first", "last"
  equal(cbor.encode(first), cbor.encode(second), "CBOR map bytes ignore insertion order")
  equal(cbor.decode(cbor.encode(first)), first, "deterministic CBOR round trip")

  local nestedFirst = { outer = { z = 1, a = 2 }, rows = { { y = 3, b = 4 } } }
  local nestedSecond = { rows = {}, outer = {} }
  nestedSecond.rows[1] = { b = 4, y = 3 }
  nestedSecond.outer.a, nestedSecond.outer.z = 2, 1
  equal(cbor.encode(nestedFirst), cbor.encode(nestedSecond),
    "nested maps and maps inside arrays ignore insertion order")

  local sparse = { [1] = { 12676 }, [3] = { 16305 } }
  equal(cbor.decode(cbor.encode(sparse)), sparse, "CBOR arrays preserve nil holes")
  equal(encode.idList({ 2, 5, 7, 12 }), encode.idList({ 2, 5, 7, 12 }),
    "compressed CBOR ID headers are deterministic")
end)

suite("deflate", "shared", function()
  local input = string.rep("QuestieDB zlib round trip \0", 100)
  local compressed = LibDeflate:CompressZlib(input, { level = 9 })
  check(type(compressed) == "string" and #compressed < #input, "LibDeflate produced compressed zlib bytes")
  equal(LibDeflate:DecompressZlib(compressed), input, "LibDeflate zlib round trip")

  local value = { [7] = { "typed", 42 }, [2] = "block" }
  local encoded = encode.compressedCbor(value)
  local decoded = cbor.decode(LibDeflate:DecompressZlib(base64.decode(encoded)))
  equal(decoded, value, "compressed CBOR helper round trip")
  equal(encoded, encode.compressedCbor(value), "compressed CBOR helper is deterministic")
end)

suite("encoding-util", "shared", function()
  client.reset()
  client.install({ expansion = "Classic" })
  local encoding = C_EncodingUtil

  local ids = { 2, 5, 7, 12, 13 }
  local idHeader = encoding.EncodeBase64(encoding.CompressString(encoding.SerializeCBOR(ids), 1, 2))
  equal(encoding.DeserializeCBOR(encoding.DecompressString(encoding.DecodeBase64(idHeader), 1)), ids,
    "C_EncodingUtil stand-ins round-trip an id header")

  local row = { [1] = "Sharptalon's Claw", [4] = 10, p = 2 ^ 7 }
  equal(encoding.DeserializeCBOR(encoding.DecodeBase64(
    encoding.EncodeBase64(encoding.SerializeCBOR(row)))), row,
    "C_EncodingUtil stand-ins round-trip a scalar row")

  local input = string.rep("compression methods \0", 20)
  for method = 0, 1 do
    local compressed = encoding.CompressString(input, method, 2)
    equal(encoding.DecompressString(compressed, method), input,
      "compression method " .. method .. " round trip")
  end

  local compressed = encoding.CompressString(input, 1, 2)
  local last = compressed:byte(-1)
  local corrupted = compressed:sub(1, -2) .. string.char((last + 1) % 256)
  local checksumOk = pcall(encoding.DecompressString, corrupted, 1)
  check(not checksumOk, "zlib decompression rejects a corrupt checksum")

  local encodedRow = encoding.SerializeCBOR(row)
  local ok = pcall(encoding.DeserializeCBOR, encodedRow .. "\0")
  check(not ok, "CBOR stand-in rejects trailing bytes")
  client.reset()
end)

--------------------------------------------------------------------------------------------
-- serialize
--------------------------------------------------------------------------------------------

suite("serialize", "shared", function()
  equal(serialize.value({ 1, 2, 3 }), "{1,2,3}", "dense array")
  equal(serialize.value({ [1] = { 12676 }, [3] = { 16305 } }), "{{12676},nil,{16305}}", "sparse array keeps holes")
  equal(serialize.value({}), "{}", "empty table")
  equal(serialize.value({ [1335] = { { 36.43, 55.89 } } }), "{[1335]={{36.43,55.89}}}", "coordinate table")

  -- Hash keys are emitted in sorted order, which is what makes regeneration byte-identical.
  equal(serialize.value({ [1335] = { 1 }, [1] = { 2 } }), "{{2},[1335]={1}}", "hash keys sorted numerically")
  equal(serialize.value({ 1, 2, 3, [1000] = 9 }), "{1,2,3,[1000]=9}", "dense prefix plus a distant key")
  equal(serialize.value({ [6] = "x" }), "{[6]='x'}", "one distant key does not emit five holes")
  equal(serialize.value({ [12] = { 1 }, [1519] = { 2 } }), "{[12]={1},[1519]={2}}", "zone-keyed spawn table")
  equal(serialize.value({ b = 1, a = 2 }), "{['a']=2,['b']=1}", "string keys sorted lexicographically")
  equal(serialize.value({ 1, x = 2 }), "{1,['x']=2}", "array part before hash part")

  -- Determinism: the same input must produce the same bytes, every time.
  local wide = {}
  for i = 1, 200 do wide["key" .. i] = i end
  equal(serialize.value(wide), serialize.value(wide), "repeated serialization is identical")

  -- Numbers must read back as exactly themselves.
  for _, n in ipairs({ 0, 1, -1, 36.43, 55.89, 0.1, 1 / 3, 2 ^ 31, -2 ^ 31, 8388607, 1e-9 }) do
    equal(tonumber(serialize.number(n)), n, "number round trip: " .. tostring(n))
  end

  -- Strings must survive loadstring exactly, including the characters a naive escaper drops.
  for _, s in ipairs({
    "Sharptalon's Claw",
    'He said "hello"',
    "back\\slash",
    "both ' and \" quotes",
    "line\nbreak",
    "carriage\rreturn",
    "tab\there",
    "null\0byte",
    "Ünïcödé ‡ dagger",
    "",
    "nil",
    "~E~",
    "~3~",
  }) do
    local decoded = decodeLiteral(serialize.quote(s))
    equal(decoded, s, "string quote round trip: " .. s:gsub("%c", "?"))
  end

  -- No serialized string may contain a raw newline; the TOC format is line-oriented.
  check(not serialize.quote("line\nbreak"):find("\n"), "quoted string contains a raw newline")

  roundTrip({ nil, nil, { 16305 }, nil, { { { 7572 }, 7572, "The Tale of Sorrow" } } }, "questgivers shape")
  roundTrip({ "Secret phrase found", { [1336] = { { 79.56, 75.65 } } } }, "trigger shape")
  roundTrip({ { nil, "ICON_TYPE_OBJECT", "Use a Fresh Carcass", 0, { { "object", 1770 } } } }, "extraobjectives shape")
  roundTrip({ [12] = { { 36.43, 55.89 }, { 31.43, 57.03, 2 } } }, "spawnlist with phase")
end)

--------------------------------------------------------------------------------------------
-- codec
--------------------------------------------------------------------------------------------

suite("codec", "shared", function()
  equal(codec.chunkCount["~3~"], 3, "chunk header parsed")
  equal(codec.chunkCount["~21~"], 21, "chunk header beyond the warmed range")
  equal(codec.chunkCount["Sharptalon's Claw"], nil, "ordinary value is not a chunk header")
  equal(codec.chunkCount["gqFhAQ=="], nil, "base64 CBOR is not a chunk header")
end)

--------------------------------------------------------------------------------------------
-- Generation inputs
--------------------------------------------------------------------------------------------

suite("generation-inputs", "shared", function()
  local l10nGen = dofile("generator/l10n.lua")
  local flavor = config.flavorByName.Vanilla
  local typeFilter = { Quest = true }
  local root = ".out/test-localization-input"
  local paths = {}
  for _, locale in ipairs(config.locales) do
    local path = l10nGen.lookupPath(root, flavor, l10nGen.types.Quest, locale)
    paths[#paths + 1] = path
    os.remove(path)
  end

  local ok, err = pcall(l10nGen.assertInputs, root, { flavor }, typeFilter)
  check(not ok and tostring(err):find("%-%-no%-l10n"),
    "missing localization input fails with the explicit partial-output escape hatch")

  -- A type-filtered Generation needs only that entity type's nine locale files.
  for _, path in ipairs(paths) do
    lib.mkdirp(path:match("^(.*)/[^/]+$"))
    lib.writeAll(path, "-- localization input fixture\n")
  end

  local present, presentErr = pcall(l10nGen.assertInputs, root, { flavor }, typeFilter)
  check(present, "a complete selected lookup set passes preflight: " .. tostring(presentErr))

  for _, path in ipairs(paths) do os.remove(path) end
end)

--------------------------------------------------------------------------------------------
-- Workflow contracts
--------------------------------------------------------------------------------------------

suite("workflow-contracts", "shared", function()
  local release = lib.readAll(".github/workflows/release.yml")
  local publish = assert(release:match("\n  publish:\n(.*)"), "release has a publication job")
  check(publish:find("needs: quality", 1, true) ~= nil,
    "release publication depends on the artifact quality job")
  check(release:find("needs: [preflight, shared, database, legacy]", 1, true) ~= nil,
    "release quality waits for preflight, shared tests, every flavor, and legacy corrections")
  check(release:find("cancel-in-progress: false", 1, true) ~= nil,
    "publication cannot be cancelled midway through replacement")

  local ci = lib.readAll(".github/workflows/ci.yml")
  local gates = assert(ci:match("\n  gates:\n(.*)"), "CI has an aggregate gate")
  check(gates:find("if: always()", 1, true) ~= nil,
    "All gates still runs when a prerequisite fails or is cancelled")
  check(gates:find("needs: [test, database, legacy]", 1, true) ~= nil,
    "All gates waits for legacy corrections as well as tests and artifacts")
  check(gates:find('[ "${{ needs.legacy.result }}" = "success" ] ||', 1, true) ~= nil,
    "All gates rejects failed, skipped, or cancelled legacy checks")
end)

--------------------------------------------------------------------------------------------
-- Offline tooling platform helpers
--------------------------------------------------------------------------------------------

suite("tooling-platform", "shared", function()
  dofile("tools/validation/platform.test.lua")(check, equal)
end)

--------------------------------------------------------------------------------------------
-- chunking
--------------------------------------------------------------------------------------------

suite("chunking", "shared", function()
  local function emit(value, maxLen)
    local path = ".out/test-chunk.toc"
    lib.mkdirp(".out")
    local out = assert(io.open(path, "wb"))
    out:write("## Interface: 11508\n\n")
    lib.writeMetadata(out, "X-T-1-1", value, maxLen)
    out:close()
    local map = emulator.parse(path)
    return emulator.getValue(map, "X-T-1-1"), map
  end

  equal(emit("short", 1000), "short", "short value is not chunked")

  local long = string.rep("a", 2500)
  local joined, map = emit(long, 1000)
  equal(joined, long, "long value reassembles exactly")
  equal(map["X-T-1-1"], "~3~", "base key holds the part count")
  equal(#map["X-T-1-1-1"], 1000, "first part is full width")

  -- Splits must not land inside a UTF-8 sequence. A wall of 3-byte characters puts a
  -- boundary at every possible offset relative to a 1000-byte limit.
  local multibyte = string.rep("‡", 900) -- U+2021, 3 bytes each => 2700 bytes
  local mbJoined, mbMap = emit(multibyte, 1000)
  equal(mbJoined, multibyte, "multibyte value reassembles exactly")
  for i = 1, tonumber(mbMap["X-T-1-1"]:match("%d+")) do
    local part = mbMap["X-T-1-1-" .. i]
    local firstByte = part:byte(1)
    check(firstByte < 0x80 or firstByte >= 0xC0,
      "chunk " .. i .. " starts on a UTF-8 continuation byte")
  end

  -- Every part except the last must be within the limit, and none may exceed it.
  for i = 1, tonumber(mbMap["X-T-1-1"]:match("%d+")) do
    check(#mbMap["X-T-1-1-" .. i] <= 1000, "chunk " .. i .. " exceeds the limit")
  end

  -- Key length counts against the same line budget as the value. A long key must shrink the
  -- parts, not push the line over the limit — the client truncates silently past it.
  local longKey = "X-l10n-Quest-1234567-2"
  local payload = string.rep("b", 5000)
  do
    local path = ".out/test-chunk.toc"
    local out = assert(io.open(path, "wb"))
    lib.writeMetadata(out, longKey, payload, 1000)
    out:close()
    local map = emulator.parse(path)
    equal(emulator.getValue(map, longKey), payload, "a long-keyed value reassembles exactly")

    local overLimit = 0
    local file = assert(io.open(path, "rb"))
    for line in file:lines() do
      if #line > lib.TOC_LINE_LIMIT then overLimit = overLimit + 1 end
    end
    file:close()
    equal(overLimit, 0, "no emitted line exceeds the client's line limit")
    os.remove(path)
  end


  os.remove(".out/test-chunk.toc")
end)

suite("artifact-lines", "artifact", function()
  -- And the same holds for every generated artifact on disk.
  for _, flavor in ipairs(artifactFlavors) do
    local tocPath = config.tocPath(flavor)
    if lib.fileExists(tocPath) then
      local overLimit, worst = 0, 0
      local file = assert(io.open(tocPath, "rb"))
      for line in file:lines() do
        if line:sub(1, 5) == "## X-" and #line > lib.TOC_LINE_LIMIT then
          overLimit = overLimit + 1
          if #line > worst then worst = #line end
        end
      end
      file:close()
      check(overLimit == 0, ("%s has %d lines over the %d-byte limit (worst %d)")
        :format(tocPath, overLimit, lib.TOC_LINE_LIMIT, worst))
    end
  end

end)

--------------------------------------------------------------------------------------------
-- nil and empty semantics
--------------------------------------------------------------------------------------------

suite("semantics", "shared", function()
  local meta = {
    entity = "Test",
    fieldCount = 6,
    names = { "num", "str", "tbl", "pair", "fac", "idarray" },
    types = { "number", "string", "table", "table", "string", "table" },
    structures = { nil, nil, "questgivers", "pair", nil, "idarray" },
    emptyIsNil = { [3] = true, [4] = true, [6] = true },
    zeroPairIsNil = { [4] = true },
    normalize = { [5] = "faction" },
    keys = { num = 1, str = 2, tbl = 3, pair = 4, fac = 5, idarray = 6 },
  }

  equal(normalize.field(meta, 1, nil), 0, "number nil reads back as 0")
  equal(normalize.field(meta, 1, 0), 0, "number zero stays zero")
  equal(normalize.field(meta, 1, 42), 42, "number passes through")

  equal(normalize.field(meta, 2, nil), nil, "string nil stays nil")
  equal(normalize.field(meta, 2, ""), "", "empty string is distinct from nil")
  equal(normalize.field(meta, 2, "x"), "x", "string passes through")

  -- Field 3 is a `questgivers` structure, whose compiler reader always constructs a table, so
  -- it is one of the never-nil fields (ADR 0004). Field 6 is a plain idarray and keeps the
  -- ordinary rule, so both halves of the contract stay covered.
  equal(normalize.field(meta, 3, nil), {}, "never-nil structure: nil reads back as {}")
  equal(normalize.field(meta, 3, {}), {}, "never-nil structure: {} stays {}")
  equal(normalize.field(meta, 3, { 1 }), { 1 }, "non-empty table passes through")
  check(normalize.field(meta, 3, nil) ~= normalize.field(meta, 3, nil),
        "never-nil default is a fresh table per call, not a shared constant")

  equal(normalize.field(meta, 6, nil), nil, "ordinary table field: nil stays nil")
  equal(normalize.field(meta, 6, {}), nil, "ordinary table field: {} reads back as nil")
  equal(normalize.field(meta, 6, { 3 }), { 3 }, "ordinary table field passes through")

  equal(normalize.field(meta, 4, { 0, 0 }), nil, "pair {0,0} reads back as nil")
  equal(normalize.field(meta, 4, { 0, 5 }), { 0, 5 }, "pair {0,n} survives")
  equal(normalize.field(meta, 4, { 5, 0 }), { 5, 0 }, "pair {n,0} survives")

  equal(normalize.field(meta, 5, nil), nil, "faction nil")
  equal(normalize.field(meta, 5, ""), nil, "faction empty string collapses to nil")
  equal(normalize.field(meta, 5, "A"), "A", "faction A")
  equal(normalize.field(meta, 5, "H"), "H", "faction H")
  equal(normalize.field(meta, 5, "AH"), "AH", "faction AH")
  equal(normalize.field(meta, 5, "HA"), "AH", "faction HA normalizes to AH")

  equal(normalize.default(meta, 1), 0, "numeric default is 0")
  equal(normalize.default(meta, 2), nil, "string default is nil")
  equal(normalize.default(meta, 3), {}, "never-nil structure default is {}")
  equal(normalize.default(meta, 6), nil, "ordinary table default is nil")

  -- Per-field encoding owns only table values. Defaults still produce no metadata.
  equal(encode.field(meta, 3, {}), nil, "empty table writes no line")
  equal(encode.field(meta, 3, nil), nil, "never-nil structure still writes no line when absent")
  equal(encode.field(meta, 6, {}), nil, "ordinary empty table writes no line")
  equal(encode.field(meta, 4, { 0, 0 }), nil, "zero pair writes no line")
  local encodedTable = encode.field(meta, 6, { 3 })
  equal(cbor.decode(base64.decode(encodedTable)), { 3 }, "stored table is base64 CBOR")

  -- Verification starts from an already-normalized value and uses this cheaper presence test
  -- instead of serializing the field again. Cover every omission class it depends on.
  check(not encode.hasStoredValue(meta, 1, 0), "normalized numeric zero needs no stored value")
  check(encode.hasStoredValue(meta, 1, 7), "normalized non-zero number needs a stored value")
  check(not encode.hasStoredValue(meta, 2, nil), "normalized nil string needs no stored value")
  check(encode.hasStoredValue(meta, 2, ""), "normalized empty string needs a stored value")
  check(not encode.hasStoredValue(meta, 3, {}), "normalized empty table needs no stored value")
  check(encode.hasStoredValue(meta, 3, { 1 }), "normalized populated table needs a stored value")
end)

suite("storage-contract", "shared", function()
  dofile("tools/validation/storage-contract.test.lua")(check, equal)
end)

suite("rows", "shared", function()
  local meta = {
    entity = "Fixture",
    fieldCount = 6,
    names = { "number", "text", "values", "constant", "emptyTable", "absentText" },
    types = { "number", "string", "table", "string", "table", "string" },
    structures = {},
    normalize = {},
    zeroPairIsNil = {},
    keys = {},
    constantValues = { [4] = "placeholder" },
  }

  equal(rowBuilder.build(meta, { [1] = 0, [3] = {}, [4] = "obsolete", [5] = {} }), nil,
    "an entity with only defaults and a constant has no scalar row")

  local row = rowBuilder.build(meta, {
    [1] = 7,
    [2] = "",
    [3] = { 99 },
    [4] = "obsolete",
    [5] = {},
  })
  equal(row, { [1] = 7, [2] = "", p = 2 ^ 2 },
    "the row stores scalars, preserves an empty string and marks a present table")
  equal(row[6], nil, "an absent string has no row slot")
  equal(row[4], nil, "a constant field has no row slot")

  local zero = rowBuilder.build(meta, { [1] = 0 })
  local absent = rowBuilder.build(meta, {})
  equal(zero, absent, "numeric zero and an absent number both need no scalar storage")
  equal(rowBuilder.build(meta, { [3] = { 99 } }), { p = 2 ^ 2 },
    "an entity containing only a table stores a presence-only row")

  local boundaryMeta = {
    entity = "Boundary", fieldCount = 52, names = {}, types = {}, structures = {},
    normalize = {}, zeroPairIsNil = {}, keys = {},
  }
  for fieldIndex = 1, 52 do
    boundaryMeta.names[fieldIndex] = "field" .. fieldIndex
    boundaryMeta.types[fieldIndex] = fieldIndex == 52 and "table" or "number"
  end
  equal(rowBuilder.build(boundaryMeta, { [52] = { 1 } }), { p = 2 ^ 51 },
    "the highest supported presence bit remains exact")

  local wideMeta = {
    entity = "TooWide", fieldCount = 53, names = {}, types = {}, structures = {}, keys = {},
  }
  local ok, err = pcall(rowBuilder.build, wideMeta, {})
  check(not ok and tostring(err):find("at most 52", 1, true) ~= nil,
    "a schema wider than the exact presence mask is rejected")
end)

suite("l10n-blocks", "shared", function()
  local l10nGen = dofile("generator/l10n.lua")
  local ids = { 10, 20, 30, 40 }
  local values = {
    [10] = {
      [1] = { [1] = "Zehn", [2] = "Ten" },
      [2] = { [1] = { "Erstes Ziel" } },
    },
    [20] = { [1] = { [2] = "Twenty" } },
    [30] = { [2] = { [1] = { "Ziel A", "Ziel B" } } },
    [999] = { [1] = { [1] = "Unknown" } },
  }

  local german, germanEntities, germanValues =
    l10nGen.buildBlock("Quest", values, ids, 1)
  equal(german, {
    [1] = { [1] = "Zehn" },
    [2] = { [1] = { "Erstes Ziel" }, [3] = { "Ziel A", "Ziel B" } },
  }, "localization columns align with base entity positions and preserve nil holes")
  equal(germanEntities, 2, "entities with any German translation are counted")
  equal(germanValues, 3, "individual German translated fields are counted")
  equal(german[1][4], nil, "an untranslated known entity leaves a fallback hole")
  equal(german[1][999], nil, "an unknown translated id is excluded from the block")

  local english, englishEntities, englishValues =
    l10nGen.buildBlock("Quest", values, ids, 2)
  equal(english, { [1] = { [1] = "Ten", [2] = "Twenty" }, [2] = {} },
    "each locale builds an independent set of columns")
  equal(englishEntities, 2, "second-locale entity count")
  equal(englishValues, 2, "second-locale field count")

  local encoded = encode.compressedCbor(german)
  local decoded = cbor.decode(LibDeflate:DecompressZlib(base64.decode(encoded)))
  equal(decoded, german, "localization block survives compressed CBOR encoding")
  equal(encoded, encode.compressedCbor(l10nGen.buildBlock("Quest", values, ids, 1)),
    "localization block bytes are deterministic")
  equal(config.l10nBlockKey("Quest", "deDE"), "X-l10n-deDE-Quest",
    "localization block key names its locale and entity type")
  for _, locale in ipairs(config.locales) do
    check(config.l10nBlockKey("Quest", locale):sub(-#locale - 1) ~= "-" .. locale,
      "localization block key does not trigger the client's localized-directive suffix: " .. locale)
  end
end)

suite("cbor-cache", "shared", function()
  local questMeta = dofile("src/meta/questMeta.lua")
  local fixturePath = ".out/test-cbor-cache.toc"
  local lines = {
    "## Interface: 11509",
    "## X-Flavor: Vanilla",
    "## X-Contract-Version: " .. tostring(config.contractVersion),
    "## X-Quest-IDS: " .. encode.idList({ 2 }),
    "## X-Quest-2-2: " .. encode.field(questMeta, 2, { { 123 } }),
    "## X-Quest-2-S: " .. encode.row({ [1] = "Fixture quest", [4] = 20, p = 2 }),
    "## X-Npc-IDS: " .. encode.idList({}),
    "## X-Item-IDS: " .. encode.idList({}),
    "## X-Object-IDS: " .. encode.idList({}),
    "",
  }
  for _, file in ipairs(config.bakedFileList(config.flavorByName.Vanilla)) do
    lines[#lines + 1] = file
  end
  lib.mkdirp(".out")
  lib.writeAll(fixturePath, table.concat(lines, "\n") .. "\n")

  client.reset()
  client.install({ expansion = "Classic" })
  local handle = emulator.install(config.addonName, emulator.parse(fixturePath))
  local metadataCalls = {}
  local function countedMetadata(addonName, key)
    metadataCalls[key] = (metadataCalls[key] or 0) + 1
    return handle.get(addonName, key)
  end
  C_AddOns.GetAddOnMetadata = countedMetadata
  GetAddOnMetadata = countedMetadata

  local deserialize = C_EncodingUtil.DeserializeCBOR
  local deserializeCalls = 0
  C_EncodingUtil.DeserializeCBOR = function(bytes)
    deserializeCalls = deserializeCalls + 1
    return deserialize(bytes)
  end

  local Lib = emulator.loadAddon(fixturePath, config.addonName)
  metadataCalls = {}
  deserializeCalls = 0
  Lib.InvalidateCache()

  equal(Lib.Quest.name(2), "Fixture quest", "first scalar read returns the decoded row value")
  equal(metadataCalls["X-Quest-2-S"], 1, "first scalar read fetches one row")
  equal(deserializeCalls, 1, "first scalar read decodes one row")

  equal(Lib.Quest.requiredLevel(2), 20, "second scalar comes from the installed row")
  equal(metadataCalls["X-Quest-2-S"], 1, "second scalar performs no metadata lookup")
  equal(deserializeCalls, 1, "second scalar performs no decode")

  equal(Lib.Quest.triggerEnd(2), nil, "clear presence bit returns the table default")
  equal(metadataCalls["X-Quest-2-9"], nil,
    "clear presence bit performs no table metadata lookup")

  local first = Lib.Quest.startedBy(2)
  local second = Lib.Quest.startedBy(2)
  equal(first, { { 123 } }, "present table decodes through its producer")
  check(first ~= second and lib.deepEqual(first, second),
    "cached table producer returns a fresh equal value")
  equal(metadataCalls["X-Quest-2-2"], 1, "warm table read reuses the stored CBOR bytes")
  equal(deserializeCalls, 3, "each present table read performs one fresh CBOR decode")

  C_EncodingUtil.DeserializeCBOR = deserialize
  os.remove(fixturePath)
  client.reset()
end)

--------------------------------------------------------------------------------------------
-- Deprecated constant fields
--------------------------------------------------------------------------------------------

suite("constant-fields", "shared", function()
  local npcMeta = dofile("src/meta/npcMeta.lua")
  local minHealth = npcMeta.keys.minLevelHealth
  local maxHealth = npcMeta.keys.maxLevelHealth

  equal(minHealth, 2, "minLevelHealth keeps its positional index")
  equal(maxHealth, 3, "maxLevelHealth keeps its positional index")
  equal(npcMeta.constantValues[minHealth], 0, "minLevelHealth materializes placeholder 0")
  equal(npcMeta.constantValues[maxHealth], 1, "maxLevelHealth materializes placeholder 1")

  equal(normalize.field(npcMeta, minHealth, 12345), 0,
    "minLevelHealth ignores an obsolete source value")
  equal(normalize.field(npcMeta, maxHealth, 67890), 1,
    "maxLevelHealth ignores an obsolete source value")
  equal(normalize.default(npcMeta, minHealth), 0,
    "minLevelHealth reconstructs from missing storage")
  equal(normalize.default(npcMeta, maxHealth), 1,
    "maxLevelHealth reconstructs its non-zero placeholder from missing storage")
  equal(encode.field(npcMeta, minHealth, 12345), nil,
    "minLevelHealth emits no metadata for a non-zero source value")
  equal(encode.field(npcMeta, maxHealth, 67890), nil,
    "maxLevelHealth emits no metadata for a non-zero source value")
  check(not encode.hasStoredValue(npcMeta, maxHealth, 1),
    "Verification shares Generation's constant-field omission rule")

  ---Checks every public read form for the deprecated health placeholders.
  ---@param Lib table Loaded QuestieDB namespace.
  ---@param label string Read mode shown in assertion failures.
  ---@return nil
  local function checkHealthPlaceholders(Lib, label)
    equal(Lib.Npc.minLevelHealth(30), 0, label .. ": named minimum health is the placeholder")
    equal(Lib.Npc.maxLevelHealth(30), 1, label .. ": named maximum health is the placeholder")
    equal(Lib.Npc.Get(30, "minLevelHealth"), 0, label .. ": Get returns minimum placeholder")
    equal(Lib.Npc.Get(30, "maxLevelHealth"), 1, label .. ": Get returns maximum placeholder")
    equal(Lib.Npc.GetByIndex(30, minHealth), 0,
      label .. ": GetByIndex returns minimum placeholder")
    equal(Lib.Npc.GetByIndex(30, maxHealth), 1,
      label .. ": GetByIndex returns maximum placeholder")
    equal(Lib.Npc.GetRaw(30, "minLevelHealth"), 0,
      label .. ": GetRaw returns minimum placeholder")
    equal(Lib.Npc.GetRaw(30, "maxLevelHealth"), 1,
      label .. ": GetRaw returns maximum placeholder")
    equal(Lib.Npc.GetAll(30, { "minLevelHealth", "maxLevelHealth" }), { 0, 1, n = 2 },
      label .. ": GetAll returns both placeholders")
    equal(Lib.Npc.minLevelHealth(999999999), nil, label .. ": unknown NPC named getter is nil")
    equal(Lib.Npc.Get(999999999, "maxLevelHealth"), nil, label .. ": unknown NPC Get is nil")
    equal(Lib.Npc.GetRaw(999999999, maxHealth), nil, label .. ": unknown NPC GetRaw is nil")
  end

  client.reset()
  client.install({ expansion = "Classic" })
  local source = emulator.loadAddon(config.addonName .. ".toc", config.addonName)
  checkHealthPlaceholders(source, "source")

  source.Corrections.RegisterRuntimeCorrection("ConstantFieldSourceTest", "Npc", "ignored-health",
    function()
      return { [30] = { [minHealth] = 9000, [maxHealth] = {} } }
    end, 10)
  source.Corrections.ApplyRegisteredCorrections("ConstantFieldSourceTest")
  equal(source.Npc.minLevelHealth(30), 0,
    "source: a Dynamic Correction cannot replace the minimum placeholder")
  equal(source.Npc.maxLevelHealth(30), 1,
    "source: a Dynamic Correction cannot delete the maximum placeholder")
  equal(source.GetProvenance("Npc", 30, "minLevelHealth"), source.Corrections.OWNER,
    "source: ignored constant writes do not claim provenance")

  -- A tiny Baked artifact proves conflicting scalar-row slots are unreadable and the
  -- constants reconstruct without generating or checking in a flavor-sized TOC.
  local fixturePath = ".out/test-constant-fields.toc"
  lib.mkdirp(".out")
  local previousManifest = config.correctionManifest
  config.correctionManifest = dofile("src/corrections/manifest.lua")
  local lines = {
    "## Interface: 11508",
    "## X-Flavor: Vanilla",
    "## X-Contract-Version: " .. tostring(config.contractVersion),
    "## X-Quest-IDS: " .. encode.idList({}),
    "## X-Npc-IDS: " .. encode.idList({ 30 }),
    "## X-Npc-30-S: " .. encode.row({ [minHealth] = 9000, [maxHealth] = 9001 }),
    "## X-Item-IDS: " .. encode.idList({}),
    "## X-Object-IDS: " .. encode.idList({}),
    "",
  }
  for _, file in ipairs(config.bakedFileList(config.flavorByName.Vanilla)) do
    lines[#lines + 1] = file
  end
  lib.writeAll(fixturePath, table.concat(lines, "\n") .. "\n")

  client.reset()
  client.install({ expansion = "Classic" })
  emulator.install(config.addonName, emulator.parse(fixturePath))
  local baked = emulator.loadAddon(fixturePath, config.addonName)
  checkHealthPlaceholders(baked, "baked")

  local constantOnlyId = 4999998
  local mixedId = 4999997
  baked.Corrections.RegisterRuntimeCorrection("ConstantFieldTest", "Npc", "ignored-health",
    function()
      return {
        [30] = { [minHealth] = 9000, [maxHealth] = {} },
        [constantOnlyId] = { [minHealth] = 9000, [maxHealth] = 9001 },
        [mixedId] = { [1] = "Synthetic NPC", [minHealth] = 9000, [maxHealth] = 9001 },
      }
    end, 10)
  baked.Corrections.ApplyRegisteredCorrections("ConstantFieldTest")
  equal(baked.Npc.minLevelHealth(30), 0,
    "a Dynamic Correction cannot replace the minimum placeholder")
  equal(baked.Npc.maxLevelHealth(30), 1,
    "a Dynamic Correction cannot delete the maximum placeholder")
  equal(baked.GetProvenance("Npc", 30, "minLevelHealth"), baked.Corrections.OWNER,
    "ignored constant writes do not claim provenance")
  equal(baked.Npc.Exists(constantOnlyId), false,
    "a constant-only Dynamic Correction does not invent an NPC")
  equal(baked.Npc.Get(constantOnlyId, "minLevelHealth"), nil,
    "the ignored constant-only NPC still reads nil")
  equal(baked.Npc.Exists(mixedId), true,
    "a legitimate nonconstant field creates a mixed synthetic NPC")
  equal(baked.Npc.name(mixedId), "Synthetic NPC",
    "the mixed synthetic NPC keeps its nonconstant correction")
  equal(baked.Npc.minLevelHealth(mixedId), 0,
    "the mixed synthetic NPC ignores corrected minimum health")
  equal(baked.Npc.maxLevelHealth(mixedId), 1,
    "the mixed synthetic NPC ignores corrected maximum health")
  equal(baked.GetProvenance("Npc", mixedId, "name"), "ConstantFieldTest",
    "only the mixed NPC's legitimate field claims provenance")
  equal(baked.GetProvenance("Npc", mixedId, "maxLevelHealth"), baked.Corrections.OWNER,
    "the mixed NPC's ignored health field keeps database provenance")

  os.remove(fixturePath)
  config.correctionManifest = previousManifest
  client.reset()
end)

--------------------------------------------------------------------------------------------
-- Negative controls
--------------------------------------------------------------------------------------------
--
-- A check that cannot fail is not a check. Each of these mutates a generated artifact and
-- asserts the failure is caught.

suite("negative-controls", "Vanilla", function()
  local flavor = config.flavorByName.Vanilla
  local sourceToc = config.tocPath(flavor)
  if not lib.fileExists(sourceToc) then
    io.write("  SKIP negative-controls: ", sourceToc, " not generated\n")
    return
  end

  lib.mkdirp(".out/corrupt")
  local original = lib.readAll(sourceToc)

  local function runVerify(content, label)
    lib.writeAll(".out/corrupt/" .. sourceToc, content)
    local command = shellQuote(LUA_BIN) ..
      " verify.lua Vanilla --toc-dir=.out/corrupt --sample=200 --quiet >" .. lib.nullDevice .. " 2>&1"
    local ok, kind, code = lib.execute(command)
    -- Lua 5.1 returns the raw exit status; 5.2+ returns ok, "exit", code.
    local failed
    if type(ok) == "number" then failed = ok ~= 0 else failed = not ok end
    check(failed, "verify.lua accepted a corrupted TOC: " .. label)
  end

  -- 1. A changed scalar inside valid CBOR must be caught.
  local changed, changedCount =
    replaceScalarInRow(original, "Quest", 2, 1, "Definitely Not Sharptalon")
  check(changedCount == 1, "corruption fixture did not apply (changed value)")
  runVerify(changed, "changed quest name")

  -- 2. A deleted scalar row must be caught.
  local deleted, deletedCount = original:gsub("## X%-Quest%-2%-S: [^\n]*\n", "", 1)
  check(deletedCount == 1, "corruption fixture did not apply (deleted row)")
  runVerify(deleted, "deleted quest scalar row")

  -- 3. A truncated compressed ID header must be rejected.
  local truncated, truncatedCount =
    original:gsub("(## X%-Quest%-IDS%-1: [^\n]*)[^\n]\n", "%1\n", 1)
  check(truncatedCount == 1, "corruption fixture did not apply (truncated id header)")
  runVerify(truncated, "truncated id header")

  -- 4. Localization blocks without their format header must not disappear silently.
  local headerless, headerCount = original:gsub(
    "## X%-l10n%-Version: [^\n]*\n", "", 1)
  check(headerCount == 1, "corruption fixture did not apply (deleted l10n header)")
  runVerify(headerless, "localization blocks without a format header")
  local equivalenceOk = lib.execute(shellQuote(LUA_BIN) ..
    " equivalence.lua Vanilla --toc-dir=.out/corrupt --sample=1 --no-self-proof " ..
    "--quiet >" .. lib.nullDevice .. " 2>&1")
  local equivalenceFailed
  if type(equivalenceOk) == "number" then
    equivalenceFailed = equivalenceOk ~= 0
  else
    equivalenceFailed = not equivalenceOk
  end
  check(equivalenceFailed, "equivalence accepted localization blocks without a format header")

  -- 5. A missing chunk part must raise rather than return a short string. Pick the first
  -- eligible key deterministically so this control fails the same field on every run.
  local map = emulator.parse(sourceToc)
  local chunkKey
  for key, value in pairs(map) do
    local partCount = tonumber(value:match("^~(%d+)~$"))
    if partCount and partCount >= 2 and map[key .. "-2"] ~= nil and
       (not chunkKey or key < chunkKey) then
      chunkKey = key
    end
  end
  if chunkKey then
    map[chunkKey .. "-2"] = nil
    client.reset()
    client.install({ expansion = "Classic" })
    emulator.install(config.addonName, map)
    local addon = emulator.loadAddon(sourceToc, config.addonName)
    local ok = pcall(addon.read.baked.getStored, chunkKey)
    check(not ok, "a missing chunk part was silently tolerated")
  else
    check(false, "no chunked value found to corrupt")
  end

  -- Later suites share the client emulator, so restore valid metadata after the intentional
  -- corruption instead of relying on their setup order to replace this global accessor.
  client.reset()
  client.install({ expansion = "Classic" })
  emulator.install(config.addonName, emulator.parse(sourceToc))

  os.remove(".out/corrupt/" .. sourceToc)
end)

--------------------------------------------------------------------------------------------
-- Corrections
--------------------------------------------------------------------------------------------

suite("derived-waypoints", "shared", function()
  dofile("tools/validation/derived-waypoints.test.lua")(check, equal)
end)

suite("localization-overrides", "shared", function()
  dofile("tools/validation/localization-overrides.test.lua")(check, equal)
end)

suite("correction-enums", "shared", function()
  local standalone = dofile("src/corrections/enum/constants.lua")
  local namespace = {}
  local env = setmetatable({
    dofile = function() error("addon constants must not call dofile") end,
    loadfile = function() error("addon constants must not call loadfile") end,
  }, { __index = _G })
  for _, path in ipairs(config.enumFiles) do
    setfenv(assert(loadfile(path)), env)("QuestieDB", namespace)
  end
  equal(namespace.Enum, standalone, "TOC and standalone loading expose the same constants")
  equal(standalone.dropCorrectionKeys, { PSERVER = -2, WOWHEAD = -1 },
    "standalone loading includes the support drop sentinels")
  equal(standalone.byExpansion.Forever.raceKeys.ALL_ALLIANCE, 4294967373,
    "Forever race masks retain values beyond 32 bits")
  equal(standalone.waypointPresets.ALLIANCE_GUNSHIP[5042][1][1], { 61.79, 46.28 },
    "waypoint presets retain area, path, and coordinate nesting")
end)

suite("corrections", "shared", function()
  local runtime = dofile("generator/runtime.lua")
  local flavor = config.flavorByName.Vanilla

  local Lib = runtime.build()
  check(Lib.CorrectionManifest ~= nil, "the correction manifest loaded")
  if not Lib.CorrectionManifest then return end

  -- Expansion gating mirrors QuestieCorrections:Initialize: the four Era fix files apply
  -- unconditionally on every expansion (upstream runs their Load()s ungated and layers
  -- TBC+ fixes on top by floor); ONLY the reputation fixes sit behind `if Questie.IsClassic`.
  -- Classic-gating the four stripped every Era-inherited static out of the TBC+ artifacts —
  -- caught by the cross-implementation differential, invisible to verify/equivalence.
  local ungatedEraFiles = {
    ["Era/classicQuestFixes.lua"] = true, ["Era/classicNPCFixes.lua"] = true,
    ["Era/classicItemFixes.lua"] = true, ["Era/classicObjectFixes.lua"] = true,
  }
  local wotlkNpcSpec
  for _, entry in ipairs(Lib.CorrectionManifest) do
    if ungatedEraFiles[entry.file] then
      equal(entry.expansions, nil, "Era fix file is not expansion-gated: " .. entry.file)
    elseif entry.file == "Era/classicQuestReputationFixes.lua" then
      check(entry.expansions and entry.expansions.Classic == true,
        "reputation fixes stay Classic-gated, per upstream's explicit IsClassic branch")
    elseif entry.file == "Wotlk/wotlkNPCFixes.lua" then
      wotlkNpcSpec = entry
    end
    -- Inherited providers need a source expansion for missing-entity protection. Providers
    -- owned by one exact flavor never participate in cumulative expansion inheritance.
    if entry.static and not entry.generated and not entry.owned then
      check(type(entry.sourceExpansionOrder or entry.minExpansionOrder) == "number",
        "an inherited Static Correction records or implies its source expansion: " .. entry.file)
    end
  end
  check(wotlkNpcSpec ~= nil, "WotLK NPC Correction manifest entry exists")
  if wotlkNpcSpec then
    equal(wotlkNpcSpec.static, { "LoadAutomatics", "Load" },
      "WotLK NPC statics preserve Questie's automatic-then-hand-authored order")
  end

  local registry = Lib.Corrections
  local previousQuestie = rawget(_G, "Questie")
  rawset(_G, "Questie", nil)
  runtime.loadCorrections(Lib, flavor)
  equal(rawget(_G, "Questie"), nil,
    "loading correction files leaves Questie's global unclaimed")

  -- Copied providers borrow a private Questie table and restore the consumer's exact value.
  local consumerQuestie = { marker = "consumer-owned" }
  rawset(_G, "Questie", consumerQuestie)
  local invokedQuestie
  local returned = Lib.CorrectionCompat.Invoke(function()
    invokedQuestie = rawget(_G, "Questie")
    return { icon = Questie.ICON_TYPE_EVENT }
  end)
  equal(returned.icon, 3, "the invocation-scoped shim supplies Questie's icon constants")
  check(invokedQuestie ~= consumerQuestie,
    "a provider sees the private stand-in rather than the consumer's table")
  check(rawget(_G, "Questie") == consumerQuestie,
    "successful invocation restores a pre-existing Questie table by identity")
  equal(consumerQuestie, { marker = "consumer-owned" },
    "the invocation shim does not augment the consumer's Questie table")

  local invokeOk, invokeErr = pcall(Lib.CorrectionCompat.Invoke, function()
    error("correction provider failed", 0)
  end)
  check(not invokeOk and tostring(invokeErr):find("correction provider failed", 1, true) ~= nil,
    "provider errors are rethrown after cleanup")
  check(rawget(_G, "Questie") == consumerQuestie,
    "failed invocation restores a pre-existing Questie table by identity")
  rawset(_G, "Questie", previousQuestie)

  local questieFields = {}
  for _, spec in ipairs(Lib.CorrectionManifest) do
    local content = lib.readAll("src/corrections/" .. spec.file)
    for field in content:gmatch("Questie%.([%a_][%w_]*)") do questieFields[field] = true end
  end
  check(next(questieFields) ~= nil, "copied correction files contain direct Questie references")
  for field in pairs(questieFields) do
    check(Lib.Enum.iconTypes[field] ~= nil,
      "the invocation shim declares directly referenced Questie field " .. field)
  end

  local entries = registry.Select({})
  check(#entries > 0, "corrections registered")

  -- Every registration carries an owner, a datatype, a name and a load order.
  for _, entry in ipairs(entries) do
    check(entry.owner == registry.OWNER, "entry has an owner: " .. tostring(entry.name))
    check(type(entry.datatype) == "string", "entry has a datatype: " .. tostring(entry.name))
    check(type(entry.name) == "string", "entry has a name")
    check(type(entry.loadOrder) == "number", "entry has a load order: " .. tostring(entry.name))
    check(type(entry.func) == "function",
      "correction data is held behind a function, not materialised at load: " .. tostring(entry.name))
  end

  -- Season of Discovery must apply *after* Era's faction fixes. The prototype passed a literal
  -- 70 instead of SoDBaseDynamicOrder, so despite the comment "Sod will always load last" it
  -- applied first. Load-order constants make that unrepresentable; this asserts it.
  local eraDynamic, sodDynamic
  for _, entry in ipairs(entries) do
    if entry.name:find("^Era/") and entry.dynamic then eraDynamic = entry.loadOrder end
    if entry.name:find("^Sod/") and entry.dynamic then sodDynamic = sodDynamic or entry.loadOrder end
  end
  if eraDynamic and sodDynamic then
    check(sodDynamic > eraDynamic,
      ("SoD dynamic corrections must apply after Era's (SoD %s, Era %s)")
        :format(tostring(sodDynamic), tostring(eraDynamic)))
  end

  -- Load-order collisions are reported, not silently overwritten, and both entries survive.
  local before = #registry.Select({ datatype = "Quest", dynamic = false })
  registry.RegisterCorrection("TestOwner", "Quest", "collide-a", function() return {} end, 42)
  registry.RegisterCorrection("TestOwner", "Quest", "collide-b", function() return {} end, 42)
  local after = #registry.Select({ datatype = "Quest", dynamic = false })
  equal(after, before + 2, "a load-order collision keeps both entries")
  local ordered = registry.Select({ owner = "TestOwner", datatype = "Quest", dynamic = false })
  equal(ordered[1].name, "collide-a", "a collision breaks ties on registration order")
  equal(ordered[2].name, "collide-b", "the second registrant applies second")

  -- Withdrawing a correction actually removes it, which the previous merge-only approach
  -- could not do.
  check(registry.UnregisterCorrection("TestOwner", "Quest", "collide-a"), "withdrawal reports success")
  equal(#registry.Select({ owner = "TestOwner", datatype = "Quest", dynamic = false }), 1,
    "a withdrawn correction is gone from the registry")

  -- Deleting a correction and regenerating removes its effect. Applying to a scratch table
  -- with and without one entry is the same observation without a 30-second regeneration.
  local scratch = {}
  registry.RegisterCorrection("TestOwner", "Quest", "scratch", function()
    return { [999001] = { [1] = "Injected Quest" } }
  end, 43)
  registry.ApplyStaticToEntities("Quest", scratch, flavor, "TestOwner")
  equal(scratch[999001] and scratch[999001][1], "Injected Quest", "a Static Correction reaches base data")

  local scratch2 = {}
  registry.UnregisterCorrection("TestOwner", "Quest", "scratch")
  registry.ApplyStaticToEntities("Quest", scratch2, flavor, "TestOwner")
  equal(scratch2[999001], nil, "deleting the correction removes its effect")

  -- Questie prevents an older expansion's Correction from resurrecting an entity removed by
  -- the target expansion. Field 1 is the exception: a named row defines a genuinely missing
  -- entity and may still be created.
  local inheritedField = registry.RegisterCorrection("InheritanceTest", "Quest", "field-only",
    function() return { [999101] = { [5] = 42 } } end, 44)
  inheritedField.sourceExpansionOrder = 1
  local inheritedNamed = registry.RegisterCorrection("InheritanceTest", "Quest", "named",
    function() return { [999102] = { [1] = "Defined Missing Quest", [5] = 42 } } end, 45)
  inheritedNamed.sourceExpansionOrder = 1

  local inheritedTarget = {}
  registry.ApplyStaticToEntities(
    "Quest", inheritedTarget, config.flavorByName.TBC, "InheritanceTest")
  equal(inheritedTarget[999101], nil,
    "an inherited field-only Correction does not create an absent entity")
  equal(inheritedTarget[999102] and inheritedTarget[999102][1], "Defined Missing Quest",
    "an inherited named Correction may create an absent entity")

  local sourceTarget = {}
  registry.ApplyStaticToEntities(
    "Quest", sourceTarget, config.flavorByName.Vanilla, "InheritanceTest")
  equal(sourceTarget[999101] and sourceTarget[999101][5], 42,
    "a same-expansion Correction keeps normal entity creation")

  local explicitNoNew = {}
  registry.MergeInto(explicitNoNew, {
    [999103] = { [5] = 42 },
    [999104] = { [1] = "Named Merge Exception" },
  }, { noNewEntries = true })
  equal(explicitNoNew[999103], nil, "noNewEntries skips an unnamed absent entity")
  equal(explicitNoNew[999104], nil, "noNewEntries also skips a named absent entity")

  -- The delete idiom: an empty table reads back as nil, so writing {} clears a field.
  local meta = Lib.Meta.Quest
  equal(Lib.Meta.normalize.field(meta, meta.keys.preQuestSingle, {}), nil,
    "a correction setting a table field to {} clears it")

  -- Static-only correction files are excluded from the shipped artifact.
  local baked = config.bakedFileList(flavor)
  local bakedSet = {}
  for _, file in ipairs(baked) do bakedSet[file] = true end
  local staticOnly, shipped = 0, 0
  for _, spec in ipairs(Lib.CorrectionManifest) do
    if not (spec.dynamic and #spec.dynamic > 0) then
      staticOnly = staticOnly + 1
      if bakedSet["src/corrections/" .. spec.file] then shipped = shipped + 1 end
    end
  end
  check(staticOnly > 0, "there are static-only correction files to exclude")
  equal(shipped, 0, "no static-only correction file is listed in a baked artifact")

  -- Expansion-varying constants. Upstream evaluates these under the client's expansion flags
  -- (QuestieDB.lua:122-150 raceKeys, :178-191 classKeys; npcDB.lua:63-75 npcFlags). They exist
  -- only under byExpansion so no caller can silently mistake Classic for a shared baseline.
  local enum = Lib.Enum
  check(enum.byExpansion ~= nil, "the enum carries per-expansion constants")
  equal(enum.classKeys, nil, "expansion-varying classKeys has no ambiguous flat value")
  equal(enum.raceKeys, nil, "expansion-varying raceKeys has no ambiguous flat value")
  equal(enum.npcFlags, nil, "expansion-varying npcFlags has no ambiguous flat value")

  local classic = enum.byExpansion.Classic
  equal(classic.raceKeys.ALL_ALLIANCE, 77, "Classic ALL_ALLIANCE per QuestieDB.lua")
  equal(classic.raceKeys.ALL_HORDE, 178, "Classic ALL_HORDE per QuestieDB.lua")
  equal(enum.byExpansion.TBC.raceKeys.ALL_ALLIANCE, 1101, "TBC ALL_ALLIANCE per QuestieDB.lua")
  equal(enum.byExpansion.TBC.raceKeys.ALL_HORDE, 690, "TBC ALL_HORDE per QuestieDB.lua")
  equal(enum.byExpansion.Cata.raceKeys.ALL_ALLIANCE, 2098253, "Cata ALL_ALLIANCE adds Worgen")
  equal(classic.npcFlags.REPAIR, 16384, "Classic REPAIR keeps the Era value")
  equal(enum.byExpansion.TBC.npcFlags.REPAIR, 4096, "TBC REPAIR per npcDB.lua IsClassic branch")
  equal(enum.byExpansion.Wotlk.npcFlags.BARBER, 33554432, "BARBER exists from Wotlk")
  equal(classic.npcFlags.BARBER, nil, "BARBER is absent on Classic")

  -- Upstream's Classic branch now returns faction-neutral 1503. The generator mechanically
  -- extracts that branch unchanged; there is no local faction normalization.
  local classicClassKeys = classic.classKeys
  local classicAllClasses = classicClassKeys.ALL_CLASSES
  equal(classicAllClasses, 1503, "Classic ALL_CLASSES is mechanically extracted upstream")
  check(math.floor(classicAllClasses / classicClassKeys.PALADIN) % 2 == 1,
    "Classic ALL_CLASSES includes Paladin")
  check(math.floor(classicAllClasses / classicClassKeys.SHAMAN) % 2 == 1,
    "Classic ALL_CLASSES includes Shaman")
  equal(enum.byExpansion.TBC.classKeys.ALL_CLASSES, 1503, "TBC ALL_CLASSES remains 1503")
  equal(enum.byExpansion.Wotlk.classKeys.ALL_CLASSES, 1535, "WotLK ALL_CLASSES remains 1535")
  equal(enum.byExpansion.Cata.classKeys.ALL_CLASSES, 1535, "Cata ALL_CLASSES remains 1535")
  equal(enum.byExpansion.MoP.classKeys.ALL_CLASSES, 2047, "MoP ALL_CLASSES remains 2047")

  -- Exercise compat directly for every supported flavor. Literal expectations keep expansion
  -- selection independent from the generated table being tested.
  local compatCases = {
    { flavor = config.flavorByName.Vanilla, allClasses = 1503, alliance = 77, repair = 16384 },
    { flavor = config.flavorByName.TBC, allClasses = 1503, alliance = 1101, repair = 4096 },
    { flavor = config.flavorByName.Wrath, allClasses = 1535, alliance = 1101, repair = 4096 },
    { flavor = config.flavorByName.Cata, allClasses = 1535, alliance = 2098253, repair = 4096 },
    { flavor = config.flavorByName.Mists, allClasses = 2047, alliance = 18875469, repair = 4096 },
  }
  local questieLoaderBeforeCompat = rawget(_G, "QuestieLoader")
  for _, case in ipairs(compatCases) do
    local remove = Lib.CorrectionCompat.Install(case.flavor)
    local selected = Lib.CorrectionCompat.modules.QuestieDB
    equal(selected.classKeys.ALL_CLASSES, case.allClasses,
      "compat serves " .. case.flavor.name .. " ALL_CLASSES")
    equal(selected.raceKeys.ALL_ALLIANCE, case.alliance,
      "compat serves " .. case.flavor.name .. " race masks")
    equal(selected.npcFlags.REPAIR, case.repair,
      "compat serves " .. case.flavor.name .. " npc flags")
    check(Lib.CorrectionCompat.modules.ZoneDB.zoneIDs == enum.zoneIDs,
      "compat serves shared invariant constants from the top level for " .. case.flavor.name)
    remove()
  end
  check(rawget(_G, "QuestieLoader") == questieLoaderBeforeCompat,
    "direct compat selection restores the previous loader")

  -- Installation requires an explicit supported flavor rather than silently inheriting Classic.
  local nilFlavorOk, nilFlavorError = pcall(Lib.CorrectionCompat.Install, nil)
  check(not nilFlavorOk and tostring(nilFlavorError):find("explicit flavor", 1, true) ~= nil,
    "compat refuses a missing flavor rather than defaulting to Classic")
  local unsupportedOk, unsupportedError = pcall(
    Lib.CorrectionCompat.Install, { name = "Future", expansion = "Future" })
  check(not unsupportedOk and tostring(unsupportedError):find("unsupported flavor", 1, true) ~= nil,
    "compat refuses an unsupported flavor rather than defaulting to Classic")

  local corrections = dofile("generator/corrections.lua")

  -- Pinned Questie applies WotLK's automatic NPC rows first and the hand-authored Load()
  -- second. NPC 30208 exists in both: the automatic set adds a spawn, then Load() deletes it.
  -- This real overlap catches a manifest that lists both valid functions in the wrong order.
  local wrath = config.flavorByName.Wrath
  local wrathContext = corrections.prepare(wrath)
  local wrathNpcs = { [30208] = { [1] = "Stormforged Ambusher" } }
  wrathContext.lib.Corrections.ApplyStaticToEntities(
    "Npc", wrathNpcs, wrath, wrathContext.lib.Corrections.OWNER)
  local finalSpawns = wrathNpcs[30208][7]
  check(type(finalSpawns) == "table" and next(finalSpawns) == nil,
    "WotLK hand-authored NPC spawn deletion wins over LoadAutomatics")

  -- Exercise the shipped source-mode load order, including _begin.lua, _end.lua, and the
  -- initial correction application in api.lua. Questie must be free to claim its own global
  -- immediately afterwards, while deferred providers must still resolve their icon constants.
  client.reset()
  client.install({ expansion = "Classic" })
  local sourceLib = emulator.loadAddon(config.addonName .. ".toc", config.addonName)
  local objectives = sourceLib.Quest.Get(28, "objectives")
  equal(objectives and objectives[2] and objectives[2][1] and objectives[2][1][3], 3,
    "source-mode corrections still resolve Questie's event icon")
  equal(rawget(_G, "Questie"), nil,
    "loading the QuestieDB addon leaves no Questie compatibility global")
  client.reset()

  -- Packaging invokes surviving Dynamic providers to compare staged and original behavior.
  -- Cata's faction provider reads an icon constant, so this catches any packaging path that
  -- bypasses the same invocation scope used by the runtime registry.
  local stripStage = ".out/test-strip-static/QuestieDB"
  testFiles.removeTree(stripStage)
  lib.mkdirp(stripStage .. "/src/corrections/Cata")
  lib.copyFile("src/corrections/Cata/cataQuestFixes.lua",
    stripStage .. "/src/corrections/Cata/cataQuestFixes.lua")
  check(commandSucceeded(shellQuote(LUA_BIN) .. " tools/distribution/strip-static.lua " ..
    shellQuote(stripStage) .. " --quiet"),
    "package stripping invokes copied providers through the scoped Questie shim")
  testFiles.removeTree(stripStage)
end)

--------------------------------------------------------------------------------------------
-- Derived requiredRaces compatibility
--------------------------------------------------------------------------------------------

suite("sod-required-races", "shared", function()
  dofile("tools/validation/sod-required-races.test.lua")(check, equal, "Source")
end)

suite("derived-required-races", "shared", function()
  local runtime = dofile("generator/runtime.lua")
  local Lib = runtime.build()
  local inference = Lib.DerivedRequiredRaces
  local questKeys = Lib.Meta.Quest.keys
  local npcKeys = Lib.Meta.Npc.keys

  ---Builds the ordinary Derived Pass context around literal synthetic rows.
  ---@param quests table<integer, table>
  ---@param npcs table<integer, table>
  ---@param flavor table
  ---@return RequiredRacesDerivedContext context
  local function inferenceContext(quests, npcs, flavor)
    ---@param entityType string
    ---@return table? entities
    local function entities(entityType)
      if entityType == "Quest" then return quests end
      if entityType == "Npc" then return npcs end
      return nil
    end

    ---@param entityType string
    ---@return table? meta
    local function meta(entityType)
      return Lib.Meta[entityType]
    end

    return { flavor = flavor, entities = entities, meta = meta }
  end

  check(type(inference.ApplyQuestieCompatibility) == "function",
    "the Questie compatibility function is published")
  check(type(inference.ApplyCorrectedInference) == "function",
    "the corrected conservative function is published")

  local registered
  local correctedRegistered = false
  for _, pass in ipairs(Lib.Derived.Select("Quest")) do
    if pass.name == "requiredRaces:questieCompatibility" then registered = pass end
    if pass.run == inference.ApplyCorrectedInference then correctedRegistered = true end
  end
  check(registered ~= nil, "the requiredRaces compatibility pass is registered")
  if registered then
    equal(registered.reads, { "Quest", "Npc" },
      "the compatibility pass declares its cross-entity inputs")
    equal(registered.order, 50, "requiredRaces has the declared order before waypoint passes")
    check(registered.run == inference.ApplyQuestieCompatibility,
      "registration uses the exact Questie transcription")
  end
  equal(correctedRegistered, false, "the corrected policy remains deliberately unregistered")

  -- These rows make Questie's permissive guesses visible. The opposite-faction object and
  -- item starters prove the loop reads startedBy[1], while sparse creature evidence proves it
  -- retains upstream's `pairs` iteration rather than silently becoming `ipairs`.
  local questieQuests = {
    [1001] = { [questKeys.startedBy] = { { 1 } } },
    [1002] = { [questKeys.startedBy] = { { 1 } }, [questKeys.requiredRaces] = 0 },
    [1003] = { [questKeys.startedBy] = { { 1, 999 } } },
    [1004] = { [questKeys.startedBy] = { { 1 }, { 2 } } },
    [1005] = { [questKeys.startedBy] = { { 1 }, nil, { 2 } } },
    [1006] = { [questKeys.startedBy] = { { 1, 3 } } },
    [1007] = { [questKeys.startedBy] = { { 1, 2 } } },
    [1008] = { [questKeys.startedBy] = { { 1 } }, [questKeys.requiredRaces] = 77 },
    [1009] = { [questKeys.startedBy] = { { 2, 4 } } },
    [1010] = { [questKeys.startedBy] = { { 1, 5 } } },
    [1011] = { [questKeys.startedBy] = { { [2] = 1 } } },
  }
  local npcs = {
    [1] = { [npcKeys.friendlyToFaction] = "H" },
    [2] = { [npcKeys.friendlyToFaction] = "A" },
    [3] = { [npcKeys.friendlyToFaction] = "AH" },
    [4] = { [npcKeys.friendlyToFaction] = "A" },
    [5] = { [npcKeys.friendlyToFaction] = "unknown" },
  }
  inference.ApplyQuestieCompatibility(
    inferenceContext(questieQuests, npcs, config.flavorByName.Vanilla))

  equal(questieQuests[1001][questKeys.requiredRaces], 178,
    "Questie infers Horde from one Horde creature starter")
  equal(questieQuests[1002][questKeys.requiredRaces], 178,
    "Questie overwrites an explicit zero")
  equal(questieQuests[1003][questKeys.requiredRaces], 178,
    "Questie ignores a missing NPC beside Horde evidence")
  equal(questieQuests[1004][questKeys.requiredRaces], 178,
    "Questie ignores an Alliance object starter beside Horde creature evidence")
  equal(questieQuests[1005][questKeys.requiredRaces], 178,
    "Questie ignores an Alliance item starter beside Horde creature evidence")
  equal(questieQuests[1006][questKeys.requiredRaces], nil,
    "an AH starter adds both flags and cancels Horde-only inference")
  equal(questieQuests[1007][questKeys.requiredRaces], nil,
    "mixed Alliance and Horde starters prevent Questie inference")
  equal(questieQuests[1008][questKeys.requiredRaces], 77,
    "Questie preserves every nonzero authored mask")
  equal(questieQuests[1009][questKeys.requiredRaces], 77,
    "unanimous Alliance creature starters infer Alliance")
  equal(questieQuests[1010][questKeys.requiredRaces], 178,
    "Questie ignores an unknown faction value beside Horde evidence")
  equal(questieQuests[1011][questKeys.requiredRaces], 178,
    "Questie reads a sparse creature starter list with pairs")

  local maskCases = {
    { flavor = config.flavorByName.Vanilla, alliance = 77, horde = 178 },
    { flavor = config.flavorByName.TBC, alliance = 1101, horde = 690 },
    { flavor = config.flavorByName.Wrath, alliance = 1101, horde = 690 },
    { flavor = config.flavorByName.Cata, alliance = 2098253, horde = 946 },
    { flavor = config.flavorByName.Mists, alliance = 18875469, horde = 33555378 },
  }
  for _, case in ipairs(maskCases) do
    local quests = {
      [2001] = { [questKeys.startedBy] = { { 1 } } },
      [2002] = { [questKeys.startedBy] = { { 2 } } },
    }
    inference.ApplyQuestieCompatibility(inferenceContext(quests, npcs, case.flavor))
    equal(quests[2001][questKeys.requiredRaces], case.horde,
      case.flavor.name .. " uses its literal ALL_HORDE mask")
    equal(quests[2002][questKeys.requiredRaces], case.alliance,
      case.flavor.name .. " uses its literal ALL_ALLIANCE mask")
  end

  -- The parked policy requires complete, faction-exclusive evidence and preserves explicit
  -- author intent. Side-by-side fixtures make every deliberate divergence reviewable.
  local correctedQuests = {
    [3001] = { [questKeys.startedBy] = { { 1 } } },
    [3002] = { [questKeys.startedBy] = { { 1 } }, [questKeys.requiredRaces] = 0 },
    [3003] = { [questKeys.startedBy] = { { 1, 999 } } },
    [3004] = { [questKeys.startedBy] = { { 1 }, { 2 } } },
    [3005] = { [questKeys.startedBy] = { { 1 }, nil, { 2 } } },
    [3006] = { [questKeys.startedBy] = { { 1, 3 } } },
    [3007] = { [questKeys.startedBy] = { { 1, 2 } } },
    [3008] = { [questKeys.startedBy] = { { 1 } }, [questKeys.requiredRaces] = 77 },
    [3009] = { [questKeys.startedBy] = { { 2, 4 } } },
    [3010] = { [questKeys.startedBy] = { { 1, 5 } } },
  }
  inference.ApplyCorrectedInference(
    inferenceContext(correctedQuests, npcs, config.flavorByName.Vanilla))

  equal(correctedQuests[3001][questKeys.requiredRaces], 178,
    "corrected policy infers from complete Horde evidence")
  equal(correctedQuests[3002][questKeys.requiredRaces], 0,
    "corrected policy preserves an explicit zero")
  equal(correctedQuests[3003][questKeys.requiredRaces], nil,
    "corrected policy refuses unresolved creature starters")
  equal(correctedQuests[3004][questKeys.requiredRaces], nil,
    "corrected policy refuses an object access path")
  equal(correctedQuests[3005][questKeys.requiredRaces], nil,
    "corrected policy refuses an item access path")
  equal(correctedQuests[3006][questKeys.requiredRaces], nil,
    "corrected policy refuses an AH starter")
  equal(correctedQuests[3007][questKeys.requiredRaces], nil,
    "corrected policy refuses mixed factions")
  equal(correctedQuests[3008][questKeys.requiredRaces], 77,
    "corrected policy preserves a nonzero mask")
  equal(correctedQuests[3009][questKeys.requiredRaces], 77,
    "corrected policy accepts unanimous resolved Alliance starters")
  equal(correctedQuests[3010][questKeys.requiredRaces], nil,
    "corrected policy refuses an unknown faction value")

  -- Dependency expansion is generic rather than coupled to requiredRaces. The synthetic chain
  -- proves transitive closure and flavor gating without modifying the runtime registry above.
  local dependencyRegistry = dofile("src/derived/registry.lua")
  ---@return nil
  local function noOpPass() end
  -- Reverse dependency order forces expansion to revisit earlier passes. A single scan can
  -- discover Npc from Quest, but cannot reach Item or Object.
  dependencyRegistry.Register({
    name = "test:item-needs-object-in-mop", writes = "Item", reads = { "Item", "Object" },
    expansions = { MoP = true }, run = noOpPass,
  })
  dependencyRegistry.Register({
    name = "test:npc-needs-item", writes = "Npc", reads = { "Npc", "Item" },
    run = noOpPass,
  })
  dependencyRegistry.Register({
    name = "test:quest-needs-npc", writes = "Quest", reads = { "Quest", "Npc" },
    run = noOpPass,
  })

  local requested = { Quest = true }
  equal(dependencyRegistry.ExpandReadDependencies(requested, config.flavorByName.Vanilla),
    { Quest = true, Npc = true, Item = true },
    "dependency expansion reaches a fixed point and honors a closed flavor gate")
  equal(dependencyRegistry.ExpandReadDependencies(requested, config.flavorByName.Mists),
    { Quest = true, Npc = true, Item = true, Object = true },
    "dependency expansion includes a transitive pass active for the flavor")
  equal(requested, { Quest = true }, "dependency expansion does not mutate the output filter")

  local flavorLoader = dofile("generator/flavor.lua")
  local loaded = flavorLoader.load(config.flavorByName.Vanilla, { Quest = true })
  check(loaded.Quest ~= nil, "Quest-only Generation returns the requested Quest output")
  equal(loaded.Npc, nil, "Quest-only Generation does not return its Npc input")
  equal(loaded.Item, nil, "Quest-only Generation does not return unrelated Item data")
  equal(loaded.Object, nil, "Quest-only Generation does not return unrelated Object data")
  equal(loaded.Quest.entities[7162][questKeys.requiredRaces], 77,
    "Quest-only Generation infers quest 7162 from its corrected Npc input")

  -- Raw loading does not run Corrections or Derived Passes, so it needs no dependency inputs.
  local rawRequested = { Quest = true }
  local rawLoaded, rawStats = flavorLoader.load(
    config.flavorByName.Vanilla, rawRequested, false)
  check(rawLoaded.Quest ~= nil, "raw Quest-only loading returns the requested Quest output")
  equal(rawLoaded.Npc, nil, "raw Quest-only loading does not load or return Npc data")
  equal(rawLoaded.Item, nil, "raw Quest-only loading does not return Item data")
  equal(rawLoaded.Object, nil, "raw Quest-only loading does not return Object data")
  equal(rawStats.applied, 0, "raw Quest-only loading applies no Static Corrections")
  equal(rawStats.derived, nil, "raw Quest-only loading runs no Derived Passes")
  equal(rawLoaded.Quest.entities[7162][questKeys.requiredRaces], 0,
    "raw Quest-only loading preserves quest 7162's zero requiredRaces value")
  equal(rawRequested, { Quest = true }, "raw loading does not mutate the output filter")

  client.reset()
  client.install({ expansion = "Classic" })
  local sourceLib = emulator.loadAddon(config.addonName .. ".toc", config.addonName)
  equal(sourceLib.Quest.Get(7162, "requiredRaces"), 77,
    "Source mode infers quest 7162 through the registered pass")
  check(sourceLib.read.source.entities.Npc ~= nil,
    "Source mode materializes the declared Npc dependency before inference")
  client.reset()

  local shipsRequiredRaces = false
  for _, path in ipairs(config.bakedFileList(config.flavorByName.Vanilla)) do
    if path == "src/derived/requiredRaces.lua" then shipsRequiredRaces = true end
  end
  equal(shipsRequiredRaces, false, "baked clients do not rerun the materialized pass")
end)

--------------------------------------------------------------------------------------------
-- Correction Overlay
--------------------------------------------------------------------------------------------

suite("overlay", "Vanilla", function()
  local tocPath = config.tocPath(config.flavorByName.Vanilla)
  if not lib.fileExists(tocPath) then
    io.write("  SKIP overlay: ", tocPath, " not generated\n")
    return
  end

  client.reset()
  client.install({ expansion = "Classic" })
  emulator.install(config.antiCollision or config.addonName, emulator.parse(tocPath))
  local Lib = emulator.loadAddon(tocPath, config.addonName)
  local registry = Lib.Corrections
  local Quest = Lib.Quest

  local id = Quest.GetAllIds()[1]
  local baseName = Quest.GetRaw(id, "name")
  check(type(baseName) == "string", "picked a quest with a name")

  -- Reads resolve through the overlay first and fall back to base data.
  registry.RegisterRuntimeCorrection("AddonA", "Quest", "rename",
    function() return { [id] = { [1] = "Renamed by A" } } end, 10)
  registry.ApplyRegisteredCorrections("AddonA")
  equal(Quest.Get(id, "name"), "Renamed by A", "a Dynamic Correction wins over base data")
  equal(Quest.GetRaw(id, "name"), baseName, "GetRaw bypasses the overlay")
  equal(Quest.name(id), "Renamed by A", "the named getter resolves through the overlay too")

  -- Cached values are invalidated when the composed view changes: the read above populated
  -- the cache, and this one must not serve it.
  registry.RegisterRuntimeCorrection("AddonA", "Quest", "rename2",
    function() return { [id] = { [1] = "Renamed again" } } end, 11)
  registry.ApplyRegisteredCorrections("AddonA")
  equal(Quest.Get(id, "name"), "Renamed again", "re-applying invalidates the cached value")

  -- Idempotent by construction: recomposition rebuilds from the registry rather than
  -- accumulating into it.
  registry.ApplyRegisteredCorrections("AddonA")
  registry.ApplyRegisteredCorrections("AddonA")
  equal(Quest.Get(id, "name"), "Renamed again", "re-applying repeatedly is idempotent")

  -- Precedence across owners: the later-RANKED owner wins, and rank is first-apply order.
  registry.RegisterRuntimeCorrection("AddonB", "Quest", "rename",
    function() return { [id] = { [1] = "Renamed by B" } } end, 1)
  registry.ApplyRegisteredCorrections("AddonB")
  equal(Quest.Get(id, "name"), "Renamed by B",
    "the later-ranked owner wins, regardless of load order within owners")
  equal(registry.GetProvenance("Quest", id, "name"), "AddonB", "provenance names the winning owner")

  -- Applying one owner does not disturb another, and re-applying never changes rank: owner
  -- precedence is fixed at first apply, so a state refresh cannot hoist an early layer above
  -- corrections registered later.
  registry.RegisterRuntimeCorrection("AddonA", "Quest", "level",
    function() return { [id] = { [4] = 42 } } end, 12)
  registry.ApplyRegisteredCorrections("AddonA")
  equal(Quest.Get(id, "requiredLevel"), 42, "A's correction applies")
  equal(Quest.Get(id, "name"), "Renamed by B",
    "A re-applying refreshes in place — B keeps the contested field")
  equal(registry.GetProvenance("Quest", id, "name"), "AddonB",
    "provenance still names B after A's refresh")
  registry.ApplyRegisteredCorrections("AddonB")
  equal(Quest.Get(id, "name"), "Renamed by B", "B re-applying changes nothing")
  equal(Quest.Get(id, "requiredLevel"), 42, "B's apply did not disturb A's uncontested field")

  -- A QuestieDB-side refresh must leave every consumer layer's precedence intact.
  local ownersBefore = table.concat(registry.GetOwners(), "<")
  registry.ApplyRegisteredCorrections(registry.OWNER)
  equal(table.concat(registry.GetOwners(), "<"), ownersBefore,
    "a QuestieDB refresh does not reorder owners")
  equal(Quest.Get(id, "name"), "Renamed by B",
    "a QuestieDB refresh does not reclaim consumer-corrected fields")

  -- Base data is never written to at runtime, in either read mode.
  equal(Quest.GetRaw(id, "name"), baseName, "base data is untouched by the overlay")
  equal(Quest.GetRaw(id, "requiredLevel"), Quest.GetRaw(id, "requiredLevel"),
    "GetRaw is stable")

  -- A withdrawn correction disappears on the next recomposition.
  registry.UnregisterCorrection("AddonB", "Quest", "rename")
  registry.ApplyRegisteredCorrections("AddonB")
  equal(Quest.Get(id, "name"), "Renamed again", "withdrawing B's correction hands the field back to A")
  registry.UnregisterCorrection("AddonA", "Quest", "rename")
  registry.UnregisterCorrection("AddonA", "Quest", "rename2")
  registry.ApplyRegisteredCorrections("AddonA")
  equal(Quest.Get(id, "name"), baseName, "withdrawing every correction falls back to base data")

  -- Within one owner, a later correction overrides an earlier one on the same field.
  registry.RegisterRuntimeCorrection("AddonA", "Quest", "clear",
    function() return { [id] = { [4] = 0 } } end, 13)
  registry.ApplyRegisteredCorrections("AddonA")
  equal(Quest.Get(id, "requiredLevel"), 0,
    "a later correction within an owner overrides an earlier one")

  -- Debug mode reports one owner overriding another.
  local logged = {}
  local realPrint = print
  _G.print = function(message) logged[#logged + 1] = tostring(message) end
  registry.debug = true
  registry.RegisterRuntimeCorrection("AddonB", "Quest", "clash",
    function() return { [id] = { [4] = 7 } } end, 1)
  registry.ApplyRegisteredCorrections("AddonB")
  registry.debug = false
  _G.print = realPrint
  local found = false
  for _, message in ipairs(logged) do
    if message:find('overrode') and message:find("AddonA") then found = true end
  end
  check(found, "debug mode reports when one owner overrides another on the same field")

  -- Order within an owner: higher loadOrder applies later and wins.
  registry.RegisterRuntimeCorrection("AddonC", "Quest", "low",
    function() return { [id] = { [5] = 1 } } end, 1)
  registry.RegisterRuntimeCorrection("AddonC", "Quest", "high",
    function() return { [id] = { [5] = 2 } } end, 100)
  registry.ApplyRegisteredCorrections("AddonC")
  equal(Quest.Get(id, "questLevel"), 2, "within an owner, the higher load order wins")

  -- `[key] = {}` is the delete idiom for EVERY field type, matching MergeInto's doc. A
  -- deleted string reads nil; a deleted number falls to the existence-gated default 0; a
  -- deleted table reads nil.
  local otIndex = Lib.Meta.Quest.keys.objectivesText
  registry.RegisterRuntimeCorrection("AddonD", "Quest", "deletes",
    function() return { [id] = { [1] = {}, [4] = {}, [otIndex] = {} } } end, 10)
  registry.ApplyRegisteredCorrections("AddonD")
  equal(Quest.Get(id, "name"), nil, "{} deletes a string field through the overlay")
  equal(Quest.Get(id, "requiredLevel"), 0, "{} deletes a number field - reads the 0 default")
  equal(Quest.Get(id, "objectivesText"), nil, "{} deletes a table field")
  equal(type(Quest.questLevel(id)), "number", "scalar named getters never leak tables")

  -- A NON-empty table on a scalar-typed field is a correction-author error: reported and
  -- dropped, never stored, never raised out of recomposition.
  local reported = {}
  local savedPrint = print
  _G.print = function(message) reported[#reported + 1] = tostring(message) end
  registry.RegisterRuntimeCorrection("AddonD", "Quest", "bad-scalar",
    function() return { [id] = { [5] = { 60 } } } end, 11)
  registry.ApplyRegisteredCorrections("AddonD")
  _G.print = savedPrint
  equal(Quest.Get(id, "questLevel"), 2, "a table written to a number field is dropped, not stored")
  local badReported = false
  for _, message in ipairs(reported) do
    if message:find("wrote a table") and message:find("AddonD") then badReported = true end
  end
  check(badReported, "the dropped scalar-table write is reported to the author")
  registry.UnregisterCorrection("AddonD", "Quest", "deletes")
  registry.UnregisterCorrection("AddonD", "Quest", "bad-scalar")
  registry.ApplyRegisteredCorrections("AddonD")

  -- Entry-level expansion filters compose in Baked mode too (recompose now resolves the
  -- flavor from LibQuestieDB.flavor, which both modes publish; it used to read only the
  -- Source backend and passed everything in Baked mode).
  local gated = registry.RegisterRuntimeCorrection("AddonE", "Quest", "tbc-only",
    function() return { [id] = { [5] = 90 } } end, 10)
  gated.expansions = { TBC = true }
  local passing = registry.RegisterRuntimeCorrection("AddonE", "Quest", "era-only",
    function() return { [id] = { [4] = 91 } } end, 11)
  passing.expansions = { Classic = true }
  registry.ApplyRegisteredCorrections("AddonE")
  check(Quest.Get(id, "questLevel") ~= 90, "a TBC-gated entry is filtered on baked Vanilla")
  equal(Quest.Get(id, "requiredLevel"), 91, "a Classic-gated entry applies on baked Vanilla")
  registry.UnregisterCorrection("AddonE", "Quest", "tbc-only")
  registry.UnregisterCorrection("AddonE", "Quest", "era-only")
  registry.ApplyRegisteredCorrections("AddonE")

  -- Future numeric localization fields must retain their schema default when neither the
  -- active locale nor the Scalar row stores a value.
  local zeroDefaultId, zeroDefaultField
  for fieldIndex = 1, Quest.meta.fieldCount do
    if Quest.meta.types[fieldIndex] == "number" then
      for _, questId in ipairs(Quest.GetAllIds()) do
        if Quest.GetRaw(questId, fieldIndex) == 0 then
          zeroDefaultId, zeroDefaultField = questId, fieldIndex
          break
        end
      end
    end
    if zeroDefaultId then break end
  end
  check(zeroDefaultId ~= nil, "found a quest with an omitted numeric default")
  Quest.SetL10nProvider(function() return nil end,
    { [zeroDefaultField] = true }, function() return true end)
  equal(Quest.Get(zeroDefaultId, zeroDefaultField), 0,
    "an untranslated numeric scalar settles through missingScalar")

  client.reset()
end)

--------------------------------------------------------------------------------------------
-- Data-shaped corrections: Set
--------------------------------------------------------------------------------------------

suite("set-corrections", "Vanilla", function()
  local tocPath = config.tocPath(config.flavorByName.Vanilla)
  if not lib.fileExists(tocPath) then
    io.write("  SKIP set-corrections: ", tocPath, " not generated\n")
    return
  end

  client.reset()
  client.install({ expansion = "Classic" })
  emulator.install(config.antiCollision or config.addonName, emulator.parse(tocPath))
  local Lib = emulator.loadAddon(tocPath, config.addonName)
  local registry = Lib.Corrections
  local Quest = Lib.Quest
  local Item = Lib.Item

  local id = Quest.GetAllIds()[1]
  local baseName = Quest.GetRaw(id, "name")
  check(type(baseName) == "string", "picked a quest with a name")

  -- Write-through: visible immediately, no Apply call, GetRaw untouched.
  local registrar = Lib.GetRegistrar("SetOwnerA")
  check(registrar.Set("Quest", "rename", { [id] = { [1] = "Set by A" } }) == true, "Set reports a change")
  equal(Quest.Get(id, "name"), "Set by A", "a Set correction is visible without an explicit apply")
  equal(Quest.GetRaw(id, "name"), baseName, "GetRaw bypasses a Set correction")
  equal(registry.GetProvenance("Quest", id, "name"), "SetOwnerA", "provenance names the Set owner")

  -- A slot replaces in place rather than accumulating.
  registrar.Set("Quest", "rename", { [id] = { [4] = 42 } })
  equal(Quest.Get(id, "name"), baseName, "rewriting a slot withdraws its previous rows")
  equal(Quest.Get(id, "requiredLevel"), 42, "the rewritten slot's rows are visible")

  -- {} keeps the slot but contributes nothing; nil removes it.
  registrar.Set("Quest", "rename", {})
  equal(Quest.Get(id, "requiredLevel"), Quest.GetRaw(id, "requiredLevel"), "{} rows contribute nothing")
  check(registrar.Set("Quest", "rename", nil) == true, "removing an existing slot reports a change")
  check(registrar.Set("Quest", "rename", nil) == false, "removing an absent slot is a no-op")

  -- Withdrawal hands a contested field back to the layer underneath, across owners.
  registrar.Set("Quest", "rename", { [id] = { [1] = "Set by A" } })
  local registrarB = Lib.GetRegistrar("SetOwnerB")
  registrarB.Set("Quest", "rename", { [id] = { [1] = "Set by B" } })
  equal(Quest.Get(id, "name"), "Set by B", "the later-ranked owner wins the contested field")
  registrarB.Set("Quest", "rename", nil)
  equal(Quest.Get(id, "name"), "Set by A", "withdrawing B hands the field back to A")
  registrar.Set("Quest", "rename", nil)
  equal(Quest.Get(id, "name"), baseName, "withdrawing every slot falls back to base data")

  -- Owner rank is fixed at the first write: re-Setting an early owner cannot hoist it.
  registrar.Set("Quest", "rank", { [id] = { [4] = 1 } })
  registrarB.Set("Quest", "rank", { [id] = { [4] = 2 } })
  registrar.Set("Quest", "rank", { [id] = { [4] = 3 } })
  equal(Quest.Get(id, "requiredLevel"), 2, "re-Setting an earlier owner does not hoist it above a later one")
  registrar.Set("Quest", "rank", nil)
  registrarB.Set("Quest", "rank", nil)

  -- Per-datatype publish: an Item write must not drop Quest caches, ID maps, or Name index.
  registrar.Set("Quest", "adds-entity", { [900000001] = { [1] = "Set-added Quest" } })
  local questMapBefore = Quest.GetAllIds(true)
  local questBucketBefore = Quest.IdsByName("Set-added Quest")
  check(questBucketBefore ~= nil, "the Name index sees a Set-added entity")
  registrar.Set("Item", "unrelated", { [6948] = { [1] = "Hearthstone (set)" } })
  check(Quest.GetAllIds(true) == questMapBefore, "an Item write keeps the Quest ID map's identity")
  check(Quest.IdsByName("Set-added Quest") == questBucketBefore, "an Item write keeps the Quest Name index")
  equal(Item.Get(6948, "name"), "Hearthstone (set)", "the Item write itself is visible")
  registrar.Set("Item", "unrelated", nil)
  registrar.Set("Quest", "adds-entity", nil)

  -- Memoization: another owner's function provider is not re-run by a Set, only by its own apply.
  local providerRuns = 0
  local fnOwner = Lib.GetRegistrar("SetSuiteFnOwner")
  fnOwner.RegisterRuntimeCorrection("Quest", "counted", function()
    providerRuns = providerRuns + 1
    return { [id] = { [5] = 55 } }
  end, 10)
  fnOwner.Apply()
  equal(providerRuns, 1, "the provider ran on its own apply")
  registrar.Set("Quest", "poke", { [id] = { [4] = 9 } })
  equal(providerRuns, 1, "another owner's Set reuses the memoized materialization")
  equal(Quest.Get(id, "questLevel"), 55, "the memoized layer still composes")
  fnOwner.Apply()
  equal(providerRuns, 2, "the owner's own re-apply re-runs its provider")
  registrar.Set("Quest", "poke", nil)
  registry.UnregisterCorrection("SetSuiteFnOwner", "Quest", "counted")
  registry.ApplyRegisteredCorrections("SetSuiteFnOwner")

  -- Write-through owners never linger pending: a no-arg apply finds nothing and drops nothing.
  local mapBeforeNoArg = Quest.GetAllIds(true)
  equal(registry.ApplyRegisteredCorrections(), 0, "no owner is left pending after write-through Sets")
  check(Quest.GetAllIds(true) == mapBeforeNoArg, "a no-arg apply with nothing pending drops no caches")

  -- Apply republishes only the owner's datatypes, and a bare registration republishes nothing.
  local scopeOwner = Lib.GetRegistrar("SetSuiteScopeOwner")
  scopeOwner.RegisterRuntimeCorrection("Quest", "scoped", function() return { [id] = { [4] = 11 } } end, 10)
  local itemMapBefore = Item.GetAllIds(true)
  scopeOwner.Apply()
  check(Item.GetAllIds(true) == itemMapBefore, "an owner's apply keeps other datatypes' ID maps")
  equal(Quest.Get(id, "requiredLevel"), 11, "the applied datatype recomposed")

  local lurker = Lib.GetRegistrar("SetSuiteLurker")
  lurker.RegisterRuntimeCorrection("Quest", "unapplied", function() return { [id] = { [4] = 77 } } end, 10)
  local questMapAfterApply = Quest.GetAllIds(true)
  registrar.Set("Item", "poke-item", { [6948] = { [1] = "Hearthstone (poked)" } })
  check(Quest.GetAllIds(true) == questMapAfterApply,
    "an unapplied registration does not make another owner's write republish its datatype")
  check(Quest.Get(id, "requiredLevel") ~= 77, "an unapplied registration stays uncomposed")
  registrar.Set("Item", "poke-item", nil)
  registry.UnregisterCorrection("SetSuiteScopeOwner", "Quest", "scoped")
  registry.ApplyRegisteredCorrections("SetSuiteScopeOwner")

  -- Guard rails.
  check(not pcall(function() registrar.Set("Quest", "bad", 5) end), "non-table rows are rejected")
  check(not pcall(function() registrar.Set("Quest", "", {}) end), "an empty slot name is rejected")
  fnOwner.RegisterRuntimeCorrection("Quest", "fn-slot", function() return {} end, 11)
  check(not pcall(function() Lib.Corrections.Set("SetSuiteFnOwner", "Quest", "fn-slot", {}) end),
    "a data write into a function-shaped slot is refused")
  registry.UnregisterCorrection("SetSuiteFnOwner", "Quest", "fn-slot")
  registry.ApplyRegisteredCorrections("SetSuiteFnOwner")

  -- A Static entry sharing a name is refused on write AND on the nil path — Set must never
  -- delete a Static registration in a data slot's place.
  registry.RegisterCorrection("SetSuiteStaticOwner", "Quest", "static-slot", function() return {} end, 5)
  check(not pcall(function() Lib.Corrections.Set("SetSuiteStaticOwner", "Quest", "static-slot", {}) end),
    "a data write into a Static correction name is refused")
  check(not pcall(function() Lib.Corrections.Set("SetSuiteStaticOwner", "Quest", "static-slot", nil) end),
    "Set(nil) refuses a Static entry rather than removing it")
  equal(#registry.Select({ owner = "SetSuiteStaticOwner", datatype = "Quest", dynamic = false }), 1,
    "the Static entry survives both refusals")
  registry.UnregisterCorrection("SetSuiteStaticOwner", "Quest", "static-slot")

  check(Lib.SetCorrection == Lib.Corrections.Set, "LibQuestieDB.SetCorrection aliases Corrections.Set")

  client.reset()
end)

--------------------------------------------------------------------------------------------
-- Independently owned Forever dataset
--------------------------------------------------------------------------------------------

suite("forever-data", "shared", function()
  -- Dataset checks install generator globals; isolate them from the runtime suites.
  check(commandSucceeded(shellQuote(LUA_BIN) .. " tools/dbc/forever-data.test.lua"),
    "Forever reviewed DBC data and faction-reference self-proof pass")
end)

--------------------------------------------------------------------------------------------
-- Frozen values
--------------------------------------------------------------------------------------------

suite("value-ownership", "Vanilla", function()
  -- ADR 0003 Decision 10, revised: table reads return a FRESH MUTABLE COPY on every read —
  -- the caller owns it outright, exactly matching the compiler semantics Questie's ~290 call
  -- sites were written against. Freezing now guards internal shared structures only
  -- (Source-mode base data), where it still degrades rather than fails.
  local flavor = config.flavorByName.Vanilla
  local tocPath = config.tocPath(flavor)
  if not lib.fileExists(tocPath) then
    io.write("  SKIP value-ownership: ", tocPath, " not generated\n")
    return
  end

  local freezeLib = dofile("emulator/freeze.lua")

  -- The offline freeze substitute itself, still needed for the internal-structure guard.
  local plain = { 1, 2, { 3 } }
  freezeLib.freeze(plain)
  check(freezeLib.isFrozen(plain), "freeze marks the table")
  check(not pcall(function() plain[4] = 9 end), "writing a new key to a frozen table must raise")
  equal(plain[1], 1, "reads through a frozen table are unaffected")
  check(freezeLib.freeze(plain) == plain, "re-freezing is harmless and returns the same table")
  freezeLib.reset()

  local function loadMode(path, clientOpts)
    client.reset()
    client.install(clientOpts or {})
    if path ~= config.addonName .. ".toc" then
      emulator.install(config.addonName, emulator.parse(path))
    end
    local Lib = emulator.loadAddon(path, config.addonName)
    freezeLib.install(Lib)
    return Lib
  end

  --- The fresh-per-read contract, checked identically in both modes.
  local function checkFreshPerRead(Lib, label)
    local first = Lib.Quest.Get(2, "startedBy")
    local second = Lib.Quest.Get(2, "startedBy")
    check(type(first) == "table", label .. ": quest 2 startedBy is a table")
    check(first ~= second, label .. ": two reads return distinct tables")
    equal(first, second, label .. ": distinct tables carry equal content")

    -- Mutating what a read handed out never reaches the database or a later read. This is
    -- the exact `creatureObjective[3] = nil` shape that used to require a mutation audit.
    local key = next(first)
    first[key] = nil
    first[999] = "consumer scribble"
    local third = Lib.Quest.Get(2, "startedBy")
    equal(third, second, label .. ": mutation of a returned table never reaches the next read")
    check(third[999] == nil, label .. ": the scribbled key is absent from a fresh read")

    -- Nested independence: inner tables are fresh too.
    local spawnsA = Lib.Npc.Get(30, "spawns")
    local spawnsB = Lib.Npc.Get(30, "spawns")
    check(type(spawnsA) == "table", label .. ": npc 30 spawns is a table")
    local zone = next(spawnsA)
    check(spawnsA[zone] ~= spawnsB[zone], label .. ": nested tables are independent copies")
    spawnsA[zone][1] = "corrupted"
    equal(Lib.Npc.Get(30, "spawns"), spawnsB, label .. ": nested mutation never propagates")

    -- Scalars are immutable, so they stay plainly cached and stable.
    equal(Lib.Quest.Get(2, "name"), "Sharptalon's Claw", label .. ": scalar reads work")
    equal(Lib.Quest.Get(2, "name"), Lib.Quest.Get(2, "name"), label .. ": scalar reads are stable")

    -- GetRaw values are caller-owned copies too.
    local rawA = Lib.Quest.GetRaw(2, "startedBy")
    local rawB = Lib.Quest.GetRaw(2, "startedBy")
    check(rawA ~= rawB, label .. ": GetRaw returns a fresh copy per call")
    equal(rawA, rawB, label .. ": GetRaw copies carry equal content")
  end

  local baked = loadMode(tocPath)
  checkFreshPerRead(baked, "baked")

  local source = loadMode(config.addonName .. ".toc", { expansion = "Classic" })
  checkFreshPerRead(source, "source")

  -- Overlay-supplied tables are fresh per read as well, and the composed row is unreachable.
  local objectivesIndex = baked.Meta.QuestMeta.questKeys.objectivesText
  baked.Corrections.RegisterRuntimeCorrection("OwnershipTest", "Quest", "objectives",
    function() return { [2] = { [objectivesIndex] = { "corrected objective" } } } end, 10)
  baked.Corrections.ApplyRegisteredCorrections("OwnershipTest")
  local correctedA = baked.Quest.Get(2, "objectivesText")
  local correctedB = baked.Quest.Get(2, "objectivesText")
  check(correctedA ~= correctedB, "overlay table values are fresh per read")
  equal(correctedA, { "corrected objective" }, "the corrected value reads through")
  correctedA[1] = "scribbled"
  equal(baked.Quest.Get(2, "objectivesText"), { "corrected objective" },
    "mutating an overlay-supplied value never reaches the overlay")
  baked.Corrections.UnregisterCorrection("OwnershipTest", "Quest", "objectives")
  baked.Corrections.ApplyRegisteredCorrections("OwnershipTest")

  -- Source mode still freezes its base data: internal shared structure, not a returned value.
  local base = source.read.source.entities.Quest
  check(source.shared.IsFrozen(base), "source mode base data itself is frozen")
  check(not pcall(function() base[999999] = {} end), "writing a new entity into base data must raise")

  -- And the internal freeze still degrades rather than fails when the VM refuses.
  source.shared.SetFreezeImplementation(function()
    error("attempted to freeze a table not owned by the calling function " ..
          "(expected 'QuestieDB', got '*** ForceTaint_Strong ***')", 0)
  end)
  source.shared.freezeRefused = 0
  local refused = source.shared.Freeze({ 1, { 2 } })
  check(type(refused) == "table", "a refused freeze still returns the value")
  check(source.shared.freezeRefused > 0, "the refusal is counted rather than raised")
  check(source.shared.lastFreezeError ~= nil, "the refusal reason is recorded for diagnosis")

  client.reset()
end)

--------------------------------------------------------------------------------------------
-- Read contract: existence, composed enumeration, precedence, season gating
--------------------------------------------------------------------------------------------

suite("read-contract", "Vanilla", function()
  local tocPath = config.tocPath(config.flavorByName.Vanilla)
  if not lib.fileExists(tocPath) then
    io.write("  SKIP read-contract: ", tocPath, " not generated\n")
    return
  end

  local function loadMode(path, clientOpts)
    client.reset()
    client.install(clientOpts or {})
    if path ~= config.addonName .. ".toc" then
      emulator.install(config.addonName, emulator.parse(path))
    end
    return emulator.loadAddon(path, config.addonName)
  end

  --- ADR D6: an unknown id reads nil for EVERY field — including numerics, whose default-0
  --- rule is gated on existence — and invalid ids never reach cache internals.
  local function checkUnknownIds(Lib, label)
    equal(Lib.Quest.Get(999999999, "requiredLevel"), nil, label .. ": unknown id numeric field is nil")
    equal(Lib.Quest.Get(999999999, "name"), nil, label .. ": unknown id string field is nil")
    equal(Lib.Quest.Exists(999999999), false, label .. ": unknown id does not exist")
    equal(Lib.Quest.GetAll(999999999, { "name" }), nil, label .. ": unknown id GetAll is nil")
    equal(Lib.Quest.GetRaw(999999999, "requiredLevel"), nil, label .. ": unknown id GetRaw is nil")

    check(pcall(Lib.Quest.Get, nil, "name"), label .. ": Get(nil) must not raise")
    equal(Lib.Quest.Get(nil, "name"), nil, label .. ": Get(nil) is nil")
    equal(Lib.Quest.name(nil), nil, label .. ": named getter with nil id is nil")
    equal(Lib.Quest.Get("2", "name"), nil, label .. ": a string id is invalid, not coerced")
    equal(Lib.Quest.GetRaw(nil, "name"), nil, label .. ": GetRaw(nil) is nil")
    equal(Lib.Quest.GetAll(nil, { "name" }), nil, label .. ": GetAll(nil) is nil")

    -- GetByIndex validates like Get (was: source raised where baked returned nil).
    equal(Lib.Quest.GetByIndex(2, 999), nil, label .. ": GetByIndex out-of-range index is nil")
    equal(Lib.Quest.GetByIndex(2, 0), nil, label .. ": GetByIndex zero index is nil")
    equal(Lib.Quest.GetByIndex(nil, 1), nil, label .. ": GetByIndex nil id is nil")

    -- GetRaw bounds parity (was: source raised where baked returned nil).
    equal(Lib.Quest.GetRaw(2, 999), nil, label .. ": GetRaw out-of-range index is nil")
    equal(Lib.Quest.GetRaw(2, -5), nil, label .. ": GetRaw negative index is nil")
    equal(Lib.Quest.GetRaw(2, "nonexistentField"), nil, label .. ": GetRaw unknown key is nil")
    equal(Lib.Quest.Get(2, 999), nil, label .. ": Get out-of-range index is nil")

    -- An existing entity still defaults absent numerics to 0 — the ~290-call-site contract.
    check(type(Lib.Quest.Get(2, "requiredSourceItems")) ~= "nil" or
          Lib.Quest.Get(2, "requiredSourceItems") == nil, label .. ": probe read")
    equal(type(Lib.Quest.Get(2, "requiredLevel")), "number",
      label .. ": existing entity numeric field is a number")
  end

  local baked = loadMode(tocPath)
  checkUnknownIds(baked, "baked")

  --- ADR D7: an entity a Dynamic Correction adds is readable, enumerable, and exists — all
  --- three or none — and withdrawal removes all three on the next recomposition.
  local addedId = 4999999
  check(baked.Quest.Exists(addedId) == false, "the added id does not exist beforehand")
  local baseCount = #baked.Quest.GetAllIds()
  baked.Corrections.RegisterRuntimeCorrection("AddingAddon", "Quest", "add-entity",
    function() return { [addedId] = { [1] = "Dynamically Added Quest" } } end, 10)
  baked.Corrections.ApplyRegisteredCorrections("AddingAddon")

  equal(baked.Quest.Get(addedId, "name"), "Dynamically Added Quest", "the added entity is readable")
  equal(baked.Quest.Exists(addedId), true, "the added entity exists")
  equal(baked.Quest.GetAllIds(true)[addedId], true, "the added entity is in the hashmap")
  equal(#baked.Quest.GetAllIds(), baseCount + 1, "the added entity is in the list")
  local sorted = true
  local list = baked.Quest.GetAllIds()
  for i = 2, #list do if list[i - 1] > list[i] then sorted = false break end end
  check(sorted, "the composed id list stays ascending")
  equal(baked.Quest.Get(addedId, "requiredLevel"), 0,
    "an added entity's absent numeric field defaults to 0 like any existing entity")
  local packed = baked.Quest.GetAll(addedId, { "name", "requiredLevel" })
  check(packed ~= nil and packed[1] == "Dynamically Added Quest",
    "GetAll works for an added entity")

  baked.Corrections.UnregisterCorrection("AddingAddon", "Quest", "add-entity")
  baked.Corrections.ApplyRegisteredCorrections("AddingAddon")
  equal(baked.Quest.Exists(addedId), false, "withdrawal removes existence")
  equal(baked.Quest.Get(addedId, "name"), nil, "withdrawal removes readability")
  equal(#baked.Quest.GetAllIds(), baseCount, "withdrawal removes the id from enumeration")

  --- ADR 0013: translations win over English Corrections, and provenance is honest.
  if baked.l10n.IsAvailable() then
    baked.l10n.SetLocale("deDE")
    equal(baked.Quest.Get(2, "name"), "Klaue von Scharfkralle", "the translation reads through")
    baked.Corrections.RegisterRuntimeCorrection("FixingAddon", "Quest", "fix-name",
      function() return { [2] = { [1] = "Corrected Name" } } end, 10)
    baked.Corrections.ApplyRegisteredCorrections("FixingAddon")
    equal(baked.Quest.Get(2, "name"), "Klaue von Scharfkralle",
      "an English correction does not suppress the active translation")
    equal(baked.GetProvenance("Quest", 2, "name"), "QuestieDB",
      "provenance names the owner whose value is actually returned")
    equal(baked.Quest.Get(2, "objectivesText") ~= nil, true,
      "an uncorrected localizable field still translates")
    baked.Corrections.UnregisterCorrection("FixingAddon", "Quest", "fix-name")
    baked.Corrections.ApplyRegisteredCorrections("FixingAddon")
    equal(baked.Quest.Get(2, "name"), "Klaue von Scharfkralle",
      "withdrawing the correction restores the translation")
    baked.l10n.SetLocale("enUS")
  end

  -- The same contract holds in source mode.
  local source = loadMode(config.addonName .. ".toc", { expansion = "Classic" })
  checkUnknownIds(source, "source")

  client.reset()

  -- Seasonal variant directories register only for their exact client and active season.
  local runtime = dofile("generator/runtime.lua")
  local savedSeasons, savedEnum = rawget(_G, "C_Seasons"), rawget(_G, "Enum")

  local syntheticManifest = {
    { file = "Era/fake.lua", module = "FakeEra", datatype = "Quest",
      dynamic = { "LoadDynamic" }, expansions = { Classic = true } },
    { file = "Sod/fake.lua", module = "FakeSod", datatype = "Quest",
      dynamic = { "LoadSod" }, expansions = { Classic = true } },
    { file = "Titan/fake.lua", module = "FakeTitan", datatype = "Quest",
      dynamic = { "LoadTitan" }, expansions = { Wotlk = true } },
  }
  local fakeModules = {
    FakeEra = { LoadDynamic = function() return { [2] = { [4] = 42 } } end },
    FakeSod = { LoadSod = function() return { [2] = { [4] = 60 } } end },
    FakeTitan = { LoadTitan = function() return { [2] = { [4] = 80 } } end },
  }
  ---Registers the synthetic manifest for one client flavor.
  ---@param flavorName string Key in `config.flavorByName`.
  ---@return table Lib
  ---@return number registered
  ---@return number sodEntries
  ---@return number titanEntries
  ---@return number eraEntries
  local function registerSynthetic(flavorName)
    local Lib = runtime.build()
    Lib.CorrectionManifest = syntheticManifest
    local registered = Lib.CorrectionRegister.FromManifest(
      Lib.config.flavorByName[flavorName], function(name) return fakeModules[name] end)
    local sodEntries, titanEntries, eraEntries = 0, 0, 0
    for _, entry in ipairs(Lib.Corrections.Select({ dynamic = true })) do
      if entry.name:find("^Sod/") then sodEntries = sodEntries + 1 end
      if entry.name:find("^Titan/") then titanEntries = titanEntries + 1 end
      if entry.name:find("^Era/") then eraEntries = eraEntries + 1 end
    end
    return Lib, registered, sodEntries, titanEntries, eraEntries
  end

  _G.C_Seasons = { GetActiveSeason = function() return 0 end }
  _G.Enum = { SeasonID = { SeasonOfDiscovery = 2 } }
  local _, _, sodInactive, _, eraInactive = registerSynthetic("Vanilla")
  equal(sodInactive, 0, "no season active: SoD sets do not register")
  equal(eraInactive, 1, "no season active: Era sets register normally")

  _G.C_Seasons = { GetActiveSeason = function() return 2 end }
  local _, _, sodActive = registerSynthetic("Vanilla")
  equal(sodActive, 1, "SoD active: SoD sets register")
  local _, _, _, titanWrongSeason = registerSynthetic("Wrath")
  equal(titanWrongSeason, 0, "SoD season on Wrath: Titan sets do not register")

  _G.C_Seasons = { GetActiveSeason = function() return 109 end }
  local _, _, _, titanWrath = registerSynthetic("Wrath")
  equal(titanWrath, 1, "Titan active on Wrath: Titan sets register")
  local _, _, _, titanVanilla = registerSynthetic("Vanilla")
  equal(titanVanilla, 0, "season 109 on Vanilla: Titan sets do not register")
  local _, _, _, titanTbc = registerSynthetic("TBC")
  equal(titanTbc, 0, "season 109 on TBC: Titan sets do not register")
  local _, _, _, titanCata = registerSynthetic("Cata")
  equal(titanCata, 0, "season 109 on Cata: Titan sets do not register")
  local _, _, _, titanMists = registerSynthetic("Mists")
  equal(titanMists, 0, "season 109 on Mists: Titan sets do not register")

  _G.C_Seasons = nil
  local _, _, sodAbsent = registerSynthetic("Vanilla")
  local _, _, _, titanAbsent = registerSynthetic("Wrath")
  equal(sodAbsent, 0, "no C_Seasons API at all: SoD sets do not register")
  equal(titanAbsent, 0, "no C_Seasons API at all: Titan sets do not register")

  _G.C_Seasons = savedSeasons
  _G.Enum = savedEnum
end)

--------------------------------------------------------------------------------------------
-- Name index (ADR 0008)
--------------------------------------------------------------------------------------------

suite("name-index", "Vanilla", function()
  local tocPath = config.tocPath(config.flavorByName.Vanilla)
  if not lib.fileExists(tocPath) then
    io.write("  SKIP name-index: ", tocPath, " not generated\n")
    return
  end

  client.reset()
  client.install({ expansion = "Classic", locale = "enUS" })
  emulator.install(config.addonName, emulator.parse(tocPath))
  local Lib = emulator.loadAddon(tocPath, config.addonName)
  local Object = Lib.Object

  local function contains(list, id)
    for i = 1, #(list or {}) do if list[i] == id then return true end end
    return false
  end

  -- Every entity type has a name field, so every Entity global carries the index.
  for _, entityType in ipairs(config.entityTypes) do
    local entity = Lib[entityType.name]
    check(type(entity.IdsByName) == "function", entityType.name .. ".IdsByName")
    check(type(entity.BuildNameIndex) == "function", entityType.name .. ".BuildNameIndex")
  end

  -- A lookup is exact, over the composed view, and never raises.
  equal(Object.IdsByName("Old Lion Statue"), { 31 }, "a unique name resolves to its one id")
  equal(Object.IdsByName("old lion statue"), nil, "the match is exact, not case-folded")
  equal(Object.IdsByName("No Such Object Name"), nil, "an unknown name is nil, never an empty list")
  equal(Object.IdsByName(nil), nil, "a nil name is nil")
  equal(Object.IdsByName(31), nil, "a non-string is nil, not coerced")
  check(pcall(Object.IdsByName, {}), "a bad argument never raises")

  -- The index is exactly the reads: every name the getter returns has a bucket holding
  -- precisely the ids that read it, ascending, each once. This is the whole contract.
  local ids = Object.GetAllIds()
  local expected = {}
  for i = 1, #ids do
    local name = Object.name(ids[i])
    if name then
      local bucket = expected[name]
      if bucket then bucket[#bucket + 1] = ids[i] else expected[name] = { ids[i] } end
    end
  end
  local names, mismatches, sharedName = 0, 0, nil
  for name, bucket in pairs(expected) do
    names = names + 1
    if not lib.deepEqual(Object.IdsByName(name), bucket) then mismatches = mismatches + 1 end
    if #bucket > 1 and (not sharedName or #bucket > #expected[sharedName]) then sharedName = name end
  end
  check(names > 2000, "the fixture has a real number of distinct names (" .. names .. ")")
  equal(mismatches, 0, "every bucket equals the ids that read that name, ascending")
  check(sharedName ~= nil and #Object.IdsByName(sharedName) == #expected[sharedName],
    "a name shared by many objects lists all of them: " .. tostring(sharedName))

  -- Composed enumeration through the index (ADR 0003 D7): an entity a Dynamic Correction
  -- adds is discoverable by name, and withdrawing it removes it. The index is rebuilt from
  -- scratch after the apply, never patched, so nothing stale can survive.
  local addedId = 4999999
  Lib.Corrections.RegisterRuntimeCorrection("AddingAddon", "Object", "add-object",
    function() return { [addedId] = { [1] = "Dynamically Added Object" } } end, 10)
  Lib.Corrections.ApplyRegisteredCorrections("AddingAddon")
  equal(Object.IdsByName("Dynamically Added Object"), { addedId }, "an added entity is discoverable by name")
  Lib.Corrections.UnregisterCorrection("AddingAddon", "Object", "add-object")
  Lib.Corrections.ApplyRegisteredCorrections("AddingAddon")
  equal(Object.IdsByName("Dynamically Added Object"), nil, "a withdrawn entity disappears from the index")

  -- A corrected name is the name the index answers to; the pre-correction name keeps no entry.
  Lib.Corrections.RegisterRuntimeCorrection("FixingAddon", "Object", "rename",
    function() return { [31] = { [1] = "Renamed Lion Statue" } } end, 10)
  Lib.Corrections.ApplyRegisteredCorrections("FixingAddon")
  equal(Object.IdsByName("Renamed Lion Statue"), { 31 }, "a corrected name resolves")
  equal(Object.IdsByName("Old Lion Statue"), nil, "the pre-correction name no longer resolves")
  Lib.Corrections.UnregisterCorrection("FixingAddon", "Object", "rename")
  Lib.Corrections.ApplyRegisteredCorrections("FixingAddon")
  equal(Object.IdsByName("Old Lion Statue"), { 31 }, "withdrawing the rename restores the base name")

  -- BuildNameIndex is the explicit warm-up: it does the pass now and is a no-op afterwards —
  -- the same bucket table comes back, which is also the documented shared-return contract.
  Lib.InvalidateCache("Object")
  Object.BuildNameIndex()
  local built = Object.IdsByName("Old Lion Statue")
  equal(built, { 31 }, "an explicitly built index answers")
  Object.BuildNameIndex()
  check(Object.IdsByName("Old Lion Statue") == built, "a second build is a no-op: the same bucket comes back")

  -- Both InvalidateCache branches drop the index: a rebuilt index hands out a new bucket with
  -- the same content. The single-id branch is its own code path, so it is proven separately.
  Lib.InvalidateCache("Object", 31)
  local rebuilt = Object.IdsByName("Old Lion Statue")
  check(rebuilt ~= built and lib.deepEqual(rebuilt, { 31 }),
    "InvalidateCache(datatype, id) drops the index and the next lookup rebuilds it")
  Lib.InvalidateCache()
  check(Object.IdsByName("Old Lion Statue") ~= rebuilt, "InvalidateCache() drops the index too")

  -- A Correction that deletes the name (the `{}` idiom, the overlay's NIL sentinel) removes
  -- the id from the index rather than filing it under a sentinel or an empty string.
  Lib.Corrections.RegisterRuntimeCorrection("FixingAddon", "Object", "unname",
    function() return { [31] = { [1] = {} } } end, 10)
  Lib.Corrections.ApplyRegisteredCorrections("FixingAddon")
  equal(Object.name(31), nil, "the deleted name reads nil")
  equal(Object.IdsByName("Old Lion Statue"), nil, "a deleted name has no bucket")
  Lib.Corrections.UnregisterCorrection("FixingAddon", "Object", "unname")
  Lib.Corrections.ApplyRegisteredCorrections("FixingAddon")
  equal(Object.IdsByName("Old Lion Statue"), { 31 }, "withdrawing the deletion restores the name")

  -- The index follows the locale: after SetLocale the translated name resolves and the
  -- English one does not, and switching back restores it. Translations outrank Corrections
  -- here exactly as they do for the getter, because the index is built from it. The German
  -- name is read from the getter rather than spelled out, so the check is about the index
  -- agreeing with the read, not about one fixture string.
  if not Lib.l10n.IsAvailable() then
    assert(not selectedFlavor, "scoped name-index checks require localization")
    io.write("  SKIP name-index locale checks: artifact generated with --no-l10n\n")
  else
    Lib.l10n.SetLocale("deDE")
    local german = Object.name(31)
    check(german ~= nil and german ~= "Old Lion Statue", "deDE: object 31 has a translation to index by")
    check(contains(Object.IdsByName(german), 31), "deDE: the translated name resolves")
    check(not contains(Object.IdsByName("Old Lion Statue"), 31), "deDE: the enUS name no longer reaches the id")
    Lib.Corrections.RegisterRuntimeCorrection("FixingAddon", "Object", "rename",
      function() return { [31] = { [1] = "Corrected In Every Locale" } } end, 10)
    Lib.Corrections.ApplyRegisteredCorrections("FixingAddon")
    equal(Object.IdsByName("Corrected In Every Locale"), nil, "deDE: an English correction does not mask the translation")
    check(contains(Object.IdsByName(german), 31), "deDE: the translation remains indexed")
    Lib.Corrections.UnregisterCorrection("FixingAddon", "Object", "rename")
    Lib.Corrections.ApplyRegisteredCorrections("FixingAddon")
    Lib.l10n.SetLocale("enUS")
    equal(Object.IdsByName("Old Lion Statue"), { 31 }, "enUS: switching back restores the base name")
    check(not contains(Object.IdsByName(german), 31), "enUS: the deDE name no longer reaches the id")
  end

  client.reset()
end)

--------------------------------------------------------------------------------------------
-- Equivalence negative control
--------------------------------------------------------------------------------------------

suite("equivalence-control", "Vanilla", function()
  local flavor = config.flavorByName.Vanilla
  local sourceToc = config.tocPath(flavor)
  if not lib.fileExists(sourceToc) then
    io.write("  SKIP equivalence-control: ", sourceToc, " not generated\n")
    return
  end

  lib.mkdirp(".out/corrupt")
  local original = lib.readAll(sourceToc)

  local function runEquivalence(content, label)
    lib.writeAll(".out/corrupt/" .. sourceToc, content)
    local ok = lib.execute(shellQuote(LUA_BIN) ..
      " equivalence.lua Vanilla --toc-dir=.out/corrupt --types=Quest --sample=200 " ..
      "--no-self-proof --quiet >" .. lib.nullDevice .. " 2>&1")
    local failed
    if type(ok) == "number" then failed = ok ~= 0 else failed = not ok end
    check(failed, "equivalence accepted a divergence: " .. label)
  end

  -- A changed baked scalar must diverge from source.
  local changed, changedCount =
    replaceScalarInRow(original, "Quest", 2, 1, "Not Sharptalon's Claw")
  check(changedCount == 1, "corruption fixture did not apply (changed quest name)")
  runEquivalence(changed, "changed quest name")

  -- A present table whose CBOR is replaced by an empty table must diverge from source.
  local emptied, emptiedCount = original:gsub("(## X%-Quest%-2%-2: )[^\n]*",
    "%1" .. base64.encode(cbor.encode({})), 1)
  check(emptiedCount == 1, "corruption fixture did not apply (empty table)")
  runEquivalence(emptied, "populated versus empty table")

  -- And the healthy case still passes, so the control is not just always-fails.
  local runEquivalenceOk = lib.execute(shellQuote(LUA_BIN) ..
    " equivalence.lua Vanilla --types=Quest --sample=200 --no-self-proof " ..
    "--quiet >" .. lib.nullDevice .. " 2>&1")
  local passed
  if type(runEquivalenceOk) == "number" then passed = runEquivalenceOk == 0 else passed = runEquivalenceOk == true end
  check(passed, "equivalence failed on an uncorrupted artifact")

  os.remove(".out/corrupt/" .. sourceToc)
end)

--------------------------------------------------------------------------------------------
-- Distributable LuaLS declarations
--------------------------------------------------------------------------------------------

suite("lua-types", "shared", function()
  local commonMethods = {
    GetByIndex = true,
    Get = true,
    GetAll = true,
    GetRaw = true,
    GetAllIds = true,
    Exists = true,
    InvalidateCache = true,
    BuildNameIndex = true,
    IdsByName = true,
  }
  local typeFiles = testFiles.list("src/types", false, { ".t.lua" })

  check(#typeFiles > 0, "packaging has at least one LuaLS declaration to ship")
  for _, path in ipairs(typeFiles) do
    local content = lib.readAll(path)
    check(content:find("---@meta _", 1, true) ~= nil,
      path .. " is marked as analysis-only LuaLS metadata")
  end

  local generalTypes = lib.readAll("src/types/General.t.lua")
  local sharedQuestieIdAliases = {
    QuestId = true,
    NpcId = true,
    ItemId = true,
    ObjectId = true,
    AreaId = true,
    FactionId = true,
    SkillId = true,
  }
  for alias in generalTypes:gmatch("%-%-%-@alias%s+([%a_][%w_]*)") do
    check(sharedQuestieIdAliases[alias] or alias:find("^QuestieDB") ~= nil,
      "helper alias is shared with Questie or namespaced for consumer compatibility: " .. alias)
  end

  local entities = {
    { name = "Quest", meta = dofile("src/meta/questMeta.lua") },
    { name = "Npc", meta = dofile("src/meta/npcMeta.lua") },
    { name = "Item", meta = dofile("src/meta/itemMeta.lua") },
    { name = "Object", meta = dofile("src/meta/objectMeta.lua") },
  }

  for _, entity in ipairs(entities) do
    local path = "src/types/" .. entity.name .. ".t.lua"
    local content = lib.readAll(path)
    local declared, duplicateFields = {}, {}
    for field in content:gmatch("%-%-%-@field%s+([%a_][%w_]*)%s+fun") do
      if declared[field] then duplicateFields[#duplicateFields + 1] = field end
      declared[field] = true
    end
    if content:find("function " .. entity.name .. "DB.GetAllIds", 1, true) then
      declared.GetAllIds = true
    end

    equal(#duplicateFields, 0, entity.name .. " type has no duplicate getter declarations")
    for _, method in ipairs({
      "GetByIndex", "Get", "GetAll", "GetRaw", "GetAllIds", "Exists", "InvalidateCache",
      "BuildNameIndex", "IdsByName",
    }) do
      check(declared[method] == true,
        entity.name .. " type declares the common method " .. method)
    end

    local schemaFields = {}
    for fieldIndex = 1, entity.meta.fieldCount do
      local field = entity.meta.names[fieldIndex]
      schemaFields[field] = true
      check(declared[field] == true,
        entity.name .. " type declares schema getter " .. field)
    end
    for field in pairs(declared) do
      if not commonMethods[field] then
        check(schemaFields[field] == true,
          entity.name .. " type has no getter outside the schema: " .. field)
      end
    end

    local aliasBody = generalTypes:match(
      "%-%-%-@alias%s+QuestieDB" .. entity.name .. "Field%s+([^\r\n]+)")
    check(aliasBody ~= nil, entity.name .. " field-name alias exists")
    local aliasedFields = {}
    for field in (aliasBody or ""):gmatch('"([^"]+)"') do aliasedFields[field] = true end
    equal(aliasedFields, schemaFields, entity.name .. " field-name alias matches the schema")
  end

  local tocPaths = { "QuestieDB.toc" }
  for _, path in ipairs(tocPaths) do
    local typeEntries = {}
    for line in lib.readAll(path):gmatch("[^\r\n]+") do
      if line:sub(1, 1) ~= "#" then
        local lower = line:lower()
        if lower:find("types/", 1, true) or lower:find("types\\", 1, true) then
          typeEntries[#typeEntries + 1] = line
        end
      end
    end
    equal(typeEntries, {}, path .. " does not runtime-load LuaLS declarations")
  end
end)

suite("artifact-types", "artifact", function()
  local tocPaths = {}
  for _, flavor in ipairs(artifactFlavors) do
    local path = config.tocPath(flavor)
    if lib.fileExists(path) then tocPaths[#tocPaths + 1] = path end
  end
  for _, path in ipairs(tocPaths) do
    local typeEntries = {}
    for line in lib.readAll(path):gmatch("[^\r\n]+") do
      if line:sub(1, 1) ~= "#" then
        local lower = line:lower()
        if lower:find("types/", 1, true) or lower:find("types\\", 1, true) then
          typeEntries[#typeEntries + 1] = line
        end
      end
    end
    equal(typeEntries, {}, path .. " does not runtime-load LuaLS declarations")
  end
end)

--------------------------------------------------------------------------------------------
-- TOC file lists
--------------------------------------------------------------------------------------------

suite("native-toc", "shared", function()
  client.reset()
  dofile("emulator/metadata.test.lua")
  dofile("emulator/native-source.test.lua")
end)

suite("toc", "shared", function()
  -- The correction manifest drives which correction files a TOC lists, and `config` cannot
  -- load it itself — in a client it arrives as an addon file, so the generator assigns it
  -- explicitly. The same has to happen here, and it is asserted rather than assumed: without
  -- it `correctionFiles` returns an empty list and every check below would pass over a file
  -- list missing twenty-odd entries.
  config.correctionManifest = dofile("src/corrections/manifest.lua")
  check(config.correctionManifest ~= nil and #config.correctionManifest > 0,
    "the correction manifest loaded")

  -- The base TOC is committed, so changing the manifest is not enough: Source mode can only
  -- load a new Correction file after `generate.lua toc` refreshes this exact list.
  local committedSourceFiles = {}
  for line in lib.readAll("QuestieDB.toc"):gmatch("[^\r\n]+") do
    if line ~= "" and line:sub(1, 1) ~= "#" then
      committedSourceFiles[#committedSourceFiles + 1] = line:gsub("\\", "/")
    end
  end
  equal(committedSourceFiles, config.sourceFileList(),
    "QuestieDB.toc exactly matches the computed Source-mode file list")

  -- The client rejects a file listed twice with `Duplicate File Load Detected`, and it is
  -- right to: the file re-executes, rebuilding whatever it defines while earlier files still
  -- hold references to the first copy. Blocks declare their own prerequisites — the support
  -- block and the correction block both need `config.enumFiles` — so the composer has to
  -- deduplicate, and this is what proves it does.
  local sourcePaths = {}
  for _, entry in ipairs(config.sourceFileEntries()) do sourcePaths[#sourcePaths + 1] = entry.path end
  local lists = { { name = "base (source mode)", files = sourcePaths } }
  for _, flavor in ipairs(config.flavors) do
    lists[#lists + 1] = { name = flavor.name, files = config.bakedFileList(flavor) }
  end

  -- Guard against the lists silently shrinking: a composer that returns early would make every
  -- check below vacuous.
  for _, list in ipairs(lists) do
    local blocks = { support = false, corrections = false, meta = false, api = false }
    for _, file in ipairs(list.files) do
      if file:find("^support/") then blocks.support = true end
      if file:find("^src/corrections/%a+/") then blocks.corrections = true end
      if file:find("^src/meta/") then blocks.meta = true end
      if file == "src/api.lua" then blocks.api = true end
    end
    for name, present in pairs(blocks) do
      check(present, ("%s is missing its %s block entirely"):format(list.name, name))
    end
    check(#list.files > 30, ("%s lists only %d files"):format(list.name, #list.files))
  end

  for _, list in ipairs(lists) do
    local seen, duplicates = {}, {}
    for _, file in ipairs(list.files) do
      if seen[file] then duplicates[#duplicates + 1] = file end
      seen[file] = true
    end
    for _, file in ipairs(duplicates) do
      check(false, ("%s lists %s more than once"):format(list.name, file))
    end
    equal(#duplicates, 0, list.name .. " has no duplicate file entries")

    -- Every listed file must exist, or the client silently skips it and the failure surfaces
    -- much later as a nil index.
    local missing = 0
    for _, file in ipairs(list.files) do
      if not lib.fileExists(file) then
        missing = missing + 1
        check(false, ("%s lists a file that does not exist: %s"):format(list.name, file))
      end
    end
    equal(missing, 0, list.name .. " lists only files that exist")
  end

  -- Load order: a block's prerequisites must precede it.
  local function positions(files)
    local at = {}
    for index, file in ipairs(files) do at[file] = at[file] or index end
    return at
  end

  for _, list in ipairs(lists) do
    local at = positions(list.files)
    local function before(a, b, why)
      if at[a] and at[b] then
        check(at[a] < at[b], ("%s: %s must load before %s (%s)"):format(list.name, a, b, why))
      end
    end
    before("src/config.lua", "src/meta/normalize.lua", "everything reads config")
    for index, path in ipairs(config.enumFiles) do
      check(at[path] ~= nil, list.name .. " includes enum file " .. path)
      if index > 1 then
        before(config.enumFiles[index - 1], path, "enum files retain their declared load order")
      end
      before(path, "src/support/_begin.lua", "support seeds DropDB.correctionKeys from the constants")
      before(path, "src/corrections/compat.lua", "compat captures constants at file scope")
    end
    before("src/corrections/registry.lua", "src/corrections/_end.lua",
      "registration needs the registry")
    before("src/read/shared.lua", "src/api.lua", "api builds entities with shared.CreateEntity")
    before("src/corrections/_end.lua", "src/api.lua",
      "api applies QuestieDB's own corrections, so they must be registered first")
    before("src/support/_begin.lua", "src/support/_end.lua", "brackets are ordered")
    before("src/corrections/_begin.lua", "src/corrections/_end.lua", "brackets are ordered")
  end

  -- Titan's four provider files ship in Source mode and the Wrath artifact, never in another
  -- baked flavor. Registration gates decide whether the loaded Wrath files apply.
  local expectedTitanSpecs = {
    {
      file = "Titan/titanReforgedQuestFixes.lua", datatype = "Quest",
      dynamic = { "LoadQuests", "LoadQuestOverrides" }, expansions = { Wotlk = true },
    },
    {
      file = "Titan/titanReforgedNPCFixes.lua", datatype = "Npc",
      dynamic = { "LoadNPCs", "LoadNPCOverrides", "LoadFactionNPCOverrides" },
      expansions = { Wotlk = true },
    },
    {
      file = "Titan/titanReforgedItemFixes.lua", datatype = "Item",
      dynamic = { "LoadItems", "LoadItemOverrides" }, expansions = { Wotlk = true },
    },
    {
      file = "Titan/titanReforgedObjectFixes.lua", datatype = "Object",
      dynamic = { "LoadObjects" }, expansions = { Wotlk = true },
    },
  }
  local titanFiles, titanSpecs, titanProviders = {}, {}, 0
  for _, spec in ipairs(config.correctionManifest) do
    check(spec.gatedDynamic == nil, spec.file .. " has no retired per-function variant gate")
    if spec.file:find("^Titan/") then
      titanFiles[#titanFiles + 1] = "src/corrections/" .. spec.file
      titanSpecs[#titanSpecs + 1] = {
        file = spec.file,
        datatype = spec.datatype,
        dynamic = spec.dynamic,
        expansions = spec.expansions,
      }
      titanProviders = titanProviders + #(spec.dynamic or {})
    end
    if spec.file:find("^Wotlk/") then
      equal(spec.dynamic, { "LoadFactionFixes" },
        spec.file .. " declares only its ordinary faction provider")
    end
  end
  equal(titanSpecs, expectedTitanSpecs,
    "manifest fixes Titan file names, datatypes, provider order, and exact expansion gate")
  equal(titanProviders, 8, "manifest declares all eight Titan providers")
  ---@param files string[]
  ---@return table<string, boolean> set
  local function fileSet(files)
    local set = {}
    for _, file in ipairs(files) do set[file] = true end
    return set
  end
  local sourceSet = fileSet(sourcePaths)
  local wrathSet = fileSet(config.bakedFileList(config.flavorByName.Wrath))
  for _, file in ipairs(titanFiles) do
    check(sourceSet[file] == true, "Source mode lists Titan provider " .. file)
    check(wrathSet[file] == true, "Wrath Baked mode lists Titan provider " .. file)
  end
  for _, flavor in ipairs(config.flavors) do
    if flavor.name ~= "Wrath" then
      local otherSet = fileSet(config.bakedFileList(flavor))
      for _, file in ipairs(titanFiles) do
        check(otherSet[file] ~= true, flavor.name .. " excludes Titan provider " .. file)
      end
    end
  end

  -- Source mode only: the reader installs the loader shim, so it has to precede the data it
  -- captures, and the data block has to close before anything else touches QuestieLoader.
  local baseAt = positions(sourcePaths)
  check(baseAt["src/read/source.lua"] < baseAt["data/Classic/classicQuestDB.lua"],
    "the source reader installs its shim before the data block opens")
  check(baseAt["data/MoP/mopObjectDB.lua"] < baseAt["data/_end.lua"],
    "every selected payload falls inside the data block")
  check(baseAt["data/_end.lua"] < baseAt["src/support/_begin.lua"],
    "the data block closes before the support block opens")
end)

--------------------------------------------------------------------------------------------
-- Independence from the prototypes
--------------------------------------------------------------------------------------------

suite("no-prototype-inputs", "shared", function()
  -- `Getters` and `toc-database` are reference material, never a build input. Nothing here may
  -- open a path inside them, and in particular nothing may consume `Getters/data/*.lua-table`:
  -- corrections are already applied there by the pipeline QuestieDB replaces, so building on
  -- it would double-apply corrections from the wrong system.
  --
  -- Provenance comments naming a prototype are fine and wanted — they say where a design came
  -- from. What is forbidden is a *path* that resolves into one.

  local function scan(dir, found)
    for _, path in ipairs(testFiles.list(dir, true, { ".lua", ".toc", ".sh", ".ps1", ".py", ".yml" })) do
      local file = io.open(path, "rb")
      if file then
        local content = file:read("*a")
        file:close()
        -- A path *literal*, not a mention. The character classes exclude newlines so a match
        -- cannot span from one quote on line 10 to another on line 400.
        for _, pattern in ipairs({
          '"[^"\n]*Getters/[^"\n]*"', "'[^'\n]*Getters/[^'\n]*'",
          '"[^"\n]*toc%-database/[^"\n]*"', "'[^'\n]*toc%-database/[^'\n]*'",
          '"[^"\n]*%.lua%-table[^"\n]*"', "'[^'\n]*%.lua%-table[^'\n]*'",
        }) do
          for match in content:gmatch(pattern) do
            found[#found + 1] = path .. ": " .. match
          end
        end
      end
    end
    return found
  end

  local found = {}
  for _, dir in ipairs({ "src", "generator", "emulator", "validators", "tools", ".github" }) do
    scan(dir, found)
  end
  -- The top-level entry points, named rather than globbed: this file is a *test* and carries
  -- the search patterns as string literals, so scanning `.` would find itself.
  for _, file in ipairs({ "generate.lua", "verify.lua", "equivalence.lua", "QuestieDB.toc" }) do
    local handle = io.open(file, "rb")
    if handle then
      local content = handle:read("*a")
      handle:close()
      for _, pattern in ipairs({ "Getters/", "toc%-database/", "%.lua%-table" }) do
        if content:find(pattern) then found[#found + 1] = file .. ": " .. pattern end
      end
    end
  end

  for _, offender in ipairs(found) do
    check(false, "a build input references a prototype path: " .. offender)
  end
  check(#found == 0, ("%d build inputs reference a prototype path"):format(#found))

  -- Every generation input is enumerated in config, and all of them live in this repo.
  local flavor = config.flavorByName.Vanilla
  for _, entityType in ipairs(config.entityTypes) do
    local path = config.dataPath(flavor, entityType)
    check(path:sub(1, 5) == "data/", "entity data comes from this repo: " .. path)
    check(lib.fileExists(path), "entity data file exists: " .. path)
  end
  for _, file in ipairs(config.supportFiles(flavor)) do
    check(lib.fileExists(file), "support file exists: " .. file)
  end
end)

--------------------------------------------------------------------------------------------
-- Public API
--------------------------------------------------------------------------------------------

suite("contract-config", "shared", function()
  local source = lib.readAll("src/config.lua")
  for _, field in ipairs({ "contractVersion", "minSupportedContract" }) do
    for _, value in ipairs({ "0", "-1", "1.5", '"2"', "nil", "0/0", "math.huge" }) do
      local changed, count = source:gsub("config%." .. field .. " = %d+", "config." .. field .. " = " .. value, 1)
      equal(count, 1, "test changes the declared " .. field)
      local ok, message = pcall(assert(loadstring(changed)))
      equal(ok, false, field .. " rejects " .. value)
      check(tostring(message):find(field .. " must be a positive integer", 1, true) ~= nil,
        "invalid configuration explains the offending field")
    end
  end
  local changed = source:gsub("config%.minSupportedContract = %d+", "config.minSupportedContract = 3", 1)
  local ok, message = pcall(assert(loadstring(changed)))
  equal(ok, false, "inverted supported contract range fails")
  check(tostring(message):find("minSupportedContract must not exceed contractVersion", 1, true) ~= nil,
    "inverted range explains the invariant")
end)

suite("api", "Vanilla", function()
  local tocPath = config.tocPath(config.flavorByName.Vanilla)
  if not lib.fileExists(tocPath) then
    io.write("  SKIP api: ", tocPath, " not generated\n")
    return
  end

  client.reset()
  client.install({ expansion = "Classic" })
  emulator.install(config.addonName, emulator.parse(tocPath))
  local Lib = emulator.loadAddon(tocPath, config.addonName)

  -- Field access, bulk field access and ID enumeration, per entity type.
  for _, entityType in ipairs(config.entityTypes) do
    local entity = Lib[entityType.name]
    check(entity ~= nil, "entity global exposed: " .. entityType.name)
    check(type(entity.Get) == "function", entityType.name .. ".Get")
    check(type(entity.GetAll) == "function", entityType.name .. ".GetAll")
    check(type(entity.GetAllIds) == "function", entityType.name .. ".GetAllIds")
    check(type(entity.GetRaw) == "function", entityType.name .. ".GetRaw")
    check(_G[entityType.name .. "DB"] == entity, entityType.name .. "DB global alias")
  end

  equal(Lib.Quest.Get(2, "name"), "Sharptalon's Claw", "Get by name")
  equal(Lib.Quest.Get(2, 1), "Sharptalon's Claw", "Get by index")
  local bulk = Lib.Quest.GetAll(2, { "name", "requiredLevel" })
  equal(bulk[1], "Sharptalon's Claw", "GetAll returns values in the requested order")
  equal(bulk[2], 20, "GetAll second value")
  equal(bulk.n, 2, "GetAll is packed: n carries the requested count")

  -- Nullable fields leave holes, which made a bare `unpack` silently drop trailing values.
  -- The packed shape makes the documented pattern `unpack(values, 1, values.n)` lossless.
  local holey = Lib.Quest.GetAll(2, { "name", "triggerEnd", "requiredLevel" })
  equal(holey.n, 3, "a nil middle field still counts in n")
  local a, b, c = unpack(holey, 1, holey.n)
  equal(a, "Sharptalon's Claw", "unpack with n: first")
  equal(b, nil, "unpack with n: the nil hole survives")
  equal(c, 20, "unpack with n: the value after the hole is not dropped")
  equal(Lib.Quest.GetAll(999999999, { "name" }), nil, "GetAll of an unknown entity is nil")

  check(#Lib.Quest.GetAllIds() > 4000, "GetAllIds returns the list")
  equal(Lib.Quest.GetAllIds(true)[2], true, "GetAllIds(true) returns a hashmap")
  equal(Lib.Quest.Exists(2), true, "Exists")

  -- The schema is exposed so consumers can name fields rather than index them, in both the
  -- internal spelling and the one DESIGN.md documents.
  equal(Lib.Meta.QuestMeta.questKeys.name, 1, "Meta.QuestMeta.questKeys")
  equal(Lib.Meta.NpcMeta.npcKeys.subName, 14, "Meta.NpcMeta.npcKeys")
  equal(Lib.Meta.ItemMeta.itemKeys.name, 1, "Meta.ItemMeta.itemKeys")
  equal(Lib.Meta.ObjectMeta.objectKeys.name, 1, "Meta.ObjectMeta.objectKeys")
  equal(Lib.Meta.Quest.names[1], "name", "Meta.Quest.names")
  equal(Lib.Meta.Quest.types[1], "string", "Meta.Quest.types")
  equal(Lib.Meta.Quest.fieldCount, 36, "Meta.Quest.fieldCount")

  -- Keep LuaLS key-class fields in runtime positional order so declaration drift fails here.
  local metaTypeSource = lib.readAll("src/types/Meta.t.lua")
  local declaredKeyFields, runtimeKeyFields = {}, {}
  for _, entityType in ipairs(config.entityTypes) do
    local classMarker = "---@class QuestieDB" .. entityType.name .. "Keys\n"
    local classStart = metaTypeSource:find(classMarker, 1, true)
    assert(classStart, ("missing exact metadata key class marker %q"):format(classMarker))

    local fieldsStart = classStart + #classMarker
    local nextClass = metaTypeSource:find("\n---@class ", fieldsStart, true)
    local classBlock = metaTypeSource:sub(fieldsStart, nextClass and nextClass - 1 or #metaTypeSource)
    local declared = {}
    for field in classBlock:gmatch("%-%-%-@field ([%w_]+)") do
      declared[#declared + 1] = field
    end
    declaredKeyFields[entityType.name] = declared

    local lower = entityType.name:sub(1, 1):lower() .. entityType.name:sub(2)
    local runtime = {}
    for field, index in pairs(Lib.Meta[entityType.name .. "Meta"][lower .. "Keys"]) do
      runtime[index] = field
    end
    runtimeKeyFields[entityType.name] = runtime
  end
  equal(declaredKeyFields, runtimeKeyFields,
    "all metadata key declarations match runtime names and indices in order")

  -- A contract version is published, and the check is a range, not an equality (ADR D12):
  -- additive releases must not break consumers built against an older contract.
  equal(Lib.contractVersion, config.contractVersion, "contractVersion published")
  equal(Lib.minSupportedContract, config.minSupportedContract, "minSupportedContract published")
  equal(Lib.RequireContract(config.minSupportedContract), true, "oldest supported contract passes")
  equal(Lib.RequireContract(config.contractVersion), true, "matching contract passes")
  local ok, message = Lib.RequireContract(config.contractVersion + 98)
  equal(ok, false, "a newer-than-provided contract fails")
  check(type(message) == "string" and message:find("mismatch"), "mismatch carries a specific message")
  equal(Lib.RequireContract(config.minSupportedContract - 1), false,
    "a contract below the supported floor fails")
  equal(Lib.RequireContract(nil), false, "a non-numeric required contract fails cleanly")
  equal(Lib.RequireContract(1.5), false, "a fractional contract inside the range fails")
  equal(Lib.RequireContract("2"), false, "a numeric string is not a contract integer")
  equal(Lib.RequireContract(0 / 0), false, "NaN is not a contract integer")
  equal(Lib.RequireContract(math.huge), false, "infinity is not a contract integer")
  equal(Lib.RequireContract(false), false, "a boolean is not a contract integer")

  -- A third-party addon registers Corrections with no special treatment.
  local registrar = Lib.GetRegistrar("ThirdPartyAddon")
  check(type(registrar.RegisterRuntimeCorrection) == "function", "GetRegistrar returns a registrar")
  registrar.RegisterRuntimeCorrection("Quest", "demo",
    function() return { [2] = { [1] = "Third-party name" } } end, 10)
  registrar.Apply()
  equal(Lib.Quest.Get(2, "name"), "Third-party name", "a third-party correction applies")
  equal(Lib.Quest.GetRaw(2, "name"), "Sharptalon's Claw", "GetRaw bypasses it")
  equal(Lib.GetProvenance("Quest", 2, "name"), "ThirdPartyAddon",
    "the winning correction's owner is discoverable")
  local owners = Lib.GetOwners()
  check(#owners >= 2, "GetOwners exposes applied order")
  equal(owners[#owners], "ThirdPartyAddon", "the last applied owner is last")

  -- A consumer-owned correction can reuse one mutable table as its runtime policy changes.
  local npcKeys = Lib.Meta.NpcMeta.npcKeys
  local baseNpcName = Lib.Npc.GetRaw(123, "name")
  local activeNpcCorrections = {
    [123] = { [npcKeys.name] = "Runtime policy: first state" },
  }
  local questieRegistrar = Lib.GetRegistrar("Questie")
  questieRegistrar.RegisterRuntimeCorrection("Npc", "RuntimeDisplayPolicy",
    ---@return table
    function()
      return activeNpcCorrections
    end, 10)
  questieRegistrar.Apply()
  equal(Lib.Npc.Get(123, "name"), "Runtime policy: first state",
    "a Questie-owned runtime policy composes through the public registrar")
  equal(Lib.GetProvenance("Npc", 123, "name"), "Questie",
    "the consumer-owned value records Questie provenance")
  equal(Lib.Npc.GetRaw(123, "name"), baseNpcName,
    "the consumer-owned policy leaves the raw NPC unchanged")

  activeNpcCorrections[123] = { [npcKeys.name] = "Runtime policy: changed state" }
  questieRegistrar.Apply()
  equal(Lib.Npc.Get(123, "name"), "Runtime policy: changed state",
    "re-applying reads the changed consumer-owned table")
  equal(Lib.Npc.GetRaw(123, "name"), baseNpcName,
    "changed policy state still leaves the raw NPC unchanged")

  activeNpcCorrections[123] = nil
  questieRegistrar.Apply()
  equal(Lib.Npc.Get(123, "name"), baseNpcName,
    "clearing the mutable policy table removes its old overlay value")
  equal(Lib.GetProvenance("Npc", 123, "name"), Lib.Corrections.OWNER,
    "clearing the policy restores database provenance")
  equal(Lib.Npc.GetRaw(123, "name"), baseNpcName,
    "clearing the policy does not alter the raw NPC")

  -- Cache lifecycle is public, and the datatype argument is case-insensitive like the
  -- corrections API — `InvalidateCache("quest", 2)` silently no-oping was a live-probed bug.
  check(type(Lib.InvalidateCache) == "function", "InvalidateCache is public")
  Lib.InvalidateCache("Quest", 2)
  equal(Lib.Quest.Get(2, "name"), "Third-party name", "invalidation preserves the composed view")
  Lib.InvalidateCache()
  equal(Lib.Quest.Get(2, "name"), "Third-party name", "a full invalidation also recomposes")
  local invalidatedWith
  local originalInvalidate = Lib.Quest.InvalidateCache
  Lib.Quest.InvalidateCache = function(id) invalidatedWith = id; return originalInvalidate(id) end
  Lib.InvalidateCache("quest", 2)
  equal(invalidatedWith, 2, "a lowercase datatype reaches the entity")
  Lib.Quest.InvalidateCache = originalInvalidate

  -- Read mode is public and unmistakable.
  equal(Lib.readMode, "baked", "readMode is published")
  equal(Lib.ModeIndicator.GetText(), nil, "baked mode shows no source-mode indicator")

  client.reset()
end)

--------------------------------------------------------------------------------------------
-- Localization
--------------------------------------------------------------------------------------------

suite("l10n", "Vanilla", function()
  local tocPath = config.tocPath(config.flavorByName.Vanilla)
  if not lib.fileExists(tocPath) then
    io.write("  SKIP l10n: ", tocPath, " not generated\n")
    return
  end

  client.reset()
  client.install({ expansion = "Classic", locale = "enUS" })
  local deserialize = C_EncodingUtil.DeserializeCBOR
  local deserializeCalls = 0
  C_EncodingUtil.DeserializeCBOR = function(bytes)
    deserializeCalls = deserializeCalls + 1
    return deserialize(bytes)
  end
  local metadataMap = emulator.parse(tocPath)
  local metadataHandle = emulator.install(config.addonName, metadataMap)
  local localizationPartReads = 0
  local localizationBaseReads = {}
  local function countedMetadata(addonName, key)
    if key:find("^X%-l10n%-") and key:find("%-%d+$") then
      localizationPartReads = localizationPartReads + 1
    elseif key == config.l10nHeaderKey or key:match("^X%-l10n%-%a+%-%a+$") then
      localizationBaseReads[key] = (localizationBaseReads[key] or 0) + 1
    end
    return metadataHandle.get(addonName, key)
  end
  C_AddOns.GetAddOnMetadata = countedMetadata
  GetAddOnMetadata = countedMetadata
  local Lib = emulator.loadAddon(tocPath, config.addonName)
  local l10n = Lib.l10n

  if not l10n.IsAvailable() then
    assert(not selectedFlavor, "scoped l10n checks require localization")
    io.write("  SKIP l10n: artifact generated with --no-l10n\n")
    client.reset()
    return
  end

  equal(#config.locales, 9, "all nine non-English locales are declared")
  for _, locale in ipairs({ "deDE", "esES", "esMX", "frFR", "koKR", "ptBR", "ruRU", "zhCN", "zhTW" }) do
    check(l10n.localeIndex[locale] ~= nil, "locale declared: " .. locale)
  end
  equal(l10n.localeIndex.enUS, nil, "enUS is not stored — base data is already English")
  equal(deserializeCalls, 4, "enUS decodes only the four entity ID headers")
  equal(localizationPartReads, 0, "enUS does not reassemble any localization block")
  equal(localizationBaseReads, { [config.l10nHeaderKey] = 1 },
    "enUS reads only the localization format header")

  -- Selecting a non-English locale eagerly decodes exactly one block per entity type.
  local base = Lib.Quest.name(2)
  equal(base, "Sharptalon's Claw", "enUS reads the base value")

  local expectedGermanParts = 0
  for _, entityType in ipairs(config.entityTypes) do
    local marker = metadataMap[config.l10nBlockKey(entityType.name, "deDE")]
    expectedGermanParts = expectedGermanParts + tonumber(marker:match("^~(%d+)~$"))
  end
  localizationPartReads = 0
  localizationBaseReads = {}
  local beforeLocaleDecode = deserializeCalls
  l10n.SetLocale("deDE")
  equal(deserializeCalls - beforeLocaleDecode, 4, "deDE eagerly decodes four localization blocks")
  equal(localizationPartReads, expectedGermanParts,
    "deDE reads each localization chunk part exactly once")
  for _, entityType in ipairs(config.entityTypes) do
    local key = config.l10nBlockKey(entityType.name, "deDE")
    equal(localizationBaseReads[key], 1, "deDE reads its " .. entityType.name .. " block header once")
  end
  equal(Lib.Quest.name(2), "Klaue von Scharfkralle", "deDE quest name")
  local expectedObjectives = {
    "Bringt die Klaue von Scharfkralle zu Senani Thunderheart im Splintertreeposten in Ashenvale.",
  }
  local translatedObjectives = Lib.Quest.objectivesText(2)
  equal(translatedObjectives, expectedObjectives,
    "deDE objectivesText comes back as a list, matching the base field's shape")
  translatedObjectives[1] = "caller mutation"
  equal(Lib.Quest.objectivesText(2), expectedObjectives,
    "translated table reads remain fresh and mutation-isolated")

  local correctedObjectives = { "Corrected localized objective" }
  local objectiveField = Lib.Meta.Quest.keys.objectivesText
  Lib.Corrections.RegisterRuntimeCorrection("L10nTableTest", "Quest", "objectives",
    function() return { [2] = { [objectiveField] = correctedObjectives } } end, 10)
  Lib.Corrections.ApplyRegisteredCorrections("L10nTableTest")
  local correctedFirst = Lib.Quest.objectivesText(2)
  equal(correctedFirst, expectedObjectives,
    "the translated objective list outranks the English correction")
  correctedFirst[1] = "caller mutation"
  equal(Lib.Quest.objectivesText(2), expectedObjectives,
    "a translated field still returns fresh table copies")
  equal(Lib.GetProvenance("Quest", 2, "objectivesText"), "QuestieDB",
    "corrected objective provenance names the winning owner")
  Lib.Corrections.UnregisterCorrection("L10nTableTest", "Quest", "objectives")
  Lib.Corrections.ApplyRegisteredCorrections("L10nTableTest")
  equal(Lib.Quest.objectivesText(2), expectedObjectives,
    "withdrawing a corrected objective list restores the active translation")

  equal(Lib.Npc.name(54), "Corina Steele", "deDE npc name")
  equal(Lib.Npc.subName(54), "Waffenschmiedin", "deDE npc subName")
  equal(Lib.Item.name(25), "Abgenutztes Kurzschwert", "deDE item name")
  equal(Lib.Object.name(31), "Alte Löwenstatue", "deDE object name")

  local invalidations = 0
  local originalInvalidations = {}
  for _, entityType in ipairs(config.entityTypes) do
    local entity = Lib[entityType.name]
    originalInvalidations[entity] = entity.InvalidateCache
    entity.InvalidateCache = function(id)
      invalidations = invalidations + 1
      return originalInvalidations[entity](id)
    end
  end
  local callbacks = 0
  l10n.onLocaleChanged[#l10n.onLocaleChanged + 1] = function() callbacks = callbacks + 1 end
  beforeLocaleDecode = deserializeCalls
  l10n.SetLocale("deDE")
  equal(deserializeCalls - beforeLocaleDecode, 0, "selecting the active locale reuses its blocks")
  equal(invalidations, 0, "selecting the active locale preserves entity caches")
  equal(callbacks, 0, "selecting the active locale fires no change callback")

  local russianKey = config.l10nBlockKey("Item", "ruRU")
  local russianBlock = metadataMap[russianKey]
  metadataMap[russianKey] = nil
  local invalidationsBeforeFailure, callbacksBeforeFailure = invalidations, callbacks
  local switched, switchError = pcall(l10n.SetLocale, "ruRU")
  check(not switched and tostring(switchError):find(russianKey, 1, true) ~= nil,
    "an incomplete replacement locale fails with its missing block key")
  equal(l10n.currentLocale, "deDE", "a failed locale switch keeps the previous locale active")
  equal(Lib.Quest.name(2), "Klaue von Scharfkralle",
    "a failed locale switch keeps previous translations readable")
  equal(invalidations, invalidationsBeforeFailure,
    "a failed locale switch preserves every entity cache")
  equal(callbacks, callbacksBeforeFailure,
    "a failed locale switch fires no change callback")
  metadataMap[russianKey] = russianBlock
  l10n.onLocaleChanged[#l10n.onLocaleChanged] = nil
  for entity, original in pairs(originalInvalidations) do entity.InvalidateCache = original end

  beforeLocaleDecode = deserializeCalls
  l10n.SetLocale("ruRU")
  equal(deserializeCalls - beforeLocaleDecode, 4, "switching locale decodes four replacement blocks")
  equal(Lib.Quest.name(2), "Коготь гиппогрифа Острокогтя", "ruRU quest name, after a switch")
  beforeLocaleDecode = deserializeCalls
  l10n.SetLocale("zhCN")
  equal(deserializeCalls - beforeLocaleDecode, 4, "another locale switch replaces all four blocks")
  equal(Lib.Quest.name(2), "沙普塔隆的爪子", "zhCN quest name, after another switch")

  l10n.SetLocale("enUS")
  equal(Lib.Quest.name(2), base, "switching back to enUS restores the base value")

  -- A field with no translation falls back to the raw English value without reloading blocks.
  local ids = Lib.Quest.GetAllIds()
  l10n.SetLocale("deDE")
  local fallbacks, translated = 0, 0
  for i = 1, math.min(#ids, 400) do
    local localized = Lib.Quest.name(ids[i])
    local english = Lib.Quest.GetRaw(ids[i], "name")
    if localized == english then fallbacks = fallbacks + 1 else translated = translated + 1 end
  end
  check(translated > 0, "translations resolve (" .. translated .. " of 400)")
  check(fallbacks + translated == math.min(#ids, 400), "every id resolves to something")

  -- Field coverage matches what Questie translates today, and no more.
  local covered = {}
  for typeName, fields in pairs(l10n.fields) do
    local names = {}
    for _, field in ipairs(fields) do names[#names + 1] = field.name end
    table.sort(names)
    covered[typeName] = table.concat(names, ",")
  end
  equal(covered.Quest, "name,objectivesText", "quest translates name and objectivesText")
  equal(covered.Npc, "name,subName", "npc translates name and subName")
  equal(covered.Item, "name", "item translates name only")
  equal(covered.Object, "name", "object translates name only")

  l10n.SetLocale("itIT")
  equal(l10n.currentLocale, "itIT", "an unsupported requested locale remains observable")
  equal(l10n.currentIndex, nil, "an unsupported locale has no stored block index")
  equal(Lib.Quest.name(2), base, "an unsupported locale falls back to base English")

  l10n.SetLocale("enUS")
  C_EncodingUtil.DeserializeCBOR = deserialize

  -- A selected type is determined by its non-empty base ID header, not by whichever locale
  -- block happens to exist. Missing deDE data must fail an initial deDE load atomically.
  client.reset()
  client.install({ expansion = "Classic", locale = "deDE" })
  local incompleteMap = emulator.parse(tocPath)
  local missingGermanKey = config.l10nBlockKey("Item", "deDE")
  incompleteMap[missingGermanKey] = nil
  emulator.install(config.addonName, incompleteMap)
  local loaded, loadError = pcall(emulator.loadAddon, tocPath, config.addonName)
  check(not loaded and tostring(loadError):find(missingGermanKey, 1, true) ~= nil,
    "an initial non-enUS load rejects a missing selected-type block")

  client.reset()
end)

--------------------------------------------------------------------------------------------
-- Translation corrections
--------------------------------------------------------------------------------------------

suite("translation-corrections", "shared", function()
  dofile("tools/validation/translation-corrections.test.lua")(check, equal)
end)

suite("titan-translations", "shared", function()
  dofile("tools/validation/titan-translations.test.lua")(check, equal, "Source")
end)

suite("sod-required-races-baked", "Vanilla", function()
  dofile("tools/validation/sod-required-races.test.lua")(check, equal, "Baked")
end)

suite("titan-translations-baked", "Wrath", function()
  dofile("tools/validation/titan-translations.test.lua")(check, equal, "Baked")
end)

--------------------------------------------------------------------------------------------
-- Objective ordering hints
--------------------------------------------------------------------------------------------

suite("objective-first", "shared", function()
  dofile("tools/validation/objective-first.test.lua")(check, equal)
end)

suite("objective-first-source", "shared", function()
  dofile("tools/validation/objective-first-addon.test.lua")(check, equal, "Source")
end)

suite("objective-first-addon", { Vanilla = true, TBC = true, Wrath = true, Cata = true, Mists = true }, function()
  dofile("tools/validation/objective-first-addon.test.lua")(check, equal, selectedFlavor)
end)

--------------------------------------------------------------------------------------------
-- Support data
--------------------------------------------------------------------------------------------

suite("support", "shared", function()
  -- Loading the largest flavor before the smallest exposes leaked modules and map variants.
  local sourceFiles = config.sourceFileList(config.flavorByName.Mists)
  local positions = {}
  for index, file in ipairs(sourceFiles) do positions[file] = index end
  check(positions["support/DropTables/mopItemDrops.lua"] < positions["support/DropTables/cataItemDrops.lua"],
    "Source preserves the cumulative MoP-then-Cata drop load order")
  -- Reuse both the environment and Support singleton across complete load blocks. A fresh
  -- library per flavor would hide stale state in Install/Remove.
  local previousLoader = {}
  local env = setmetatable({ QuestieLoader = previousLoader }, { __index = _G })
  env._G = env
  local namespace = { config = config }
  local enumFiles = {}
  for _, path in ipairs(config.enumFiles) do
    enumFiles[path] = true
    setfenv(assert(loadfile(path)), env)("QuestieDB", namespace)
  end
  setfenv(assert(loadfile("src/support/data.lua")), env)("QuestieDB", namespace)
  local support = namespace.Support

  ---@param flavor table
  ---@param faction string
  ---@return table modules
  local function loadSupportBlock(flavor, faction)
    namespace.flavor = flavor
    env.UnitFactionGroup = function() return faction end
    for _, file in ipairs(config.supportFiles(flavor)) do
      if not enumFiles[file] and file ~= "src/support/data.lua" then
        setfenv(assert(loadfile(file)), env)("QuestieDB", namespace)
      end
    end
    return support.GetAll()
  end

  local mists = loadSupportBlock(config.flavorByName.Mists, "Horde")
  check(env.QuestieLoader == previousLoader, "Mists loading restores the existing QuestieLoader")
  local vanilla = loadSupportBlock(config.flavorByName.Vanilla, "Alliance")
  check(env.QuestieLoader == previousLoader, "Vanilla reloading restores the existing QuestieLoader")
  check(namespace.Support == support, "both flavors used the same Support singleton")
  check(mists.QuestieMopItemDrops ~= nil and mists.QuestieCataItemDrops ~= nil,
    "Mists retains both MoP and Cata drop modules")
  check(vanilla.QuestieClassicItemDrops ~= nil and vanilla.QuestieMopItemDrops == nil and
    vanilla.QuestieCataItemDrops == nil, "Vanilla retains no drop modules from the preceding Mists load")
  check(type(vanilla.ZoneDB.private.areaIdToUiMapId) == "string",
    "support publication preserves authored Lua source strings")

  env.QuestieLoader = nil
  support.Install(config.flavorByName.Vanilla)
  support.Remove()
  equal(rawget(env, "QuestieLoader"), nil, "removal restores an originally absent QuestieLoader")

  -- Known missing blocks: five Era items and four TBC items, with all 37 NPC pairs.
  local drops = vanilla.QuestieItemDropCorrections
  local wowhead = vanilla.DropDB.correctionKeys.WOWHEAD
  equal(drops.Era[5030], {
    [3272] = wowhead, [3273] = wowhead, [3274] = wowhead, [3275] = wowhead,
    [3394] = wowhead, [3395] = wowhead, [3396] = wowhead, [3397] = wowhead,
    [5837] = wowhead, [5838] = wowhead, [5841] = wowhead, [9456] = wowhead,
    [9523] = wowhead, [9524] = wowhead,
  }, "Centaur Bracers use Wowhead rates for all fourteen NPCs")
  equal(drops.Era[5062], { [3254] = wowhead, [3255] = wowhead, [3256] = wowhead,
    [3257] = wowhead, [5842] = wowhead }, "Raptor Heads use Wowhead rates")
  equal(drops.Era[5086], { [3242] = wowhead, [3426] = wowhead, [3466] = wowhead,
    [5831] = wowhead }, "Zhevra Hooves use Wowhead rates")
  equal(drops.Era[10551], { [5839] = 50, [5840] = 50, [5843] = 50, [5844] = 50,
    [5846] = 50, [8337] = 50, [8504] = 50, [8566] = 50, [8637] = 50 },
    "Thorium Plated Daggers have fifty-percent rates")
  equal(drops.Era[11725], { [5856] = wowhead }, "Solid Crystal Leg Shaft uses Wowhead rates")
  equal(drops.Tbc[25767], { [18585] = 100 }, "Raliq's Debt is guaranteed")
  equal(drops.Tbc[25768], { [18586] = 100 }, "Coosh'coosh's Debt is guaranteed")
  equal(drops.Tbc[25769], { [18588] = 100 }, "Floon's Debt is guaranteed")
  equal(drops.Tbc[31957], { [20520] = 100 }, "Ethereum Prisoner I.D. Tag is guaranteed")
  equal(vanilla.ZoneDB.private.dungeons[209][2], {10014,10015,10016,10017,10018,10019},
    "Shadowfang Keep publishes all alternative areas as a list")
  equal(vanilla.ZoneDB.private.dungeons[3959][4], {{3520, 71, 46.4}},
    "Black Temple preserves authored entrance coordinates")
end)

--------------------------------------------------------------------------------------------
-- Emulator
--------------------------------------------------------------------------------------------

suite("emulator", "shared", function()
  lib.mkdirp(".out")
  local path = ".out/test-emulator.toc"
  lib.writeAll(path, table.concat({
    "# comment",
    "## Interface: 11508",
    "## X-Flavor: Vanilla",
    "## X-T-1-1: hello",
    "## X-T-1-2: ",
    "",
  }, "\n"))

  local map, header = emulator.parse(path)
  equal(header["Interface"], "11508", "ordinary directive parsed")
  equal(header["X-Flavor"], "Vanilla", "X- directive appears in the header view too")
  equal(map["Interface"], nil, "ordinary directive is not stored data")
  equal(map["X-T-1-1"], "hello", "stored value parsed")
  equal(map["X-T-1-2"], "", "empty stored value parsed rather than dropped")

  local handle = emulator.install("QuestieDB", map)
  equal(handle.get("QuestieDB", "X-T-1-1"), "hello", "installed accessor reads")
  equal(handle.get("SomeOtherAddon", "X-T-1-1"), nil, "accessor is scoped to its addon")
  equal(C_AddOns.GetAddOnMetadata("QuestieDB", "X-T-1-1"), "hello", "C_AddOns global installed")

  local ok = pcall(emulator.parse, ".out/does-not-exist.toc")
  check(not ok, "parsing a missing file must raise")

  os.remove(path)
end)

--------------------------------------------------------------------------------------------
-- Wire safety: trim-safe splitting, case-folded keys (ADR 0003 D4, D5)
--------------------------------------------------------------------------------------------

suite("wire-safety", "shared", function()
  lib.mkdirp(".out")
  local path = ".out/test-wire.toc"

  local function emit(key, value, maxLen)
    local out = assert(io.open(path, "wb"))
    out:write("## Interface: 11508\n\n")
    lib.writeMetadata(out, key, value, maxLen)
    out:close()
    return emulator.parse(path)
  end

  -- The client trims each stored value's edges (measured, docs/client-metadata-probes.md §1).
  -- Simulate exactly that per part and require lossless reassembly.
  local function clientTrim(s) return s:match("^[ \t\r\n]*(.-)[ \t\r\n]*$") end
  local function clientJoin(map, key)
    local header = map[key]
    if not header:match("^~%d+~$") then return clientTrim(header) end
    local joined = {}
    for i = 1, tonumber(header:match("%d+")) do
      joined[#joined + 1] = clientTrim(map[key .. "-" .. i])
    end
    return table.concat(joined)
  end

  -- A space sitting exactly at the split point must move the split, not straddle it.
  local spaceAtBoundary = string.rep("x", 999) .. " " .. string.rep("y", 500)
  local map = emit("X-T-1-1", spaceAtBoundary, 1000)
  equal(clientJoin(map, "X-T-1-1"), spaceAtBoundary, "client-trimmed reassembly is lossless")
  for i = 1, tonumber(map["X-T-1-1"]:match("%d+")) do
    local part = map["X-T-1-1-" .. i]
    check(not part:match("^[ \t\r\n]") and not part:match("[ \t\r\n]$"),
      "part " .. i .. " has no trimmable edge")
  end

  -- A run of spaces near the boundary backs the split up past the whole run.
  local runNearBoundary = string.rep("a", 995) .. "     " .. string.rep("b", 995)
  map = emit("X-T-1-2", runNearBoundary, 1000)
  equal(clientJoin(map, "X-T-1-2"), runNearBoundary, "space-run value reassembles losslessly")
  for i = 1, tonumber(map["X-T-1-2"]:match("%d+")) do
    local part = map["X-T-1-2-" .. i]
    check(not part:match("^[ \t\r\n]") and not part:match("[ \t\r\n]$"),
      "run part " .. i .. " has no trimmable edge")
  end

  -- Multibyte text with spaces — both split constraints at once.
  local mixed = string.rep("Bringt die Klaue von Scharfkralle ‡u Senani ", 60)
  mixed = mixed:sub(1, #mixed - 1) -- no trailing space: whole-value edges are the encoder's job
  map = emit("X-T-1-3", mixed, 1000)
  equal(clientJoin(map, "X-T-1-3"), mixed, "utf-8 + spaces reassemble losslessly under client trim")

  -- A whitespace run longer than a part cannot split trim-safely: build failure, not corruption.
  do
    local out = assert(io.open(path, "wb"))
    local ok, err = pcall(lib.writeMetadata, out, "X-T-1-4",
      "x" .. string.rep(" ", 2000) .. "y", 1000)
    out:close()
    check(not ok and tostring(err):find("whitespace run"),
      "unsplittable whitespace run fails the build: " .. tostring(err))
  end

  -- Whole-value edges are refused at the chokepoint — the encoders must never produce them.
  do
    local out = assert(io.open(path, "wb"))
    local okLead = pcall(lib.writeMetadata, out, "X-T-1-5", " leading", 1000)
    local okTrail = pcall(lib.writeMetadata, out, "X-T-1-6", "trailing ", 1000)
    out:close()
    check(not okLead, "leading-whitespace value is refused at write time")
    check(not okTrail, "trailing-whitespace value is refused at write time")
  end

  -- GetAddOnMetadata folds key case (measured §2): a case-only key collision is one key to
  -- the client, so generation must refuse it.
  do
    local out = assert(io.open(path, "wb"))
    lib.writeMetadata(out, "X-Abc-1", "one", 1000)
    local ok, err = pcall(lib.writeMetadata, out, "X-ABC-1", "two", 1000)
    out:close()
    check(not ok and tostring(err):find("case%-insensitively"),
      "case-folded key collision is refused: " .. tostring(err))
  end

  -- Cross-family prefixes must differ by more than case, since the per-handle registry
  -- cannot see across the entity pass and the l10n append pass.
  do
    local prefixes = {}
    for _, entityType in ipairs(config.entityTypes) do
      prefixes[#prefixes + 1] = ("x-" .. entityType.metaPrefix):lower()
      prefixes[#prefixes + 1] = ("x-" .. config.l10nMetaPrefix .. entityType.metaPrefix):lower()
    end
    for i = 1, #prefixes do
      for j = 1, #prefixes do
        if i ~= j then
          check(prefixes[i]:sub(1, #prefixes[j]) ~= prefixes[j],
            ("key families %q and %q overlap case-insensitively"):format(prefixes[i], prefixes[j]))
        end
      end
    end
  end


  os.remove(path)
end)

suite("artifact-wire", "artifact", function()
  -- Every artifact on disk honors the edge-whitespace invariant, exactly as verify.lua checks.
  for _, flavor in ipairs(artifactFlavors) do
    local tocPath = config.tocPath(flavor)
    if lib.fileExists(tocPath) then
      local offending = 0
      local file = assert(io.open(tocPath, "rb"))
      for line in file:lines() do
        line = line:gsub("\r$", "")
        if line:sub(1, 5) == "## X-" then
          local value = line:match("^## [^:]+: (.*)$")
          if value and #value > 0 and
             (lib.TRIMMABLE[value:byte(1)] or lib.TRIMMABLE[value:byte(#value)]) then
            offending = offending + 1
          end
        end
      end
      file:close()
      check(offending == 0,
        ("%s has %d values with client-trimmable edges"):format(tocPath, offending))
    end
  end

end)

--------------------------------------------------------------------------------------------
-- Raw production coordinates (ADR 0006)
--------------------------------------------------------------------------------------------

suite("raw-coordinates", "shared", function()
  local meta = {
    entity = "Test",
    fieldCount = 4,
    names = { "spawns", "waypoints", "triggerEnd", "extraObjectives" },
    types = { "table", "table", "table", "table" },
    structures = { "spawnlist", "waypointlist", "trigger", "extraobjectives" },
    emptyIsNil = { [1] = true, [2] = true, [3] = true, [4] = true },
    zeroPairIsNil = {},
    normalize = {},
    keys = { spawns = 1, waypoints = 2, triggerEnd = 3, extraObjectives = 4 },
  }

  equal(normalize.field(meta, 1, { [1440] = { { 36.43, 55.89 } } }),
    { [1440] = { { 36.43, 55.89 } } }, "spawn coordinates retain authored precision")
  equal(normalize.field(meta, 1, { [1440] = { { -1, -1 } } }),
    { [1440] = { { -1, -1 } } }, "explicit instance sentinel survives")
  equal(normalize.field(meta, 1, { [1440] = { { 0, 0 } } }),
    { [1440] = { { 0, 0 } } }, "zero coordinates remain real coordinates")
  equal(normalize.field(meta, 1, { [1440] = { { 0.001, 0.002 } } }),
    { [1440] = { { 0.001, 0.002 } } }, "sub-grid coordinates retain their precision")
  equal(normalize.field(meta, 1, { [1440] = { { 10, 20, 3 } } }),
    { [1440] = { { 10, 20, 3 } } }, "nonzero spawn phase survives")
  equal(normalize.field(meta, 1, { [1440] = { { 10, 20, 0 } } }),
    { [1440] = { { 10, 20 } } }, "spawn phase zero remains omitted")

  equal(normalize.field(meta, 2, { [85] = { { { 52.5, 47.25 }, { -1, -1 } } } }),
    { [85] = { { { 52.5, 47.25 }, { -1, -1 } } } },
    "waypoints retain raw coordinates through their extra nesting level")
  equal(normalize.field(meta, 2, { [85] = { { { 52.5, 47.25, 9 } } } }),
    { [85] = { { { 52.5, 47.25 } } } },
    "waypoint third element remains omitted")

  equal(normalize.field(meta, 3, { "Scout the tower", { [85] = { { 52.5, 47.25 } } } }),
    { "Scout the tower", { [85] = { { 52.5, 47.25 } } } },
    "trigger text and nested raw coordinates survive")
  equal(normalize.field(meta, 4, {
    { { [85] = { { 52.5, 47.25 } } }, 42, "Use the thing", 1, { { "monster", 5 } } },
  }), {
    { { [85] = { { 52.5, 47.25 } } }, 42, "Use the thing", 1, { { "monster", 5 } } },
  }, "extraObjectives preserves its nested raw coordinates and other slots")

  local input = { [1440] = { { 36.43, 55.89, 2 } } }
  normalize.field(meta, 1, input)
  equal(input, { [1440] = { { 36.43, 55.89, 2 } } },
    "coordinate normalization does not mutate source data")

  local encoded = encode.field(meta, 1, { [1440] = { { 36.43, 55.89 } } })
  equal(cbor.decode(base64.decode(encoded)), { [1440] = { { 36.43, 55.89 } } },
    "Baked decoding returns the same raw coordinates")

  local computed = 1 / 3
  local computedEncoded = encode.field(meta, 1, { [1440] = { { computed, computed * 2 } } })
  equal(cbor.decode(base64.decode(computedEncoded)), { [1440] = { { computed, computed * 2 } } },
    "computed coordinates retain every significant digit needed to round-trip")
end)

--------------------------------------------------------------------------------------------
-- Personas: branches the default Alliance-Human persona can never execute
--------------------------------------------------------------------------------------------

---@param path string
---@param clientOpts table
---@return table
local function loadPersona(path, clientOpts)
  client.reset()
  client.install(clientOpts)
  if path ~= config.addonName .. ".toc" then
    emulator.install(config.addonName, emulator.parse(path))
  end
  return emulator.loadAddon(path, config.addonName)
end

suite("personas", "Vanilla", function()
  local tocPath = config.tocPath(config.flavorByName.Vanilla)
  if not lib.fileExists(tocPath) then
    io.write("  SKIP personas: ", tocPath, " not generated\n")
    return
  end

  -- Faction oracle: Soothing Spices (item 3713). `LoadFactionFixes` points its relatedQuests
  -- at the Alliance quest 555 or the Horde quest 7321 — src/corrections/Era/
  -- classicItemFixes.lua:1612 (Alliance) and :1632 (Horde). Literal expected values, so a
  -- persona plumbing regression cannot pass by comparing one wrong answer against itself.
  local sourceAlliance = loadPersona(config.addonName .. ".toc", { expansion = "Classic" })
  equal(sourceAlliance.Item.Get(3713, "relatedQuests"), { 555, 1218 },
    "source Alliance: Soothing Spices relates to quest 555")

  local sourceHorde = loadPersona(config.addonName .. ".toc", { expansion = "Classic", faction = "Horde" })
  equal(sourceHorde.Item.Get(3713, "relatedQuests"), { 7321, 1218 },
    "source Horde: Soothing Spices relates to quest 7321 — the Horde branch actually ran")

  local bakedHorde = loadPersona(tocPath, { faction = "Horde" })
  equal(bakedHorde.Item.Get(3713, "relatedQuests"), { 7321, 1218 },
    "baked Horde: the faction branch composes identically over the artifact")

  -- Season persona: with Season of Discovery active the gated Sod/ sets register and the SoD
  -- base quests join the composed view. Counts are compared, not hardcoded — the data moves.
  local plain = loadPersona(config.addonName .. ".toc", { expansion = "Classic" })
  local plainIds = plain.Quest.GetAllIds(true)
  local plainCount = #plain.Quest.GetAllIds()

  local sod = loadPersona(config.addonName .. ".toc", { expansion = "Classic", season = "SoD" })
  local sodList = sod.Quest.GetAllIds()
  check(#sodList > plainCount, "SoD persona: the composed quest list grows")

  local addedId
  for _, id in ipairs(sodList) do
    if not plainIds[id] then addedId = id break end
  end
  check(addedId ~= nil, "SoD persona: an added quest id is enumerable")
  if addedId then
    equal(sod.Quest.Exists(addedId), true, "SoD persona: an added quest exists")
    check(select("#", sod.Quest.Get(addedId, 1)) >= 0, "SoD persona: an added quest reads without raising")
    equal(plain.Quest.Exists(addedId), false, "plain Era: the same quest does not exist")
  end

  local sodSets = 0
  for _, entry in ipairs(sod.Corrections.Select({ dynamic = true })) do
    if entry.name:find("^Sod/") then sodSets = sodSets + 1 end
  end
  check(sodSets > 0, "SoD persona: Sod/ correction sets registered")

  client.reset()
end)

suite("personas-titan", "Wrath", function()
  -- Titan Reforged is a Dynamic variant over Wrath, selected by Wrath plus season 109.
  -- Probe: quest 6823 "Agent of Hydraxis" gains level 80.
  ---Counts the dedicated Titan providers.
  ---@param loaded table Loaded QuestieDB namespace.
  ---@return integer count
  local function titanSets(loaded)
    local count = 0
    for _, entry in ipairs(loaded.Corrections.Select({ dynamic = true })) do
      if entry.name:find("^Titan/") then count = count + 1 end
    end
    return count
  end

  local plainWrath = loadPersona(config.addonName .. ".toc", { expansion = "Wotlk", faction = "Horde" })
  equal(titanSets(plainWrath), 0, "plain Wrath: no Titan set registers")
  equal(plainWrath.Quest.Get(6823, "questLevel"), plainWrath.Quest.GetRaw(6823, "questLevel"),
    "plain Wrath: quest 6823 keeps its base questLevel")
  check(plainWrath.Quest.Get(6823, "questLevel") ~= 80, "plain Wrath: the Titan 80 never applies")

  local titanWrath = loadPersona(config.addonName .. ".toc",
    { expansion = "Wotlk", faction = "Horde", season = "TitanReforged" })
  equal(titanSets(titanWrath), 8, "Titan persona: every declared Titan provider registers")
  local titanOrder = {}
  for _, entry in ipairs(titanWrath.Corrections.Select({ dynamic = true })) do
    if entry.name:find("^Titan/") then
      titanOrder[#titanOrder + 1] = { entry.name, entry.loadOrder }
    end
  end
  equal(titanOrder, {
    { "Titan/titanReforgedQuestFixes.lua:LoadQuests", 911 },
    { "Titan/titanReforgedNPCFixes.lua:LoadNPCs", 911 },
    { "Titan/titanReforgedItemFixes.lua:LoadItems", 911 },
    { "Titan/titanReforgedObjectFixes.lua:LoadObjects", 911 },
    { "Titan/titanReforgedQuestFixes.lua:LoadQuestOverrides", 912 },
    { "Titan/titanReforgedNPCFixes.lua:LoadNPCOverrides", 912 },
    { "Titan/titanReforgedItemFixes.lua:LoadItemOverrides", 912 },
    { "Titan/titanReforgedNPCFixes.lua:LoadFactionNPCOverrides", 913 },
  }, "Titan persona: provider application order stays base, overrides, then faction overrides")
  equal(titanWrath.Quest.Get(6823, "questLevel"), 80, "Titan persona: quest 6823 questLevel 80")
  equal(titanWrath.Quest.Get(6823, "requiredLevel"), 80, "Titan persona: quest 6823 requiredLevel 80")

  -- Dedicated providers restore Titan-only rows over plain Wrath. These literal probes catch
  -- an empty, misordered, or misclassified provider even when all eight functions registered.
  ---Checks every Titan provider through representative public reads.
  ---@param plainView table Plain Wrath namespace.
  ---@param titanView table Titan Reforged namespace.
  ---@param label string Assertion prefix identifying the read mode.
  ---@return nil
  local function checkTitanView(plainView, titanView, label)
    local addedEntities = {
      { entity = titanView.Quest, id = 93950, name = "quest" },
      { entity = titanView.Npc, id = 257012, name = "NPC" },
      { entity = titanView.Item, id = 264272, name = "Item" },
      { entity = titanView.Object, id = 420002, name = "Object" },
    }
    for _, probe in ipairs(addedEntities) do
      equal(probe.entity.Exists(probe.id), true,
        label .. ": Titan-only " .. probe.name .. " exists")
      equal(probe.entity.GetAllIds(true)[probe.id], true,
        label .. ": Titan-only " .. probe.name .. " is enumerable")
    end

    equal(plainView.Quest.Exists(93950), false,
      label .. ": Titan-only quest is absent from plain Wrath")
    equal(titanView.Quest.Get(93950, "name"), "A Message From The Stars",
      label .. ": LoadQuests adds Titan quest templates")
    equal(titanView.Quest.Get(6823, "questLevel"), 80,
      label .. ": LoadQuestOverrides changes inherited quests")

    equal(plainView.Npc.Exists(257012), false,
      label .. ": Titan-only NPC is absent from plain Wrath")
    equal(titanView.Npc.Get(257012, "name"), "Algalon the Observer",
      label .. ": LoadNPCs adds Titan NPCs")
    equal(titanView.Npc.Get(14834, "minLevel"), 83,
      label .. ": LoadNPCOverrides changes inherited NPCs")
    local zoneIDs = titanView.Support.Get("ZoneDB").zoneIDs
    equal(titanView.Npc.Get(257012, "zoneID"), zoneIDs.DUROTAR,
      label .. ": LoadFactionNPCOverrides selects the Horde capital")

    equal(plainView.Item.Exists(264272), false,
      label .. ": Titan-only Item is absent from plain Wrath")
    equal(titanView.Item.Get(264272, "name"), "Celestial Missive",
      label .. ": LoadItems adds Titan Items")
    equal(titanView.Item.Get(22734, "npcDrops"), { 15172 },
      label .. ": LoadItemOverrides changes inherited Items")

    equal(plainView.Object.Exists(420002), false,
      label .. ": Titan-only Object is absent from plain Wrath")
    equal(titanView.Object.Get(420002, "name"), "Blood Ritual Altar",
      label .. ": LoadObjects adds Titan Objects")
  end

  checkTitanView(plainWrath, titanWrath, "source Titan")

  -- The ungated sibling function still applies with the gate closed AND open: Horde elder
  -- quest 13012 gains reputationReward {{HORDE, 75}} from LoadFactionFixes
  -- (src/corrections/Wotlk/wotlkQuestFixes.lua, questFixesHorde).
  local plainRep = plainWrath.Quest.Get(13012, "reputationReward")
  check(type(plainRep) == "table" and plainRep[1] and plainRep[1][2] == 75,
    "plain Wrath: faction fixes still apply alongside the closed gate")
  local titanRep = titanWrath.Quest.Get(13012, "reputationReward")
  check(type(titanRep) == "table" and titanRep[1] and titanRep[1][2] == 75,
    "Titan persona: faction fixes unaffected by the open gate")

  -- Season 109 is not Season of Discovery: the Sod/ sets must not mistake it.
  local titanSod = 0
  for _, entry in ipairs(titanWrath.Corrections.Select({ dynamic = true })) do
    if entry.name:find("^Sod/") then titanSod = titanSod + 1 end
  end
  equal(titanSod, 0, "Titan persona: Sod/ sets do not register on season 109")

  -- Baked mode composes the same gate: the Wrath artifact plus a Titan persona reads 80.
  local wrathToc = config.tocPath(config.flavorByName.Wrath)
  if lib.fileExists(wrathToc) then
    local bakedTitan = loadPersona(wrathToc, { expansion = "Wotlk", faction = "Horde", season = "TitanReforged" })
    equal(bakedTitan.Quest.Get(6823, "questLevel"), 80, "baked Titan: gate composes over the artifact")
    local bakedPlain = loadPersona(wrathToc, { expansion = "Wotlk", faction = "Horde" })
    check(bakedPlain.Quest.Get(6823, "questLevel") ~= 80, "baked plain Wrath: gate stays closed")
    checkTitanView(bakedPlain, bakedTitan, "baked Titan")
  end

  client.reset()
end)

--------------------------------------------------------------------------------------------
-- Perf guard: the cached hot path must not allocate beyond the fresh value itself
--------------------------------------------------------------------------------------------

suite("perf-guard", "Vanilla", function()
  local tocPath = config.tocPath(config.flavorByName.Vanilla)
  if not lib.fileExists(tocPath) then
    io.write("  SKIP perf-guard: ", tocPath, " not generated\n")
    return
  end

  client.reset()
  client.install({})
  local map = emulator.parse(tocPath)
  emulator.install(config.addonName, map)
  local Lib = emulator.loadAddon(tocPath, config.addonName)

  local N = 5000

  --- Bytes allocated by `fn` run N times, with the collector stopped so every allocation is
  --- visible and none is reclaimed mid-measurement.
  local function allocatedBytes(fn)
    collectgarbage("collect")
    collectgarbage("stop")
    local before = collectgarbage("count")
    for _ = 1, N do fn() end
    local grown = (collectgarbage("count") - before) * 1024
    collectgarbage("restart")
    collectgarbage("collect")
    return grown
  end

  -- Warm both paths so the measured loops see only cache hits.
  Lib.Quest.Get(2, "name")
  Lib.Quest.Get(2, "startedBy")

  -- A cached scalar read allocates nothing at all. The tightest possible guard against the
  -- reviewed sibling's defect class (an eager assert-message concat on every read): a single
  -- per-read string is ≥ 24 bytes, i.e. ≥ 120,000 bytes over this loop, against a bound of 512.
  local scalarBytes = allocatedBytes(function() return Lib.Quest.Get(2, "name") end)
  check(scalarBytes <= 512,
    ("cached scalar reads allocated %d bytes over %d reads — the hot path is allocating"):format(scalarBytes, N))

  -- A cached table read allocates exactly what the producer itself allocates — the fresh
  -- copy — and nothing on top. Tolerance: 16 bytes per read, smaller than any real string.
  local tableKey = "X-Quest-2-" .. tostring(Lib.Meta.QuestMeta.questKeys.startedBy)
  local stored = emulator.getValue(map, tableKey)
  check(stored ~= nil, "quest 2 startedBy stored CBOR found for calibration")
  local bytes = base64.decode(stored)
  local producer = function() return cbor.decode(bytes) end
  local baseline = allocatedBytes(function() return producer() end)
  local viaGet = allocatedBytes(function() return Lib.Quest.Get(2, "startedBy") end)
  check(viaGet - baseline <= N * 16,
    ("cached table reads allocated %d bytes beyond the %d-byte producer baseline over %d reads")
      :format(viaGet - baseline, baseline, N))

  client.reset()
end)

--------------------------------------------------------------------------------------------
-- Reconstruction negative control: the byte gate must detect one corrupted Scalar row
--------------------------------------------------------------------------------------------

suite("reconstruct-control", "Vanilla", function()
  local flavor = config.flavorByName.Vanilla
  local sourceToc = config.tocPath(flavor)
  if not lib.fileExists(sourceToc) then
    io.write("  SKIP reconstruct-control: ", sourceToc, " not generated\n")
    return
  end

  lib.mkdirp(".out/corrupt")
  local original = lib.readAll(sourceToc)
  local corrupted, corruptedCount =
    replaceScalarInRow(original, "Npc", 30, 1, "Not A Forest Spider")
  check(corruptedCount == 1, "corruption fixture did not apply")
  lib.writeAll(".out/corrupt/" .. sourceToc, corrupted)

  local countFile = ".out/reconstruct-count.txt"
  local ok = lib.execute(shellQuote(LUA_BIN) ..
    " reconstruct.lua Vanilla --toc-dir=.out/corrupt --count-only > " ..
    shellQuote(countFile) .. " 2>" .. lib.nullDevice)
  local failed
  if type(ok) == "number" then failed = ok ~= 0 else failed = not ok end
  check(failed, "reconstruct accepted a corrupted artifact")
  local counted = tonumber((lib.readAll(countFile):match("(%d+)")))
  equal(counted, 1, "one corrupted byte is exactly one localized mismatch")

  os.remove(".out/corrupt/" .. sourceToc)
  os.remove(countFile)
end)

--------------------------------------------------------------------------------------------
-- Driver
--------------------------------------------------------------------------------------------

local requested, scope, listOnly
for _, value in ipairs(arg or {}) do
  if value == "--list" and not listOnly then
    listOnly = true
  elseif value == "--shared" or value:match("^%-%-flavor=") then
    if scope or requested then
      io.stderr:write("Choose one scope, or named suites, not both.\n")
      os.exit(2)
    end
    scope = value
    if value ~= "--shared" then
      selectedFlavor = config.flavorByName[value:sub(10)]
      if not selectedFlavor then
        io.stderr:write("Unknown flavor: ", value:sub(10), "\n")
        os.exit(2)
      end
    end
  else
    if scope or not suites[value] then
      io.stderr:write("Unknown suite or incompatible selection: ", value, "\n")
      os.exit(2)
    end
    requested = requested or {}
    requested[value] = true
  end
end

if scope then
  requested = {}
  for _, name in ipairs(order) do
    requested[name] = scope == "--shared" and scopes[name] == "shared" or
      selectedFlavor ~= nil and (scopes[name] == "artifact" or scopes[name] == selectedFlavor.name or
        (type(scopes[name]) == "table" and scopes[name][selectedFlavor.name] == true))
  end
  artifactFlavors = selectedFlavor and { selectedFlavor } or {}
elseif requested then
  -- Existing suite names still include the assertions split out for pipeline ownership.
  local companions = {
    chunking = "artifact-lines", ["wire-safety"] = "artifact-wire",
    ["lua-types"] = "artifact-types", personas = "personas-titan",
    ["sod-required-races"] = "sod-required-races-baked",
    ["titan-translations"] = "titan-translations-baked",
  }
  for name, companion in pairs(companions) do
    if requested[name] then requested[companion] = true end
  end
end

if listOnly then
  for _, name in ipairs(order) do
    if not requested or requested[name] then print(name) end
  end
  os.exit(0)
end

if selectedFlavor then
  -- Scoped runs are release gates: partial Generation must fail, never silently skip.
  local path = config.tocPath(selectedFlavor)
  local ok, message = pcall(function()
    local map, headers = emulator.parse(path)
    assert(headers["X-Flavor"] == selectedFlavor.name, path .. " has the wrong flavor")
    assert(map[config.l10nHeaderKey] == tostring(config.l10nVersion), path .. " needs full localization")
    for _, entity in ipairs(config.entityTypes) do
      assert(map["X-" .. entity.metaPrefix .. "IDS"], path .. " lacks " .. entity.name .. " IDs")
      for _, locale in ipairs(config.locales) do
        local key = config.l10nBlockKey(entity.name, locale)
        assert(emulator.getValue(map, key), path .. " lacks " .. key)
      end
    end
  end)
  if not ok then
    io.stderr:write("Artifact preflight failed: ", tostring(message), "\n")
    os.exit(1)
  end
end

local totalFailed, totalChecks = 0, 0

for _, name in ipairs(order) do
  if not requested or requested[name] then
    current = { name = name, total = 0, failed = 0 }
    local ok, err = pcall(suites[name])
    if not ok then
      current.failed = current.failed + 1
      io.write("  ERROR ", name, ": ", tostring(err), "\n")
    end
    print(("[%s] %-18s %d checks, %d failed")
      :format(current.failed == 0 and "PASS" or "FAIL", name, current.total, current.failed))
    totalFailed = totalFailed + current.failed
    totalChecks = totalChecks + current.total
  end
end

print(("%d checks, %d failed"):format(totalChecks, totalFailed))
os.exit(totalFailed == 0 and 0 or 1)
