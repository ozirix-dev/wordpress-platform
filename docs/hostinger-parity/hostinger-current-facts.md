# Hostinger Current Facts

Tama tiedosto kokoaa Hostingerin virallisista docs-sivuista luetut nykyfaktat
paivalta `2026-04-17`.

Tarkoitus ei ole kopioida Hostingerin koko dokumentaatiota tahan reppoon.
Tarkoitus on kirjata:

- mita dokeja luettiin
- mita faktaa niista oikeasti kaytettiin
- mika vaikuttaa vakaalta
- mika on plan-, product- tai time-sensitive
- missa docsissa nakyy wording-driftia tai ristiriidan mahdollisuus

Luokittelut:

- `stable-ish`: todennakoisesti sama useimmille vastaaville Hostinger-siteille
- `plan-sensitive`: riippuu valitusta hosting-planista
- `product-sensitive`: riippuu hosting-tuoteperheesta tai WordPress-detectionista
- `likely-to-change`: kannattaa tarkistaa aina uudestaan ennen oikeaa adoptiota

## Luetut docsit

| Dokumentti | URL | Updated | Kaytetty fakta | Sensitivity | Huomio |
| --- | --- | --- | --- | --- | --- |
| How to deploy a Git repository in Hostinger | https://support.hostinger.com/en/articles/1583302-how-to-deploy-a-git-repository-in-hostinger | Updated over 2 months ago | Git deploy kayttaa repo-URLia, branchia ja install pathia. Tyhja install path deployaa root folderiin. `./public_html` tarkoittaa kaytannossa julkista juurta. Target-dir ei saa sisaltaa tiedostoja. | likely-to-change, product-sensitive | Composer install ja auto deployment ovat optionaalisia. Niita ei pideta taman mallin oletuksena. |
| How to create a staging environment for a WordPress site | https://support.hostinger.com/en/articles/15836786-how-to-create-a-staging-environment-for-a-wordpress-site | Updated over 5 months ago | Staging-sivu naytetaan vain, jos Hostinger tunnistaa WordPress-asennuksen. Doc sanoo stagingin vaativan Web Business tai suuremman planin. | plan-sensitive, product-sensitive | Saatavuus ja wording voivat muuttua tuoteperheen mukaan. Verify in hPanel. |
| Como crear un entorno de prueba WordPress | https://support.hostinger.com/es/articles/5720286-como-crear-un-entorno-de-prueba-wordpress | Actualizado hace mas de 8 meses | Lokalisoitu doc viittaa hieman eri tuotenimityksiin kuin englanninkielinen staging-doc. | plan-sensitive, product-sensitive, likely-to-change | Tulkitaan driftiksi, ei kovaksi faktaksi. |
| How to enable SSH access on Hostinger hPanel | https://support.hostinger.com/en/articles/1583246-how-to-enable-ssh-access-on-hostinger-hpanel | Updated over 4 months ago | SSH aktivoidaan hPanelissa sivukohtaisesti. Aktivointi voi kestaa jopa 15 minuuttia. Password- ja SSH key -kirjautuminen ovat mahdollisia. | plan-sensitive, product-sensitive | Doc sanoo Web Premium and greater. |
| How to connect to your account via SSH | https://support.hostinger.com/en/articles/1583365-how-to-connect-to-your-account-via-ssh | Updated over 2 months ago | Peruskomento on `ssh user@hostname`. Doc sanoo, etta kaikki web hosting planit Singlea ja WordPress Singlea lukuun ottamatta tukevat SSH:ta. | plan-sensitive, product-sensitive | Wording poikkeaa SSH enable -docista. Verify in hPanel. |
| How to generate SSH keys and add them to hPanel | https://www.hostinger.com/support/5634532-how-to-generate-ssh-keys-and-add-them-to-hpanel/ | Published on July 26, 2023; Updated on March 25, 2025 | SSH key -auth kuvataan erikseen ja doc sitoo sen Web Hosting Business or higher- ja Cloud-plan-perheisiin. | plan-sensitive, product-sensitive | Kayta key-authia suosituksena vasta kun plan ja SSH Access -nakyma tukevat sita. |
| How to open the website's root directory via SSH | https://support.hostinger.com/en/articles/5973000-how-to-open-the-website-s-root-directory-via-ssh | Updated over 2 months ago | Esimerkkipolku kulkee `domains/<domain>/public_html`-rakenteen kautta. | stable-ish | Hyva parity-lahde root/public path -dokumentointiin. |
| What Is the root directory of my website? | https://support.hostinger.com/en/articles/5534979-what-is-the-root-directory-of-my-website | Updated over 2 months ago | Root path seuraa mallia `/home/<username>/domains/<domain>/public_html`. Web/WordPress/Cloud-hostingissa root directorya ei voi muuttaa. | stable-ish, product-sensitive | Tarkka polku on silti sivukohtainen. Verify in hPanel tai SSH:ssa. |
| How to connect via FTP using FileZilla | https://support.hostinger.com/en/articles/1583313-how-to-connect-via-ftp-using-filezilla | Updated over a month ago | File manager / FTP -nakyma ohjaa kaytannossa `public_html`-hakemistoon. | stable-ish | Ei oikeuta muokkaamaan ylatasoja sokkona. |
| How to change the PHP version and update PHP extensions | https://support.hostinger.com/en/articles/1583243-how-to-change-the-php-version-and-update-php-extensions | Updated over 5 months ago | PHP-versio ja extensionit hallitaan hPanelin PHP Configuration -nakymasta. Doc sanoo, etta voi valita `8.2 and higher`. Folder-kohtainen poikkeus on mahdollinen. | product-sensitive, likely-to-change | Docissa on sisainen wording-jannite versioiden saatavuudesta. |
| What are the PHP options available in hPanel? | https://support.hostinger.com/en/articles/1583509-what-are-the-php-options-available-in-hpanel | Updated over a month ago | PHP-option max-arvot riippuvat current PHP-versiosta. | product-sensitive, likely-to-change | Arvot on tarkistettava site-kohtaisesti. |
| How to manage databases and users on Hostinger hPanel | https://support.hostinger.com/en/articles/1583293-how-to-manage-databases-and-users-on-hostinger-hpanel | Updated over 4 months ago | Databaset ja userit hallitaan website/domain-kontekstista hPanelissa. | stable-ish, product-sensitive | Passwordit eivat kuulu site-profileen tai intake-dokiin. |
| How to access phpMyAdmin directly on Hostinger | https://support.hostinger.com/en/articles/2260616-how-to-access-phpmyadmin-directly-on-hostinger | Updated over a month ago | phpMyAdminin suora entry path on `https://phpmyadmin.hostinger.com`. | stable-ish | Login vaatii userin ja passwordin; passwordia ei dokumentoida repoon. |
| How to set up cron jobs in hPanel | https://support.hostinger.com/en/articles/1583499-how-to-set-up-cron-jobs-in-hpanel | Updated over a month ago | Cron timezone on UTC+0. Cron-tyypit sisaltavat PHP:n, custom commandin ja website URL:n. Special chars -tapauksiin suositellaan advanced commandia tai `.sh`-wrapperia. | stable-ish, likely-to-change | Cron-ajon tarkka tarve on arvioitava site-kohtaisesti. |
| How to manage background processes on Hostinger | https://support.hostinger.com/en/articles/6484825-how-to-manage-background-processes-on-hostinger | Updated over 6 months ago | Background process -hallinta on kuvattu VPS-ymparistoon. | product-sensitive | Pitkakestoisia taustaprosesseja ei pideta shared Hostinger WordPress -mallin oletuksena. |

## Tasta vedetyt tyoskentelysaannot

- Root path, `public_html`, phpMyAdmin direct URL ja cronin UTC+0 ovat
  kaytannollisia parity-lahteita.
- SSH, staging, SSH key -auth ja osa PHP-runtimen asetuksista ovat
  plan-sensitive tai product-sensitive. Niita ei saa kovakoodata koko
  WordPress-perheen oletukseksi.
- Git deploy on kaytannollinen capability, mutta sen install path, target-dir ja
  mahdollinen auto deployment tarkistetaan aina oikean sivuston kohdalla.
- Jos Hostinger-docsien wording poikkeaa toisistaan, site-repoon kirjataan
  `verify in hPanel`, ei "paatelty varmasti".
