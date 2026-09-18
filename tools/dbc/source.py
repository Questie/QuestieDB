"""Read explicit, verified DBC snapshots without following mutable major views."""

from __future__ import annotations

import math
import sqlite3

def read_table(conn: sqlite3.Connection, table: str, build: str,
               fields: dict[str, type], *, allow_untracked: bool = False) -> list[dict]:
    """Reject unavailable or incomplete snapshots before projecting rows.

    Interval comparisons follow dbc.delta.reconstruct_at_build. Untracked legacy
    coverage requires explicit consent; it never bypasses recorded failures.
    A float field accepts finite SQLite integers or floats. Identifiers come from
    caller-owned schema constants, never SQL supplied by CLI users.
    """
    coverage = conn.execute(
        'SELECT status, error FROM _table_build '
        'WHERE table_name = ? AND build = ? AND locale = ?', (table, build, ""),
    ).fetchone()
    if (coverage is None and not allow_untracked) or (coverage is not None and coverage["status"] != "ok"):
        detail = "untracked" if coverage is None else f'{coverage["status"]}: {coverage["error"]}'
        raise ValueError(f"{table} at {build}: snapshot {detail}")
    columns = {row["name"] for row in conn.execute(f'PRAGMA table_info("{table}")')}
    missing = set(fields) - columns
    if missing:
        raise ValueError(f"{table}: missing columns {sorted(missing)}")
    projection = ", ".join(f'"{column}"' for column in fields)
    rows = [dict(row) for row in conn.execute(
        f'SELECT {projection} FROM "{table}" '
        'WHERE _first_seen <= ? AND _last_seen >= ? ORDER BY ID', (build, build),
    )]
    if not rows:
        raise ValueError(f"{table} at {build}: empty snapshot cannot supply required support data")
    seen: set[int] = set()
    for row in rows:
        for column, expected in fields.items():
            value = row[column]
            valid = type(value) is expected
            if expected is float:
                valid = type(value) in (int, float) and math.isfinite(value)
            if not valid or (expected is str and not value.strip()):
                raise ValueError(f'{table} ID {row["ID"]}: invalid {column}={value!r}')
        if row["ID"] in seen:
            raise ValueError(f'{table}: overlapping snapshots for ID {row["ID"]}')
        seen.add(row["ID"])
    return rows
