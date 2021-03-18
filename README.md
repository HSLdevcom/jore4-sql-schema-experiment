# jore4-sql-schema-experiment

Experiment with SQL schemas for Jore4.

## Use of the Docker image

Docker image expects the following env variables, which are **set by default**.

| Env variable | Default value |
| ------------- |:-------------:|
| HASURA_GRAPHQL_UNAUTHORIZED_ROLE | anonymous |
| HASURA_GRAPHQL_MIGRATIONS_DIR | /hasura-migrations |
| HASURA_GRAPHQL_METADATA_DIR | /hasura-metadata |

**Please don't change those, so either don't define those at all or set those to the same values as documented above.**
