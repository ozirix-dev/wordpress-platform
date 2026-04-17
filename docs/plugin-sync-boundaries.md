# Plugin Sync Boundaries

This document records what should not be conflated when WordPress plugins are
discussed across local, staging, live, repo, and vault boundaries.

## The Main Boundaries

### Plugin code vs DB settings

Do not assume that copying a plugin folder recreates:

- activation state
- options
- redirect rules
- schema/meta settings
- editorial plugin state

Code and DB settings are separate layers.

### Plugin folder vs activation state

Normal plugins can exist on disk without being active.

Activation state usually lives in the WordPress database. A repo artifact can
therefore be correct as code while still not being the active runtime.

### Plugin presence vs usable parity

A plugin can be present in staging or live and still not be part of the local
minimum parity target.

Examples:

- Hostinger provider plugins
- LiteSpeed runtime integrations
- provider preview-domain helpers

### Hostinger runtime plugins vs repo-managed code

Hostinger may add plugins or mu-plugins to support its managed WordPress
runtime.

That does not make them site-owned code.

### MU-plugins vs normal plugins

MU-plugins:

- live under `wp-content/mu-plugins/`
- auto-load
- do not use the same activation model as normal plugins

Normal plugins:

- live under `wp-content/plugins/`
- usually depend on DB activation state

### Drop-ins vs normal plugins

Drop-ins are not just "another plugin folder".

They are special files such as:

- `wp-content/object-cache.php`

They are runtime integration points and often belong to the host/performance
layer, not to repo-managed application code.

### Cache/object-cache layer vs application code

Caching layers can affect behavior, but they are not automatically part of the
site-owned application layer.

Do not treat:

- `LiteSpeed Cache`
- `object-cache.php`

as mandatory local parity targets unless the site really needs that exact
runtime behavior for the task at hand.

### Secrets/licensing vs docs/code

License keys, API tokens, and service credentials belong in:

- `K:\`

They do not belong in:

- site repos
- shared support repos
- deploy artifacts
- ReportHub reports

## Do / Don't

### Do

- document whether a plugin is provider-managed, third-party business logic, or
  custom site code
- keep custom plugin and mu-plugin code in the site repo when the site owns it
- record when settings live mainly in DB rather than in code
- record when a plugin requires vault-managed licensing or tokens
- treat drop-ins as a separate runtime category
- review staging/live plugin drift explicitly before normalizing it

### Don't

- do not assume `wp-content/plugins/<slug>/` in Git means the runtime is fully
  reproduced
- do not assume every Hostinger plugin belongs in local development
- do not commit provider-managed plugin code just because it is visible in
  staging
- do not commit `object-cache.php` by default just because the host uses it
- do not store plugin license keys or API tokens in docs or code
- do not treat DB-backed plugin state as if it were recoverable from filesystem
  sync alone

## Practical Sync Rule

Default sync target:

- repo-managed custom themes
- repo-managed custom plugins
- repo-managed custom mu-plugins

Default non-sync target:

- host/provider plugins
- host/provider mu-plugins
- host drop-ins
- DB-only activation/configuration state
- secrets and licenses

## SEO Plugin Boundary Example

With Rank Math or an equivalent SEO plugin:

- code may live in `wp-content/plugins/`
- runtime value lives heavily in DB
- license belongs in `K:\`

So the correct question is not:

- "is the plugin folder present?"

The correct question is:

- "which parts of this SEO behavior must be reproduced in local, and which
  parts only need staging/live validation?"
