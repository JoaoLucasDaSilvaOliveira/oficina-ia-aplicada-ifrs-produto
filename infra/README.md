# Infraestrutura local

PostgreSQL e pgAdmin rodando em Docker Compose. Backend e frontend entram neste mesmo Compose mais adiante (I03 e I04).

## Pré-requisitos

- Docker com o plugin Compose (`docker compose version`).
- Portas `5432` e `5050` livres na máquina. Se estiverem em uso, troque `DB_PORT` e `PGADMIN_PORT` no `.env`.

## Subir

Todos os comandos rodam a partir da pasta `infra/`.

```bash
cp .env.example .env      # só na primeira vez; os valores são fictícios
docker compose up -d --wait
```

`--wait` só termina quando o banco passa no healthcheck.

## Acessar o pgAdmin

1. Abra <http://localhost:5050>.
2. Entre com `PGADMIN_DEFAULT_EMAIL` e `PGADMIN_DEFAULT_PASSWORD` do `.env`.
3. O servidor **Registro de Demandas (local)** já aparece cadastrado. Ao abri-lo, informe a senha `POSTGRES_PASSWORD` do `.env`.

O pgAdmin conecta pelo nome do serviço na rede do Compose: host `db`, porta `5432`. Para cadastrar outro servidor manualmente, use esses mesmos valores, não `localhost`.

## Banco e usuários

| Variável | Para quê |
| --- | --- |
| `POSTGRES_DB` | Banco da aplicação |
| `POSTGRES_USER` / `POSTGRES_PASSWORD` | Superusuário, só para administração (pgAdmin) |
| `APP_DB_USER` / `APP_DB_PASSWORD` | Usuário da aplicação: dono do banco, sem privilégios de superusuário. É o que o backend usa |

O usuário da aplicação é criado por [`db/init/01-criar-usuario-app.sh`](db/init/01-criar-usuario-app.sh) **só na primeira subida**, com o volume `db-data` vazio. Ainda não há tabelas nem dados: elas virão das migrações do backend, depois que as entidades forem definidas (B03).

Conexão a partir da máquina (testes fora do Compose):

```text
postgresql://<APP_DB_USER>:<APP_DB_PASSWORD>@localhost:<DB_PORT>/<POSTGRES_DB>
```

As portas são publicadas só em `127.0.0.1` e não ficam acessíveis por outras máquinas da rede.

## Parar e recomeçar

| Comando | Efeito |
| --- | --- |
| `docker compose down` | Para e remove os contêineres. Os dados do banco continuam no volume `db-data` |
| `docker compose down -v` | Remove também o volume: o banco volta vazio e o script de inicialização roda de novo |

Se você mudar usuário, senha ou nome do banco no `.env` depois da primeira subida, rode `docker compose down -v`. O PostgreSQL só lê essas variáveis com o volume vazio.

## Problemas comuns

- **`required variable ... is missing a value`**: falta o `infra/.env`. Copie de `.env.example`.
- **`port is already allocated`**: outra coisa usa a porta. Troque `DB_PORT` ou `PGADMIN_PORT` no `.env`.
- **pgAdmin recusa a senha do servidor**: o volume foi criado com outro `.env`. Veja "Parar e recomeçar".
