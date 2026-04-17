# Hostinger Preflight Checklist

Kayta tata listaa ennen kuin yksi oikea site-repo kytketaan Hostingeriin
parity-mallin kautta.

## Ennen site-intakea

- [ ] oikea Hostinger website on tunnistettu hPanelissa
- [ ] primary domain on varmennettu
- [ ] WordPress detection on tarkistettu, jos staging tai WordPress-tyokalut
      kiinnostavat
- [ ] root path on tarkistettu
- [ ] `public_html`-polku on tarkistettu
- [ ] hosting plan family on kirjattu tai merkitty `unknown`

## Capabilities

- [ ] staging availability on tarkistettu
- [ ] SSH availability on tarkistettu
- [ ] SSH key -tuki on tarkistettu, jos key-auth on tarkoitus ottaa kayttoon
- [ ] Git deployment -nakyma on tarkistettu
- [ ] PHP version on tarkistettu
- [ ] tarvittavat PHP config- tai extension-poikkeukset on kirjattu
- [ ] database access on tarkistettu ilman passwordin tallennusta repoon
- [ ] cron-tarve on arvioitu

## Repo ja turvallisuus

- [ ] site-profile sisältää Hostinger-parity-kentat
- [ ] deployment-muistio kertoo, kaytetaanko manual packagea, Git deployta vai
      muuta hallittua polkua
- [ ] package-helperin scope on tarkistettu
- [ ] local sync -target ei osoita tuotantoon
- [ ] uploads, database, backups ja salaisuudet eivat kuulu deploy-pakettiin
- [ ] yhtaan secretia ei ole commitattu reppoon

## Muistutus

Jos yksikin capability on edelleen plan-sensitive tai product-sensitive eika sita
ole tarkistettu, merkitse se eksplisiittisesti `verify in hPanel` ennen kuin
paatat oikean deployment-mallin.
