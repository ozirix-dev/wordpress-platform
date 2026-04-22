# Temporary Artifacts And Baselines

This repository intentionally ignores local helper output under `tmp/**`.

`tmp/` is allowed for short-lived local smoke artifacts, dry-run targets and
review packages, but it is not a current-state source of truth.

## Rules

- Keep `tmp/**` out of Git.
- Do not store secrets, database dumps, uploads, backup payloads, private keys
  or credentials under `tmp/`.
- Treat generated packages under `tmp/` as disposable review output.
- Inspect a `tmp/` target before deciding whether it is safe to remove.
- Do not delete `tmp/` artifacts without the user's explicit `Kyllä`.

## Package Output

The starter package helper may write:

- `wp-content/` payload files
- `package-manifest.json` review metadata
- optional extra files when explicitly requested
- zip files when `ArtifactType` is `Zip`

Only the intended `wp-content/` payload belongs in a WordPress runtime target.
The manifest is for review and audit, not runtime deployment.
Manifest metadata should not expose absolute local workstation paths.

## Baseline Wording

When documenting test outcomes, avoid unanchored wording such as "current
baseline" unless the document also gives a concrete date or source.

Preferred wording:

- `2026-04-17 local smoke baseline`
- `current as of 2026-04-22 public runtime check`
- `superseded by <document or section>`

This keeps historical smoke tests useful without letting them masquerade as
fresh runtime truth.
