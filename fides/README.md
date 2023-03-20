# Fides Helm Chart

This [Helm](https://helm.sh) chart deploys [Fides](https://fid.es/docs), an open-source privacy engineering platform.

## Prerequisites
Before deploying the Helm chart, you will need the several dependencies, depending on your `values.yaml` configuration.

* [Helm v3](https://helm.sh/docs/intro/install/) installed on your machine
* A Kubernetes cluster to which Fides will be deployed

### Optional Prerequisites
* If `postgresql.deployPostgres` is set to `false`
  * A PostgreSQL database
  * A Kubernetes secret for the Postgres containing at least the following keys:
    * `DB_HOST`
    * `DB_PORT` - \[Optional - Defaults to `5432`\]
    * `DB_DATABASE`
    * `DB_USERNAME`
    * `DB_PASSWORD`
* If `redis.deployRedis` is set to `false`
  * A Redis cache
  * A Kubernetes secret for the Redis containing at least the following keys:
    * `REDIS_HOST`
    * `REDIS_PORT` - \[Optional - Defaults to `6379`\]
    * `REDIS_PASSWORD`
* If `s3.createS3Bucket` is set to `true`
  * [AWS Controllers for Kubernetes for S3](https://aws-controllers-k8s.github.io/community/docs/user-docs/install/)

## Configuration

See [values.yaml](./values.yaml) for the configuration options.

You'll likely want to override some of the values set in the `values.yaml` file. To do so, create a local version of the file with your configuration.

Most of the Fides configuration is handled natively within the chart; however, you may pass additional environment variables to Fides by setting `fides.configuration.additionalEnvVars` or `fides.configuration.additionalEnvVarsSecret`. See the [Fides configuration guide](https://docs.ethyca.com/fides/get_started/configuration) for all possible values.

## Chart installation

To download the chart, run the following commands: 
```sh
helm repo add ethyca https://helm.ethyca.com
helm pull ethyca/fides
```

To install this chart, create a local values file to override the defaults and run the following command:
```sh
helm install fides ethyca/fides --values values.local.yaml
```

## Manage S3 Bucket (optional)

If you would also like to manage the S3 bucket to be used as a Fides storage destination, you must first install the appropriate AWS Controllers for Kubernetes [ACK](https://aws-controllers-k8s.github.io/community/docs/community/overview/) services. ACK is a way to manage AWS resources from within Kubernetes using Custom Resource Definitions. To get started, follow the [official ACK setup documentation](https://aws-controllers-k8s.github.io/community/docs/user-docs/install/) for **S3**. 

Additionally, [IAM Roles for Service Accounts](https://aws-controllers-k8s.github.io/community/docs/user-docs/irsa/) must be enabled.

## Additional information

* Need some additional help with Fides? Try out our [Sample Fides Project](https://docs.ethyca.com/fides/get_started/quickstart)!
* Not familiar with Helm? Take a look at [Helm's quick start guide](https://helm.sh/docs/intro/quickstart/)!
