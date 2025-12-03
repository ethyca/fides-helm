# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/)

To view the Changelog for the Fides code, see the [CHANGELOG.md of the ethyca/fides repository](https://github.com/ethyca/fides/blob/main/CHANGELOG.md).

The types of changes are:

- `Added` for new features.
- `Changed` for changes in existing functionality.
- `Deprecated` for soon-to-be removed features.
- `Docs` for documentation only changes.
- `Removed` for now removed features.
- `Fixed` for any bug fixes.
- `Security` in case of vulnerabilities.

## [Unreleased](https://github.com/ethyca/fides-helm/compare/fides-0.18.0...main)

### Added

### Fixed

## [0.18.1](https://github.com/ethyca/fides-helm/compare/fides-0.18.0...fides-0.18.1)

### Fixed

- Update default resource limits and requests to better allign with actual usage
- Fix docs links in values.yaml

## [0.18.0](https://github.com/ethyca/fides-helm/compare/fides-0.17.1...fides-0.18.0)

### Added

- Add support for Worker differentiation
- Add default deployments for each worker, unless overridden
- Add support for loadbalancers to work with http

### Fixed

- Switch to bitnami legacy chart override

## [0.17.1](https://github.com/ethyca/fides-helm/compare/fides-0.17.0...fides-0.17.1)

### Fixed

- Redis cert is only mounted when used. [#82](https://github.com/ethyca/fides-helm/pull/82)

## [0.17.0](https://github.com/ethyca/fides-helm/compare/fides-0.16.1...fides-0.17.0)

### Added

- Add support for Redis SSL CA certificates via a new `fides.configuration.redisCaSecretName` value [#81](https://github.com/ethyca/fides-helm/pull/81)

### Changed

- Upgrade Fides version to [`2.64.0`](https://github.com/ethyca/fides/releases/tag/2.64.0) [#81](https://github.com/ethyca/fides-helm/pull/81)
- Convert configuration variables to use named templates to improve consistency [#81](https://github.com/ethyca/fides-helm/pull/81)

### Fixed

- `test-connection` pod did not use security context defined in the values file [#80](https://github.com/ethyca/fides-helm/pull/80)

## [0.16.1](https://github.com/ethyca/fides-helm/compare/fides-0.15.0...fides-0.16.1)

### Added

- Ability to set replica count for Fides Webservers and Fides Privacy Center [#79](https://github.com/ethyca/fides-helm/pull/79)

### Changed

- Upgrade Fides version to [`2.48.1`](https://github.com/ethyca/fides/releases/tag/2.48.1) [#79](https://github.com/ethyca/fides-helm/pull/79)

## [0.15.1](https://github.com/ethyca/fides-helm/compare/fides-0.15.0...fides-0.15.1)

### Changed

- Upgrade Fides version to [`2.36.0`](https://github.com/ethyca/fides/releases/tag/2.36.0) [#77](https://github.com/ethyca/fides-helm/pull/77)
- Synchronize chart versions between `fides` and `fides-minimal` [#77](https://github.com/ethyca/fides-helm/pull/77)
- Move CHANGELOG.md to root of directory [#77](https://github.com/ethyca/fides-helm/pull/77)
- Add Kubernetes annotations to services [#76](https://github.com/ethyca/fides-helm/pull/76)

## [0.15.0](https://github.com/ethyca/fides-helm/compare/fides-0.14.1...fides-0.15.0)

### Changed

- Upgrade Fides version to [`2.20.1`](https://github.com/ethyca/fides/releases/tag/2.20.1) [#73](https://github.com/ethyca/fides-helm/pull/73)
- Allow Fides Worker resources to be allocated separately from Fides Webserver resources [#73](https://github.com/ethyca/fides-helm/pull/73)

## [0.14.1](https://github.com/ethyca/fides-helm/compare/fides-0.14.0...fides-0.14.1)

### Changed

- Upgrade Fides version to [`2.19.1`](https://github.com/ethyca/fides/releases/tag/2.19.1) [#70](https://github.com/ethyca/fides-helm/pull/70)

## [0.14.0](https://github.com/ethyca/fides-helm/compare/fides-0.13.8...fides-0.14.0)

### Changed

- **Breaking** Resources now specified at the fides and privacyCenter level. [#68](https://github.com/ethyca/fides-helm/pull/68)

## [0.13.8](https://github.com/ethyca/fides-helm/compare/fides-0.13.7...fides-0.13.8)

### Changed

- Upgrade Fides version to [`2.18.0`](https://github.com/ethyca/fides/releases/tag/2.18.0) [#67](https://github.com/ethyca/fides-helm/pull/67)

## [0.13.7](https://github.com/ethyca/fides-helm/compare/fides-0.13.6...fides-0.13.7)

### Changed

- Upgrade Fides version to [`2.17.1`](https://github.com/ethyca/fides/releases/tag/2.17.1) [#66](https://github.com/ethyca/fides-helm/pull/66)

## [0.13.6](https://github.com/ethyca/fides-helm/compare/fides-0.13.5...fides-0.13.6)

### Changed

- Upgrade Fides version to [`2.17.0`](https://github.com/ethyca/fides/releases/tag/2.17.0) [#64](https://github.com/ethyca/fides-helm/pull/64)

## [0.13.5](https://github.com/ethyca/fides-helm/compare/fides-0.13.4...fides-0.13.5)

### Changed

- Upgrade Fides version to [`2.16.0`](https://github.com/ethyca/fides/releases/tag/2.16.0) [#63](https://github.com/ethyca/fides-helm/pull/63)

## [0.13.4](https://github.com/ethyca/fides-helm/compare/fides-0.13.3...fides-0.13.4)

### Changed

- Upgrade Fides version to [`2.15.1`](https://github.com/ethyca/fides/releases/tag/2.15.1) [#62](https://github.com/ethyca/fides-helm/pull/62)

## [0.13.3](https://github.com/ethyca/fides-helm/compare/fides-0.13.2...fides-0.13.3)

### Changed

- Upgrade Fides version to [`2.15.0`](https://github.com/ethyca/fides/releases/tag/2.15.0) [#61](https://github.com/ethyca/fides-helm/pull/61)

## [0.13.2](https://github.com/ethyca/fides-helm/compare/fides-0.13.1...fides-0.13.2)

### Changed

- Upgrade Fides version to [`2.14.2`](https://github.com/ethyca/fides/releases/tag/2.14.2) [#60](https://github.com/ethyca/fides-helm/pull/60)

## [0.13.1](https://github.com/ethyca/fides-helm/compare/fides-0.13.0...fides-0.13.1)

- Upgrade Fides version to [`2.14.1`](https://github.com/ethyca/fides/releases/tag/2.14.1) [#59](https://github.com/ethyca/fides-helm/pull/59)

### Changed

## [0.13.0](https://github.com/ethyca/fides-helm/compare/fides-0.12.0...fides-0.13.0)

### Added

- Add privacy center configuration options to [values.yaml](./values.yaml) [#58](https://github.com/ethyca/fides-helm/pull/58)

### Fixed

- Add [CHANGELOG.md](./CHANGELOG.md) to [.helmignore](./.helmignore) file [#58](https://github.com/ethyca/fides-helm/pull/58)

### Changed

- Update `aws/aws-load-balancer-controller` sub-chart to [`1.5.3`](https://artifacthub.io/packages/helm/aws/aws-load-balancer-controller/1.5.3) [#58](https://github.com/ethyca/fides-helm/pull/58)
- Update `bitnami/postgresql` sub-chart to [`12.5.6`](https://artifacthub.io/packages/helm/bitnami/postgresql/12.5.6) [#58](https://github.com/ethyca/fides-helm/pull/58)
- Update `bitnami/redis` sub-chart to [`17.11.3`](https://artifacthub.io/packages/helm/bitnami/redis/17.11.3) [#58](https://github.com/ethyca/fides-helm/pull/58)

## [0.12.0](https://github.com/ethyca/fides-helm/compare/fides-0.11.2...fides-0.12.0)

### Fixed

- Fixed the `LivenessProbe` for the worker, following a code change in Fides [#56](https://github.com/ethyca/fides-helm/pull/56)
