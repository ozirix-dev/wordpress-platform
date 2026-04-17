# Multisite-paatosopas

WordPress Multisite kuuluu tahan perheeseen vain harkittuna poikkeusmallina.

## Kayta multisitea vain jos oikeasti tarvitset

Hyvia perusteluja voivat olla esimerkiksi:

- useat sivustot tarvitsevat aidosti yhden jaetun WordPress-verkon
- kayttaja- tai hallintamalli hyotyy keskitetysta verkko-operaatiosta
- yhteiset plugin- ja teemapaatokset ovat toivottuja, eivat ongelma
- verkon yhteinen hallinta on halvempi tai turvallisempi kuin useiden erillisten asennusten operointi

## Ala kayta multisitea, jos syy on vain jokin naista

- sivustolla on useampi kieli
- halutaan valttaa uuden site-repon luonti
- halutaan "saastaa yksi asennus"
- ei ole viela paatosta siita, ovatko sivustot oikeasti yksi verkko vai monta erillista palvelua

## Operatiiviset seuraukset

Multisite tuo mukanaan yhteisen operointipinnan:

- verkon paivitykset koskevat useaa sivustoa
- plugin- ja teemariskit voivat levita laajalle
- roolit ja kayttajahallinta muuttuvat verkkoajatteluksi
- yhden sivuston poikkeukset voivat olla vaikeampia toteuttaa siististi

## Jaetun asennuksen riskit

- yksi huono paivitys voi vaikuttaa koko verkkoon
- testaus- ja rollback-raja ei aina ole yhden sivuston mittainen
- verkko voi alkaa ohjata site-arkkitehtuuria liikaa
- ownership hamartyy helposti, jos osa muutoksista on network-tasolla ja osa subsite-tasolla

## Miksi erilliset sivustot ovat useimmiten parempi oletus

Taman umbrella-mallin tavoitteena on selkea ownership. Erilliset sivustot ovat useimmiten parempi oletus, koska ne:

- pitavat Git-rajan selvana
- pitavat deployn site-kohtaisena
- sallivat eri kieli-, plugin- ja builder-ratkaisut
- rajaavat regressiot paremmin
- sopivat luontevasti malliin `Products/<site-slug>`

## Paatoslista ennen multisitea

Kysy ainakin:

1. Ovatko nama oikeasti yksi verkko vai useita erillisia sivustoja?
2. Hyotyvatko kayttajat ja operaattorit aidosti yhteisesta hallinnasta?
3. Onko rollback edelleen hallittava, jos yksi deploy menee pieleen?
4. Tarvitaanko jaettu verkko, vai riittaisiko usea erillinen site-repo ja asennus?
5. Pysyyko ownership selkeana viela vuoden paasta?

Jos johonkin olennaiseen kohtaan ei ole vahvaa kylla-vastausta, oletus pysyy:

- yksi repo per sivusto
- multisite ei ole oletus
