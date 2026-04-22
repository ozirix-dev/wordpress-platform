# SPDX-License-Identifier: GPL-2.0-or-later

BeforeAll {
    $script:RepoRoot = Split-Path -Path $PSScriptRoot -Parent
    $script:WorkflowPath = Join-Path $script:RepoRoot '.github/workflows/verify.yml'
    $script:BranchProtectionPath = Join-Path $script:RepoRoot '.github/branch-protection-main.json'
    $script:DependabotPath = Join-Path $script:RepoRoot '.github/dependabot.yml'
    $script:BranchProtectionTool = Join-Path $script:RepoRoot 'tools/apply-branch-protection.ps1'
}

Describe 'repository control configuration' {
    It 'keeps branch protection required checks aligned with workflow jobs' {
        $config = Get-Content -Raw -LiteralPath $script:BranchProtectionPath |
            ConvertFrom-Json
        $workflow = Get-Content -Raw -LiteralPath $script:WorkflowPath

        @($config.required_status_checks.contexts) |
            Should -Be @('lint-and-smoke', 'gitleaks')
        $config.required_status_checks.strict | Should -BeTrue
        $workflow | Should -Match '(?m)^\s*lint-and-smoke:\s*$'
        $workflow | Should -Match '(?m)^\s*gitleaks:\s*$'
        $workflow | Should -Match 'FORCE_JAVASCRIPT_ACTIONS_TO_NODE24:\s+"true"'
    }

    It 'keeps the branch protection policy in checks-only mode' {
        $config = Get-Content -Raw -LiteralPath $script:BranchProtectionPath |
            ConvertFrom-Json

        $config.enforce_admins | Should -BeFalse
        $config.allow_force_pushes | Should -BeFalse
        $config.allow_deletions | Should -BeFalse
        $config.required_linear_history | Should -BeFalse
        $config.block_creations | Should -BeFalse
        $config.required_conversation_resolution | Should -BeFalse
        $config.lock_branch | Should -BeFalse
        $config.allow_fork_syncing | Should -BeFalse
        $config.required_pull_request_reviews | Should -BeNullOrEmpty
        $config.restrictions | Should -BeNullOrEmpty
    }

    It 'prints the branch protection payload without calling GitHub in dry-run mode' {
        $json = & $script:BranchProtectionTool -DryRun
        $payload = $json | ConvertFrom-Json

        @($payload.required_status_checks.contexts) |
            Should -Be @('lint-and-smoke', 'gitleaks')
        $payload.required_status_checks.strict | Should -BeTrue
        $payload.allow_force_pushes | Should -BeFalse
        $payload.allow_deletions | Should -BeFalse
    }

    It 'URL-escapes branch names before building GitHub API paths' {
        $script = Get-Content -Raw -LiteralPath $script:BranchProtectionTool

        $script | Should -Match '\[System\.Uri\]::EscapeDataString\(\$Branch\)'
        $script | Should -Match 'branches/\$encodedBranch/protection'
    }

    It 'keeps Dependabot enabled for GitHub Actions drift' {
        $dependabot = Get-Content -Raw -LiteralPath $script:DependabotPath

        $dependabot | Should -Match 'version:\s+2'
        $dependabot | Should -Match 'package-ecosystem:\s+"github-actions"'
        $dependabot | Should -Match 'directory:\s+"/"'
        $dependabot | Should -Match 'interval:\s+"weekly"'
    }
}
