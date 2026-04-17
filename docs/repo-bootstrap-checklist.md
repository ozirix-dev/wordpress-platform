# Repo-bootstrap-checklist

Tama checklista on tarkoitettu uuden WordPress site-repon perustamiseen.

## 1. Luo uusi repo oikeaan paikkaan

- luo uusi paikallinen repo polkuun `D:\Projects\Products\<site-slug>`
- varmista, etta kyse on yhden sivuston owner-reposta eika shared support -repasta
- alusta git paikallisesti ennen remotea vain jos se auttaa bootstrapissa

## 2. Kopioi starter

- kopioi `templates/site-repo-starter/` uuden site-repon rungoksi
- vaihda placeholder-nimet:
  - `your-child-theme` tai vastaava site-kohtainen theme slug
  - `your-custom-plugin`
  - `your-site-slug`

## 3. Tayta site-profile heti

- tayta `docs/site-profile.md`
- kirjaa `repo_path`, `github_repo`, `production_url` ja mahdollinen `staging_url`
- kirjaa mita seurataan Gitissa ja mita ei

## 4. Paata kielimalli tietoisesti

- valitse `language_model`
- valitse `translation_method`
- kirjaa `primary_locale`
- kirjaa `additional_locales`

Monikielisyys ei tarkoita automaattisesti multisitea.

## 5. Rajaa Hostinger-target

- kirjaa mika Hostinger-site tai vastaava runtime-target on kyseessa
- paata site-kohtainen deploy-menetelma
- pida staging site-kohtaisena, ei epamaaraisena yhteiskohteena

## 6. Paata branch-malli yksinkertaisesti

- `main` on oletuksena kanoninen paahaara
- kayta lyhytikaisia feature-branchia tarpeen mukaan
- ota erillinen `staging`-haara vain jos se vastaa oikeaa ymparistoa tai sovittua workflowta

## 7. Tee ensimmainen review ennen isoa toteutusta

- tarkista `README.md`
- tarkista `docs/site-profile.md`
- tarkista `docs/deployment.md`
- tarkista `.gitignore`
- tarkista starterin `wp-content`-runko

## 8. Mita ei kannata tehda liian aikaisin

- ala kopioi WordPress corea reppoon
- ala versionoi `uploads`-kansiota
- ala rakenna raskasta CI/CD-putkea ennen kuin deploy-raja on selva
- ala pakota multilingual-pluginia ennen site-kohtaista paatosta
- ala tee multisitea vain tulevaisuuden varalle
- ala tallenna salaisuuksia repojuureen

## 9. Minimitulos bootstrapin jalkeen

Bootstrap on riittava, kun:

- site-repon ownership on selva
- docsit kertovat mika sivusto on kyseessa
- Git-raja on siisti
- deploy-raja on alustavasti dokumentoitu
- kieli- ja hosting-paatokset on kirjattu ainakin luonnostasolla
