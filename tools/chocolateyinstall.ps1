# Functions
function Print {
    param(
        [string]$Message,
        [string]$Color="Blue"
    )

    Write-Host "- $Message" -ForegroundColor $color
}
function Invoke-SilentCommand {
    param(
        [string]$Command,
        [string]$Description
    )

    Print -Message $Description
    try {
        Invoke-Expression "$Command 2>`$null" | Out-Null
    }
    catch {
        throw "We tried to run the following command: '$Command' and it returned this error message: $_ `n`nSorry for the inconvenience, email support@controlplane.com and we’ll be happy to help troubleshoot with you.`n"
    }
}

# Define main variables
$executableName = $env:ChocolateyPackageName
$executableNameWithExtension = "$executableName.exe"
$url = "https://github.com/controlplane-com/k8s-cost-analyzer/archive/refs/tags/v" + $env:ChocolateyPackageVersion + ".zip"
$unzippedFolderName = "k8s-cost-analyzer-" + $env:ChocolateyPackageVersion
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$cacheDir = Join-Path (Get-PackageCacheLocation) $env:ChocolateyPackageName
$workDir = Join-Path $cacheDir $unzippedFolderName

Print -Message "[INFO] The script will simply download the source code and execute pyinstaller to create the $executableName executable" -Color Yellow

# Install the zip from the $url
Install-ChocolateyZipPackage -PackageName $env:ChocolateyPackageName -Url $url -UnzipLocation $cacheDir

# Change current working directory
Set-Location -Path $workDir

# Create virtual environment
Invoke-SilentCommand -Command "python -m venv venv; venv\Scripts\Activate.ps1" -Description "Creating a python virtual environment in the source code directory"

# Install dependencies
Invoke-SilentCommand -Command "pip install -r requirements.txt; pip install pyinstaller" -Description "Installing python dependencies, please wait"

# Run pyinstaller to create the executable and place the executable in the $toolsDir so it can be shimmed
Invoke-SilentCommand -Command "pyinstaller main.py --onefile --name $executableNameWithExtension --distpath $toolsDir" "Generating the executable '$executableName'"

# Cleanup
Print -Message "Deleting the virtual environment..."
Remove-Item -Path "venv" -Recurse -Force

Print -Message "$executableName generated successfully, execute '$executableName' in your terminal to execute the binary" -Color Green
