# Local Single-Install Test Plan

Tama dokumentti kuvaa suositellun ensimmaisen local-testipassin tilanteessa,
jossa WordPress-perheen shared support -mallia halutaan kokeilla vain yhdella
paikallisella WordPress-asennuksella.

Tavoite ei ole rakentaa pysyvaa local-platformia tassa repossa. Tavoite on
todentaa hallitusti, etta:

- yksi site-repo voidaan bootstrapata taman shared support -mallin paalta
- repo-managed `wp-content` voidaan synkata yhteen local WordPress-asennukseen
- package-helperit tuottavat review-kelpoisen artifactin
- ownership-rajat pysyvat selkeina

## Miksi yksi asennus riittaa ensimmaiseen testiin

Ensimmainen local-pass ei tarvitse useita WordPress-asennuksia, koska tassa
vaiheessa emme testaa usean sivuston rinnakkaisajoa emmeka multisite-verkkoa.

Yksi puhdas single-site WordPress-asennus riittaa todentamaan:

- starter-rungon kaynnistyminen
- repo-managed teeman ja pluginien sijoittuminen oikeisiin polkuihin
- helper-skriptien dry-run- ja sync-kayttaytyminen
- package-helperin rajaus repo-managed sisaltoon
- sen, etta core, uploads, tietokanta ja salaisuudet pysyvat Gitin ulkopuolella

## Suositeltu testimalli

Kayta kahta erillista paikallista pintaa:

1. yksi local WordPress-asennus testikohteena
2. yksi erillinen testisivuston repo tai tyokopio, joka omistaa vain
   `wp-content`-kerroksen

Suositeltu sijoittelu:

- local WordPress root:
  - esimerkiksi `D:\Projects\Systems\wordpress-dev\...`
  - tai muu jo olemassa oleva paikallinen WordPress-ymparisto
- testisite-repo:
  - ensisijaisesti valiaikainen polku `D:\Projects\Staging\...`, jos kyse ei ole
    viela oikeasta tuotantosivustosta
  - tai suoraan `D:\Projects\Products\<site-slug>`, jos ensimmainen oikea
    sivusto on jo tiedossa

Tarkeaa on, etta local WordPress root ja site-repo eivat ole sama hakemisto.

## Rajat tassa suunnitelmassa

Tassa suunnitelmassa ei:

- rakenneta multisitea
- versionoida WordPress corea
- versionoida `uploads`-kansiota
- siirreta tietokantaa GitHubiin
- sidota tata suoraan Hostingeriin
- rakenneta CI/CD-putkea

Tama on local-validointisuunnitelma yhdelle single-site asennukselle.

## Suositeltu eteneminen

## Vaihe 1: Valitse testikohde oikein

Paatos ennen mitaan bootstrapia:

- testataanko vain starterin tekninen toimivuus
- vai bootstrapataanko samalla ensimmainen oikea site-repo

Jos tarkoitus on vain varmistaa mallin toimivuus, tee ensin valiaikainen
testisite-repo esimerkiksi:

- `D:\Projects\Staging\wordpress-platform-local-smoke`

Jos oikea sivusto on jo tiedossa, bootstrap voidaan tehda suoraan polkuun:

- `D:\Projects\Products\<site-slug>`

## Vaihe 2: Pidä local WordPress-asennus puhtaana harnessina

Yksi asennus toimii tassa mallissa harnessina, ei source-of-truthina.

Suositeltu baseline:

- WordPress asentuu normaalisti paikalliseen rootiin
- admin toimii
- permalinks voidaan tallentaa
- kaytossa on vain ne plugin- ja teemapaketit, joita testikohde oikeasti tarvitsee

Ennen ensimmaista syncia kirjaa ylos:

- local WordPress root
- kaytossa oleva PHP-versio
- kaytossa oleva tietokanta
- mahdollinen virheloki

Tama helpottaa myohempaa vertailua, jos jokin menee rikki.

## Vaihe 3: Bootstrap testisite-repo starterista

