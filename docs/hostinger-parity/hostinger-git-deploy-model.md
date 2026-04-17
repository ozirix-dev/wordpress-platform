# Hostinger Git Deploy Model

Tama dokumentti kuvaa, miten Hostingerin Git deploy kannattaa tulkita taman
WordPress-perheen docs-first -mallissa.

## Mita Hostingerin Git deploy tekee

Virallisen docin perusteella Git deploy:

- yhdistaa yhteen repo-URLin, branchin ja install pathin
- deployaa valitun branchin sisallon target-pathiin
- vaatii, etta target-directory on tyhja ennen ensimmaista deployta
- voi tarjota auto deploymentin ja Composer installin lisavalintoina

Tassa mallissa Git deploy on vain yksi mahdollinen siirtokerros. Se ei muuta
site-repoa koko WordPress-runtimea omistavaksi reppoksi.

## Mita kannattaa vieda Gitista

Suositeltu Git-deploy-scope on edelleen repo-managed site-kohtainen kerros:

- `wp-content/themes/<theme_slug>/`
- `wp-content/plugins/<custom-plugin>/`
- `wp-content/mu-plugins/`
- tarvittaessa pieni manifesti tai muu tarkoituksellinen deploy-metatieto

Ela vie Gitista:

- WordPress corea
- `wp-admin/`- tai `wp-includes/`-puuta
- `wp-content/uploads/`-sisaltoa
- databaseja tai dumppeja
- secrets- tai backup-payloadia

## Install path -tulkinta

Hostingerin docin perusteella:

- tyhja install path deployaa root folderiin
- `./public_html` voi tarkoittaa kaytannossa samaa julkista juurta
- syvempi polku, kuten `./subfolder-name`, on erillinen target

Tama tarkoittaa, etta install pathia ei saa paattaa muistista. Kirjaa site-
repoon aina toteutunut valinta ja peruste:

- miksi kentta jätettiin tyhjaksi
- tai miksi kaytettiin `./public_html`
- tai miksi deploy kohdistui syvempaan polkuun

## Miten tama sopii wordpress-platform-malliin

Jos site-repo kayttaa Git deployta, turvallinen malli on:

1. package-helperilla rajattu artifact reviewta varten
2. selkea site-profile, joka kertoo Hostinger-polut ja capabilityt
3. erillinen paatos siita, kaytetaanko Git deployta vai manuaalista pakettia

## Mita ei saa olettaa

- Git deploy ei tarkoita, etta koko WordPress-asennus kuuluisi GitHubiin.
- Git deploy ei todista stagingin, SSH:n tai custom background process -tuen
  olemassaoloa.
- Composer install ei ole taman perheen oletus. Ota se kayttoon vain, jos
  site-repo todella omistaa PHP-riippuvuudet tarkoituksellisesti.
