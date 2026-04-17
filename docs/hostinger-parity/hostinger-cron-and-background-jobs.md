# Hostinger Cron And Background Jobs

Tama dokumentti erottaa kaksi asiaa, jotka menevat helposti sekaisin:

- ajastettu cron-ajo
- pitkaikainen taustaprosessi

## Cron jobs Hostingerissa

Virallisen cron-docin perusteella:

- cron timezone on UTC+0
- hPanel tukee ainakin PHP-, custom command- ja website URL -tyyppisia jobeja
- jos komento sisaltaa erikoismerkkeja, kannattaa kayttaa advanced commandia tai
  `.sh`-wrapperia

Tama riittaa parity-layerille.

## Mita se tarkoittaa WordPress-siteille

WordPress-siteissa cron-ajattelu kannattaa dokumentoida kysymalla:

- kayttaako sivusto vain WordPressin sisaisia request-driven jobeja
- tarvitaanko oikea Hostinger cron
- onko cron PHP-komento vai jokin muu hallittu komentopolku

Starteriin riittaa kentta `cron_in_use`. Tarkempi cron-komento kuuluu vasta
oikean site-repon deployment-muistioon tai secure ops -tasolle.

## Background process -rajat

Virallinen background process -doc on VPS-painotteinen. Siksi shared
Web/WordPress/Cloud-hostingille ei pideta turvallisena oletuksena:

- jatkuvasti kayvissa olevia worker-prosesseja
- omaa process manager -mallia
- pitkaa shell-loopia tai daemonia

## Kaytannon saanto

- Suosi WordPress- tai cron-vetoista mallia ennen taustaprosesseja.
- Jos tehtava aidosti vaatii taustaprosesseja, pysahdy tarkistamaan onko kyse jo
  VPS- tai muusta ei-shared -mallista.
- Muunna ajat UTC+0-yhteensopiviksi ennen kuin kirjaat oikeaa ajoaikataulua.
