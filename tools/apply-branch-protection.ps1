#!/usr/bin/env pwsh
#Requires -Version 7.0
# SPDX-License-Identifier: GPL-2.0-or-later

<#
.SYNOPSIS
Applies or verifies the classic branch protection rule for this repository.

.DESCRIPTION
The desired branch protection state is stored in
.github/branch-protection-main.json so the GitHub API setting is reviewable in
the repository. Use -DryRun to print the payload without calling GitHub.

.PARAMETER Repository
GitHub repository in owner/name format.

.PARAMETER Branch
Branch to configure.

.PARAMETER ConfigPath
Path to the classic branch protection JSON payload.

.PARAMETER Verify
Checks the live GitHub branch protection state against the config instead of
applying it.

.PARAMETER DryRun
Prints the config JSON and exits without calling GitHub.
#>

[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
param(
    [string] $Repository = 'ozirix-dev/wordpress-platform',
    [string] $Branch = 'main',
    [string] $ConfigPath = (
        Join-Path (Split-Path -Path $PSScriptRoot -Parent) '.github/branch-protection-main.json'
    ),
    [switch] $Verify,
    [switch] $DryRun
)

$ErrorActionPreference = 'Stop'

if (-not (Test-Path -LiteralPath $ConfigPath -PathType Leaf)) {
    throw "Branch protection config not found: $ConfigPath"
}

$configJson = Get-Content -Raw -LiteralPath $ConfigPath
$config = $configJson | ConvertFrom-Json

if ($DryRun) {
    $config | ConvertTo-Json -Depth 10
    return
}

$encodedBranch = [System.Uri]::EscapeDataString($Branch)
$endpoint = "repos/$Repository/branches/$encodedBranch/protection"

if ($Verify) {
    $actual = gh api $endpoint | ConvertFrom-Json

    $expectedContexts = @($config.required_status_checks.contexts) | Sort-Object
    $actualContexts = @($actual.required_status_checks.contexts) | Sort-Object
    if (@(Compare-Object -ReferenceObject $expectedContexts -DifferenceObject $actualContexts).Count -ne 0) {
        throw "Required status checks do not match config"
    }

    if ([bool] $actual.required_status_checks.strict -ne [bool] $config.required_status_checks.strict) {
        throw "Strict status check setting does not match config"
    }

    if ([bool] $actual.enforce_admins.enabled -ne [bool] $config.enforce_admins) {
        throw "Admin enforcement setting does not match config"
    }

    if ([bool] $actual.allow_force_pushes.enabled -ne [bool] $config.allow_force_pushes) {
        throw "Force-push setting does not match config"
    }

    if ([bool] $actual.allow_deletions.enabled -ne [bool] $config.allow_deletions) {
        throw "Branch deletion setting does not match config"
    }

    $booleanControlNames = @(
        'required_linear_history',
        'block_creations',
        'required_conversation_resolution',
        'lock_branch',
        'allow_fork_syncing'
    )

    foreach ($controlName in $booleanControlNames) {
        $expectedValue = $config.PSObject.Properties[$controlName].Value
        $actualNode = $actual.PSObject.Properties[$controlName].Value

        if ($null -eq $actualNode) {
            throw "Live protection does not expose expected control: $controlName"
        }

        if ([bool] $actualNode.enabled -ne [bool] $expectedValue) {
            throw "Branch protection setting does not match config: $controlName"
        }
    }

    if ($null -ne $config.required_pull_request_reviews -and $null -eq $actual.required_pull_request_reviews) {
        throw "Required pull request reviews are missing from live protection"
    }

    if ($null -eq $config.required_pull_request_reviews -and $null -ne $actual.required_pull_request_reviews) {
        throw "Live protection requires pull request reviews but config does not"
    }

    if ($null -eq $config.restrictions -and $null -ne $actual.restrictions) {
        throw "Live protection has push restrictions but config does not"
    }

    Write-Output "Branch protection matches $ConfigPath for $Repository/$Branch."
    return
}

if ($PSCmdlet.ShouldProcess("$Repository/$Branch", "Apply classic branch protection")) {
    $configJson | gh api --method PUT $endpoint --input -
}
