<#
.SYNOPSIS
Runs QuestieDB contributor commands through the shared Python implementation.
.EXAMPLE
.\questiedb.ps1 generate Vanilla
.EXAMPLE
.\questiedb.ps1 package all
#>
& (Join-Path $PSScriptRoot 'tools/cli/run-python.ps1') -Script (Join-Path $PSScriptRoot 'tools/cli/questiedb.py') -Arguments $args
exit $LASTEXITCODE
