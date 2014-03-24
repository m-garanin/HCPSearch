#!/bin/sh
psql -d template1 -c "DROP DATABASE test_hcp;" -U $1
psql -d template1 -c "CREATE DATABASE test_hcp ENCODING='UNICODE';" -U $1
psql -d test_hcp -f schema.sql -U $1
cat test_data.csv | psql -d test_hcp -c "COPY npidatas FROM STDIN CSV HEADER;ALTER TABLE npidatas ADD COLUMN id SERIAL PRIMARY KEY;" -U $1
psql -d test_hcp -f indx.sql -U $1

