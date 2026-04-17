# Languages And Locales

Tama tiedosto on site-kohtainen muistio kaytetyista kielista, localeista ja kaannosworkflowsta.

## Kaytetyt kielet

- `primary_locale`:
- `additional_locales`:
- `language_model`: `single | multilingual | multisite-network | multisite-subsite`
- `translation_method`: `none | plugin | multisite`

## Oletuskieli

Kirjaa tahan:

- mika locale on oletus
- mika kieli nakyy ilman locale-prefiksia
- onko fallback-kieli sallittu

## URL-strategia

Kirjaa tahan valittu malli:

- yksi domain ja locale-polut, esimerkiksi `/en/`
- oma domain tai subdomain localea kohden
- multisite-pohjainen locale-erottelu, jos sellainen on oikeasti paatetty

Kirjaa samalla mahdolliset SEO-vaikutukset:

- `hreflang`
- canonical-linjaukset
- locale-kohtaiset redirectit

## Translation workflow

Kirjaa tahan:

- kuka tekee kaannokset
- miten uusi sisalto kulkee eri kieliin
- onko kaannos plugin-pohjainen vai editoriaalinen prosessi
- mika plugin tai ratkaisu on valittu, jos jokin on valittu

## Site-kohtaiset poikkeukset

Kirjaa tahan kaikki poikkeukset, joita ei pida arvata:

- locale, jolla on eri URL-strategia
- locale, jolla on eri sisaltorakenne
- locale, joka ei seuraa samaa release-tahtia
- multisite-subsite -poikkeukset

## Tarkistuslista

- `site-profile.md` vastaa taman tiedoston arvoja
- domainit ja localet vastaavat todellista julkaisumallia
- translation workflow on nimetty, ei oletettu
- plugin-valinta on kirjattu vain jos se on oikeasti paatetty
