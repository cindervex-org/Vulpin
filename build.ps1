$ErrorActionPreference = "Stop"

$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
$AsmFile = Join-Path $Root "vulpin.asm"
$ObjectFile = Join-Path $Root "vulpin.obj"
$OutputFile = Join-Path $Root "vulpin.exe"

if (-not (Get-Command nasm -ErrorAction SilentlyContinue)) {
    Write-Error "Error: NASM is not installed or is not in the PATH."
    exit 127
}

if (-not (Get-Command gcc -ErrorAction SilentlyContinue)) {
    Write-Error "Error: GCC is required for linking."
    exit 127
}

if (-not (Test-Path $AsmFile)) {
    Write-Error "Error: file vulpin.asm not found: $AsmFile"
    exit 1
}

nasm -f win64 $AsmFile -o $ObjectFile

gcc -mconsole $ObjectFile -o $OutputFile

Write-Host "Built full Vulpin interpreter: $OutputFile"
