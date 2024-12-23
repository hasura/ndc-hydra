# Ory Hydra Connector

> [!IMPORTANT]
> Deprecated. Use the [HTTP connector](https://github.com/hasura/ndc-http) with [Ory Hydra](https://github.com/hasura/ndc-http-recipes/tree/main/recipes/ory) recipe instead. 

Ory Hydra connector provides instant queries and mutations to request Ory Hydra API resources.

This connector is built upon the [NDC Rest](https://github.com/hasura/ndc-rest) with [Ory Hydra's REST API Specification](https://raw.githubusercontent.com/ory/hydra/master/internal/httpclient/api/openapi.yaml).

> [!NOTE]
> The connector `v1.x` supports Hydra v2 API spec. Use `v0.x` if you want to use Hydra v1.

> [!NOTE]
> Support `client_secret_post` auth method for public APIs that require `client_credentials` credentials such as `/oauth2/*` only. The connector mainly supports admin API wrappers for Hasura Engine v3.

## Environment Variables

| Name                           | Description                                                   | Default Value         |
| ------------------------------ | ------------------------------------------------------------- | --------------------- |
| HYDRA_PUBLIC_SERVER_URL        | Public Hydra server URL                                       | http://localhost:4444 |
| HYDRA_ADMIN_SERVER_URL         | Admin Hydra server URL                                        | http://localhost:4445 |
| HYDRA_PUBLIC_TIMEOUT           | Default request timeout for public APIs in seconds            | 30                    |
| HYDRA_PUBLIC_RETRY_TIMES       | Number of retry times for public APIs                         | 0                     |
| HYDRA_PUBLIC_RETRY_DELAY       | Delay time between each retry in milliseconds for public APIs | 1000                  |
| HYDRA_PUBLIC_RETRY_HTTP_STATUS | Retry on HTTP status for public APIs                          | 429, 500, 502, 503    |
| HYDRA_ADMIN_TIMEOUT            | Default request timeout in seconds for admin APIs             | 30                    |
| HYDRA_ADMIN_RETRY_TIMES        | Number of retry times for admin APIs                          | 0                     |
| HYDRA_ADMIN_RETRY_DELAY        | Delay time between each retry in milliseconds for admin APIs  | 1000                  |
| HYDRA_ADMIN_RETRY_HTTP_STATUS  | Retry on HTTP status for admin APIs                           | 429, 500, 502, 503    |

## Development

### Local Development

Copy `.env.example` to `.env` and start Docker Compose:

```sh
docker-compose up -d --build
```

The connector serves the HTTP service at `http://localhost:8080`.

### Update dependencies

```sh
NDC_REST_VERSION=\<version\> make update-deps
```

### Update schema

Update `VERSION` in [Makefile](./Makefile) and run:

```sh
make build-schema
```
