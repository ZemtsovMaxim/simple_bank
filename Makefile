.PHONY: postgres createdb dropdb migrateup migratedown

postgres:
	docker run --name test_postgres -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=123 -d postgres:latest
createdb:
	docker exec -it test_postgres createdb --username=root --owner=root simple_bank
dropdb:
	docker exec -it test_postgres dropdb simple_bank
migrateup:
	migrate -path db/migration -database "postgresql://root:123@localhost:5432/simple_bank?sslmode=disable" -verbose up
migratedown:
	migrate -path db/migration -database "postgresql://root:123@localhost:5432/simple_bank?sslmode=disable" -verbose down