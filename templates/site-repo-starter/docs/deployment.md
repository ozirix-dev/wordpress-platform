# Deployment

Tama tiedosto on site-kohtainen muistio paikallisesta kehityksesta, Git-polusta ja Hostingeriin vietavasta deploy-rajasta.

## Local

- paikallinen kehitys tapahtuu hallitussa WordPress-ymparistossa
- paikallinen stack kirjataan `site-profile.md`:n kenttaan `local_stack`
- paikallinen runtime ei ole taman repon source of truth, vaan vain kehitysymparisto

## Git

- `main` on kanoninen paahaara
- feature-muutokset tehdaan lyhytikaisissa brancheissa
- vain versionhallittava site-kohtainen koodi ja docs kuuluvat GitHubiin

## Hostinger

- Hostinger on production target vain taman sivuston osalta
- deploy scope rajataan site-kohtaiseen `wp-content`-omistukseen
- WordPress corea, tietokantaa, `uploads`-kirjastoa tai salaisuuksia ei tuoda GitHubista deploy-pakettiin
- Hostinger-capabilityt varmennetaan `site-profile.md`-kenttiin ennen kuin
  deployment-mallia pidetaan paatettyna

Kirjaa tahan ainakin:

- hosting plan family:
- Hostinger website name:
- root path:
- public path:
- Git deploy kaytossa: `yes | no | unknown`
- Git install path:
- SSH kaytossa: `yes | no | unknown`
- PHP version:
- database name:
- phpMyAdmin entry path:
- cron kaytossa: `yes | no`
- verification date:
- verification source:

Jos tieto on edelleen plan-sensitive tai product-sensitive, kirjoita suoraan
`verify in hPanel`.

## Staging

Kirjaa tahan oma toteutus:

- staging kaytossa: `yes | no`
- staging URL:
- staging target:
- miten staging eroaa tuotannosta:

Jos stagingia ei ole, kirjoita se suoraan tahan dokumenttiin.

## Production

Kirjaa tahan oma tuotantopolku:

- production URL:
- production target:
- miten paketti siirtyy tuotantoon:
- kuka tarkistaa tuotantovalmiuden:

## Starter-helperit

Kayta tarvittaessa taman starterin apureita:

- `tools/sync-to-local.ps1`
  - tarkoitettu paikalliseen synkkiin, ei live-ymparistoon
  - aja ensin `-DryRun -WhatIf`
  - `-PurgeExtraneous` vaatii lisaksi `-AllowPurge`
  - skripti ei ole tarkoitettu source-repon omaan puuhun tai tuotantopolkuun
- `tools/package-deployable.ps1`
  - kokoaa review-paketin site-kohtaisesta repo-managed sisallosta
  - paketin deploy-payload on `wp-content/`; `package-manifest.json` on
    review-metatietoa, ei Hostingeriin vietavaa WordPress-sisaltoa
  - aja ensin `-DryRun -WhatIf`
  - salli `ExtraFiles` vain tarkoituksellisille repo-relatiivisille tiedostoille
  - manifestin `includedExtras` kuvaa vain ne extra-tiedostot, jotka todella
    kopioitiin pakettiin; puuttuvat extrat kirjataan manifestin varoituksiin

## Rollback-ajattelu

Pida rollback yksinkertaisena:

1. tieda viimeisin toimiva paketti tai release
2. pida deploy scope pienena
3. palauta vain repo-managed site-kohtainen kerros
4. kirjaa havainto ja korjaus `ReportHub`iin vain kun tehtava tai poikkeama oikeasti vaatii audit trailin

## Ennen deployta tarkistetaan

- `site-profile.md` on ajan tasalla
- oikea `staging_url` ja `production_url` on kirjattu
- deploy-paketin WordPress-payload sisaltaa vain hallitut `wp-content`-polut
- ei `uploads`, dumppeja, cachea tai salaisuuksia
- multilingual-site:ssa locale-polut ja kaannoslogiikka on tarkistettu
- rollback-polku on tiedossa ennen tuotantoonvientia
- mahdolliset starter-helperit on ajettu ensin dry-runina

## Muistutus

Tama tiedosto kuvaa site-kohtaisen deploy-ajattelun. Jos perheen yhteinen deploy-linja muuttuu, paatos kirjataan ensisijaisesti `D:\Projects\Support\wordpress-platform`-repoon, ei vain tahan site-repoon.

Hostingerin current facts ja parity-map loytyvat shared support -repasta:

- `D:\Projects\Support\wordpress-platform\docs\hostinger-parity\README.md`
- `D:\Projects\Support\wordpress-platform\docs\hostinger-parity\local-to-hostinger-parity-map.md`
