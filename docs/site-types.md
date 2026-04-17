# Site-tyypit

Tassa perheessa site-tyyppi valitaan operatiivisen tarpeen mukaan, ei WordPress-ominaisuuksien vuoksi vain siksi, etta ne ovat saatavilla.

## 1. Single-site / single-language

### Milloin kaytetaan

- yksi brandi tai palvelu
- yksi paakieli
- ei tarvetta jaetulle verkko- tai kielierottelulle

### Milloin ei kayteta

- jos saman sivuston sisalla on aidosti useita localeja
- jos yhden asennuksen alle tarvitaan useita erillisia sivustoja

### Repo-vaikutus

- yksi site-repo `Products`-haarassa
- yksi site profile
- hyvin selkea ownership

### Hosting- ja deploy-vaikutus

- yksi Hostinger-site tai vastaava target
- deploy scope pysyy pienena
- rollback on helpompi rajata

### Riskit ja rajat

- jos monikielisyys tulee myohemmin, malli voi tarvita laajennuksen
- yksinkertainen rakenne ei itsessaan ratkaise sisallontuotannon prosessia

## 2. Single-site / multilingual

### Milloin kaytetaan

- kyse on edelleen yhdesta sivustosta
- eri kielet jakavat saman brandin, rakenteen ja perustoiminnallisuuden
- halutaan yksi site-repo ja yksi WordPress-asennus

### Milloin ei kayteta

- jos eri kieliversiot ovat kaytannossa eri sivustoja eri ownershipilla
- jos eri markkinat tarvitsevat vahvasti erilliset deploy-syklit tai plugin-pinot

### Repo-vaikutus

- yksi site-repo pysyy oletuksena
- site-profileen kirjataan `language_model: multilingual`
- plugin-valinta ja translation workflow dokumentoidaan site-kohtaisesti

### Hosting- ja deploy-vaikutus

- yksi Hostinger-asennus voi riittaa
- deploy kohdistuu yha samaan site-kohtaiseen koodiin
- locale-logiikka kasvattaa testattavaa pintaa

### Riskit ja rajat

- kaannosworkflow voi sitoa tiimin tiettyyn plugin-ekosysteemiin
- URL-strategia ja SEO-ratkaisut on paatettava tietoisesti
- yhdella plugin-paivityksella voi olla laaja vaikutus kaikkiin kieliin

## 3. Multisite-network

### Milloin kaytetaan

- oikeasti tarvitaan yksi jaettu WordPress-verkko
- useat sivustot jakavat hallintaa, kayttajia tai keskitettya verkko-operaatiota
- verkon yhteinen hallintamalli on erillisia sivustoja tehokkaampi

### Milloin ei kayteta

- vain siksi, etta sivustolla on monta kielta
- kun tavoitteena on vain saastaa yksi asennus
- kun sivustojen on parempi pysya operatiivisesti erillaan

### Repo-vaikutus

- verkolla voi olla oma owner-repo `Products`-haarassa
- subsitejen omistusrajat on kuvattava erikseen
- shared support -repo ei muutu verkon runtime-kodiksi

### Hosting- ja deploy-vaikutus

- yksi verkko tarkoittaa jaettua asennusta ja yhteista riskia
- deploy- ja huoltotyot voivat koskea useaa sivustoa samalla kertaa
- Hostinger-toteutus on varmistettava erikseen valitun tuotteen ja hallintamallin mukaan

### Riskit ja rajat

- regressio voi levita koko verkkoon
- plugin- ja teemapaatokset muuttuvat yhteisiksi
- kayttaja- ja roolihallinta monimutkaistuu

## 4. Multisite-subsite

### Milloin kaytetaan

- sivusto elaa olemassa olevan multisite-verkon sisalla
- subsite kuuluu tietoisesti verkon jaettuun operointimalliin

### Milloin ei kayteta

- jos subsite on kaytannossa itsenainen sivusto, joka kannattaisi erottaa
- jos oma deploy-sykli tai ownership halutaan selvaksi ilman verkko-riippuvuutta

### Repo-vaikutus

- subsite ei useimmiten ole oma taydellinen WordPress-repo
- mahdollinen oma docs- tai config-kerros riippuu verkon ownership-rajoista
- shared code voi elaa network-repossa, ei subsite-kohtaisesti

### Hosting- ja deploy-vaikutus

- deploy tapahtuu verkon yhteisten guardrailien puitteissa
- yhden subsite-muutoksen vaikutus on tarkistettava koko verkon kannalta

### Riskit ja rajat

- subsite-ownership voi hamartya
- rollback ei aina ole puhtaasti yhden subsite:n asia
- rajat sisallon, koodin ja verkkoasetusten valilla vaativat erityista kuria

## Nyrkkisaanto

Jos et ole varma, aloita mallista:

- `single-site / single-language`, tai
- `single-site / multilingual`

Multisite tarvitsee erillisen perustelun. Se ei ole oletusratkaisu yhden sivuston kasvulle tai monikielisyydelle.
