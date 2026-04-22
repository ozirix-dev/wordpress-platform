#!/usr/bin/env pwsh
#Requires -Version 7.0
# SPDX-License-Identifier: GPL-2.0-or-later

<#
.SYNOPSIS
Copies repo-managed wp-content scopes into a local WordPress root.

.DESCRIPTION
This helper is intended for local review and development flows only.
Run it with -DryRun -WhatIf first. Purge mode requires explicit opt-in
through -AllowPurge.

.PARAMETER TargetWordPressPath
Target local WordPress root that contains wp-content or wp-config.php.

.PARAMETER SourceWpContentPath
Source wp-content path inside the current repo.

.PARAMETER Scopes
Managed wp-content scopes to copy.

.PARAMETER PurgeExtraneous
Remove items from the target scope when they are not present in the source.

.PARAMETER AllowPurge
Required confirmation switch for PurgeExtraneous.

.PARAMETER DryRun
Enables WhatIf-style dry-run behavior.
#>

[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Medium")]
param(
    [Parameter(Mandatory = $true)]
    [string] $TargetWordPressPath,

    [string] $SourceWpContentPath = (Join-Path $PSScriptRoot "..\wp-content"),

    [ValidateSet('mu-plugins', 'plugins', 'themes')]
    [string[]] $Scopes = @('mu-plugins', 'plugins', 'themes'),

    [switch] $PurgeExtraneous,
    [switch] $AllowPurge,
    [switch] $DryRun
)

if ($DryRun) {
    $WhatIfPreference = $true
}

function Resolve-ExistingPath {
    param(
        [Parameter(Mandatory = $true)]
        [string] $Path
    )

    return (Resolve-Path -LiteralPath $Path -ErrorAction Stop).Path
}

function Copy-Scope {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [string] $SourceScope,
        [string] $DestinationScope,
        [switch] $Purge
    )

    if (-not (Test-Path -LiteralPath $SourceScope)) {
        Write-Warning "Source scope does not exist and was skipped: $SourceScope"
        return
    }

    if (-not (Test-Path -LiteralPath $DestinationScope)) {
        if ($PSCmdlet.ShouldProcess($DestinationScope, "Create target scope directory")) {
            New-Item -ItemType Directory -Path $DestinationScope -Force | Out-Null
        }
    }

    if ($Purge) {
        $sourceChildNames = @((Get-ChildItem -LiteralPath $SourceScope -Force).Name)
        foreach ($existing in Get-ChildItem -LiteralPath $DestinationScope -Force) {
            if ($existing.Name -in $sourceChildNames) {
                continue
            }
            if ($PSCmdlet.ShouldProcess($existing.FullName, "Remove item not present in source scope")) {
                Remove-Item -LiteralPath $existing.FullName -Recurse -Force
            }
        }
    }

    foreach ($item in Get-ChildItem -LiteralPath $SourceScope -Force) {
        $targetPath = Join-Path $DestinationScope $item.Name
        if ($PSCmdlet.ShouldProcess($targetPath, "Copy '$($item.FullName)' into local wp-content")) {
            if ($item.PSIsContainer) {
                Copy-Item -LiteralPath $item.FullName -Destination $DestinationScope -Recurse -Force
            }
            else {
                Copy-Item -LiteralPath $item.FullName -Destination $DestinationScope -Force
            }
        }
    }
}

try {
    $sourceWpContent = Resolve-ExistingPath -Path $SourceWpContentPath
    $targetPath = Resolve-ExistingPath -Path $TargetWordPressPath
}
catch {
    throw "Could not resolve required paths. Check SourceWpContentPath and TargetWordPressPath values."
}

$sourceRepoRoot = Split-Path -Path $sourceWpContent -Parent
$sourceRepoBoundary = $sourceRepoRoot.TrimEnd('\') + '\'
if (
    $targetPath.Equals($sourceRepoRoot, [System.StringComparison]::OrdinalIgnoreCase) -or
    $targetPath.StartsWith($sourceRepoBoundary, [System.StringComparison]::OrdinalIgnoreCase)
) {
    throw "Refusing to sync into the source repo tree. TargetWordPressPath must point to a separate local WordPress root."
}

if ($PurgeExtraneous -and -not $AllowPurge) {
    throw "PurgeExtraneous requires -AllowPurge. Use -DryRun -WhatIf first before any real cleanup."
}

$targetWpContent = Join-Path $targetPath 'wp-content'
$targetWpConfig = Join-Path $targetPath 'wp-config.php'

if (-not (Test-Path -LiteralPath $targetWpContent) -and -not (Test-Path -LiteralPath $targetWpConfig)) {
    throw "Target path does not look like a local WordPress root. Missing both 'wp-content' and 'wp-config.php'."
}

if (-not (Test-Path -LiteralPath $targetWpContent)) {
    if ($PSCmdlet.ShouldProcess($targetWpContent, "Create target wp-content directory")) {
        New-Item -ItemType Directory -Path $targetWpContent -Force | Out-Null
    }
}

foreach ($scope in $Scopes) {
    $sourceScopePath = Join-Path $sourceWpContent $scope
    $destinationScopePath = Join-Path $targetWpContent $scope
    Copy-Scope -SourceScope $sourceScopePath -DestinationScope $destinationScopePath -Purge:$PurgeExtraneous
}

Write-Information "sync-to-local complete for scopes: $($Scopes -join ', ')"
