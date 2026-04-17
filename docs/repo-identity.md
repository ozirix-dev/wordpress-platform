# Repo Identity

Tämä dokumentti lukitsee tämän repon identiteetin ja nimeämislinjan.

## Canonical Identity

- canonical nimi: `wordpress-platform`
- local path: `D:\Projects\Support\wordpress-platform`
- repo-rooli: WordPress-perheen shared support -repo
- umbrella-sijoitus: `Support`

Tämän repon kanoninen nimi on `wordpress-platform`.

Sitä käytetään source-repon sisäisissä docsissa, paikallisessa polussa ja kaikessa
nimeämisessä, jossa puhutaan repon identiteetistä.

## Current GitHub Identity

Nykyinen GitHub-remote on:

- owner/name: `ozirix-dev/wordpress-platform`
- URL: `https://github.com/ozirix-dev/wordpress-platform`
- default branch: `main`
- visibility: `PUBLIC`

Current GitHub identity on nyt linjassa tämän repon kanonisen nimen kanssa.

Paikallinen path, canonical nimi ja GitHub owner/name osoittavat nyt samaan
repo-identiteettiin.

## Naming Policy

Käytä tässä source-repossa näitä tasoja tietoisesti eri tarkoituksiin:

- canonical nimi
  - `wordpress-platform`
- local path
  - `D:\Projects\Support\wordpress-platform`
- current GitHub handle
  - `ozirix-dev/wordpress-platform`
- canonical GitHub URL
  - `https://github.com/ozirix-dev/wordpress-platform`

Sääntö:

- `wordpress-platform` on tämän repon kanoninen nimi kaikissa source-repon
  current-viittauksissa
- `WP-Pohja`-nimeä saa käyttää vain historiallisena rename-huomiona tai vanhan
  audit trailin selityksenä
- jos local path, canonical nimi ja GitHub handle eivät täsmää, canonical nimi
  voittaa source-repon identiteettitasolla

## Decision

Tämän passin suositeltu ja käytännössä lukittu naming-päätös on:

- canonical nimi = `wordpress-platform`

Perustelu:

- nimi on jo source-repon paikallinen identiteetti
- nimi on linjassa `Support`-haaran placement-logiikan kanssa
- nimi on jo ReportHub-jäljessä projektitason identiteettinä
- GitHub-repo on nyt harmonisoitu samaan nimeen

## Historical Rename Note

Tämä repo luotiin GitHubiin ensin nimellä:

- `ozirix-dev/WP-Pohja`

Rename tehtiin myöhemmin nimeen:

- `ozirix-dev/wordpress-platform`

Vanhaa nimeä ei käytetä enää current-identiteettinä. Se jätetään näkyviin vain
silloin, kun historiallinen audit trail muuten jäisi epäselväksi.

## Rename Status

Rename-stage on tehty ja varmennettu:

1. GitHub-repo on nyt `ozirix-dev/wordpress-platform`.
2. Paikallinen `origin` osoittaa uuteen URL:iin.
3. Source-repon naming on harmonisoitu rename-jälkeen.
4. Vanha `WP-Pohja`-nimi jää vain historialliseksi viitteeksi.

Rename-jälkeinen tarkistuslista:

- `gh repo view ozirix-dev/wordpress-platform`
- `git remote -v`
- `git status --short`

## Current Source-Repo Rule

Rename-jälkeen:

- pidä `wordpress-platform` kanonisena nimenä
- käytä `ozirix-dev/wordpress-platform`-handlen viittauksia, kun puhutaan
  current GitHub-reposta
- dokumentoi `WP-Pohja` vain historiallisena rename-huomiona
- älä sekoita GitHub-handlea source-repon identiteettiin
