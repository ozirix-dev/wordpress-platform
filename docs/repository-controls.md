# Repository Controls

This repository is public and uses a checks-only protected `main` branch model.

## Branch Protection

The desired classic branch protection payload is tracked in:

- [`.github/branch-protection-main.json`](../.github/branch-protection-main.json)

The live rule should match these controls:

- required status checks: `lint-and-smoke`, `gitleaks`
- strict status checks: enabled
- force pushes: disabled
- branch deletion: disabled
- required pull request reviews: disabled
- push restrictions: disabled
- admin enforcement: disabled

Admin bypass is intentional for this repository. It preserves owner direct-push
ability for small support-repo maintenance, while the required checks keep the
branch status surface explicit.

Apply or verify the live setting with:

```powershell
./tools/apply-branch-protection.ps1 -Verify
./tools/apply-branch-protection.ps1
```

Use `-DryRun` to print the payload without calling the GitHub API.

## Verification Workflow

The `Verify` workflow must keep these job names stable because branch protection
depends on them:

- `lint-and-smoke`
- `gitleaks`

`lint-and-smoke` covers Markdown lint, current-tree public-safety grep,
PowerShell parser checks, PSScriptAnalyzer, PHP syntax lint, Pester tests, and
the package-helper manifest smoke test.

`gitleaks` runs default Gitleaks rules against full history. Hostinger-specific
account/IP/DB/path checks are intentionally current-tree checks in
`tools/check-public-safety.ps1`, not full-history Gitleaks rules.

## Drift Control

Dependabot is enabled for GitHub Actions updates in:

- [`.github/dependabot.yml`](../.github/dependabot.yml)

Pester tests assert that the branch protection JSON, workflow job names,
Dependabot config, and branch-protection helper stay aligned.

## Vulnerability Reporting

GitHub private vulnerability reporting is enabled for the public repository.
Keep vulnerability reports out of public issues and use the private reporting
path described in [SECURITY.md](../SECURITY.md).
