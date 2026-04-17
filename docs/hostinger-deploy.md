# Hostinger-deploy

Tama tiedosto on tarkoituksella lyhyt umbrella- ja pointer-dokki.

Sen rooli ei ole toimia Hostingerin current facts -lähteenä. Nykyinen
Hostinger-faktakerros, parity-map ja intake/preflight-ajattelu elavat
`docs/hostinger-parity/`-osion alla.

## Kayta ensin naita

- current entrypoint: [docs/hostinger-parity/README.md](./hostinger-parity/README.md)
- audit-kelpoinen fakta-aineisto:
  [docs/hostinger-parity/hostinger-current-facts.md](./hostinger-parity/hostinger-current-facts.md)
- local/site-repo/Hostinger parity:
  [docs/hostinger-parity/local-to-hostinger-parity-map.md](./hostinger-parity/local-to-hostinger-parity-map.md)
- oikean site-intaken preflight:
  [docs/hostinger-parity/hostinger-preflight-checklist.md](./hostinger-parity/hostinger-preflight-checklist.md)

## Yleislinja

- deployoi GitHubista vain tarkoituksellinen repo-managed `wp-content`-kerros
- ala pidä koko WordPress-asennusta GitHub-deployn oletusmallina
- tarkista Hostinger-capabilityt oikeasta hPanelista ennen site-kohtaista
  deploy-paatosta

Jos jokin Hostinger-asia on plan-sensitive, product-sensitive tai muuten elava,
kanoninen merkinta on `verify in hPanel`, ei vanhan docs-muistin varaan tehty
oletus.
