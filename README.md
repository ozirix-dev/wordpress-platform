# wordpress-platform

`wordpress-platform` on `D:\Projects\Support`-haaran shared support -repo WordPress-perheelle.

Tama repo ei omista yhden sivuston tuotantokoodia. Sen tehtava on tarjota yhteinen docs-, starter-, naming- ja policy-kerros silloin, kun perheessa on useita erillisia WordPress-sivustoja eri kieli- ja deploy-malleilla.

## Repo Identity

- canonical nimi: `wordpress-platform`
- local path: `D:\Projects\Support\wordpress-platform`
- current GitHub handle: `ozirix-dev/wordpress-platform`
- canonical GitHub URL: `https://github.com/ozirix-dev/wordpress-platform`

Tässä repossa `wordpress-platform` on kanoninen nimi sekä paikallisessa polussa
että GitHubissa. Historiallinen alkuperäinen GitHub-handle oli `WP-Pohja`, mutta
se ei ole enää tämän repon current-identiteetti.

Ks. tarkempi linjaus: [docs/repo-identity.md](./docs/repo-identity.md)

## Rooli umbrella-rakenteessa

- `D:\Projects\_Hub\Project-Map` on umbrella- ja placement-kartta.
- `D:\Projects\_Hub\ReportHub` on raportointi-, auditointi- ja handoff-kerros.
- `D:\Projects\Support\wordpress-platform` on WordPress-perheen shared support -kerros.
- varsinainen yksittainen WordPress-sivusto kuuluu oletuksena omaan site-repoonsa `D:\Projects\Products\<site-slug>`

Tama repo ei korvaa `Project-Map`- tai `ReportHub`-rooleja, eika se siirra site-kohtaista ownershipia `Support`-haaraan.

## Mita tama repo omistaa

- yhteiset WordPress-perheen arkkitehtuuri- ja placement-docsit
- site-repon bootstrap-starterin
- multilingual- ja multisite-paatosrungot
- kevyet site-repon V1-tyokalut paikalliseen synkkiin ja deploy-paketin kokoamiseen

## Mita tama repo ei omista

- yhden sivuston tuotantokoodia source-of-truthina
- WordPress corea
- tietokantoja tai dumppeja
- `uploads`-kirjastoja
- salaisuuksia, `.env`-tiedostoja tai hostausavaimia
- Hostinger-tilin asetuksia, oikeita deploy-ymparistoja tai live-sivustojen runtimea

## Miksi oletus on yksi repo per sivusto

Yksi repo per sivusto on taman perheen oletus, koska se:

- pitaa ownershipin selvana
- erottaa deploy-syklit ja riskit toisistaan
- sallii eri sivustoille eri kieli-, builder- ja plugin-valinnat
- estaa jaetun WordPress-asennuksen paisumisen vahingossa koko perheen oletukseksi
- sopii hyvin malliin `Local -> GitHub -> Hostinger`

Yhteinen support-repo on tukikerros, ei site-repojen korvike.

## Monikielisyys tassa mallissa

Monikielisyys ei tarkoita automaattisesti WordPress Multisitea.

Oletusjarjestys on:

1. yksi repo per sivusto
2. tarvittaessa yksi WordPress-asennus per sivusto
3. monikielisyys ratkaistaan site-kohtaisesti
4. Multisite otetaan kayttoon vain silloin, kun yksi jaettu verkko on aidosti parempi operatiivinen ratkaisu

Yksi sivusto voi siis olla:

- yksikielinen single-site
- monikielinen single-site
- poikkeuksellisesti osa Multisite-verkkoa

Plugin-valinta tehdaan site-kohtaisesti. Tama repo ei lukitse koko perhetta yhteen multilingual-plugin-ratkaisuun.

## Miksi Multisite ei ole oletus

Multisite keskittaa useita sivustoja samaan WordPress-verkkoon. Se voi olla oikea valinta tietyissa tapauksissa, mutta se kasvattaa jaetun operatiivisen pinnan kokoa:

