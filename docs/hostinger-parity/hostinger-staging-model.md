# Hostinger Staging Model

Hostingerin staging on hyodyllinen capability silloin, kun valittu plan,
tuoteperhe ja sivuston WordPress-detection tukevat sita. Se ei ole taman
wordpress-platform-mallin automaattinen oletus.

## Mita docs sanovat nyt

Virallisen staging-docin perusteella:

- staging-nakyma liittyy WordPress-siteihin
- sivun taytyy tunnistua WordPress-asennukseksi ennen kuin staging-toiminto
  ylipaatansa nakyy
- doc sitoo stagingin Web Business tai korkeampaan plan-tasoon

Koska product naming voi elaa eri docs-sivuilla, staging-status merkitsee aina
myos `verify in hPanel`.

## Suositeltu staging-ajattelu tassa projektissa

Suositusjarjestys:

1. local baseline ja package review
2. staging, jos oikea Hostinger-site ja plan tukevat sita
3. live vasta kun site-kohtainen preflight on kunnossa

## Miten tarkistetaan

Tarkista ainakin:

- tunnistaako hPanel oikean sivuston WordPress-siteksi
- nakyyko staging-nakyma kyseiselle sivustolle
- mika staging-URL todella on

## Jos stagingia ei ole

Jos stagingia ei ole, ala rakenna mutuiluun perustuvaa "staging-jarjestelmaa"
taman support-repon sisaan. Kayta sen sijaan:

- local smoke tai local site-harness
- hallittua deploy-package reviewta
- pienta deploy-scopea
- tarvittaessa erillista maintenance-ikkunaa oikeassa site-repossa

## Muistutus

2026-04-17 local smoke -baseline ei yksin todista Hostinger-staging-polun
toimivuutta. Se todistaa vain sen, etta site-repo ja helperit osaavat tuottaa
hallitun local/runtime-rajan.
