# Content Boundaries

Tama tiedosto kertoo, mita tahan site-repoon kuuluu ja mita ei.

## Mita kuuluu tahan repoon

Tahan repoon kuuluu vain yhden sivuston versionhallittava kerros:

- site-kohtainen teema
- custom pluginit
- site-kohtaiset mu-pluginit
- `docs/`
- `tools/`

Teema voi olla joko child theme tai standalone-teema. Oleellista on, etta
kyse on sivuston omasta repo-managed teemasta, ei WordPress-coren tai hostin
jaetusta runtime-sisallosta.

## Mita ei kuulu tahan repoon

Tahan repoon ei kuulu:

- WordPress core
- `wp-admin/`
- `wp-includes/`
- `wp-content/uploads/`
- tietokanta
- exportit ja dumpit
- backup-zipit
- cache ja muu runtime-jate
- salaisuudet

## Media, uploads, DB, exports ja backups

Kasittele nama aina erillisina:

- media ja `uploads`
  - kuuluvat runtimeen, eivat GitHubiin
- database
  - kuuluu runtimeen tai erilliseen export-prosessiin, ei site-repon vakiopolkuun
- exports
  - kayta erillista lokaatiota tai ignoroitua kansiota, jos tilapaisia exportteja tarvitaan
- backups
  - ala kayta site-repoa backup-hautumaana

## Suhde shared support -repoon

`D:\Projects\Support\wordpress-platform` antaa yhteisen mallin, mutta ei omista taman sivuston sisaltoa tai tuotantokoodia.

## Tarkistuslista

- `tracked_in_repo` ja `not_tracked_in_repo` on paivitetty `site-profile.md`:ssa
- `.gitignore` estaa `uploads`-, DB-, backup- ja secret-driftin
- deploy-paketti rajataan vain repo-managed site-kohtaiseen koodiin
- mahdolliset poikkeukset on kirjoitettu tahan dokumenttiin eika jatetty hiljaisiksi oletuksiksi
