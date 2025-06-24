# fides-helm

This repository contains Helm charts and code examples to deploy [Fides](https://ethyca.github.io/fides).

To use the charts in this repository, first add the chart repository with the following commands:

```sh
helm repo add ethyca https://helm.ethyca.com
```

## Helm Charts

- [Fides Helm Chart](./fides/) - Deploy Fides to Kubernetes
- [Fides Minimal Helm Chart](./fides-minimal/) - Deploy Fides without lookups or other advanced features

## :balance_scale: License

The [Fides](https://github.com/ethyca/fides) ecosystem of tools are licensed under the [Apache Software License Version 2.0](https://www.apache.org/licenses/LICENSE-2.0).
Fides tools are built on [fideslang](https://github.com/ethyca/privacy-taxonomy), the Fides language specification, which is licensed under [CC by 4](https://github.com/ethyca/privacy-taxonomy/blob/main/LICENSE).

Fides is created and sponsored by Ethyca: a developer tools company building the trust infrastructure of the internet. If you have questions or need assistance getting started, let us know at fides@ethyca.com!
