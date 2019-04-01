#!/usr/bin/env bash

service="pivx"

# Build and push builds for these architectures
for arch in x86_64 arm64v8; do
    docker build -f ${VERSION}/Dockerfile.${arch} -t crypdex/${service}:${arch}-latest docker/${service}/.
    docker push crypdex/${service}:${arch}-latest
done

# Now create a manifest that points from latest to the specific architecture
rm -rf ~/.docker/manifests/*

docker manifest create crypdex/${service}:latest crypdex/${service}:x86_64-latest crypdex/${service}:arm64v8-latest
docker manifest push crypdex/${service}:latest

