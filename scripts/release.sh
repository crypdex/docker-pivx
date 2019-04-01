#!/usr/bin/env bash

service="pivx"

# Build and push builds for these architectures
for arch in x86_64 arm64v8; do
    docker build -f ${VERSION}/Dockerfile.${arch} -t crypdex/${service}:${arch}-${VERSION} -t crypdex/${service}:${arch} ${VERSION}/.
    # Push both images, version and "latest"
    docker push crypdex/${service}:${arch}-${VERSION}
    docker push crypdex/${service}:${arch}
done

# Now create a manifest that points from latest to the specific architecture
rm -rf ~/.docker/manifests/*

# version
docker manifest create crypdex/${service}:${VERSION} crypdex/${service}:x86_64-${VERSION} crypdex/${service}:arm64v8-${VERSION}
docker manifest push crypdex/${service}:${VERSION}

# latest
docker manifest create crypdex/${service}:latest crypdex/${service}:x86_64-latest crypdex/${service}:arm64v8-latest
docker manifest push crypdex/${service}:latest

