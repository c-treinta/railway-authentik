RAILWAY_PROJECT ?= templates-test
SECRET_KEY ?= $(shell openssl rand -hex 36)

deploy:
	railway link -p $(RAILWAY_PROJECT)
	railway add --database postgres
	railway add --database redis
	railway add --service authentik-server
	railway add --service authentik-worker
	cd server && railway up --service authentik-server
	cd worker && railway up --service authentik-worker
	railway variable set --service authentik-server \
	  AUTHENTIK_SECRET_KEY=$(SECRET_KEY) \
	  'AUTHENTIK_POSTGRESQL__HOST=${{Postgres.PGHOST}}' \
	  'AUTHENTIK_POSTGRESQL__PORT=${{Postgres.PGPORT}}' \
	  'AUTHENTIK_POSTGRESQL__NAME=${{Postgres.PGDATABASE}}' \
	  'AUTHENTIK_POSTGRESQL__USER=${{Postgres.PGUSER}}' \
	  'AUTHENTIK_POSTGRESQL__PASSWORD=${{Postgres.PGPASSWORD}}' \
	  'AUTHENTIK_REDIS__HOST=${{Redis.REDISHOST}}'
	railway variable set --service authentik-worker \
	  AUTHENTIK_SECRET_KEY=$(SECRET_KEY) \
	  'AUTHENTIK_POSTGRESQL__HOST=${{Postgres.PGHOST}}' \
	  'AUTHENTIK_POSTGRESQL__PORT=${{Postgres.PGPORT}}' \
	  'AUTHENTIK_POSTGRESQL__NAME=${{Postgres.PGDATABASE}}' \
	  'AUTHENTIK_POSTGRESQL__USER=${{Postgres.PGUSER}}' \
	  'AUTHENTIK_POSTGRESQL__PASSWORD=${{Postgres.PGPASSWORD}}' \
	  'AUTHENTIK_REDIS__HOST=${{Redis.REDISHOST}}'

destroy:
	@echo "Delete services via Railway dashboard: authentik-server, authentik-worker, Postgres, Redis"
	@echo "https://railway.app/project/$(RAILWAY_PROJECT)"

status:
	railway service status --all --json

logs:
	railway logs --service authentik-server --lines 100

.PHONY: deploy destroy status logs
