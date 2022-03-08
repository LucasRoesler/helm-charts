#!/bin/bash

set -e

root=$(git rev-parse --show-toplevel)

chart_repo=${GITHUB_REPOSITORY:-"LucasRoesler/helm-charts"}
chart_repo_owner=$(echo "$chart_repo" | cut -d "/" -f 1)
chart_project=$(echo "$chart_repo" | cut -d "/" -f 2)

full_project=${PROJECT:-"LucasRoesler/openfaas-loki"}
project_owner=$(echo "$full_project" | cut -d "/" -f 1)
project=$(echo "$full_project" | cut -d "/" -f 2)

version="$VERSION"
unprefixed=$(echo "$version" | sed -E 's/.*v?([0-9]+\.[0-9]+\.[0-9]+).*/\1/')

chart_url=$(echo "https://$chart_repo_owner.github.io/$chart_project" | tr '[:upper:]' '[:lower:]')
asset_url=https://github.com/$project_owner/$project/releases/download/$version/$project-$unprefixed.tgz

if [ -z "$version" ]; then
    echo "VERSION can not be empty"
    exit 1
fi

cd "$root/charts" && curl -sSLO "$asset_url"
cd "$root"
helm repo index "$root" --merge=index.yaml --url="$chart_url"
