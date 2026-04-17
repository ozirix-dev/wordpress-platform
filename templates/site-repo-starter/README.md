# Site Repo Starter

Tama template on tarkoitettu yhden WordPress-sivuston omistajarepon V1-bootstrapiin.

## Mita tama repo omistaa

Site-repo omistaa yhden sivuston versionhallittavan kerroksen:

- site-kohtaisen child themen
- site-kohtaisen custom pluginin
- site-kohtaiset mu-pluginit
- site-kohtaiset docsit
- kevyet paikalliset helper-skriptit

Site-repo ei omista yhteista WordPress-perheen support- tai umbrella-kerrosta.

## Mita tama repo ei sisalla

Tassa repossa ei pideta:

- WordPress corea
- `wp-admin/`- tai `wp-includes/`-puita
- `wp-content/uploads/`-mediaa
- tietokantaa, dumppeja tai backup-zippeja
- salaisuuksia, `.env`-tiedostoja tai avaimia

GitHubiin kuuluu paaasiallisesti vain se koodi ja dokumentaatio, jonka tama yksi sivusto oikeasti omistaa.

## Sijainti ja suhde muihin repoihin

Taman site-repon oletuspolku on:

- `D:\Projects\Products\<site-slug>`

Suhteet muihin kerroksiin:

- `D:\Projects\Support\wordpress-platform`
  - shared support -repo startereille, namingille, multilingual-strategialle ja yhteisille docs-linjauksille
- `D:\Projects\_Hub\Project-Map`
  - umbrella- ja placement-kartta
- `D:\Projects\_Hub\ReportHub`
  - raportointi-, auditointi- ja handoff-kerros

Site-repo on yhden sivuston source of truth. `wordpress-platform` on ohjaava shared kerros, ei taman sivuston tuotantokoodin kanoninen koti.

## Branch-malli

Pida branch-malli yksinkertaisena:

1. `main` on kanoninen paahaara.
2. Kayta lyhytikaisia branchia kuten `feat/...`, `fix/...` ja `chore/...`.
3. Ota `staging`-haara kayttoon vain jos se vastaa oikeaa staging-ymparistoa tai sovittua release-mallia.

Branch-rakenne ei saa korvata deploy-ajattelua. Ensin tarkistus, sitten hallittu siirto stagingiin tai tuotantoon.

## Monikielisyys ja multisite

Monikielisyys ei muuta site-repon perusajatusta. Oletus on edelleen yksi repo per sivusto, vaikka sivusto olisi multilingual.

WordPress Multisite on poikkeusmalli. Jos sivusto kuuluu multisite-verkkoon, dokumentoi se heti `site-profile.md`:ssa ja `languages-and-locales.md`:ssa.

## Bootstrap tiivistettyna

1. Kopioi taman starterin sisalto uuteen site-repoon.
2. Nimea placeholderit site-kohtaisiksi:
   - `your-site-slug`
   - `your-child-theme`
   - `your-custom-plugin`
3. Tayta `docs/site-profile.md` ensimmaisena.
4. Tayta `docs/deployment.md`, `docs/languages-and-locales.md` ja `docs/content-boundaries.md`.
5. Lisaa site-kohtainen teema- ja plugin-koodi vasta sen jalkeen kun ownership-raja on dokumentoitu.
6. Pida tuotantopolku mallissa `Local -> GitHub -> Hostinger`, mutta ala rakenna live-automaatioita liian aikaisin.
