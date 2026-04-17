# Plugins And Runtime

Use this document to record how one site separates plugin code, runtime state,
DB-backed settings, and vault-managed secrets.

This file is intentionally operational, not theoretical.

## Inventory Baseline

Fill at least these sections:

- verification_date:
- verification_source:
- repo-managed custom themes:
- repo-managed custom plugins:
- repo-managed custom mu-plugins:
- third-party business plugins in use:
- environment-managed plugins:
- drop-ins:
- local-only dev/debug plugins:

## Repo-Managed Custom Code

List only code the site intentionally owns in Git:

- custom plugins under `wp-content/plugins/`
- custom mu-plugins under `wp-content/mu-plugins/`
- site-owned theme code under `wp-content/themes/`

Document whether the code is:

- already active in runtime
- packaged for deploy
- still local-only

## Third-Party Plugins In Use

For each business plugin, record:

- plugin name
- why the site needs it
- whether its code is vendored or environment-installed
- where settings mainly live
- whether local parity is required
- whether a license or token is required

## Environment-Managed Plugins

List plugins that the hosting provider or runtime adds for its own managed
workflow.

For each one, record:

- expected owner
- where the code is expected to live
- whether local parity is a goal
- whether staging/live are expected to contain it

## MU-Plugins

Record both:

- site-owned mu-plugins
- provider/runtime mu-plugins

These are not equivalent. Site-owned mu-plugins belong in the site repo.
Provider/runtime mu-plugins usually do not.

## Drop-Ins

Record drop-ins separately from normal plugins.

Typical example:

- `wp-content/object-cache.php`

State clearly whether the drop-in is:

- site-owned
- provider/runtime-managed
- expected locally

## Local Plugin Policy

Write down:

- which plugins are required locally
- which plugins are optional locally
- which provider/runtime plugins are intentionally not mirrored locally

## Staging / Live Plugin Policy

Write down:

- which plugins are expected in staging
- which plugins are expected in live
- which items are environment-managed rather than repo-managed
- which items require DB-backed validation rather than filesystem-only review

## Secrets / Licensing Policy

Rules:

- license keys, API tokens, and credentials belong in `K:\`
- do not commit plugin secrets
- do not embed plugin licenses in deploy artifacts
- document only the existence and ownership of a secret, not its value

## Notes

- plugin folders do not capture activation state by themselves
- DB-backed settings are part of runtime behavior
- provider/runtime plugins are not automatic local parity targets

See the shared support docs for the governing model:

- `D:\Projects\Support\wordpress-platform\docs\plugin-governance.md`
- `D:\Projects\Support\wordpress-platform\docs\plugin-taxonomy-and-placement.md`
- `D:\Projects\Support\wordpress-platform\docs\plugin-sync-boundaries.md`
