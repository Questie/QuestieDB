"""Read owned ZoneDB support literals without executing Lua providers."""
from __future__ import annotations

from dataclasses import dataclass
from typing import Optional

from rewrite import Tables, _lex


@dataclass
class SupportTable:
    """Values, original literal and source-preserving insertion offsets."""

    values: dict[int, int]
    literal: str
    closing: int
    missing_comma_at: Optional[int]


_HEADER = ['local', 'ZoneDB', '=', 'QuestieLoader', ':', 'ImportModule', '(', '"ZoneDB"', ')']


def _read_literal(source: str, tokens: list, literal: str,
                  zone_ids: Optional[dict[str, int]] = None) -> SupportTable:
    parsed = Tables(source, tokens)
    fields = parsed.fields((0, len(tokens)))
    values = {}
    for entry in fields:
        if entry.position is not None:
            raise ValueError("ZoneDB support needs explicit integer keys")
        key = parsed.integer(entry.key)
        expression = parsed.text(entry.value)
        if zone_ids is not None and expression.startswith("ZoneDB.zoneIDs."):
            symbol = expression[len("ZoneDB.zoneIDs."):]
            if symbol not in zone_ids:
                parsed.fail(entry.value[0], "Unknown owned zone symbol " + symbol)
            value = zone_ids[symbol]
        else:
            value = parsed.integer(entry.value)
        if key < 0 or key in values:
            raise ValueError("Invalid or duplicate ZoneDB support entry")
        values[key] = value
    comma = None
    if fields and tokens[-2].text not in (',', ';'):
        comma = tokens[fields[-1].value[1] - 1].end
    return SupportTable(values, literal, tokens[-1].start, comma)


def read_support_tables(source: str, name: str) -> tuple[SupportTable, SupportTable]:
    """Read one base/override pair; reject computed values and extra module-side writes.

    Accept the owned ZoneDB module shape only. Preserve long-string comments and
    delimiters for candidates; callers validate the field-specific ID semantics.
    """
    tokens = _lex(source)
    if [t.text for t in tokens[:len(_HEADER)]] != _HEADER:
        raise ValueError("Unsupported ZoneDB support module header")
    tables = {}
    index = len(_HEADER)
    while index < len(tokens):
        group = tokens[index:index + 7]
        if (len(group) != 7 or [t.text for t in group[:4]] != ['ZoneDB', '.', 'private', '.']
                or group[5].text != '=' or group[6].kind != 'long'):
            raise ValueError("ZoneDB support must contain only two literal deferred tables")
        field, payload = group[4].text, group[6]
        if field not in (name, name + "Override") or field in tables:
            raise ValueError("Unexpected or duplicate ZoneDB support table: " + field)
        inner = _lex(source[payload.content_start:payload.content_end], payload.content_start)
        if not inner or inner[0].text != 'return' or inner[-1].text != '}':
            raise ValueError("ZoneDB support payload must return one literal table")
        tables[field] = _read_literal(source, inner[1:], payload.text)
        index += 7
    if len(tables) != 2:
        raise ValueError("ZoneDB support requires both base and override tables")
    return tables[name], tables[name + "Override"]


def read_instance_table(source: str, zone_ids: dict[str, int]) -> SupportTable:
    """Accept only the owned direct instance table and numeric/owned-symbol values."""
    tokens = _lex(source)
    prefix = _HEADER + ['ZoneDB', '.', 'instanceIdToAreaId', '=']
    if [t.text for t in tokens[:len(prefix)]] != prefix:
        raise ValueError("Unsupported ZoneDB instance support module")
    return _read_literal(source, tokens[len(prefix):], source, zone_ids)


def append_support_rows(source: str, table: SupportTable, rows: list[dict], comment: str) -> bytes:
    """Insert rows at a parsed table's close, preserving every other source byte."""
    if rows:
        lines = ["", "    -- " + comment]
        lines += [f"    [{row['key']}] = {row['value']}," for row in rows]
        source = source[:table.closing] + "\n".join(lines) + "\n" + source[table.closing:]
        if table.missing_comma_at is not None:
            offset = table.missing_comma_at
            source = source[:offset] + "," + source[offset:]
    return source.encode("utf-8")
