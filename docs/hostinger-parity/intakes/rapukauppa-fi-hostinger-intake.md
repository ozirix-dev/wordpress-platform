# rapukauppa.fi Hostinger Intake

## Site Intake Identity

- intake target name: `rapukauppa.fi`
- reviewed_on: `2026-04-17`
- reviewed_by_context: `Codex`
- data sources:
  - `wordpress-platform` Hostinger parity docs
  - Hostinger API via `D:\Projects\Products\rapukauppa-fi\scripts\hostinger-api.ps1`
  - live WordPress REST surface `https://rapukauppa.fi/wp-json/`
  - local repo context `D:\Projects\Products\rapukauppa-fi`
  - GitHub metadata via `gh repo view ozirix-dev/rapukauppa-fi`
  - attempted Brave/Playwright hPanel read, which stayed on Hostinger auth/challenge flow and did not produce a trustworthy in-panel read

## Site Mapping

- hostinger_website_name: `rapukauppa.fi`
- primary_domain: `https://rapukauppa.fi`
- mapped_local_repo_path: `D:\Projects\Products\rapukauppa-fi`
- mapped_github_repo: `https://github.com/ozirix-dev/rapukauppa-fi`
- matched_site_slug: `rapukauppa-fi`
- wordpress_detected_yes_no: `yes`
- confidence_of_mapping: `high`

## Verified Hostinger Facts

- hosting_plan_family: `hostinger_business`
- hostinger_system_username: `u963025419`
- public_path: `/home/u963025419/domains/rapukauppa.fi/public_html`
- git_deploy_available: `unknown`
- git_deploy_current_status: `unknown`
- staging_available: `unknown`
- staging_current_status: `unknown`
- ssh_available: `unknown`
- ssh_enabled: `unknown`
- php_version: `unknown`
- php_extensions_or_config_notes:
  - `unknown`
- database_name: `unknown`
- database_user: `unknown`
- phpmyadmin_entry_path: `https://phpmyadmin.hostinger.com`
- cron_in_use_yes_no: `unknown`
- file_manager_or_ftp_notes:
  - Hostinger website inventory exposed the website `root_directory` only as the public web root.
  - A separate hPanel File Manager or FTP view was not verified in this pass.
- verification_source:
  - `rapukauppa.fi`, `is_enabled`, `order_id`, `username` and `public_path`:
    - Hostinger API `GET /api/hosting/v1/websites`
  - `hosting_plan_family`:
    - Hostinger API `GET /api/hosting/v1/orders?statuses[]=active&order_ids[]=1006284049`
  - `wordpress_detected_yes_no`:
    - live `https://rapukauppa.fi/wp-json/` response exposed a WordPress REST index and Hostinger WordPress plugin namespaces
  - `mapped_github_repo` and visibility:
    - `gh repo view ozirix-dev/rapukauppa-fi`

## Unknown / Not Yet Verified

- separate account home path without `public_html`
  - why unknown:
    - Hostinger API exposed the website web root only
  - verify in:
    - `hPanel` or SSH/path view
- Git deploy availability and current configuration
  - why unknown:
    - not exposed by the API calls used in this pass and hPanel read did not complete
  - verify in:
    - `hPanel`
- Hostinger staging availability and current status
  - why unknown:
    - hPanel WordPress/staging view was not verified
  - verify in:
    - `hPanel`
- SSH availability, enabled state and actual host string
  - why unknown:
    - capability is plan-sensitive and was not confirmed from this account
  - verify in:
    - `hPanel`
- PHP version and PHP config/extensions
  - why unknown:
    - current account/site runtime view was not reached
  - verify in:
    - `hPanel`
- database name and database user
  - why unknown:
    - not exposed by the website/order API calls used here
  - verify in:
    - `hPanel`
- cron usage
  - why unknown:
    - cron list was not reachable in this pass
  - verify in:
    - `hPanel`

## Local-to-Hostinger Parity Notes

- local must match:
  - site-owned `wp-content` code in `D:\Projects\Products\rapukauppa-fi`
  - the current local attachment to `D:\Projects\Systems\wordpress-dev`
  - the reality that production is a live WordPress site on Hostinger, not a full-repo runtime mirror
- local should not try to mirror:
  - Hostinger uploads
  - Hostinger database state
  - Hostinger account toggles for staging, SSH, Git deploy or cron
- site-repo metadata only:
  - GitHub repo identity
  - chosen deployment method
  - verified Hostinger capability status
- host-only runtime state:
  - actual Hostinger website enablement
  - hosting order state and plan
  - database credentials
  - hPanel capability toggles

## Deployment Recommendation For This Site

- recommended model right now: `manual package`

Perustelu:

- verified facts prove that `rapukauppa.fi` exists as an active Hostinger website
  on `hostinger_business`
- verified facts also prove that the live site is a WordPress installation
- this pass did not verify Git deploy, staging or SSH in hPanel, so niiden
  varaan ei pidä lukita ensimmäistä site-kohtaista deploy-päätöstä

## Risks / Caveats

- Hostinger capability flags remain partly plan-sensitive and hPanel-sensitive
- the public WordPress surface can drift independently from the local repo until
  the first controlled site-code adoption pass is complete
- do not store secrets, database passwords or SSH private keys in repo docs
- do not treat `phpmyadmin_entry_path` as proof that the correct database is
  already mapped; it is only the current Hostinger direct entry URL pattern

## Recommended Next Step

- tee yksi autentikoitu `rapukauppa.fi`-kohteen hPanel-only capability read ja
  tayta sen perusteella puuttuvat kentat:
  - staging
  - Git deploy
  - SSH
  - PHP version
  - database name/user
  - cron
