# Chocolatey - Control Plane K8s Cost Analyzer

This repository contains the packaging details for the [K8s Cost Analyzer](https://github.com/controlplane-com/k8s-cost-analyzer) that is hosted on [Chocolatey](https://chocolatey.org).

## Installation Prerequisites
* Make sure you are running on a Windows machine.
* Make sure that Chocolatey is installed on the target machine. Visit [this](https://chocolatey.org/install) page for installation instructions.

## Install through Chocolatey
```powershell
choco install cpln-k8s-cost-analyzer
```

## Install through the repository code

Clone this repository. Then navigate to the repository directory on your machine and execute the following command:

```powershell
choco pack; choco install cpln-k8s-cost-analyzer --source "'.;https://community.chocolatey.org/api/v2/'"
```

## Uninstall the package

```powershell
choco uninstall cpln-k8s-cost-analyzer
```

## Developer Commands

Verify the integrity of the executable

```powershell
checksum -t sha256 cpln-k8s-cost-analyzer.exe
```

Push the package to chocolatey

```powershell
choco pack; choco push cpln-k8s-cost-analyzer.VERSION.nupkg --source "'https://push.chocolatey.org/'"
```
