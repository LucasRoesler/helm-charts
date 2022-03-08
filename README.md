# Helm Charts

Helm Chart repo for my projects. Currently just [`openfaas-lok`](https://github.com/LucasRoesler/openfaas-loki)

## Updating

An bash script is provided to download the packaged helm chart from the Github release and then updating the chart repository index.yaml

```sh
VERSION=<value> ./scripts/update.sh
```
