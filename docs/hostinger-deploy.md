# Hostinger-deploy

Tama dokumentti kuvaa varovaisen perusmallin WordPress-perheen Hostinger-deploylle.

Tassa passissa ei rakenneta oikeaa deploy-automaatioita, ei muuteta tiliymparistoa eika kosketa live-sivustoihin. Tavoite on rajata mita kannattaa versionoida ja mita kannattaa siirtaa Hostingeriin.

Jos tarvitset Hostingerin nykyiset dokumentoidut faktat, capability-matrixin tai
site-intake-pohjan, kayta ensin:

- [docs/hostinger-parity/README.md](./hostinger-parity/README.md)
- [docs/hostinger-parity/hostinger-current-facts.md](./hostinger-parity/hostinger-current-facts.md)
- [docs/hostinger-parity/local-to-hostinger-parity-map.md](./hostinger-parity/local-to-hostinger-parity-map.md)

Tama tiedosto on tarkoituksella yleisempi deploy-linja. Current facts -kerros
elaa `hostinger-parity/`-osion alla.

## Peruslinja

Deployoi GitHubista paaasiallisesti vain site-kohtainen WordPress-koodi:

- `wp-content/themes/`
- `wp-content/plugins/`
- `wp-content/mu-plugins/`
- tarvittaessa pienet deploy-metatiedot tai manifestit

Ela deployoi GitHubista:

- WordPress corea
- `wp-admin/`- ja `wp-includes/`-puuta
- `uploads`-kirjastoa
- tietokantaa
- salaisuuksia tai `.env`-tiedostoja
- backup-zippeja, dumppeja tai muuta runtime-jatetta

## Site-repo ja Hostinger-site

Oletus on yksi site-repo per yksi Hostingerissa hallittava sivusto tai WordPress-asennus.

Kaytannossa yhteys kannattaa ajatella nain:

- `Products/<site-slug>` omistaa versionhallittavan site-koodin
- Hostingerin sivusto tai WordPress-asennus omistaa liven runtimen
- deploy siirtaa vain sen osan, jonka Git oikeasti omistaa

Tama erottaa omistuksen siististi:

- Git omistaa koodin ja docsit
- Hostinger omistaa runtime-ympariston
- WordPress admin ja tietokanta omistavat sisallon ja asetusten elavan tilan

## Staging tassa mallissa

Staging kannattaa ajatella site-kohtaisena, ei perheen yhteisena oletusklusterina.

Mahdollisia malleja ovat esimerkiksi:

- erillinen staging-domain tai subdomain
- erillinen Hostinger-site
- hostauksen tarjoama staging-toiminto, jos valittu plan tai tuote tukee sita

Koska Hostingerin ominaisuudet voivat vaihdella planin, hosting-tuotteen ja ajankohdan mukaan, staging-ominaisuudet kannattaa varmistaa aina nykyisesta tilista ennen kuin niiden varaan rakennetaan workflowta.

## Buildatut theme-assetsit

Jos sivuston teema tuottaa buildattuja assetteja, paata site-repossa kumpi on deployn source of truth:

1. repo sisaltaa valmiiksi buildatut assetit, jotka siirretaan Hostingeriin sellaisenaan
2. repo sisaltaa lahteet, mutta deploy-pakettiin otetaan vain build-output

Yhta aikaa ei kannata yrittaa omistaa kaikkea epaselvasti.

Kaytannon V1-saanto:

- Hostingeriin menee se asset-muoto, jota runtime oikeasti tarvitsee
- deploy-paketti ei saa olla riippuvainen Hostingerissa tehtavasta satunnaisesta buildista
- jos build vaatii Node-tyoketjun, tee build ennen paketin kokoamista

## Miten valtetaan koko-WordPressin sekava versionhallinta

Valta tata:

- koko WordPress-asennus Gitissa
- `uploads`-kansion kopiointi reppoon
- tietokantadumpin pitaminen koodimuutosten rinnalla vakiona
- hostauskohtaisen runtime-jatteen versionhallinta

Suosi tata:

- site-kohtainen `wp-content`-ownership
- selkea deploy-paketti
- site-profile, joka kertoo mita seurataan Gitissa ja mita ei

## Kaytannon guardrailit

- pida deploy scope site-kohtaisena
- dokumentoi `staging_url`, `production_url` ja `deployment_method` site-profileen
- tarkista ennen automaatiota, mita nykyinen Hostinger-ymparisto oikeasti tukee
- valta ratkaisuja, joissa yksi shared repo alkaa omistaa usean liven WordPress-asennuksen koko runtimea

Jos joku sivusto tarvitsee myohemmin vahvemman Hostinger-automaatio- tai API-polun, se kannattaa paattaa site-repossa erikseen, ei pakottaa taman shared support -repon perusmalliksi.
