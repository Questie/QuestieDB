<#
.SYNOPSIS
Runs a QuestieDB Python entry point without native argument loss.
.DESCRIPTION
Finds Python 3.8+ using py -3, python3, or python. Arguments travel through a temporary
JSON environment value because Windows PowerShell 5.1 alters quotes and trailing
backslashes in native argument lists. The previous environment value is restored.
.PARAMETER Script
Python entry point selected by a launcher.
.PARAMETER Arguments
Arguments to forward verbatim, including empty strings.
#>
param(
    [Parameter(Mandatory = $true)][string] $Script,
    [AllowEmptyCollection()][AllowEmptyString()][string[]] $Arguments = @()
)

$ErrorActionPreference = 'Stop'
$PSNativeCommandUseErrorActionPreference = $false
foreach ($name in @('py', 'python3', 'python')) {
    $command = Get-Command $name -CommandType Application -ErrorAction SilentlyContinue | Select-Object -First 1
    if (-not $command) { continue }
    $prefix = @()
    if ($name -eq 'py') { $prefix = @('-3') }
    try {
        & $command.Source @prefix -c 'import sys; sys.exit(0 if sys.version_info >= (3, 8) else 1)' 2>$null
        if ($LASTEXITCODE -ne 0) { continue }
    } catch { continue }

    $previous = $env:QUESTIEDB_LAUNCH
    try {
        $env:QUESTIEDB_LAUNCH = ConvertTo-Json -Compress -InputObject @{ script = $Script; arguments = @($Arguments) }
        $bootstrap = "import json,os,runpy,sys; c=json.loads(os.environ.pop('QUESTIEDB_LAUNCH')); sys.argv=[c['script']]+c['arguments']; runpy.run_path(c['script'],run_name='__main__')"
        & $command.Source @prefix -c $bootstrap
        $code = $LASTEXITCODE
    } finally {
        $env:QUESTIEDB_LAUNCH = $previous
    }
    exit $code
}
[Console]::Error.WriteLine('QuestieDB requires Python 3.8+ (py -3, python3, or python) for this command.')
[Console]::Error.WriteLine('To generate without Python, run .\generate.cmd Vanilla from the checkout (see README.md, Working on corrections).')
exit 2
