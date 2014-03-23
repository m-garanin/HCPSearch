#!/bin/sh
psql -d template1 -c "DROP DATABASE test_hcp;"
psql -d template1 -c "CREATE DATABASE test_hcp ENCODING='UNICODE';"
psql -d test_hcp -f schema.sql
cat test_data.csv | psql -d test_hcp -c "COPY npidatas FROM STDIN WITH (FORMAT CSV, HEADER TRUE);ALTER TABLE npidatas ADD COLUMN id SERIAL PRIMARY KEY;"
