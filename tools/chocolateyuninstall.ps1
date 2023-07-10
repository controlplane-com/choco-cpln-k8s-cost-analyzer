$ErrorActionPreference = 'Stop'
$cacheDir = Join-Path (Get-PackageCacheLocation) $env:ChocolateyPackageName

# Clean the cache directory
if (Test-Path $cacheDir) {
    Remove-Item -Path $cacheDir -Recurse -Force
}
