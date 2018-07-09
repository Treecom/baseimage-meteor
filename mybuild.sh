#!/bin/bash -e

IMAGE="martinezko/baseimage-meteor"
TAG="latest"
# TAG="testing"

# docker build -t ${IMAGE}:${TAG} .
docker build -t ${IMAGE}:${TAG} .
docker tag ${IMAGE}:${TAG} ${IMAGE}:${TAG}
docker push ${IMAGE}:${TAG}
