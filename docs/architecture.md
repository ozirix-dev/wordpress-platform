# Arkkitehtuuri

Taman repon perusajatus on erottaa kolme eri vastuutasoa toisistaan:

1. umbrella-ohjaus
2. shared WordPress support
3. site-kohtainen ownership

## Kerrokset

| Kerros | Paarepo | Rooli |
| --- | --- | --- |
| Umbrella-control | `D:\Projects\_Hub\Project-Map` | placement, naming, policy ja repo-family-kartta |
| Reporting / audit | `D:\Projects\_Hub\ReportHub` | raportointi, audit trail, handoff |
| Shared WordPress support | `D:\Projects\Support\wordpress-platform` | starterit, docsit, yhteiset WordPress-perheen toimintalinjat |
| Site ownership | `D:\Projects\Products\<site-slug>` | yhden sivuston kanoninen koodi, docsit ja deploy-raja |
| Mahdollinen local platform | esimerkiksi `D:\Projects\Systems\wordpress-dev` | paikallinen dev-stack, jos sellainen tarvitaan |

## Oletusmalli

Taman perheen oletus on:

- yksi repo per sivusto
- yksi WordPress-asennus per sivusto, ellei ole vahvaa syyta muuhun
- site-kohtainen GitHub-repo versionhallittavalle koodille ja docsille
- Hostinger target site-kohtaisena runtime-ymparistona

Shared support -repo ei omista sivuston liiketoimintalogiikkaa, sisaltoa tai tuotantoasennusta.

## Site-repo vs shared support repo

### Site-repo omistaa

- site-kohtaiset teemat, plugin-koodin ja mu-pluginit
- site-kohtaiset operator-docsit
- site profile -tiedon
- deploy- ja rollback-muistiot
- kyseisen sivuston kieliratkaisun

### Shared support repo omistaa

- WordPress-perheen yhteiset naming- ja placement-saannot
- bootstrapin uuden site-repon alkuun
- monikielisyys- ja multisite-paatosrungot
- varovaiset deploy-ohjeet Hostinger-malliin

## Virtaus: Local -> GitHub -> Hostinger

Suositeltu peruspolku on:

1. kehita paikallisesti
2. versionoi vain site-kohtainen koodi ja docs GitHubiin
3. rakenna review-kelpoinen deploy-paketti site-reposta
4. siirra site-kohtainen `wp-content`-omistus Hostingerin WordPress-asennukseen hallitusti

Tama malli valttaa koko WordPress-asennuksen versionhallinnan.

## Mita kuuluu Gitiin

GitHubiin kuuluu paaasiallisesti:

- `README.md`
- `docs/`
- `wp-content/themes/<site-theme>/`
- `wp-content/plugins/<site-plugin>/`
- `wp-content/mu-plugins/`
- site-kohtaiset helper-skriptit

## Mita ei kuulu Gitiin

Gitin ulkopuolelle jaavat oletuksena:

- WordPress core
- `wp-admin/`
- `wp-includes/`
- `wp-content/uploads/`
- tietokanta
- dumpit, backup-zipit ja runtime-cache
- `.env`-tiedostot ja salaisuudet

## Site-tyypit tassa arkkitehtuurissa

### Single-site / single-language

Yksi WordPress-asennus, yksi kieli, yksi site-repo.

### Single-site / multilingual

Yksi WordPress-asennus, useita kielia, yksi site-repo. Tama on usein ensisijainen tapa toteuttaa monikielisyys, jos saman sivuston sisalto, brandi ja hallinta pysyvat yhtena kokonaisuutena.

### Multisite-network

Yksi WordPress-verkko, joka palvelee useita sivustoja tai tarkoituksella erotettuja locale-kokonaisuuksia. Kayta vain, jos jaettu verkko todella tuo etua.

### Multisite-subsite

Yhden multisite-verkon alisivusto. Subsite ei ole automaattisesti oma repo; Git-raja riippuu siita, missa verkon yhteinen ja site-kohtainen koodi elaa.

## Kaytannon perusraja

Jos paatettavana on "pitaako tama ratkaista jaetulla verkolla vai omalla site-repolla", oletus on oma site-repo ja oma site-asennus. Multisite tarvitsee erillisen perustelun.
