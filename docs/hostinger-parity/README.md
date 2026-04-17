# Hostinger Parity

Tama osio on `wordpress-platform`-repon Hostinger-kerros. Sen tarkoitus on
auttaa sita, etta local-kehitys, site-repojen metadata ja Hostingerissa
tarkistettava todellinen runtime puhuvat samaa kielellista ja operatiivista
kielta.

Kaytannossa "local puhuu samaa kielta Hostingerin kanssa" tarkoittaa tata:

- site-repo dokumentoi oikean Hostinger-sivuston tunnisteet ja polut
- localissa kaytetty deploy-scope vastaa sita, mita Hostingeriin oikeasti
  kannattaa vieda
- PHP-, database-, SSH-, staging- ja cron-oletuksia ei arvata, vaan ne
  tarkistetaan Hostingerin nykyisesta dokumentaatiosta ja hPanelista
- plan- ja product-sensitive asiat merkitsevat aina "verify in hPanel", eivat
  "oleta kaikille samanlaiseksi"

Tama osio koostuu kolmesta kerroksesta:

1. `hostinger-current-facts.md`
   - mita Hostingerin virallinen dokumentaatio sanoo juuri nyt
2. `local-to-hostinger-parity-map.md` ja `hostinger-capability-matrix.md`
   - miten local/site-repo/Hostinger kytketaan toisiinsa
3. intake- ja preflight-dokit
   - mita yhdesta oikeasta Hostinger-sivustosta pitaa kirjata ennen kuin sita
     kaytetaan deploy-kohteena

Hostingerin docs elavat ajan mukana. Siksi taman osion sisaanmeno on aina:

1. lue `hostinger-current-facts.md`
2. tarkista `local-to-hostinger-parity-map.md`
3. kayta `hostinger-site-intake-template.md`- ja
   `hostinger-preflight-checklist.md`-dokeja vasta, kun oikeaa sivustoa ollaan
   oikeasti liittamassa mukaan

Tama osio on docs-first compatibility layer. Se ei tee live-deployta, ei muuta
DNS:aa, ei koske oikeisiin databaseihin eika tallenna salaisuuksia.

## Mista aloittaa

Jos haluat:

- tarkistaa mita Hostingerin docs sanoivat juuri taman passin hetkella
  - lue `hostinger-current-facts.md`
- ymmartaa miten local, site-repo ja Hostinger vastaavat toisiaan
  - lue `local-to-hostinger-parity-map.md`
- mapata capabilityt suoraan starterin site-profile-kenttiin
  - lue `hostinger-capability-matrix.md`
- tayttaa yhden oikean Hostinger-site-intaken
  - lue `hostinger-site-intake-template.md`
- varmistaa, etta intake on valmis ennen site-kohtaista deploy-paatosta
  - lue `hostinger-preflight-checklist.md`
- tarkistaa Git deploy-, SSH/path-, PHP-, database-, staging- tai cron-rajat
  - lue vastaava osa-aluekohtainen doki tassa kansiossa

## Recommended Reading Order

1. `hostinger-current-facts.md`
2. `local-to-hostinger-parity-map.md`
3. `hostinger-capability-matrix.md`
4. `hostinger-site-intake-template.md`
5. `hostinger-preflight-checklist.md`
6. tarvittava osa-aluekohtainen doki:
   - `hostinger-git-deploy-model.md`
   - `hostinger-ssh-sftp-and-paths.md`
   - `hostinger-php-runtime-parity.md`
   - `hostinger-database-access.md`
   - `hostinger-staging-model.md`
   - `hostinger-cron-and-background-jobs.md`
