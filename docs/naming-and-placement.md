# Nimeaminen ja placement

Tama dokumentti sovittaa WordPress-perheen namingin nykyiseen `Projects`-umbrella-logiikkaan.

## Perusmalli

- yhden sivuston owner-repo kuuluu `Products`-haaraan
- shared WordPress support -repo kuuluu `Support`-haaraan
- workstation-level kartta ja governance pysyvat `_Hub`-haarassa

Siksi taman repon paikka on:

- `D:\Projects\Support\wordpress-platform`

ja uuden site-repon oletuspaikka on:

- `D:\Projects\Products\<site-slug>`

## Site-repon nimeaminen

Suosi nimea, joka kertoo mika sivusto tai domain kyseessa on:

- `rapukauppa-fi`
- `example-com`
- `nordic-services`

Nyrkkisaannot:

- kayta pienia kirjaimia
- kayta yhdysmerkkeja, ei valilyonteja
- pida nimi vakaana ja ihmisluettavana
- nimea repo ensisijaisesti sivuston tai domainin mukaan, ei teknisen toteutuksen mukaan

## Monikielinen site naming

Monikielinen sivusto ei oletuksena saa omaa erillista repoaan per kieli.

Oletus on edelleen:

- yksi repo
- yksi site-slug
- kielitiedot `site-profile`- ja `languages-and-locales`-dokumenteissa

Erillinen locale-repo tarvitsee erillisen perustelun, koska se kasvattaa ownership- ja deploy-pintaa.

## Milloin repo kuuluu Products-haaraan

Repo kuuluu `Products`-haaraan, kun se on yhden sivuston tai verkon kanoninen omistajarepo:

- site-kohtainen WordPress-koodi
- site-kohtaiset docsit
- site-kohtainen deploy-raja
- site-kohtaiset operator-muistiot

## Milloin shared repo kuuluu Support-haaraan

Repo kuuluu `Support`-haaraan, kun se tukee useita muita repoja eika omista yhden sivuston runtimea.

`wordpress-platform` kuuluu `Support`-haaraan, koska se:

- tarjoaa yhteiset starterit
- dokumentoi yhteiset WordPress-perheen rajat
- ei omista yksittaisen sivuston tuotantokoodia

## Milloin jokin on Staging-tapaus

Kayta `Staging`-haaraa vain, kun repon lopullinen rooli ei ole viela lukittu.

Esimerkkeja:

- kokeilu, josta voi tulla myohemmin site-repo
- migration- tai selvitystyotila, jossa ownership on viela auki

Aktiivista tuotantosivustoa ei pida jattaa `Staging`-haaraan vain siksi, etta nimi tai scope tuntuu keskeneraiselta.

## Milloin jokin on Archive-tapaus

Kayta `Archive`-haaraa, kun sivusto tai repo ei ole enaa aktiivinen omistajapinta, mutta sen historia tai fallback-arvo halutaan sailyttaa.

Archive ei ole poistamista varten. Se on tietoinen historian koti.

## Multisite naming

Jos paatetaan perustaa oikea multisite-network owner-repo, nimea se sen verkon tai palveluperheen mukaan, ei geneerisena `multisite`-repona.

Esimerkki:

- `Products\example-network`

Subsiteja ei oletuksena nimeta omina repoinaan, ellei ownership ole oikeasti erotettava.

## Kaytannon muistutus

Jos kysymys on "omistaako tama repo yhden sivuston vai tukeeko se useita sivustoja", vastaus ratkaisee placementin:

- yksi sivusto -> `Products`
- useita sivustoja tukeva shared kerros -> `Support`