Kopioi `templates/site-repo-starter/` testisite-repon sisalloksi.

Tayta heti ainakin:

- `README.md`
- `docs/site-profile.md`
- `docs/deployment.md`
- `docs/languages-and-locales.md`
- `docs/content-boundaries.md`

Ensimmainen testikohde kannattaa pitaa mahdollisimman yksinkertaisena:

- `language_model: single`
- `translation_method: none`
- `installation_type: single`
- yksi repo-managed teema
- yksi custom plugin
- yksi mu-plugin

Tavoite on ensin todentaa perusraja, ei kaikkea kerralla.

Kaytannon huomio ensimmaisen smoke-kierroksen jalkeen:

- jos local harnessissa ei ole valmiiksi tarkoitettua parent-themea, ensimmainen
  smoke-teema kannattaa tehda tarkoituksella standalone-teemaksi
- child theme -malli kannattaa ottaa käyttöön vasta, kun parent-theme on osa
  tiedossa olevaa local baselinea tai oikeaa site-repoa

Starterin nykyinen oletusmalli seuraa samaa linjaa: ensimmaisen site-repon
placeholder-teema on neutral site theme -scaffold, ei pakotettu child theme.
Jos sivusto tarvitsee child-teeman, kirjaa `parent_theme_slug`
`site-profile.md`:aan ja muuta teeman headerit site-kohtaisesti.

Mita nykyinen smoke-testi todisti:

- local sync -raja toimii yhdella local WordPress-asennuksella
- packaging-raja toimii repo-managed `wp-content`-sisallolle
- runtime-raja toimii, kun repo-managed teema ja plugin aktivoidaan harnessissa

Mita nykyinen smoke-testi ei viela todistanut:

- child theme + oikea parent theme -polkua ei ole viela todennettu erillisena
  testina
- smoke tehtiin tarkoituksella standalone-teemalla, jotta parent-theme-riippuvuus
  ei sotke ensimmaista boundary-validointia

Tama ei tee child theme -mallista huonoa ratkaisua. Se vain tarkoittaa, etta
parent-themeen sidottu polku kannattaa testata seuraavassa erillisessa
follow-up-passissa, eika sitoa starterin oletusscaffoldia siihen.

## Vaihe 4: Tarkista omistusraja ennen syncia

Ennen kuin yhtaan tiedostoa kopioidaan local WordPressiin, tarkista:

- site-repo sisaltaa vain repo-managed `wp-content`-sisallon
- `.gitignore` sulkee ulos `uploads`, cachet, dumpit, backupit ja salaisuudet
- local WordPress root ei ole sama kuin site-repo
- starterin placeholderit on vaihdettu

Tama on kriittinen kohta. Jos omistusraja on epa-selva jo tassa vaiheessa,
myohempi deploy-polku menee sekaisin.

## Vaihe 5: Aja ensimmaiset helper-testit dry-runina

Tee aina ensin dry-run.

Suositeltu jarjestys:

1. `sync-to-local.ps1`
2. `package-deployable.ps1`

Esimerkkiajatus:

```powershell
pwsh -File .\tools\sync-to-local.ps1 `
  -TargetWordPressPath D:\path\to\local-wp `
  -DryRun -WhatIf
```

Tarkista dry-runissa:

- oikeat scope-polut tunnistuvat
- target osoittaa local WordPress rootiin
- skripti ei yrita kirjoittaa takaisin source-repon puuhun
- purge ei ole vahingossa kaytossa

Sen jalkeen testaa package-helper dry-runina:

```powershell
pwsh -File .\tools\package-deployable.ps1 `
  -ArtifactType Directory `
  -DryRun -WhatIf
```

Tarkista dry-runissa:

- artifactin scope on vain `mu-plugins`, `plugins`, `themes`
- `ExtraFiles` pysyvat repo-relatiivisina
- manifestin luonti kuuluu suunniteltuun outputiin

## Vaihe 6: Tee ensimmainen oikea sync localiin

Kun dry-run nayttaa oikealta, aja sync ilman `-DryRun`-lippua.

