#!/usr/bin/env pwsh
#Requires -Version 7.0
# SPDX-License-Identifier: GPL-2.0-or-later

[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'

$checks = @(
    @{
        Name = 'legacy Hostinger account literal'
        Pattern = ('u' + '963025419')
    },
    @{
        Name = 'legacy Hostinger origin IP literal'
        Pattern = ('92' + '\.112' + '\.182' + '\.62')
    },
    @{
        Name = 'legacy Hostinger SSH port literal'
        Pattern = ('ssh -p ' + '65002')
    },
    @{
        Name = 'legacy Hostinger DB/user prefix literal'
        Pattern = ('u' + '963025419_')
    },
    @{
        Name = 'legacy Hostinger order ID literal'
        Pattern = ('100' + '6284049')
    },
    @{
        Name = 'generic Hostinger account ID'
        Pattern = 'u[0-9]{9}'
    },
    @{
        Name = 'generic Hostinger DB/user prefix'
        Pattern = 'u[0-9]{9}_'
    },
    @{
        Name = 'generic Hostinger home path'
        Pattern = '/home/u[0-9]{9}'
    },
    @{
        Name = 'generic Hostinger SSH target'
        Pattern = 'ssh[[:space:]]+-p[[:space:]]+[0-9]{2,5}[[:space:]]+u[0-9]{9}@[0-9]{1,3}(\.[0-9]{1,3}){3}'
    }
)

foreach ($check in $checks) {
    $pattern = [string] $check.Pattern
    $grepMatches = git grep -n -E -- $pattern
    $grepExitCode = $LASTEXITCODE

    if ($grepExitCode -eq 0) {
        $grepMatches
        throw "Public-safety match remains in the current tree: $($check.Name)"
    }

    if ($grepExitCode -ne 1) {
        throw "git grep failed with exit $grepExitCode"
    }

    $global:LASTEXITCODE = 0
}

$global:LASTEXITCODE = 0
