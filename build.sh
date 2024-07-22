#/bin/bash

export DOCKER_BUILDKIT=1
docker buildx create --name ikik.builder
docker buildx use ikik.builder

docker buildx build --platform linux/amd64,linux/arm64 -t ikikio/myimage:latest ./