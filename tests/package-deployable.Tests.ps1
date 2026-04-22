# SPDX-License-Identifier: GPL-2.0-or-later

BeforeAll {
    $script:RepoRoot = Split-Path -Path $PSScriptRoot -Parent
    $script:PackageScript = Join-Path $script:RepoRoot 'templates/site-repo-starter/tools/package-deployable.ps1'

    function Initialize-TestSourceRepo {
        param(
            [Parameter(Mandatory = $true)]
            [string] $Root,

            [switch] $WithoutWpContent
        )

        if (Test-Path -LiteralPath $Root) {
            Remove-Item -LiteralPath $Root -Recurse -Force
        }

        New-Item -ItemType Directory -Path $Root -Force | Out-Null
        Set-Content -Path (Join-Path $Root 'README.md') -Value '# Fixture repo' -Encoding UTF8

        if ($WithoutWpContent) {
            return $Root
        }

        $themeRoot = Join-Path $Root 'wp-content/themes/fixture-theme'
        $pluginRoot = Join-Path $Root 'wp-content/plugins'
        New-Item -ItemType Directory -Path $themeRoot -Force | Out-Null
        New-Item -ItemType Directory -Path $pluginRoot -Force | Out-Null
        Set-Content -Path (Join-Path $themeRoot 'style.css') -Value '/* fixture */' -Encoding UTF8

        return $Root
    }

    function Invoke-PackageHelper {
        param(
            [Parameter(Mandatory = $true)]
            [string] $SourceRepo,

            [Parameter(Mandatory = $true)]
            [string] $OutputDirectory,

            [string] $ArtifactType = 'Directory',

            [string[]] $Scopes = @('themes'),

            [string[]] $ExtraFiles = @()
        )

        & $script:PackageScript `
            -SourceRepoPath $SourceRepo `
            -OutputDirectory $OutputDirectory `
            -ArtifactType $ArtifactType `
            -ArtifactName 'pester-package' `
            -Scopes $Scopes `
            -ExtraFiles $ExtraFiles
    }

    function Get-LatestPackageDirectory {
        param([Parameter(Mandatory = $true)] [string] $OutputDirectory)

        return Get-ChildItem -LiteralPath $OutputDirectory -Directory |
            Sort-Object LastWriteTime -Descending |
            Select-Object -First 1
    }
}

