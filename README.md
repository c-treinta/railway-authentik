# Authentik

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/new/template?template=https://github.com/c-treinta/railway-authentik)

Enterprise-grade SSO and OIDC identity provider.

**Services:** `authentik-server`, `authentik-worker`, `Postgres`, `Redis` (Railway-managed)

## Deploy

```bash
make deploy
# SECRET_KEY is auto-generated (hex, no whitespace)
```

## Post-Deploy

Access admin UI at `https://<domain>/if/flow/initial-setup/` to set the initial admin password.

## Environment Variables (auto-wired)

| Variable | Services | Description |
|----------|----------|-------------|
| `AUTHENTIK_SECRET_KEY` | server, worker | Auto-generated hex secret |
| `AUTHENTIK_POSTGRESQL__HOST` | server, worker | Railway reference to `Postgres` |
| `AUTHENTIK_POSTGRESQL__PORT` | server, worker | Railway reference to `Postgres` |
| `AUTHENTIK_POSTGRESQL__NAME` | server, worker | Railway reference to `Postgres` |
| `AUTHENTIK_POSTGRESQL__USER` | server, worker | Railway reference to `Postgres` |
| `AUTHENTIK_POSTGRESQL__PASSWORD` | server, worker | Railway reference to `Postgres` |
| `AUTHENTIK_REDIS__HOST` | server, worker | Railway reference to `Redis` |
