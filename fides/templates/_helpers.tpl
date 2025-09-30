{{/*
Expand the name of the chart.
*/}}
{{- define "fides.name" -}}
  {{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name for Fides
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "fides.fullname" -}}
  {{- $baseName := default .Chart.Name .Values.nameOverride }}
    {{- if .Values.fides.fullnameOverride }}
      {{- $baseName = .Values.fides.fullnameOverride }}
    {{- else }}
      {{- if contains $baseName .Release.Name }}
        {{- $baseName = .Release.Name }}
      {{- else }}
        {{- $baseName = printf "%s-%s" .Release.Name $baseName }}
      {{- end }}
    {{- end }}
  {{- $baseName | trunc 63 | trimSuffix "-"}}
{{- end }}

{{/*
Create a default fully qualified app name for Fides Workers
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "fides.worker.fullname" -}}
  {{- printf "worker-%s" ( include "fides.fullname" . )  | trunc 63 | trimSuffix "-" }}
{{- end }}


{{/*
Create a default fully qualified app name for the Privacy Center
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "fides.privacyCenter.fullname" -}}
  {{- printf "pc-%s" ( include "fides.fullname" . )  | trunc 63 | trimSuffix "-" }}
{{- end }}


{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "fides.chart" -}}
  {{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
The Docker tag from which to pull the image.
*/}}
{{- define "fides.dockerTag" -}}
{{ .Values.fides.image.tag | default .Chart.AppVersion }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "fides.labels" -}}
helm.sh/chart: {{ include "fides.chart" . }}
{{ include "fides.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Base Selector labels
*/}}
{{- define "fides.selectorLabels" -}}
app.kubernetes.io/name: {{ include "fides.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Fides Selector labels
*/}}
{{- define "fides.fides.selectorLabels" -}}
{{ include "fides.selectorLabels" . }}
app.kubernetes.io/component: "fides"
{{- end }}

{{/*
Privacy Center Selector labels
*/}}
{{- define "fides.privacyCenter.selectorLabels" -}}
{{ include "fides.selectorLabels" . }}
app.kubernetes.io/component: "privacy-center"
{{- end }}

{{/*
Fides Worker Selector labels
*/}}
{{- define "fides.worker.selectorLabels" -}}
{{ include "fides.selectorLabels" . }}
app.kubernetes.io/component: "fides-worker"
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "fides.serviceAccountName" -}}
  {{- if .Values.serviceAccount.create }}
    {{- default (include "fides.fullname" .) .Values.serviceAccount.name }}
  {{- else }}
    {{- default "default" .Values.serviceAccount.name }}
  {{- end }}
{{- end }}

{{/*
Control the deployment strategy
*/}}
{{- define "fides.deploymentStrategy" -}}
type: {{ ternary "RollingUpdate" "Recreate" .Values.useRollingUpdate}}
{{- if .Values.useRollingUpdate }}
rollingUpdate:
  maxSurge: 1
  maxUnavailable: 0
{{- end }}
{{- end }}

{{/*
Create the name of the secret to store FIDES__SECURITY environment variables
*/}}
{{- define "fides.fidesSecuritySecretName" -}}
{{ default (printf "fides-security-%s" ( include "fides.fullname" . ) | trunc 63 | trimSuffix "-") .Values.fides.configuration.fidesSecuritySecretName }}
{{- end }}

{{/*
Create the name of the config map to store the fides.toml file.
*/}}
{{- define "fides.tomlConfigMapName" -}}
{{ printf "fides-toml-%s" ( include "fides.fullname" . ) | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create the name of the config map to store the fides.toml file.
*/}}
{{- define "fides.worker.tomlConfigMapName" -}}
{{ printf "worker-%s" (include "fides.tomlConfigMapName" .) | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
List of CORS origins, concatenated, deduplicated, and formatted.
*/}}
{{- define "fides.corsOrigins" -}}
{{- $cors := list }}

{{- if .Values.privacyCenter.publicHostname }}
  {{- $cors = append $cors (printf "https://%s" .Values.privacyCenter.publicHostname | quote) }}
{{- end }}
{{- if .Values.fides.publicHostname }}
  {{- $cors = append $cors (printf "https://%s" .Values.fides.publicHostname | quote) }}
{{- end }}

{{- if eq .Values.fides.service.type "LoadBalancer" }}
  {{- if .Values.fides.publicHostname }}
    {{- $cors = append $cors (printf "http://%s" .Values.fides.publicHostname | quote) }}
  {{- end }}
  {{- if and .Values.privacyCenter.enabled .Values.privacyCenter.publicHostname }}
    {{- $cors = append $cors (printf "http://%s" .Values.privacyCenter.publicHostname | quote) }}
  {{- end }}
{{- end }}

{{- range (.Values.fides.configuration.additionalCORSOrigins | compact) }}
  {{- $cors = append $cors (. | quote) }}
{{- end }}

{{- $cors = $cors | compact | uniq }}
{{ printf "[%s]" (join "," $cors) }}
{{- end }}

