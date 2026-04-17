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
theme_slug: your-site-theme
parent_theme_slug: null
custom_plugin: your-custom-plugin
mu_plugins:
  - site-tweaks.php
page_builder: none
seo_plugin: none
local_stack: wordpress-dev

hostinger_plan_family: unknown
hostinger_website_name: your-hostinger-site
hostinger_root_path: /home/username/domains/example.com
hostinger_public_path: /home/username/domains/example.com/public_html
hostinger_git_deploy_enabled: unknown
hostinger_git_install_path: ./public_html
hostinger_staging_available: unknown
hostinger_ssh_enabled: unknown
hostinger_php_version: "8.3"
database_name: your_database_name
database_user: your_database_user
phpmyadmin_entry_path: https://phpmyadmin.hostinger.com
cron_in_use: no
verification_date: 2026-04-17
verification_source: Hostinger hPanel + official docs

staging_url: https://staging.example.com
production_url: https://example.com
deployment_method: manual-package

tracked_in_repo:
  - wp-content/themes/your-site-theme/
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
- `hostinger_plan_family`
  - kayta toteutunutta Hostinger-plan-perhetta, jos se on tiedossa
  - muuten `unknown`
- `hostinger_git_deploy_enabled`
  - `yes`
  - `no`
  - `unknown`
- `hostinger_staging_available`
  - `yes`
  - `no`
  - `unknown`
- `hostinger_ssh_enabled`
  - `yes`
  - `no`
  - `unknown`

Kentta `theme_slug` kertoo site-repon oman repo-managed teeman kansion nimen.
Kentta `parent_theme_slug` on valinnainen ja taytetaan vain silloin, kun
sivusto tarkoituksella nojaa erilliseen parent-themeen.

Pidä kentat keskenaan johdonmukaisina:

- `language_model: single` sopii normaalisti yhteen `installation_type: single`
- `language_model: multilingual` on yleensa edelleen `installation_type: single`
- `language_model: multisite-network` tai `multisite-subsite` edellyttaa kaytannossa `installation_type: multisite`
- `parent_theme_slug: null` on normaali oletus, kun starterin teema on oma
  standalone site theme
- jos `parent_theme_slug` on asetettu, theme-koodin ja `style.css`-headerin
  kuuluu vastata sita tietoisesti
- `hostinger_root_path` ja `hostinger_public_path` kirjataan vain varmennettuna,
  ei arvattuna
- `database_user` kirjataan ilman passwordia
- `verification_source` kertoo, perustuuko tieto Hostinger-docsiin, hPaneliin,
  vai molempiin

## Paivityssaanto

Paivita tama tiedosto aina, kun:

- domain tai URL-strategia muuttuu
- language model muuttuu
- deployment method muuttuu
- Hostinger-target vaihtuu
- Hostinger capability tai polku tarkentuu
- repo ownership -raja tarkentuu

Jos `site_slug`, local path ja `github_repo` eivät vastaa toisiaan, kirjaa
poikkeama ja suunniteltu harmonisointi `notes`-kenttään heti.
