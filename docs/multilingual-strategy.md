# Monikielisyysstrategia

Tassa perheessa monikielisyys on site-kohtainen paatos, ei koko WordPress-perheen hard-default.

## Peruslinja

Monikielisyys voidaan toteuttaa ainakin kahdella eri tavalla:

1. yksi single-site WordPress-asennus, jossa on useita kielia
2. multisite-verkko tai muu eriytetty rakenne, jos kielet tai markkinat on aidosti erotettava toisistaan

Oletus on ensimmainen vaihtoehto, ellei eriytys tuo selvaa operatiivista etua.

## Mita tama repo ei lukitse

Tama repo ei pakota koko perhetta:

- yhteen multilingual-plugin-ratkaisuun
- yhteen URL-strategiaan
- yhteen kaannosworkflowhon
- yhteen sivurakenteen malliin

Site-kohtainen valinta voi myohemmin olla esimerkiksi:

- `WPML`
- `Polylang`
- `Weglot`
- jokin muu plugin
- tai multisite-pohjainen locale-erottelu

Nama ovat esimerkkeja, eivat perheen hard-defaulteja.

## Site-profileen kirjattavat kentat

Jokaisen multilingualia harkitsevan site-repon kannattaa tayttaa ainakin nama:

- `language_model`
- `translation_method`
- `primary_locale`
- `additional_locales`

Suositeltu tulkinta:

- `language_model`
  - `single`
  - `multilingual`
  - `multisite-network`
  - `multisite-subsite`
- `translation_method`
  - `none`
  - `plugin`
  - `multisite`

Esimerkki:

```yaml
language_model: multilingual
translation_method: plugin
primary_locale: fi_FI
additional_locales:
  - en_US
  - sv_SE
```

## Single site multilingual vs multisite for language separation

### Single site multilingual

Kayta tata, kun:

- brandi, rakenne ja sisalto kuuluvat samalle sivustolle
- hallinta halutaan pitaa yhdessa WordPress-asennuksessa
- deployn ja ownershipin halutaan pysyvan yksinkertaisina

Tyypillinen seuraus:

- yksi site-repo
- yksi WordPress-asennus
- locale-logiikka dokumentoidaan site-repoon

### Multisite kielen erotteluun

Kayta tata vain, kun:

- eri kieliversiot ovat kaytannossa eri sivustoja
- markkinat tarvitsevat aidosti erilliset hallinta- tai operointirajat
- verkon yhteinen hallinta on silti perustellumpi kuin erilliset asennukset

Tyypillinen seuraus:

- jaettu verkko kasvattaa yhteista riskia
- plugin- ja teemapaatokset siirtyvat osittain network-tasolle
- subsitejen oma autonomia pieniaityy

## Translation workflow dokumentoidaan site-kohtaisesti

Taman shared repon tehtava on muistuttaa, etta kaannosworkflow on todellinen operatiivinen paatos. Siksi jokaisen site-repon `docs/languages-and-locales.md` kannattaa kertoa ainakin:

- kaytetyt kielet
- oletuskieli
- URL-strategia
- miten uudet sisallot kaannetaan
- kuka omistaa kaannosten laadun
- mika plugin tai malli on valittu

## Nyrkkisaanto

Jos monikielisyys voidaan hoitaa siististi yhden sivuston sisalla, tee niin.

Jos alat perustella multisitea vain siksi, etta kielia on useampi kuin yksi, palaa ensin tarkistamaan, ratkaiseeko single-site multilingual ongelman yksinkertaisemmin.