{{/*
The set of environment variables for Fides and workers
*/}}
{{- define "fides.env" -}}
{{- $namespace := .Release.Namespace }}
{{- $releaseName := .Release.Name }}
{{- $redisDeployment := .Values.redis }}
{{- $pgDeployment := .Values.postgresql }}
{{- with .Values.fides.configuration }}
{{- include "fides.processedEnvVars" $ }}
{{- $dbConfig := lookup "v1" "Secret" $namespace .dbSecretName }}
{{- $redisConfig := lookup "v1" "Secret" $namespace .redisSecretName }}
- name: FIDES__DATABASE__SERVER
{{- if $pgDeployment.deployPostgres }}
  value: {{ printf "%s-postgresql" $releaseName }}
{{- else }}
  valueFrom:
    secretKeyRef:
      name: {{ .dbSecretName }}
      key: DB_HOST
{{- end }}
{{- if hasKey $dbConfig "DB_PORT"}}
- name: FIDES__DATABASE__PORT
  valueFrom:
    secretKeyRef:
      name: {{ .dbSecretName }}
      key: DB_PORT
{{- end }}
- name: FIDES__DATABASE__USER
{{- if $pgDeployment.deployPostgres }}
  value: postgres
{{- else }}
  valueFrom:
    secretKeyRef:
      name: {{ .dbSecretName }}
      key: DB_USERNAME
{{- end }}
- name: FIDES__DATABASE__PASSWORD
  valueFrom:
    secretKeyRef:
    {{- if $pgDeployment.deployPostgres }}
      name: {{ printf "%s-postgresql" $releaseName }}
      key: postgres-password
    {{- else }}
      name: {{ .dbSecretName }}
      key: DB_PASSWORD
    {{- end }}
- name: FIDES__DATABASE__DB
{{- if $pgDeployment.deployPostgres }}
  value: postgres
{{- else }}
  valueFrom:
    secretKeyRef:
      name: {{ .dbSecretName }}
      key: DB_DATABASE
{{- end }}
- name: FIDES__REDIS__HOST
{{- if $redisDeployment.deployRedis }}
  value: {{ printf "%s-redis-master" $releaseName }}
{{- else }}
  valueFrom:
    secretKeyRef:
      name: {{ .redisSecretName }}
      key: REDIS_HOST
{{- end }}
{{- if hasKey $redisConfig "REDIS_PORT" }}
- name: FIDES__REDIS__PORT
  valueFrom:
    secretKeyRef:
      name: {{ .redisSecretName }}
      key: REDIS_PORT
{{- end }}
{{- if $.Values.fides.configuration.redisCaSecretName }}
- name: FIDES__REDIS__SSL_CA_CERTS
  value: {{ printf "%s/ca.crt" (include "fides.redisCaPath" $) }}
{{- end }}
- name: FIDES__REDIS__PASSWORD
  valueFrom:
    secretKeyRef:
{{- if $redisDeployment.deployRedis }}
      name: {{ printf "%s-redis" $releaseName }}
      key: redis-password
{{- else }}
      name: {{ .redisSecretName }}
      key: REDIS_PASSWORD
{{- end }}
{{- end }}
{{- end }}

{{/*
Config volume name
*/}}
{{- define "fides.configVolume" -}}
config
{{- end }}

{{/*
Config path
*/}}
{{- define "fides.configPath" -}}
/etc/fides/config
{{- end }}

{{/*
Redis CA volume name
*/}}
{{- define "fides.redisCaVolume" -}}
redis-ca
{{- end }}

{{/*
Redis CA path
*/}}
{{- define "fides.redisCaPath" -}}
/etc/fides/redis-ca
{{- end }}

{{/* User defined Fides secrets */}}
{{- define "custom_fides_secrets" }}
  # Dynamically created secret envs
  {{- range $i, $config := .Values.secret }}
  - name: {{ $config.envName }}
    valueFrom:
      secretKeyRef:
        name: {{ $config.secretName }}
        key: {{ default "value" $config.secretKey }}
  {{- end }}
{{- end }}

{{/*
Detect if fidesplus is being used based on the repository name
*/}}
{{- define "fides.isFidesplus" -}}
{{- if contains "fidesplus" (.Values.fides.image.repository | lower) -}}
true
{{- else -}}
false
{{- end -}}
{{- end }}

{{/*
Get processed environment variables with additional settings
*/}}
{{- define "fides.processedEnvVars" -}}
{{- $envVars := .Values.fides.configuration.additionalEnvVars | default list }}
{{- $hiddenEnvVar := dict "name" "FIDES__EXECUTION__MONITOR_CELERY_TASKS_ENABLED" "value" "true" }}
{{- $envVars = append $envVars $hiddenEnvVar }}
{{- $envVars | toYaml }}
{{- end }}

{{/*
Validates that all worker types have unique names. Fails if duplicate names are found.
*/}}
{{- define "fides.worker.validateUniqueNames" -}}
{{- $workers := .Values.fides.workerConfiguration.workers | default list }}
{{- $names := dict }}
{{- range $workers }}
{{- if hasKey $names .name }}
{{- fail (printf "Duplicate worker name found: '%s'. Worker names must be unique" .name) }}
{{- else }}
{{- $_ := set $names .name "used" }}
{{- end }}
{{- end }}
{{- end }}
