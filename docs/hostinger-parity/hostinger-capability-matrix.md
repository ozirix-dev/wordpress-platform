# Hostinger Capability Matrix

Tama matrix auttaa paattamaan, mita Hostinger-capabilitya kannattaa verrata
localiin ja missa kohtaa site-repon metadata tarvitsee vastaavan kentan.

| Capability | Local equivalent | Hostinger source of truth | Where to verify in hPanel | Site-profile field needed? | Notes / caveats |
| --- | --- | --- | --- | --- | --- |
| Root path | local WordPress-root tai mount target | Website root directory doc + site runtime | File Manager, SSH, website root context | Yes: `hostinger_root_path` | Root path on site-kohtainen, ei support-repon oletus |
| Public path | local `public_html`-vastine tai runtime mount | Root directory doc | File Manager, SSH | Yes: `hostinger_public_path` | `public_html` on tavallinen mutta silti varmennettava |
| Git deploy | package-helper output tai repo-managed `wp-content` | Git deploy doc | Advanced -> Git | Yes: `hostinger_git_deploy_enabled` | Install path tarkistetaan site-kohtaisesti |
| Git install path | package review scope | Git deploy doc | Advanced -> Git | Optional: deployment-doki | Tyhja kentta vs `./public_html` on kirjattava tarkoituksellisesti |
| Staging | local smoke / local review flow | WordPress staging doc | WordPress -> Staging, jos nakyma on olemassa | Yes: `hostinger_staging_available` | Plan- ja WordPress-detection-sensitive |
| SSH | local shell access | SSH enable/connect docs | Advanced -> SSH Access | Yes: `hostinger_ssh_enabled` | Docsissa wording drift plan-saatavuudesta |
| SSH keys | local keypair management | SSH key doc | SSH Access -> SSH Keys | No separate starter-kenttaa pakolla | Kirjaa notes/deployment-dokiin vain jos oikeasti kaytossa |
| PHP version | local `php -v` / harness runtime | PHP version doc | Advanced -> PHP Configuration | Yes: `hostinger_php_version` | Folder-level override voi olla olemassa; verify in hPanel |
| PHP config | local ini expectations | PHP options doc | Advanced -> PHP Configuration | No dedicated field by default | Kirjaa poikkeukset notesiin |
| Database / phpMyAdmin | local DB used by harness | Manage databases doc + phpMyAdmin doc | Databases, phpMyAdmin | Yes: `database_name`, `database_user`, `phpmyadmin_entry_path` | Password ei kuulu repoihin |
| Cron | local scheduler or manual script run | Cron doc | Advanced -> Cron Jobs | Yes: `cron_in_use` | Aikavyohyke UTC+0 |
| File Manager / FTP path | local package target | FTP/File Manager docs | File Manager / FTP client | No extra field if root/public path documented | Ei todiste deploy-oikeuksista yksin |
| Background process limits | local long-running process | Background process doc | Ei tyypillisesti shared-siteille relevanttia hallintanakymaa | No | Oleta ei-saatavaksi shared Web/WordPress -mallissa |

## Tulkinta

- Jos capabilityta ei voi todentaa hPanelissa, ala merkitse sita site-repoon
  toteutuneena.
- Jos capability riippuu WordPress-detectionista tai planista, kirjaa se
  `unknown` tai `verify in hPanel` kunnes oikea sivusto on tarkistettu.
