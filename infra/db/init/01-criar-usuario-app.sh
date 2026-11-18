#!/bin/bash
# Cria o usuário da aplicação e o torna dono do banco.
# O backend conecta com esse usuário, sem privilégios de superusuário.
# Roda só na primeira subida (volume db-data vazio); tabelas vêm das migrações do backend.
set -euo pipefail

psql -v ON_ERROR_STOP=1 \
  --username "$POSTGRES_USER" \
  --dbname "$POSTGRES_DB" \
  -v app_user="$APP_DB_USER" \
  -v app_password="$APP_DB_PASSWORD" \
  -v db_name="$POSTGRES_DB" <<-'EOSQL'
	CREATE ROLE :"app_user" LOGIN PASSWORD :'app_password'
	  NOSUPERUSER NOCREATEDB NOCREATEROLE;
	ALTER DATABASE :"db_name" OWNER TO :"app_user";
EOSQL
