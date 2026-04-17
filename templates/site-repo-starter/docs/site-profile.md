# Site Profile

Tayta tama tiedosto heti, kun uusi site-repo syntyy. Pida tama lyhyena mutta konkreettisena.

## Profiili

```yaml
site_slug: your-site-slug
site_name: Your Site Name
primary_domain: https://example.com
secondary_domains:
  - https://www.example.com
repo_path: D:\Projects\Products\your-site-slug
github_repo: https://github.com/your-org/your-site-repo

language_model: single
translation_method: none
primary_locale: fi_FI
additional_locales: []

installation_type: single
child_theme: your-child-theme
custom_plugin: your-custom-plugin
mu_plugins:
  - site-tweaks.php
page_builder: none
seo_plugin: none
local_stack: wordpress-dev

hostinger_site_name: your-hostinger-site
staging_url: https://staging.example.com
production_url: https://example.com
deployment_method: manual-package

tracked_in_repo:
  - wp-content/themes/your-child-theme/
  - wp-content/plugins/your-custom-plugin/
  - wp-content/mu-plugins/site-tweaks.php
  - docs/
  - tools/
not_tracked_in_repo:
  - WordPress core
  - wp-admin/
  - wp-includes/
  - wp-content/uploads/
  - database
  - backups
  - cache
  - secrets
notes: |
  Kirjaa tahan site-kohtaiset poikkeukset, ownership-rajat ja muut
  olennaiset huomiot.
```

## Kenttien tulkinta

- `language_model`
  - `single`
  - `multilingual`
  - `multisite-network`
  - `multisite-subsite`
- `translation_method`
  - `none`
  - `plugin`
  - `multisite`
- `installation_type`
  - `single`
  - `multisite`

Pidä kentat keskenaan johdonmukaisina:

- `language_model: single` sopii normaalisti yhteen `installation_type: single`
- `language_model: multilingual` on yleensa edelleen `installation_type: single`
- `language_model: multisite-network` tai `multisite-subsite` edellyttaa kaytannossa `installation_type: multisite`

## Paivityssaanto

Paivita tama tiedosto aina, kun:

- domain tai URL-strategia muuttuu
- language model muuttuu
- deployment method muuttuu
- Hostinger-target vaihtuu
- repo ownership -raja tarkentuu
