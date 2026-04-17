# Plugin Taxonomy And Placement

This taxonomy separates WordPress plugin-like artifacts by ownership,
filesystem placement, runtime expectations, and risk.

## A. Hosting / provider managed runtime plugins

- definition:
  - plugins added or maintained by the hosting provider as part of the managed
    WordPress runtime
- examples:
  - `Hostinger AI`
  - `Hostinger Easy Onboarding`
  - `Hostinger Reach`
  - `Hostinger Tools`
- where code lives:
  - usually `wp-content/plugins/<provider-plugin>/` in the host runtime
- where settings live:
  - mostly WordPress DB, sometimes provider-linked services
- expected in local:
  - no by default
- expected in staging:
  - yes when the host-managed target runtime provisions them
- expected in live:
  - possible, but site docs must verify rather than assume
- expected in repo:
  - no by default
- common risks:
  - confusing provider runtime with site-owned application code

## B. Hosting / performance integration plugins

- definition:
  - plugins whose main job is to integrate WordPress with the host cache,
    object cache, CDN, or other runtime acceleration layer
- examples:
  - `LiteSpeed Cache`
- where code lives:
  - usually `wp-content/plugins/<performance-plugin>/`
- where settings live:
  - WordPress DB and host/runtime behavior
- expected in local:
  - no by default
- expected in staging:
  - yes when the host runtime uses the same integration
- expected in live:
  - yes when the host runtime uses the same integration
- expected in repo:
  - no by default
- common risks:
  - copying host cache assumptions into local development where they do not
    exist

## C. Site-required third-party business plugins

- definition:
  - non-provider plugins the site actually depends on for business behavior
- examples:
  - SEO plugin such as Rank Math
  - commerce, form, booking, or membership plugins
- where code lives:
  - usually `wp-content/plugins/<plugin-slug>/`
- where settings live:
  - mostly WordPress DB, often plus post meta or term meta
- expected in local:
  - only when the site needs that behavior locally
- expected in staging:
  - usually yes before production reliance
- expected in live:
  - yes when the site depends on them
- expected in repo:
  - document always; vendor code only by deliberate decision
- common risks:
  - assuming that the plugin folder alone captures state, licensing, or content
    metadata

## D. Repo-managed custom plugins

- definition:
  - site-owned normal plugins whose code belongs to the site repo
- examples:
  - `your-custom-plugin`
  - a site-owned integrations plugin
- where code lives:
  - site repo and runtime under `wp-content/plugins/`
- where settings live:
  - code in repo, state usually in DB if the plugin stores options
- expected in local:
  - yes
- expected in staging:
  - yes
- expected in live:
  - yes
- expected in repo:
  - yes
- common risks:
  - mixing site code with provider/runtime plugins in the same ownership model

## E. Repo-managed custom mu-plugins

- definition:
  - site-owned must-use code that must load on every request
- examples:
  - `site-tweaks.php`
  - environment header or runtime guard mu-plugins
- where code lives:
  - site repo and runtime under `wp-content/mu-plugins/`
- where settings live:
  - code in repo, any state usually in DB if the mu-plugin stores options
- expected in local:
  - yes
- expected in staging:
  - yes
- expected in live:
  - yes
- expected in repo:
  - yes
- common risks:
  - forgetting that mu-plugins auto-load and do not behave like normal
    activation-based plugins

## F. Drop-ins

- definition:
  - special WordPress drop-in files loaded by filename rather than normal plugin
    activation
- examples:
  - `object-cache.php`
- where code lives:
  - `wp-content/<drop-in>.php`
- where settings live:
  - host/runtime state and sometimes WordPress DB
- expected in local:
  - no by default
- expected in staging:
  - yes when the host runtime enables that integration
- expected in live:
  - yes when the host runtime enables that integration
- expected in repo:
  - no by default
- common risks:
  - treating a host-provided drop-in as if it were site-owned application code

## G. Local-only dev/debug plugins

- definition:
  - plugins useful only for development, profiling, migration, or debugging
- examples:
  - debug bar plugins
  - local migration helpers
- where code lives:
  - local runtime only, or deliberately excluded from production deploy scope
- where settings live:
  - local WordPress DB
- expected in local:
  - yes when needed
- expected in staging:
  - no by default
- expected in live:
  - no
- expected in repo:
  - only if intentionally documented and excluded from deployment
- common risks:
  - accidentally promoting dev tooling into staging/live expectations

## H. Unknown / drift / review-needed

- definition:
  - plugin-like artifacts whose owner or purpose is not yet clear
- examples:
  - unexpected premium plugins
  - host-added tools not yet documented
  - a plugin present in staging but absent from repo and site docs
- where code lives:
  - whichever runtime currently contains them
- where settings live:
  - unknown until verified
- expected in local:
  - no until classified
- expected in staging:
  - review-needed
- expected in live:
  - review-needed
- expected in repo:
  - no until deliberately adopted
- common risks:
  - silently normalizing drift into the operating model

## Practical Reading Rule

When you see a plugin on a real site, classify it before you decide whether it
belongs in:

- the site repo
- local parity goals
- staging validation scope
- production operating assumptions
