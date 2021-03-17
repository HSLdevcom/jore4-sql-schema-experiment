# jore4-sql-schema-experiment

Experiment with SQL schemas for Jore4.

## Use of the Docker image

The Docker image expects the following values for the following environment variables or for the corresponding CLI options.
The expected values are **set by default**.

| Environment variable             | Default value      |
| -------------------------------- | ------------------ |
| HASURA_GRAPHQL_UNAUTHORIZED_ROLE | anonymous          |
| HASURA_GRAPHQL_MIGRATIONS_DIR    | /hasura-migrations |
| HASURA_GRAPHQL_METADATA_DIR      | /hasura-metadata   |

**Please don't change them. Either don't define them at all or set them to the same values as documented above.**

## Development

To contribute:

1. Install [Hasura CLI](https://hasura.io/docs/1.0/graphql/core/hasura-cli/install-hasura-cli.html)
1. `cp .env.example .env`
1. Replace your own secrets into `.env`
1. Groan... to have `hasura/config.yml` in `hasura/` and to still use `.env` with Hasura CLI: `ln -s "$(pwd)/.env" hasura/.env`
1. Start the Hasura server with `docker-compose up`

### Change the SQL schema

While the local server is running, create a new migration with

```sh
cd hasura # To allow hasura-cli to find config.yaml
hasura migrate create ${SENSIBLE_SNAKE_CASE_MIGRATION_NAME}
```

Write your SQL schema changes in the files `up.sql` and `down.sql` in the created directory `hasura/migrations/${TIMESTAMP}_${SENSIBLE_SNAKE_CASE_MIGRATION_NAME}/`.

Run your migrations on your development database with something like

```sh
cd hasura # To allow hasura-cli to find config.yaml
hasura migrate status
hasura migrate apply --up 1
hasura migrate apply --down 1
```

Once you are convinced your SQL schema migration is correct, commit the new SQL files into git.

### Change the Hasura API

To change what to expose, to whom and how in the API served by Hasura, you need to modify the metadata of Hasura.
These yaml files in `hasura/metadata/` _could_ be changed by writing text.
On the other hand, the admin UI exposes all the choices.

Start the admin UI:

```sh
cd hasura # To allow hasura-cli to find config.yaml
hasura console
```

In the admin UI, navigate to the Data tab.
Select the relevant schema.
To expose something new in the GraphQL API, track new tables, foreign-key relationships or functions from the middle panel.
Then modify permissions of tracked tables by selecting a table from the left panel and choosing the Permissions tab from the middle panel.

When you make changes in the admin UI, `hasura console` will modify `hasura/metadata/*.yaml` files accordingly in the background.
When you are done clicking, commit the metadata changes into git.

#### Advice for permissions

The role name for public, unauthenticated use is given to the Hasura server with the environment variable `HASURA_GRAPHQL_UNAUTHORIZED_ROLE`.
The variable is currently set to `anonymous` in `docker-compose.yml`.

If the SQL schema generates a sensible default value for a column, e.g. for an ID column, do not allow inserts or updates to that column over the GraphQL API.

Do not allow inserting, updating or deleting data in reference tables ("enums") over the GraphQL API.

#### Incompatible SQL schema and metadata

If you make backwards-incompatible changes to the SQL schema, the old Hasura metadata might become incompatible with the SQL schema.

One way to resolve the Hasura metadata conflicts:

1. Reload the metadata: Navigate to the admin UI Settings (the cog in the top bar) > Metadata Actions (left panel) > Reload metadata (middle panel). Click Reload.
1. Remove the conflicting parts of the metadata: Navigate to Metadata Status (left panel). Read which parts of the metadata conflict with the SQL schema. Once you know what should be changed, click Delete all and OK.
1. Recreate the missing parts of the metadata as explained above.
