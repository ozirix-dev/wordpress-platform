# Hostinger Site Intake Template

Kayta tata templatea, kun yksi oikea Hostinger-sivusto liitetaan site-repon
parity-ajatteluun ensimmaista kertaa.

Tama ei sisalla salaisuuksia.

```yaml
hostinger_website_name: your-hostinger-website
hosting_plan_family: unknown
wordpress_detected: unknown

primary_domain: https://example.com
staging_available: unknown
git_deploy_available: unknown
ssh_enabled: unknown

ssh_command_placeholder: ssh username@hostname
ssh_key_model: password-only | key-supported | unknown

root_path: /home/username/domains/example.com
public_html_path: /home/username/domains/example.com/public_html
git_install_path: ./public_html

php_version: "8.3"
php_extension_or_config_notes:
  - none yet

database_name: your_database_name
database_user: your_database_user
phpmyadmin_entry_path: https://phpmyadmin.hostinger.com

cron_jobs_used: no
deployment_method_chosen: manual-package | git-deploy | mixed

notes: |
  Kirjaa tahan vain site-kohtaiset parity-havainnot, ei salaisuuksia.

verification_date: 2026-04-17
verification_source: Hostinger hPanel + official docs
```

## Intake-saannot

- `hosting_plan_family` voi olla aluksi `unknown`, jos oikeaa plan-etikettia ei
  viela ole varmistettu.
- `wordpress_detected` tarkoittaa sita, tunnistaako hPanel sivuston WordPress-
  kohteeksi niissa nakymissa, joihin staging tai muut WordPress-toiminnot
  nojaavat.
- `git_install_path` kirjataan vain toteutuneena valintana. Ala paata sita
  oletuksena ilman hPanel-tarkistusta.
- `database_user` kirjataan ilman passwordia.
- `verification_source` kertoo mihin tarkistus oikeasti perustui.
