# Fides-minimal Helm Chart

This [Helm](https://helm.sh) chart deploys [Fides](https://fid.es/docs), an open-source privacy engineering platform. Unlike the [Fides Helm chart](../fides/), the Fides-minimal Helm chart has fewer bells-and-whistles, for more advanced use cases and control. In most circumstances, you should use the generic Fides chart. If you use ArgoCD, try out this chart, which does not use the `lookup` function. 

This chart does not generate secrets, so all of them must be generated outside of Helm and referenced in the `values.yaml`. Additionally, this chart does not deploy the auxiliary services, such as Postgres and Redis.

## Prerequisites
Before deploying the Helm chart, you will need the several dependencies, depending on your `values.yaml` configuration.

* [Helm v3](https://helm.sh/docs/intro/install/) installed on your machine
* A Kubernetes cluster to which Fides will be deployed

* Postgres
  * A PostgreSQL database
  * A Kubernetes secret for the Postgres containing at least the following keys:
    * `DB_HOST`
    * `DB_PORT` - \[Optional - Defaults to `5432`\]
    * `DB_DATABASE`
    * `DB_USERNAME`
    * `DB_PASSWORD`
* Redis
  * A Redis cache
  * A Kubernetes secret for the Redis containing at least the following keys:
    * `REDIS_HOST`
    * `REDIS_PORT` - \[Optional - Defaults to `6379`\]
    * `REDIS_PASSWORD`

## Configuration

See [values.yaml](./values.yaml) for the configuration options.

You'll likely want to override some of the values set in the `values.yaml` file. To do so, create a local version of the file with your configuration.

Most of the Fides configuration is handled natively within the chart; however, you may pass additional environment variables to Fides by setting `fides.configuration.additionalEnvVars` or `fides.configuration.additionalEnvVarsSecret`. See the [Fides configuration guide](https://docs.ethyca.com/fides/get_started/configuration) for all possible values.

## Chart installation

To download the chart, run the following commands: 
```sh
helm repo add ethyca https://helm.ethyca.com
helm pull ethyca/fides-minimal
```

To install this chart, create a local values file to override the defaults and run the following command:
```sh
helm install fides ethyca/fides --values values.local.yaml
```

## Additional information

* Need some additional help with Fides? Try out our [Sample Fides Project](https://docs.ethyca.com/fides/get_started/quickstart)!
* Not familiar with Helm? Take a look at [Helm's quick start guide](https://helm.sh/docs/intro/quickstart/)!
