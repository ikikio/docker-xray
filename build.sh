#/bin/bash

export DOCKER_BUILDKIT=1
docker buildx create --name ikik.builder
docker buildx use ikik.builder

docker buildx build --platform \
    linux/amd64,linux/arm64,\
    linux/arm/v7,linux/arm/v8 \
    -t username/myimage:latest ./