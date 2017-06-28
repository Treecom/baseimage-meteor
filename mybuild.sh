#!/bin/bash -e

IMAGE="martinezko/baseimage-meteor"
TAG="latest"
# TAG="testing"

# docker build --no-cache --rm -t ${IMAGE}:${TAG} .
docker build --rm -t ${IMAGE}:${TAG} .
docker tag ${IMAGE}:${TAG} ${IMAGE}:${TAG}
docker push ${IMAGE}:${TAG}
