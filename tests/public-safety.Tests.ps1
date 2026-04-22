# SPDX-License-Identifier: GPL-2.0-or-later

BeforeAll {
    $script:RepoRoot = Split-Path -Path $PSScriptRoot -Parent
    $script:SafetyScript = Join-Path $script:RepoRoot 'tools/check-public-safety.ps1'

    function Initialize-SafetyGitRepo {
        param(
            [Parameter(Mandatory = $true)]
            [string] $Root,

            [Parameter(Mandatory = $true)]
            [string] $Content
        )

        if (Test-Path -LiteralPath $Root) {
            Remove-Item -LiteralPath $Root -Recurse -Force
        }

        New-Item -ItemType Directory -Path $Root -Force | Out-Null
        git -C $Root init --quiet
        $docRoot = Join-Path $Root 'docs'
        New-Item -ItemType Directory -Path $docRoot -Force | Out-Null
        Set-Content -Path (Join-Path $docRoot 'intake.md') -Value $Content -Encoding UTF8
        git -C $Root add docs/intake.md

        return $Root
    }

    function Invoke-PublicSafetyCheck {
        param([Parameter(Mandatory = $true)] [string] $Repository)

        Push-Location -LiteralPath $Repository
        try {
            & $script:SafetyScript
        }
        finally {
            Pop-Location
        }
    }
}

Describe 'check-public-safety.ps1' {
    It 'passes a redacted tracked tree' {
        $repo = Initialize-SafetyGitRepo `
            -Root (Join-Path $TestDrive 'safe-repo') `
            -Content 'Account <HOSTINGER_ACCOUNT_ID> uses <HOSTINGER_ORIGIN_IP>.'

        { Invoke-PublicSafetyCheck -Repository $repo } | Should -Not -Throw
    }

    It 'fails on Hostinger account-shaped tracked literals' {
        $account = 'u' + '123456789'
        $repo = Initialize-SafetyGitRepo `
            -Root (Join-Path $TestDrive 'account-repo') `
            -Content "Account $account must not be public."

        {
            Invoke-PublicSafetyCheck -Repository $repo
        } | Should -Throw -ExpectedMessage '*generic Hostinger account ID*'
    }

    It 'fails on Hostinger SSH port literals' {
        $sshExample = ('ssh -p ' + '65002') + ' <HOSTINGER_ACCOUNT_ID>@<HOSTINGER_ORIGIN_IP>'
        $repo = Initialize-SafetyGitRepo `
            -Root (Join-Path $TestDrive 'ssh-repo') `
            -Content $sshExample

        {
            Invoke-PublicSafetyCheck -Repository $repo
        } | Should -Throw -ExpectedMessage '*legacy Hostinger SSH port literal*'
    }
}
