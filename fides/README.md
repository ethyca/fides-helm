# Fides Helm Chart

This [Helm](https://helm.sh) chart deploys [Fides](https://ethyca.github.io/fides), an open-source privacy engineering platform.

## Prerequisites

Before deploying the Helm chart, you will need the following:
* A Kubernetes cluster to which Fides will be deployed
* A PostgreSQL database
* A Redis cache
* A Kubernetes secret for the Postgres containing at least the following keys:
  * `DB_HOST`
  * `DB_PORT` - \[Optional - Defaults to `5432`\]
  * `DB_DATABASE`
  * `DB_USERNAME`
  * `DB_PASSWORD`
* A Kubernetes secret for the Redis containing at least the following keys:
  * `REDIS_HOST`
  * `REDIS_PORT` - \[Optional - Defaults to `6379`\]
  * `REDIS_PASSWORD`

## Configuration

See [values.yaml](./values.yaml) for the configuration options.

You'll likely want to override some of the values set in the `values.yaml` file. To do so, create a local version of the file with your configuration.

```sh
cp values.yaml values.local.yaml
```

Most of the Fides configuration is handled natively within the chart; however, you can pass additional environment variables to Fides in `fides.configuration.additionalEnvVars`. See the [Fides configuration guide](https://ethyca.github.io/fides/installation/configuration/) for all possible values.

## Chart installation

To install this chart, you can clone this repository and run the following command:
```sh
helm install fides . --values values.local.yaml
```

## Additional information

* Not familiar with Helm? Take a look at [Helm's quick start guide](https://helm.sh/docs/intro/quickstart/).