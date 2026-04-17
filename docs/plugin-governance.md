# Plugin Governance

This document defines how WordPress plugin-related responsibility is split
between repos, runtime filesystems, the WordPress database, and the local
vault.

The goal is simple: avoid treating `wp-content/plugins/` as if it were the only
truth surface.

## Four Separate Things

### 1. Plugin code

Plugin code means the files that implement behavior:

- normal plugins under `wp-content/plugins/`
- must-use plugins under `wp-content/mu-plugins/`
- drop-ins such as `wp-content/object-cache.php`

Code belongs in a repo only when the site intentionally owns that code or has
made a deliberate decision to vendor it.

### 2. Plugin runtime state

Runtime state means facts such as:

- installed or missing
- active or inactive
- auto-updates on or off
- provider/runtime toggles that affect the plugin

Runtime state usually lives in the WordPress database and in hosting-provider
runtime, not in the plugin folder itself.

### 3. Plugin settings and content-linked configuration

Settings mean plugin-owned operational data, for example:

- WordPress options
- post meta and term meta
- redirects, schema rules, content-analysis state
- cache settings
- onboarding flags

These usually live in the database. Some plugins may also use constants,
generated files, or host/runtime state, but the folder alone still does not
capture the effective configuration.

### 4. Licenses and secrets

Licenses, API tokens, service credentials, and recovery material do not belong
in Git repos or in WordPress content folders.

They belong in the local vault:

- `K:\`

The repo may document that a secret exists and where it is expected to be
managed, but it must not store the secret value.

## Ownership Boundaries

### Site repo

A site repo should own only the plugin-related code that is truly site-owned:

- custom normal plugins
- custom mu-plugins
- site docs that explain plugin policy

It may also document site-required third-party plugins, but documentation is
not the same thing as vendoring their code into the repo.

### Shared support repo

`wordpress-platform` owns the policy layer:

- taxonomy
- placement rules
- sync boundaries
- starter documentation

It does not own one site's runtime plugin inventory as executable truth.

### WordPress runtime filesystem

The runtime filesystem may contain several kinds of plugin-like artifacts:

- repo-managed custom code
- third-party plugin code installed in the environment
- provider-managed runtime plugins
- mu-plugins
- drop-ins

Filesystem presence alone does not tell you who owns the code or whether the
site expects parity across environments.

### Database

The database is the usual source of truth for:

- plugin activation state
- options
- onboarding status
- SEO metadata and redirect state
- cache/integration settings

If a plugin folder exists but its activation or settings live in DB, folder
sync alone does not recreate the real runtime.

### K: vault

The vault is the source of truth for:

- license keys
- API tokens
- premium service credentials
- connection strings or recovery material tied to a plugin

The repo may reference a canonical vault location such as
`K:\apps\<site>\secrets\`, but it must not copy secret material into docs,
export bundles, or deploy artifacts.

## Core Rules

### Repo-managed does not mean runtime-complete

A plugin can be present in Git and still be runtime-incomplete because:

- it is inactive
- it depends on DB settings
- it depends on a secret
- it depends on a provider-specific runtime layer

### Runtime-present does not mean repo-managed

A plugin can be active in Hostinger staging or live without belonging in the
repo at all, for example:

- Hostinger-managed plugins
- LiteSpeed Cache
- provider preview-domain mu-plugins
- cache drop-ins

### Local, staging, and live are not automatically identical

Plugin parity should be intentional, not maximal.

What usually deserves parity:

- site-owned custom code
- site-required third-party business plugins when the site actually depends on
  their behavior

What often does not deserve forced parity:

- host/provider onboarding plugins
- provider dashboards and reach/marketing plugins
- provider preview-domain helpers
- cache drop-ins tied to a specific host runtime

## Governance Decision Questions

When deciding where a plugin belongs, ask these in order:

1. Is this site-owned code?
2. Is this a provider/runtime artifact?
3. Does the site actually depend on the plugin's behavior in local review?
4. Does the plugin rely mainly on DB state rather than filesystem code?
5. Does it require a license key or token that belongs in `K:\`?

If the answer to `2` is yes, do not automatically pull the plugin into the
repo or demand local parity.

If the answer to `1` is yes, prefer explicit repo ownership.

If the answer to `4` or `5` is yes, document the dependency boundary instead of
pretending code sync is enough.

## Repo Policy

Default policy for site repos:

- commit site-owned custom plugins
- commit site-owned mu-plugins
- document required third-party plugins explicitly
- do not commit provider-managed runtime plugins by default
- do not commit cache drop-ins by default
- do not commit plugin license keys, API keys, or other secrets

## Worked Example: SEO Plugin Model

Use Rank Math or an equivalent SEO plugin as the default example unless a site
has verified a different actual plugin.

Typical split:

- code:
  - `wp-content/plugins/seo-plugin-slug/`
- settings:
  - WordPress options in DB
- content-linked data:
  - post meta, term meta, schema/meta state, redirect rules
- license:
  - `K:\` vault, not repo

Key implication:

- syncing the SEO plugin folder does not recreate the effective SEO state by
  itself

Local parity guidance:

- local should include the SEO plugin only when site behavior, templates,
  schema, redirect logic, or editorial workflow depend on it
- local does not need full live parity just to prove a theme or mu-plugin
  change

Staging guidance:

- staging is the right place to review plugin behavior that depends on DB state
  or host/runtime specifics
- keep non-production indexing boundaries explicit

Live guidance:

- treat SEO plugin updates as operationally significant because they may affect
  schema, redirects, canonical output, and crawl-facing metadata

Never commit:

- license keys
- API tokens
- raw secret exports
- DB-derived assumptions disguised as code-only parity

## Related Docs

- [plugin-taxonomy-and-placement.md](./plugin-taxonomy-and-placement.md)
- [plugin-sync-boundaries.md](./plugin-sync-boundaries.md)
- [templates/site-repo-starter/docs/plugins-and-runtime.md](../templates/site-repo-starter/docs/plugins-and-runtime.md)
