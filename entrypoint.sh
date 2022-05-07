#!/bin/sh

while ! pg_isready -q -h db -p 5432 -U postgres
do
  echo "$(date) - waiting for database to start"
  sleep 2
done

if [[ -z `psql -Atqc "\\list python_challenge_prod"` ]]; then
  echo "Database python_challenge_prod does not exist. Creating..."
  createdb -E UTF8 python_challenge_prod -l en_US.UTF-8 -T template0
  mix ecto.create
  mix ecto.migrate
  echo "Database python_challenge_prod created."
fi

exec mix phx.server