- yksi asennus vaikuttaa useaan sivustoon
- plugin-, teema- ja kayttajanhallinta sidotaan yhteen
- regressiot ja huoltotyot voivat levita koko verkkoon

Siksi multisite on tassa mallissa harkittu poikkeus, ei perustaso.

## Suhde nykyiseen WordPress-ekosysteemiin

Nykyinen `D:\Projects\Systems\wordpress-dev` voi toimia paikallisena dev-alustana, mutta se on edelleen `Systems`-puolen local-platform-repo.

Tama `wordpress-platform`-repo ei omista Docker-runtimea, local stackia tai jaettua WordPress-instanssia. Se omistaa vain shared support -kerroksen, jonka avulla uusia site-repoja voi bootstrapata siististi.

## Mita starter sisaltaa

`templates/site-repo-starter/` sisaltaa V1-runkoainekset uudelle site-repolle:

- site-repon README:n
- site-kohtaiset docs-pohjat
- WordPress-painotteisen `.gitignore`:n
- minimi `wp-content`-rungon site-kohtaiselle teemalle, custom pluginille ja mu-pluginille
- kevyet PowerShell-tyokalut paikalliseen synkkiin ja deploy-paketin kokoamiseen

Starter ei yrita olla valmis tuote. Sen tarkoitus on pakottaa oikeat boundaryt heti alkuun.

Starterin theme-oletus on neutral site theme -malli. Se tarkoittaa, etta
starterin placeholder-teema on oletuksena oma standalone-teema, ja
child-theme-polku otetaan kayttoon vasta site-kohtaisesti silloin, kun repo
aidosti nojaa erilliseen parent-themeen.

## Miten uusi site-repo bootstrapataan

1. Luo uusi repo polkuun `D:\Projects\Products\<site-slug>`.
2. Kopioi `templates/site-repo-starter/` uuden site-repon sisalloksi.
3. Vaihda placeholder-nimet site-kohtaisiksi.
4. Tayta `docs/site-profile.md`.
5. Paata `language_model`, `translation_method` ja `Hostinger`-target site-kohtaisesti.
6. Lisaa vain se `wp-content`-koodi, jonka kyseinen sivusto oikeasti omistaa.
7. Pida WordPress core, uploads, database, secrets ja backup-payload Gitin ulkopuolella.

## Ennen ensimmaista oikeaa site-repoa

Lue ainakin:

- [docs/architecture.md](./docs/architecture.md)
- [docs/repo-identity.md](./docs/repo-identity.md)
- [docs/site-types.md](./docs/site-types.md)
- [docs/multilingual-strategy.md](./docs/multilingual-strategy.md)
- [docs/multisite-decision-guide.md](./docs/multisite-decision-guide.md)
- [docs/local-single-install-test-plan.md](./docs/local-single-install-test-plan.md)
- [docs/repo-bootstrap-checklist.md](./docs/repo-bootstrap-checklist.md)

Nykyinen local smoke -baseline todisti local sync-, packaging- ja runtime-rajan
yhdella standalone-teemalla. Child theme + oikea parent theme -polku on edelleen
oma erillinen follow-up-testi, ei viela lopullisesti todistettu baseline.

Seuraava isompi vaihe local smoke -vaiheen jalkeen on Hostinger parity -kerros:

- [docs/hostinger-parity/README.md](./docs/hostinger-parity/README.md)
- [docs/hostinger-parity/local-to-hostinger-parity-map.md](./docs/hostinger-parity/local-to-hostinger-parity-map.md)
- [docs/hostinger-parity/hostinger-preflight-checklist.md](./docs/hostinger-parity/hostinger-preflight-checklist.md)

Tavoite on yksinkertainen: jokainen sivusto pysyy omana omistajareponaan, ja shared support -kerros pysyy kevyena mutta hyodyllisena.
