# Security Policy

`wordpress-platform` is a public support repository for WordPress site-repo
starters, documentation, and local helper tooling. It is not a production
runtime repository and must not contain secrets, customer data, database dumps,
uploads, private keys, or live hosting credentials.

## Supported Scope

Security reports are in scope when they affect:

- repo-owned PowerShell helper scripts
- starter WordPress theme, plugin, or mu-plugin scaffolds
- packaging, sync, or manifest behavior
- public documentation that could expose operationally sensitive details
- `.gitignore`, lint, CI, or boundary policy that protects the repository

Out of scope for this repository:

- WordPress core vulnerabilities
- third-party plugin or theme vulnerabilities not authored in this repository
- live Hostinger account operations
- live site content, uploads, databases, or customer data
- secrets stored outside this repository, such as vault-managed material

## Reporting A Vulnerability

Do not open a public issue for a suspected vulnerability or secret exposure.

Use the first available private channel:

1. GitHub private vulnerability reporting or a GitHub Security Advisory, if
   enabled for the repository.
2. A private maintainer channel already established for this workspace.
3. A direct private handoff to the repository owner.

Include:

- affected file or workflow
- concise reproduction steps
- impact assessment
- whether any secret, token, hostname, account id, database name, or local path
  appears to be exposed
- any suggested minimal fix

## Sensitive Data Rules

Never commit:

- passwords, API keys, tokens, cookies, sessions, or recovery material
- SSH private keys or known sensitive host key material
- database dumps, database passwords, or connection strings
- plugin license keys or premium service credentials
- `wp-content/uploads/`
- backup archives or restore payloads
- `.env` files or local machine secrets

Sensitive material belongs in the local vault, not in this repository. In this
workspace the default vault boundary is `K:\`.

## Hostinger And WordPress Runtime Details

Operational hosting details must stay redacted in public docs. Use placeholders
for values such as:

- `<HOSTINGER_ACCOUNT_ID>`
- `<HOSTINGER_ORIGIN_IP>`
- `<HOSTINGER_SSH_PORT>`
- `<HOSTINGER_DB_NAME_PRIMARY>`
- `<HOSTINGER_DB_USER_PRIMARY>`

The repository may document that a capability exists, such as SSH, database
access, staging, cron, or Git deploy, but it must not publish credentials or
unnecessary account-specific identifiers.

## Package And Artifact Safety

Generated package output under `tmp/**` is local review output and is ignored by
Git. Do not publish tmp artifacts without checking their contents.

`package-manifest.json` is review metadata, not WordPress runtime content. It
must not expose absolute local workstation paths or secrets.

## Expected Handling

For a confirmed security issue:

1. Keep discussion private until the fix is available.
2. Patch the smallest affected surface.
3. Run the repo verification gates.
4. Commit and push only the intended fix.
5. Add a ReportHub note when the issue changes policy, public posture, or
   operational security state.
