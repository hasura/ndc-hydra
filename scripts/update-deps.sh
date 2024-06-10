#!/bin/bash

if [ -z "$VERSION" ]; then
  echo "VERSION env variable is required"
  exit 1
fi

sed -i -r "s/v[0-9.]+$/$VERSION/" Dockerfile
sed -i -r "s/NDC_REST_VERSION\s+\?\=\s+[a-z0-9.]+$/NDC_REST_VERSION ?= $VERSION/" Makefile

if [ -n "$ORY_HYDRA_VERSION" ]; then
  sed -i -r "s/ory\/hydra\/v[0-9.]+/ory\/hydra\/$ORY_HYDRA_VERSION/" schema/public/config.yaml
  sed -i -r "s/ory\/hydra\/v[0-9.]+/ory\/hydra\/$ORY_HYDRA_VERSION/" schema/admin/config.yaml
  sed -i -r "s/oryd\/hydra:v[0-9.]+$/oryd\/hydra:$ORY_HYDRA_VERSION/" docker-compose.yaml
  sed -i -r "s/ORY_HYDRA_VERSION\s+\?\=\s+[a-z0-9.]+$/ORY_HYDRA_VERSION ?= $ORY_HYDRA_VERSION/" Makefile
fi