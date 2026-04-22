# Site Repo Starter

Tama template on tarkoitettu yhden WordPress-sivuston omistajarepon V1-bootstrapiin.

## License

Starterin oletuslisenssi on `GPL-2.0-or-later`.

Pidä site-owned WordPress-teema-, plugin-, mu-plugin- ja helper-koodi samalla
WordPress-yhteensopivalla lisenssiketjulla, ellei site-repossa dokumentoida
erillistä yhteensopivaa päätöstä. Sisältö, media, salaisuudet, lisenssiavaimet
ja asiakasdata eivät kuulu tähän repo-lisenssiin.

## Mita tama repo omistaa

Site-repo omistaa yhden sivuston versionhallittavan kerroksen:

- site-kohtaisen teeman
- site-kohtaisen custom pluginin
- site-kohtaiset mu-pluginit
- site-kohtaiset docsit
- kevyet paikalliset helper-skriptit

Starterin oletusteema on neutral site theme -scaffold. Oletus on siis oma
repo-managed standalone-teema, joka ei nojaa erilliseen parent-themeen ilman
site-kohtaista paatosta.

Jos oikea sivusto tarvitsee child-teeman, muuta placeholder-teema
tarkoituksellisesti child-theme-malliin ja kirjaa `parent_theme_slug`
`site-profile.md`:aan.

2026-04-17 local smoke -tulos todisti standalone-teemalla sync-, packaging- ja
runtime-rajan. Se ei yksinaan todista child theme + parent theme -polkua,
jos site-repo nojaa valmiiseen parent-themeen.

## Child-theme conversion

Standalone site theme riittaa, kun sivusto omistaa oman teema-runkonsa eika
nojaa tarkoituksellisesti erilliseen parent-themeen.

Siirry child theme -malliin vasta silloin, kun sivusto oikeasti laajentaa
yhteisesti hallittua parent-themea.

Pieni conversion-checklist:

1. paivita `docs/site-profile.md`:
   - `theme_slug: your-child-theme`
   - `parent_theme_slug: your-parent-theme`
2. lisaa `style.css`:aan `Template:`-header, joka vastaa parent-theme-slugia
3. vaihda `functions.php`:n nykyinen standalone-oletus child-theme-logiikkaan,
   jos parent-theme tarvitsee oman stylesheetin enqueue-ajon

Esimerkkikatkelma child-theme-headerista:

```css
/*
Theme Name: Example Child Theme
Template: kadence
Text Domain: example-child-theme
*/
```

Validation-muistutus:

- jos `parent_theme_slug` on asetettu, `style.css`-headerin, runtime-baselinen
  ja oikean parent-theme-paketin kuuluu vastata toisiaan
- 2026-04-17 local smoke -baseline todisti standalone-teeman, ei yksinaan
  parent-themeen sidottua child-theme-polkuasi

Site-repo ei omista yhteista WordPress-perheen support- tai umbrella-kerrosta.

## Mita tama repo ei sisalla

Tassa repossa ei pideta:

- WordPress corea
- `wp-admin/`- tai `wp-includes/`-puita
- `wp-content/uploads/`-mediaa
- tietokantaa, dumppeja tai backup-zippeja
- salaisuuksia, `.env`-tiedostoja tai avaimia

GitHubiin kuuluu paaasiallisesti vain se koodi ja dokumentaatio, jonka tama yksi sivusto oikeasti omistaa.

Nimeämislinja kannattaa pitää heti siistinä:

- local path
- repo slug
- GitHub handle

saavat mielellään olla samaa nimeämisketjua. Jos jokin niistä poikkeaa
väliaikaisesti, dokumentoi poikkeama heti `README.md`:ssa ja `site-profile.md`:ssa.

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
   - `your-site-theme` tai vastaava site-kohtainen theme slug
   - `your-custom-plugin`
3. Tayta `docs/site-profile.md` ensimmaisena.
4. Tayta `docs/deployment.md`, `docs/languages-and-locales.md` ja `docs/content-boundaries.md`.
5. Lisaa site-kohtainen teema- ja plugin-koodi vasta sen jalkeen kun ownership-raja on dokumentoitu.
6. Pida tuotantopolku mallissa `Local -> GitHub -> Hostinger`, mutta ala rakenna live-automaatioita liian aikaisin.

## Helperit

Starter sisaltaa kaksi kevytta PowerShell-apuria:

- `tools/sync-to-local.ps1`
  - synkkaa repo-managed `wp-content`-rungon paikalliseen WordPress-kohteeseen
  - aja ensin aina `-DryRun -WhatIf`
  - `-PurgeExtraneous` vaatii lisaksi `-AllowPurge`
  - skripti kieltaytyy kirjoittamasta takaisin source-repon omaan puuhun
- `tools/package-deployable.ps1`
  - kokoaa review-kelpoisen paketin repo-managed `wp-content`-poluista
  - kirjoittaa `package-manifest.json`-review-metatiedon paketin juureen
  - tukee `Directory`- ja `Zip`-artifacteja
  - aja ensin aina `-DryRun -WhatIf`
  - `ExtraFiles` pidetaan repo-relatiivisina ja source-repon rajoissa
