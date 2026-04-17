# Hostinger PHP Runtime Parity

PHP-runtime parity tarkoittaa sita, etta site-repon dokumentaatio tietaa mika
PHP-versio ja mahdolliset hPanel-poikkeukset oikeassa Hostinger-kohteessa ovat.

## Miten PHP-version hallinta toimii Hostingerissa nyt

Virallisen docin perusteella PHP-version ja extensionien hallinta tapahtuu
hPanelin `PHP Configuration` -nakymasta.

Doc sanoo:

- valittavana on `8.2 and higher`
- folder-kohtainen poikkeus on mahdollinen

Samalla saman docin wording versioiden saatavuudesta ei ole aivan taysin
johdonmukainen, joten tarkka vaihtoehtovalikoima on aina varmennettava
oikeasta hPanelista.

## Mita localissa pitaa peilata

Localissa pitaa ainakin tietaa:

- mika PHP-major/minor pyorii kehitysharnessissa
- onko site-repo riippuvainen jostain tietysta extensionista tai ini-rajoitteesta

Jos local-PHP ja Hostinger-PHP eroavat, parity-docsissa ei teeskennella niiden
olevan samat. Kirjaa toteutunut Hostinger-versio ja paata jatko:

- nosta local lahemmaksi Hostingeria
- tai merkitse ero tietoiseksi riskiksi

## Per-site ja subfolder-poikkeukset

Koska Hostingerin doc viittaa folder-level PHP-poikkeuksiin, niita ei pideta
globaalina oletuksena. Jos poikkeus on kaytossa:

- kirjaa se site-profileen tai deployment-muistioon
- kirjaa myos mihin polkuun poikkeus kohdistuu

## Mika ei ole hyva oletusmalli

Valta file-based PHP-kikkailua oletuksena:

- satunnaiset `.htaccess`-viritykset
- repoon haudatut ini-poikkeukset ilman dokumentoitua tarvetta
- oletus, etta localin vanha PHP riittaa todisteeksi Hostinger-yhteensopivuudesta

Suosi:

- hPanelissa varmennettua current PHP-versiota
- dokumentoitua site-profile-kenttaa `hostinger_php_version`
- selkeaa poikkeamamerkintaa, jos local ei viela vastaa targettia
