# Hostinger Database Access

Tama dokumentti rajaa, mita database-faktaa WordPress-siteista kannattaa
dokumentoida parity- ja intake-tarkoituksiin ilman etta salaisuuksia paatyy
repoon.

## Mitka access-pisteet docs vahvistavat

Virallisten docsien perusteella:

- databaseja ja userien hallintaa tehdään hPanelin database-nakymasta
- phpMyAdminiin on suora entry path:
  `https://phpmyadmin.hostinger.com`

Tama riittaa parity-layerille.

## Mita tietoa tarvitaan ilman salasanoja

Site-repon metadataan riittavat:

- `database_name`
- `database_user`
- `phpmyadmin_entry_path`

Password, host string ja muut salaiset yksityiskohdat eivat kuulu starteriin tai
site-profileen.

## Miten DB-access kirjataan

Starter-tasolla DB-access kirjataan site-profileen. Oikean sivuston intake-vaiheessa
voit kayttaa lisaksi `hostinger-site-intake-template.md`-dokia.

## Mita local DB vs Hostinger DB parity tarkoittaa kaytannossa

Parity ei tarkoita sita, etta local- ja live-database olisivat samat.
Parity tarkoittaa sita, etta:

- tiedat mika Hostinger-database kuuluu sivustolle
- tiedat mista phpMyAdminiin mennaan
- et sekoita database-ownershipia GitHubiin

## Mita ei teha GitHubin kautta

Ela tee GitHubin kautta:

- database-passwordien tallennusta
- dumppeja repoihin oletuksena
- live-datan siirtoa commit-historian mukana
- phpMyAdmin-linkkien muuttamista salaisuusvarastoiksi
