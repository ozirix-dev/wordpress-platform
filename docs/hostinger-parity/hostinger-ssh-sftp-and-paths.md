# Hostinger SSH, SFTP And Paths

Tama dokumentti kokoaa ne Hostinger-path- ja shell-faktat, joita WordPress-
sitejen parity-ajattelussa oikeasti tarvitaan.

## SSH

Virallisten docsien perusteella SSH:

- aktivoidaan hPanelissa website-kohtaisesti
- voi vaatia odotusta ennen kuin access toimii
- voi sallia password-authin ja joissain docs-polussa myos SSH keys -mallin

Tassa reppoperheessa SSH:ta tarvitaan kaytannossa vain rajattuihin tarkoituksiin:

- root/public path -varmistukseen
- tarvittaessa turvalliseen shell-tarkistukseen
- tarkempaan site-intakeen, jos hPanel-UI ei yksin riita

SSH ei ole deploy-strategia itsessaan.

## Plan- ja product-rajoitukset

Hostingerin docsissa nakyy wording-driftia:

- yksi doc puhuu Web Premium and greater -rajoista
- toinen sanoo, etta kaikki web hosting planit Singlea ja WordPress Singlea
  lukuun ottamatta tukevat SSH:ta
- SSH key -doc sitoo key-authin Business/Cloud-tyyppisiin plan-perheisiin

Siksi oikea tyosaanto on:

- tarkista SSH Access hPanelissa
- tarkista erikseen, nakyyko SSH Keys -osio
- kirjaa toteutunut status site-profileen

## Root path ja public path

Hostingerin docsien perusteella tyypillinen polku on:

- `/home/<username>/domains/<domain>/`
- julkinen juuri useimmiten `public_html`

SSH-doc tarjoaa esimerkkiketjun:

1. `cd domains`
2. `cd yourdomain.tld`
3. `cd public_html`

Tama on hyva parity-havainto, mutta ei riita yksin. Dokumentoi aina:

- `hostinger_root_path`
- `hostinger_public_path`

## File Manager ja FTP

File Manager / FTP on kaytannollinen apu polkujen varmistamiseen, jos SSH ei ole
kaytossa. Ne eivat kuitenkaan todista shell-capabilitya tai taustaprosessitukea.

## Mita SSH ei takaa

SSH ei yksin takaa:

- stagingin olemassaoloa
- Git deploy -nakymaa
- PHP-version tai configin oikeellisuutta
- pitkaikaisten background processien sallittavuutta

Jos SSH on poissa kaytosta, parity voidaan silti rakentaa hPanelin, File
Managerin ja docsien avulla. Jos SSH on kaytossa, key-based auth on suositeltava
vasta kun tuki on varmennettu hPanelissa ja private key pysyy vaultissa.
