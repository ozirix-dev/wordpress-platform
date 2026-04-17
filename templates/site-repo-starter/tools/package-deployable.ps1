#!/usr/bin/env pwsh
#Requires -Version 7.0

<#
.SYNOPSIS
Builds a reviewable wp-content package from the current repo.

.DESCRIPTION
This helper assembles repo-managed wp-content scopes and optional extra
repo-relative files into a directory or zip artifact for review.
Run it with -DryRun -WhatIf first.

.PARAMETER SourceRepoPath
Repo root that contains wp-content.

.PARAMETER OutputDirectory
Directory where the package staging folder or zip will be created.

.PARAMETER ArtifactType
Output format: Directory or Zip.

.PARAMETER ArtifactName
Base name used for the generated artifact.

.PARAMETER Scopes
Managed wp-content scopes to include.

.PARAMETER ExtraFiles
Additional repo-relative files to include alongside wp-content.

.PARAMETER DryRun
Enables WhatIf-style dry-run behavior.
#>

[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Medium")]
param(
    [string] $SourceRepoPath = (Join-Path $PSScriptRoot ".."),
    [string] $OutputDirectory = (Join-Path (Join-Path $PSScriptRoot "..") 'tmp'),

    [ValidateSet('Directory', 'Zip')]
    [string] $ArtifactType = 'Zip',

    [string] $ArtifactName = "wp-content-package",

    [ValidateSet('mu-plugins', 'plugins', 'themes')]
    [string[]] $Scopes = @('mu-plugins', 'plugins', 'themes'),

    [string[]] $ExtraFiles = @(),
    [switch] $DryRun
)

if ($DryRun) {
    $WhatIfPreference = $true
}

function Resolve-ExistingPath {
    param([Parameter(Mandatory = $true)] [string] $Path)
    return (Resolve-Path -LiteralPath $Path -ErrorAction Stop).Path
}

function Resolve-OrCreateDirectory {
    param([Parameter(Mandatory = $true)] [string] $Path)

    if (-not (Test-Path -LiteralPath $Path)) {
        if ($WhatIfPreference) {
            return [System.IO.Path]::GetFullPath($Path)
        }

        if ($PSCmdlet.ShouldProcess($Path, "Create output directory")) {
            New-Item -ItemType Directory -Path $Path -Force | Out-Null
        }
    }

    return (Resolve-Path -LiteralPath $Path -ErrorAction Stop).Path
}

function Test-SafeRelativeRepoPath {
    param([Parameter(Mandatory = $true)] [string] $Path)

    if ([System.IO.Path]::IsPathRooted($Path)) {
        return $false
    }

    if ($Path -match '(^|[\\/])\.\.([\\/]|$)') {
        return $false
    }

    return $true
}

function Copy-ScopeItems {
    param(
        [Parameter(Mandatory = $true)]
        [string] $SourceScope,

        [Parameter(Mandatory = $true)]
        [string] $DestinationScope
    )

    foreach ($item in Get-ChildItem -LiteralPath $SourceScope -Force) {
        if ($item.PSIsContainer) {
            Copy-Item -LiteralPath $item.FullName -Destination $DestinationScope -Recurse -Force
        }
        else {
            Copy-Item -LiteralPath $item.FullName -Destination $DestinationScope -Force
        }
    }
}

function New-Manifest {
    param(
        [Parameter(Mandatory = $true)]
        [string] $TargetPath,

        [string[]] $IncludedScopes = @(),

        [Parameter(Mandatory = $true)]
        [hashtable] $Warnings,

        [Parameter(Mandatory = $true)]
        [datetime] $GeneratedAt,

        [Parameter(Mandatory = $true)]
        [string] $ArtifactKind,

        [Parameter(Mandatory = $true)]
        [string] $SourcePath,

        [string[]] $IncludedExtraFiles = @()
    )

    $manifestPath = Join-Path $TargetPath 'package-manifest.json'
    $payload = [ordered]@{
        generatedAt = $GeneratedAt.ToString('o')
        artifactType = $ArtifactKind
        scopeNames = @($IncludedScopes)
        includedExtras = @($IncludedExtraFiles)
        sourceRepo = $SourcePath
        warnings = @($Warnings.GetEnumerator() | ForEach-Object {
                @{
                    name = $_.Name
                    reason = $_.Value
                }
            })
    }

    if ($PSCmdlet.ShouldProcess($manifestPath, "Write review manifest")) {
        $payload | ConvertTo-Json -Depth 5 | Set-Content -Path $manifestPath -Encoding UTF8
    }
}

try {
    $sourceRepo = Resolve-ExistingPath -Path $SourceRepoPath
    $outputDir = Resolve-OrCreateDirectory -Path $OutputDirectory
}
catch {
    throw "Could not resolve SourceRepoPath or OutputDirectory. Verify they exist."
}

$sourceWpContent = Join-Path $sourceRepo 'wp-content'
if (-not (Test-Path -LiteralPath $sourceWpContent)) {
    throw "Source repo does not have a wp-content folder: $sourceWpContent"
}

$timestamp = (Get-Date).ToString('yyyyMMdd-HHmmss')
$packageFolderName = "$ArtifactName-$timestamp"
$stagingPath = Join-Path $outputDir $packageFolderName
$packageWpContent = Join-Path $stagingPath 'wp-content'

if ($PSCmdlet.ShouldProcess($stagingPath, "Create staging package folder")) {
    New-Item -ItemType Directory -Path $stagingPath -Force | Out-Null
    New-Item -ItemType Directory -Path $packageWpContent -Force | Out-Null
}

$warnings = @{}
$includedScopes = New-Object System.Collections.Generic.List[string]

foreach ($scope in $Scopes) {
    $sourceScope = Join-Path $sourceWpContent $scope
    if (-not (Test-Path -LiteralPath $sourceScope)) {
        Write-Warning "Scope not found in source and was skipped: $scope"
        $warnings[$scope] = 'Missing in source repo'
        continue
    }

    [void] $includedScopes.Add($scope)
    $destinationScope = Join-Path $packageWpContent $scope
    if ($PSCmdlet.ShouldProcess($destinationScope, "Copy scope '$scope' for package")) {
        if (-not (Test-Path -LiteralPath $destinationScope)) {
            New-Item -ItemType Directory -Path $destinationScope -Force | Out-Null
        }

        Copy-ScopeItems -SourceScope $sourceScope -DestinationScope $destinationScope
    }
}

foreach ($file in $ExtraFiles) {
    if (-not (Test-SafeRelativeRepoPath -Path $file)) {
        throw "ExtraFiles must be repo-relative safe paths without drive roots or '..': $file"
    }

    $sourceFile = Join-Path $sourceRepo $file
    if (-not (Test-Path -LiteralPath $sourceFile)) {
        Write-Warning "Extra file not found in source repo and was skipped: $file"
        $warnings[$file] = 'Missing in source repo'
        continue
    }

    $resolvedSourceFile = Resolve-ExistingPath -Path $sourceFile
    $sourceRepoBoundary = $sourceRepo.TrimEnd('\') + '\'
    if (
        -not $resolvedSourceFile.Equals($sourceRepo, [System.StringComparison]::OrdinalIgnoreCase) -and
        -not $resolvedSourceFile.StartsWith($sourceRepoBoundary, [System.StringComparison]::OrdinalIgnoreCase)
    ) {
        throw "Extra file resolved outside the source repo boundary: $file"
    }

    $destinationFile = Join-Path $stagingPath $file
    $destinationParent = Split-Path -Path $destinationFile -Parent

    if ($PSCmdlet.ShouldProcess($destinationFile, "Copy extra file '$file' for package")) {
        if (-not (Test-Path -LiteralPath $destinationParent)) {
            New-Item -ItemType Directory -Path $destinationParent -Force | Out-Null
        }

        Copy-Item -LiteralPath $sourceFile -Destination $destinationFile -Force
    }
}

New-Manifest `
    -TargetPath $stagingPath `
    -IncludedScopes $includedScopes.ToArray() `
    -Warnings $warnings `
    -GeneratedAt (Get-Date) `
    -ArtifactKind $ArtifactType `
    -SourcePath $sourceRepo `
    -IncludedExtraFiles $ExtraFiles

if ($ArtifactType -eq 'Zip') {
    $zipPath = Join-Path $outputDir "$packageFolderName.zip"
    $itemsToZip = Join-Path $stagingPath '*'

    if ($PSCmdlet.ShouldProcess($zipPath, "Create zip artifact")) {
        if (Test-Path -LiteralPath $zipPath) {
            Remove-Item -LiteralPath $zipPath -Force
        }

        Compress-Archive -Path $itemsToZip -DestinationPath $zipPath -Force
    }

    Write-Information "package-deployable complete: $zipPath"
}
else {
    Write-Information "package-deployable complete: $stagingPath"
}
