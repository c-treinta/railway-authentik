# Deploy and Host Authentik on Railway

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/TEMPLATE_ID)

Authentik is an open-source identity provider and SSO platform that supports OAuth2, OIDC, SAML, LDAP, and SCIM. It lets you centralize authentication across all your applications, enforce MFA, and manage users with a built-in admin UI and flow engine.

## About Hosting Authentik

Hosting Authentik requires running two coordinated services — a server (handles HTTP and authentication flows) and a worker (handles background tasks like email and policy execution) — plus a PostgreSQL database and a Redis instance for session storage and task queuing. Both the server and worker share the same secret key and database credentials. On Railway, Postgres and Redis are provisioned as managed services, and all inter-service credentials are wired automatically via reference variables. Persistent volumes are not required because Authentik stores all state in PostgreSQL.

## Common Use Cases

- Centralized SSO and OIDC provider for self-hosted applications
- MFA enforcement and user lifecycle management across internal tools
- LDAP/SAML identity bridge for legacy enterprise integrations
- Outpost proxy authentication for services that lack native auth support
- Admin-controlled OAuth2 authorization server for developer platforms

## Dependencies for Authentik Hosting

- PostgreSQL 14+ (Railway managed)
- Redis 7+ (Railway managed)

### Deployment Dependencies

- Authentik Docker image: https://ghcr.io/goauthentik/server
- Authentik documentation: https://docs.goauthentik.io
- Authentik GitHub: https://github.com/goauthentik/authentik

### Implementation Details

Two Dockerfiles extend the upstream `ghcr.io/goauthentik/server` image with a single `CMD` override — `server` for the HTTP service and `worker` for the background task processor. Both images are identical except for that CMD, so they always run the same Authentik version.

After first deploy, complete the initial admin setup at:
```
https://<your-domain>/if/flow/initial-setup/
```

## Why Deploy Authentik on Railway?

Railway is a singular platform to deploy your infrastructure stack. Railway will host your infrastructure so you don't have to deal with configuration, while allowing you to vertically and horizontally scale it.

By deploying Authentik on Railway, you are one step closer to supporting a complete full-stack application with minimal burden. Host your servers, databases, AI agents, and more on Railway.
