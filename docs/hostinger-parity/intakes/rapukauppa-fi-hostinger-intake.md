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
  - live Brave + Playwright read of the Hostinger WordPress Staging page before and after staging creation
  - live Brave + Playwright read of the authenticated Cloudflare DNS Records page for `rapukauppa.fi`
  - public DNS and HTTP reachability checks against `https://staging.rapukauppa.fi/`

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
- account_home_path: `/home/u963025419`
- site_parent_path_before_public_html: `/home/u963025419/domains/rapukauppa.fi`
- public_path: `/home/u963025419/domains/rapukauppa.fi/public_html`
- git_deploy_available: `yes`
- git_deploy_current_status: `no repository configured; create-state visible in hPanel`
- staging_available: `yes`
- staging_current_status: `created; visible in hPanel staging list with status Completed`
- staging_exact_url: `https://staging.rapukauppa.fi/`
- staging_public_reachability: `blocked at verification time; DNS name did not resolve publicly`
- ssh_available: `yes`
- ssh_enabled: `no`
- ssh_connection_hint: `ssh -p 65002 u963025419@92.112.182.62`
- php_version: `PHP 8.3`
- php_extensions_or_config_notes:
  - `PHP Configuration page is available in hPanel`
  - `Selectable versions observed in the current UI: PHP 8.2, PHP 8.3, PHP 8.4, PHP 8.5`
  - `The active selected version was read from the checked radio input on the PHP Configuration page: PHP 8.3`
- database_name: `u963025419_bdTYW`
- database_user: `u963025419_HwpPW`
- database_additional_visible_candidates:
  - `u963025419_3j7E9 / u963025419_NJvtS` was visible in the same hosting account, but the Website column showed `Assign` rather than `rapukauppa.fi`
- phpmyadmin_entry_path: `https://phpmyadmin.hostinger.com`
- cron_in_use_yes_no: `no existing cron jobs were visible in the current hPanel cron view`
- file_manager_or_ftp_notes:
  - Hostinger website inventory exposed the website `root_directory` as the public web root.
  - hPanel File Manager exposes a website-specific access mode and a broader hosting-plan access mode as separate choices.
  - The Cron Jobs form exposed the account-home prefix `/home/u963025419/`, which closes the parent path interpretation together with the verified public path.
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
  - `staging_current_status`, `staging_exact_url` and create outcome:
    - live Brave + Playwright read of the Hostinger WordPress Staging page after creating subdomain `staging`
  - `active PHP version`:
    - live Brave + Playwright DOM read from the checked radio input on the PHP Configuration page
  - `account_home_path`:
    - live Brave + Playwright read from the default Cron Jobs PHP command prefix `/usr/bin/php /home/u963025419/`
  - `site_parent_path_before_public_html`:
    - deterministic derivation from the verified `public_path` plus the verified account-home prefix
  - `additional database row is not mapped to rapukauppa.fi`:
    - live Brave + Playwright row read from MySQL Database Management where the Website column showed `Assign`
  - `staging_public_reachability`:
    - `Resolve-DnsName staging.rapukauppa.fi`
    - `Invoke-WebRequest https://staging.rapukauppa.fi/`
    - `Invoke-WebRequest https://staging.rapukauppa.fi/wp-admin/`
    - `Invoke-WebRequest https://staging.rapukauppa.fi/wp-json/`
    - live Brave + Playwright read of the authenticated Cloudflare DNS Records page, which showed only apex `A` and `www` `CNAME` records for `rapukauppa.fi`
  - `initial copied-profile auth-check`:
    - copied Brave profile landed on public/log-in pages for GitHub, Cloudflare and Hostinger rather than a reusable authenticated session, so the reliable browser read path became live Brave attach over remote debugging

## Unknown / Not Yet Verified

- no blocker-level capability unknowns remain in the current deploy-contract baseline
- public staging baseline checks are currently blocked, not unknown:
  - Hostinger shows staging as created and completed
  - public DNS for `staging.rapukauppa.fi` did not resolve at verification time
  - because the staging hostname does not resolve publicly yet, front page, `wp-admin` and `wp-json` checks could not be completed in this pass
- not audited in this pass:
  - field-by-field PHP extension and option overrides beyond the active version `PHP 8.3`

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
- staging capability is visible in hPanel and the first staging environment now exists at `https://staging.rapukauppa.fi/`
- Git deploy capability is visible in hPanel, but no repository is configured
- SSH capability is visible, but it is currently `INACTIVE`
- public staging baseline verification is still blocked because `staging.rapukauppa.fi` does not currently resolve in public DNS
- therefore the safest first site-specific deployment path is still a manual artifact flow with staging as the preferred first boundary, but the next concrete blocker is now DNS reachability rather than missing staging capability

## Risks / Caveats

- Hostinger capability flags remain partly plan-sensitive and hPanel-sensitive
- the copied Brave profile did not preserve reusable authenticated sessions for GitHub, Cloudflare or Hostinger in Playwright, so the reliable browser path currently depends on relaunching live Brave with remote debugging enabled
- the public WordPress surface can drift independently from the local repo until the first controlled site-code adoption pass is complete
- the first staging subdomain now exists in Hostinger, but public reachability is blocked until the authoritative DNS layer exposes `staging.rapukauppa.fi`
- do not store secrets, database passwords or SSH private keys in repo docs
- do not treat `phpmyadmin_entry_path` as proof that the correct database is already mapped; it is only the current Hostinger direct entry URL pattern

## Recommended Next Step

- tee erillinen pieni DNS-pass, jossa lisataan tai varmennetaan `staging.rapukauppa.fi` nykyiseen Cloudflare-zoneseen, ja aja vasta sen jalkeen staging-frontin, `wp-admin`-polun ja `wp-json`-pinnan baseline-check uudelleen