Suositeltu ensimmaisen kierroksen rajaus:

- ei `-PurgeExtraneous`
- vain perusscopet
- yksi testikierros yhdelle sivustolle

Taman jalkeen local WordPressissa tarkistetaan:

- teema loytyy administa
- custom plugin loytyy administa
- mu-plugin on latautunut
- ei valittomia fatal-virheita

## Vaihe 7: Tee admin-tason smoke-testit

Ensimmainen smoke-testilista:

- front page latautuu
- admin `/wp-admin/` latautuu
- teema voidaan aktivoida
- custom plugin voidaan aktivoida
- mu-plugin ei riko kirjautumista tai adminia
- permalinks voidaan tallentaa ilman virhetta
- media/upload-polku pysyy local WordPressin omana, ei repon omana

Jos jokin naista epaonnistuu, korjaus tehdään site-repon puolella tai local
harnessin asetuksissa, ei shared support -repoon sokkona.

## Vaihe 8: Tee packaging-testi

Kun local sync toimii, testaa package-helper oikeasti.

Suositeltu ensimmaisen kierroksen artifacti:

- `ArtifactType Directory`

Se on helpoin tarkistaa silmalla. Kun se toimii, testaa:

- `ArtifactType Zip`

Tarkista package-sisallosta:

- mukana on vain repo-managed `wp-content`
- ei WordPress corea
- ei `uploads`-sisaltoa
- ei tietokantaa
- ei salaisuuksia
- manifesti vastaa todellista artifactia

## Vaihe 9: Testaa turvallisuusrajat tarkoituksella

Tassa kohtaa kannattaa ajaa muutama hallittu negatiivinen testi:

- anna `sync-to-local.ps1`:lle source-repon oma path targetiksi
  - odotus: skripti kieltaytyy
- aja `-PurgeExtraneous` ilman `-AllowPurge`
  - odotus: skripti kieltaytyy
- anna `package-deployable.ps1`:lle vaarallinen `ExtraFiles`-polku kuten `..\`
  - odotus: skripti kieltaytyy

Jos nama suojat toimivat, local-malli on paljon turvallisempi ottaa oikeaan
site-repoon.

## Vaihe 10: Laajenna vasta sitten

Kun single-language single-site -baseline on todistettu, vasta sen jalkeen
siirry seuraaviin lisatesteihin tarpeen mukaan:

- multilingual single-site
- page builder -kohtaiset erot
- seo-plugin -kohtaiset erot
- staging- ja production-docsien tarkennus

Multisitea ei kannata ottaa ensimmaiseen local-passiin.

## Suositeltu onnistumiskriteeri

Tama local-pass on onnistunut, kun:

- yksi testisite-repo on bootstrapattu hallitusti
- `sync-to-local.ps1` toimii dry-runina ja oikeana ajona
- `package-deployable.ps1` tuottaa tarkistettavan artifactin
- WordPress admin ja frontend pysyvat ehjina
- repo-managed `wp-content` on erotettu WordPress coresta ja local datasta
- tiedetaan, mita seuraavaksi pitaisi testata oikeassa site-repossa

## Mitä ei kannata tehdä heti tämän jälkeen

- ala lisata useita rinnakkaisia local WordPress-asennuksia ilman syyta
- ala pakottaa multilingual-pluginia ennen single-site baselinea
- ala rakentaa deploy-automatiikkaa ennen kuin package-raja on todennettu
- ala sekoittaa shared support -repoa ja oikeaa site-repoa samaan puuhun

## Suositeltu seuraava konkreettinen askel

Kun tama suunnitelma on reviewattu, seuraava kaytannollinen askel on:

1. paattaa tehdaanko ensin valiaikainen smoke-repo `Staging`-haaraan vai
   bootstrapataanko suoraan ensimmainen oikea site-repo
2. valita yksi puhdas local WordPress-asennus testiharnessiksi
3. ajaa ensimmainen dry-run kierros starterin helper-skripteilla
