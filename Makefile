# PostgreSQL
.PHONY: postgre-up
postgre-up:
	@docker-compose up -d postgresql

.PHONY: postgre-down
postgre-down:
	@docker stop simplebank_postgres

.PHONY: db-create
db-create:
	@docker exec -it simplebank_postgres createdb --username=simplebank simplebank

.PHONY: db-drop
db-drop:
	@docker exec -it simplebank_postgres dropdb --username=simplebank simplebank

.PHONY: db-migrate-up
db-migrate-up:
	@migrate -path db/migration -database "postgresql://simplebank:simplebank-pass@localhost:5432/simplebank?sslmode=disable" -verbose up

.PHONY: db-migrate-down
db-migrate-down:
	@migrate -path db/migration -database "postgresql://simplebank:simplebank-pass@localhost:5432/simplebank?sslmode=disable" -verbose down

.PHONY: sqlc
sqlc:
	@sqlc generate

test:
	go test -v -cover ./...