Describe 'package-deployable.ps1' {
    It 'builds a directory package with manifest invariants' {
        $source = Initialize-TestSourceRepo -Root (Join-Path $TestDrive 'source-repo')
        $output = Join-Path $TestDrive 'output'

        Invoke-PackageHelper `
            -SourceRepo $source `
            -OutputDirectory $output `
            -ArtifactType Directory `
            -Scopes @('themes') `
            -ExtraFiles @('README.md', 'missing-extra.md')

        $package = Get-LatestPackageDirectory -OutputDirectory $output
        $package | Should -Not -BeNullOrEmpty

        $manifestPath = Join-Path $package.FullName 'package-manifest.json'
        $manifest = Get-Content -Raw -LiteralPath $manifestPath | ConvertFrom-Json

        @($manifest.scopeNames) | Should -Contain 'themes'
        @($manifest.includedExtras) | Should -Contain 'README.md'
        @($manifest.includedExtras) | Should -Not -Contain 'missing-extra.md'
        $manifest.sourceRepo | Should -Be 'source-repo'
        $manifest.sourceRepo | Should -Not -Match '^[A-Za-z]:\\'
        Join-Path $package.FullName 'wp-content/themes/fixture-theme/style.css' |
            Should -Exist
        Join-Path $package.FullName 'README.md' | Should -Exist

        $missingExtra = @($manifest.warnings) |
            Where-Object { $_.name -eq 'missing-extra.md' }
        $missingExtra.reason | Should -Be 'Missing in source repo'
    }

    It 'builds a zip package containing payload and manifest' {
        $source = Initialize-TestSourceRepo -Root (Join-Path $TestDrive 'source-repo')
        $output = Join-Path $TestDrive 'output'

        Invoke-PackageHelper `
            -SourceRepo $source `
            -OutputDirectory $output `
            -ArtifactType Zip `
            -Scopes @('themes') `
            -ExtraFiles @('README.md')

        $zip = Get-ChildItem -LiteralPath $output -Filter 'pester-package-*.zip' |
            Select-Object -First 1
        $zip | Should -Not -BeNullOrEmpty

        $expanded = Join-Path $TestDrive 'expanded'
        Expand-Archive -LiteralPath $zip.FullName -DestinationPath $expanded

        Join-Path $expanded 'package-manifest.json' | Should -Exist
        Join-Path $expanded 'README.md' | Should -Exist
        Join-Path $expanded 'wp-content/themes/fixture-theme/style.css' |
            Should -Exist
    }

    It 'records missing scopes as warnings without adding them to scopeNames' {
        $source = Initialize-TestSourceRepo -Root (Join-Path $TestDrive 'source-repo')
        Remove-Item -LiteralPath (Join-Path $source 'wp-content/plugins') -Recurse -Force
        $output = Join-Path $TestDrive 'output'

        Invoke-PackageHelper `
            -SourceRepo $source `
            -OutputDirectory $output `
            -ArtifactType Directory `
            -Scopes @('themes', 'plugins')

        $package = Get-LatestPackageDirectory -OutputDirectory $output
        $manifestPath = Join-Path $package.FullName 'package-manifest.json'
        $manifest = Get-Content -Raw -LiteralPath $manifestPath | ConvertFrom-Json

        @($manifest.scopeNames) | Should -Contain 'themes'
        @($manifest.scopeNames) | Should -Not -Contain 'plugins'
        $missingScope = @($manifest.warnings) |
            Where-Object { $_.name -eq 'plugins' }
        $missingScope.reason | Should -Be 'Missing in source repo'
    }

    It 'does not copy unmanaged wp-content folders when scoped to themes' {
        $source = Initialize-TestSourceRepo -Root (Join-Path $TestDrive 'source-repo')
        $uploads = Join-Path $source 'wp-content/uploads'
        New-Item -ItemType Directory -Path $uploads -Force | Out-Null
        Set-Content -Path (Join-Path $uploads 'private.txt') -Value 'private' -Encoding UTF8
        $output = Join-Path $TestDrive 'output'

        Invoke-PackageHelper `
            -SourceRepo $source `
            -OutputDirectory $output `
            -ArtifactType Directory `
            -Scopes @('themes')

        $package = Get-LatestPackageDirectory -OutputDirectory $output
        Join-Path $package.FullName 'wp-content/themes/fixture-theme/style.css' |
            Should -Exist
        Join-Path $package.FullName 'wp-content/uploads/private.txt' |
            Should -Not -Exist
    }

    It 'rejects unsafe extra files' {
        $source = Initialize-TestSourceRepo -Root (Join-Path $TestDrive 'source-repo')
        $output = Join-Path $TestDrive 'output'
        $absolutePath = Join-Path $TestDrive 'outside.md'

        {
            Invoke-PackageHelper `
                -SourceRepo $source `
                -OutputDirectory $output `
                -ExtraFiles @($absolutePath)
        } | Should -Throw -ExpectedMessage '*ExtraFiles must be repo-relative*'

        {
            Invoke-PackageHelper `
                -SourceRepo $source `
                -OutputDirectory $output `
                -ExtraFiles @('../outside.md')
        } | Should -Throw -ExpectedMessage '*ExtraFiles must be repo-relative*'
    }

    It 'fails when source repo has no wp-content folder' {
        $source = Initialize-TestSourceRepo `
            -Root (Join-Path $TestDrive 'source-repo') `
            -WithoutWpContent
        $output = Join-Path $TestDrive 'output'

        {
            Invoke-PackageHelper -SourceRepo $source -OutputDirectory $output
        } | Should -Throw -ExpectedMessage '*does not have a wp-content folder*'
    }

    It 'does not write package output during dry-run WhatIf mode' {
        $source = Initialize-TestSourceRepo -Root (Join-Path $TestDrive 'source-repo')
        $output = Join-Path $TestDrive 'dry-run-output'

        & $script:PackageScript `
            -SourceRepoPath $source `
            -OutputDirectory $output `
            -ArtifactType Directory `
            -ArtifactName 'dry-run-package' `
            -Scopes themes `
            -DryRun `
            -WhatIf

        Test-Path -LiteralPath $output | Should -BeFalse
    }

    It 'does not write zip output during dry-run WhatIf mode' {
        $source = Initialize-TestSourceRepo -Root (Join-Path $TestDrive 'source-repo')
        $output = Join-Path $TestDrive 'dry-run-output'

        & $script:PackageScript `
            -SourceRepoPath $source `
            -OutputDirectory $output `
            -ArtifactType Zip `
            -ArtifactName 'dry-run-package' `
            -Scopes themes `
            -DryRun `
            -WhatIf

        Test-Path -LiteralPath $output | Should -BeFalse
    }
}
