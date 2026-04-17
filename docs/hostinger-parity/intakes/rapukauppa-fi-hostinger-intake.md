# rapukauppa.fi Hostinger Intake

## Site Intake Identity

- intake target name: `rapukauppa.fi`
- reviewed_on: `2026-04-17`
- reviewed_by_context: `Codex`
- data sources:
  - `wordpress-platform` Hostinger parity docs
  - Hostinger API via `D:\Projects\Products\rapukauppa-fi\scripts\hostinger-api.ps1`
  - Hostinger public OpenAPI `https://developers.hostinger.com/openapi/openapi.json`
  - live WordPress REST surface `https://rapukauppa.fi/wp-json/`
  - local repo context `D:\Projects\Products\rapukauppa-fi`
  - GitHub metadata via `gh repo view ozirix-dev/rapukauppa-fi`
  - initial Brave + Playwright auth-check against copied Brave profile data
  - live Brave + Playwright attach to the already authenticated Hostinger hPanel session after relaunching Brave with remote debugging enabled

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
- hostinger_subscription_name: `Business Web Hosting`
- hostinger_subscription_status: `non_renewing`
- hostinger_system_username: `u963025419`
- public_path: `/home/u963025419/domains/rapukauppa.fi/public_html`
- git_deploy_available: `yes`
- git_deploy_current_status: `no repository configured; create-state visible in hPanel`
- staging_available: `yes`
- staging_current_status: `no staging environment visible; create-state visible in hPanel`
- ssh_available: `yes`
- ssh_enabled: `no`
- ssh_connection_hint: `ssh -p 65002 u963025419@92.112.182.62`
- php_version: `unknown`
- php_extensions_or_config_notes:
  - `PHP Configuration page is available in hPanel`
  - `Selectable versions observed in the current UI: PHP 8.2, PHP 8.3, PHP 8.4, PHP 8.5`
  - `The active selected PHP version was not readable from the current hPanel view in this pass`
- database_name: `u963025419_bdTYW`
- database_user: `u963025419_HwpPW`
- database_additional_visible_candidates:
  - `u963025419_3j7E9 / u963025419_NJvtS` was visible in the same hosting account, but the site mapping for that row was not verified in this pass
- phpmyadmin_entry_path: `https://phpmyadmin.hostinger.com`
- cron_in_use_yes_no: `no existing cron jobs were visible in the current hPanel cron view`
- file_manager_or_ftp_notes:
  - Hostinger website inventory exposed the website `root_directory` as the public web root.
  - hPanel File Manager exposes a website-specific access mode and a broader hosting-plan access mode as separate choices.
  - A literal parent path outside `public_html` was not shown in the verified File Manager text.
- verification_source:
  - `rapukauppa.fi`, `is_enabled`, `order_id`, `username` and `public_path`:
    - Hostinger API `GET /api/hosting/v1/websites`
  - `hosting_plan_family`:
    - Hostinger API `GET /api/hosting/v1/orders?statuses[]=active&order_ids[]=1006284049`
  - `hostinger_subscription_name` and `hostinger_subscription_status`:
    - Hostinger API `GET /api/billing/v1/subscriptions`
  - `wordpress_detected_yes_no`:
    - live `https://rapukauppa.fi/wp-json/` response exposed a WordPress REST index and Hostinger WordPress plugin namespaces
  - `mapped_github_repo` and visibility:
    - `gh repo view ozirix-dev/rapukauppa-fi`
  - `shared-hosting capability API gap`:
    - Hostinger public OpenAPI `0.11.7` showed `Hosting: Files` and `Hosting: Wordpress` tags, but no verified read operations for site-level Git deploy, staging, SSH, PHP, database or cron capability reads
  - `Git deploy`, `staging`, `SSH`, `PHP page availability`, `database rows`, `phpMyAdmin view`, `cron view` and `File Manager wording`:
    - live Brave + Playwright attach to the already authenticated Hostinger hPanel session for `rapukauppa.fi`
  - `initial copied-profile auth-check`:
    - copied Brave profile landed on public/log-in pages for GitHub, Cloudflare and Hostinger rather than a reusable authenticated session, so the reliable browser read path became live Brave attach over remote debugging

## Unknown / Not Yet Verified

- explicit parent path literal without `public_html`
  - why unknown:
    - Hostinger API exposed the website web root only, and the verified File Manager text did not show the parent path as a literal path string
  - verify in:
    - `hPanel` or SSH/path view
- active PHP version and final PHP config/extensions
  - why unknown:
    - the PHP Configuration page was reachable, but the currently active selected version was not readable from the captured view
  - verify in:
    - `hPanel`
- whether the additional database row belongs to `rapukauppa.fi`
  - why unknown:
    - one row was clearly mapped to `rapukauppa.fi`, but the second visible row was shown as an assignable database rather than a confirmed site binding
  - verify in:
    - `hPanel`
- whether `no visible cron jobs` should be treated as a final site-level no
  - why unknown:
    - the verified hPanel cron view showed the create form and no existing rows, but this pass did not perform any deeper operational audit beyond the visible view
  - verify in:
    - `hPanel`

## Local-to-Hostinger Parity Notes

- local must match:
  - site-owned `wp-content` code in `D:\Projects\Products\rapukauppa-fi`
  - the current local attachment to `D:\Projects\Systems\wordpress-dev`
  - the reality that production is a live WordPress site on Hostinger, not a full-repo runtime mirror
  - the active Hostinger PHP major version once it is read from hPanel
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

- recommended model right now: `staging-first manual flow`

Perustelu:

- verified facts prove that `rapukauppa.fi` exists as an active Hostinger website on `hostinger_business`
- verified facts also prove that the live site is a WordPress installation
- staging capability is visible in hPanel, but no staging environment exists yet
- Git deploy capability is visible in hPanel, but no repository is configured
- SSH capability is visible, but it is currently `INACTIVE`
- therefore the safest first site-specific deployment path is still a manual artifact flow, but now with staging as the preferred first boundary rather than direct live-only promotion

## Risks / Caveats

- Hostinger capability flags remain partly plan-sensitive and hPanel-sensitive
- the copied Brave profile did not preserve reusable authenticated sessions for GitHub, Cloudflare or Hostinger in Playwright, so the reliable browser path currently depends on relaunching live Brave with remote debugging enabled
- the public WordPress surface can drift independently from the local repo until the first controlled site-code adoption pass is complete
- do not store secrets, database passwords or SSH private keys in repo docs
- do not treat `phpmyadmin_entry_path` as proof that the correct database is already mapped; it is only the current Hostinger direct entry URL pattern

## Recommended Next Step

- lue viela `rapukauppa.fi`-kohteen aktiivinen PHP-versio ja varmista, onko `u963025419_bdTYW / u963025419_HwpPW` sivuston ainoa kanoninen tietokantarivi; sen jalkeen lukitse ensimmainen hallittu site-kohtainen muutosmalli `staging-first manual flow` -linjaan
