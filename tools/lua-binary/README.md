# Bundled Lua interpreters

Ready-to-run **Lua 5.1.5** with bit32, LuaFileSystem 1.8.0, and Busted 2.2.0 embedded.
No LuaRocks installation or runtime downloads are required.

| Platform | Executable |
| --- | --- |
| Windows x64 | `lua.exe` |
| Linux/WSL x64 | `linux-x64/lua` |

## Use

From the repository root:

```sh
./generate.sh Vanilla
```

Git Bash selects Windows Lua; Linux/WSL x64 selects Linux Lua. On macOS, the launcher checks
for an installed Lua 5.1 or LuaJIT and reports an error if neither is available.

On Windows Command Prompt or PowerShell:

```powershell
.\generate.cmd Vanilla
```

Omit the flavor to generate all five. Double-clicking `generate.cmd` keeps the results visible.
The full `questiedb.sh`/`questiedb.ps1` commands also prefer the matching bundle, but still need
Python. Explicit `LUA` overrides and the check runner's `--lua` take precedence.

Each executable supports `--busted [options] [test paths]`. Busted stays on bundled Lua 5.1;
optional LuaCov, MoonScript and Terra implementations are not included. The Linux executable
is fully static and cannot load external native modules. Windows uses only system DLLs and
is unsigned. Run only trusted scripts and tests.

## Checksums and notices

`SHA256SUMS` covers both executables. From this directory on Linux:

```sh
sha256sum --check SHA256SUMS
```

From the repository root in PowerShell, compare the hash with its entry:

```powershell
Get-FileHash .\tools\lua-binary\lua.exe -Algorithm SHA256
Get-Content .\tools\lua-binary\SHA256SUMS
```

`THIRD_PARTY_NOTICES.txt` contains the applicable copyright notices, license text, and compiler/
runtime exceptions. Keep it with redistributed binaries. The upstream mediator_lua notice gap
is recorded there.

This project consumes prebuilt interpreters. Build tooling and detailed provenance are maintained
separately. When replacing a binary, validate it and update its checksum and notices together.
These contributor tools are not included in the WoW addon ZIPs.
