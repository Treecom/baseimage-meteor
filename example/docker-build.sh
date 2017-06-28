#!/bin/sh

set -e

CONTAINER=martinez/baseimage-meteor-example	# <-- Name your container
TAG=latest									# <-- Tag for your container
REGISTRY=false								# <-- If you use other then github repo
BUILD_DIR=${PWD}/.build						# <-- This is where meteor build your files.
											#     Folder will be created and after build will be deleted
FROM=martinezko/baseimage-meteor			# <-- Build from base image
FROM_TAG=latest								# <-- Build from base image version

echo "Start building container ${CONTAINER}:${TAG} ..."

# pull fresh base image:
docker pull ${FROM}:${FROM_TAG} &&

# build container
docker build --rm -t ${CONTAINER}:${TAG} . &&

# create tag on container
if [ $REGISTRY ]; then
	docker tag ${CONTAINER}:${TAG} ${REGISTRY}/${CONTAINER}:${TAG}
else
	docker tag ${CONTAINER}:${TAG} ${CONTAINER}:${TAG}
fi &&

# push to our registry
if [ $REGISTRY ]; then
	docker push ${REGISTRY}/${CONTAINER}:${TAG}
else
	docker push ${CONTAINER}:${TAG}
fi &&

# clean images if needed
# docker rmi -f ${CONTAINER}:${TAG} ${REGISTRY}/${CONTAINER}:${TAG} ${FROM}:${FROM_TAG}

# to run your container
# docker run -d ${REGISTRY}/${CONTAINER}:${TAG}
# OR use docker-compose.yaml file
# docker-compose up -d

echo "End build of container ${CONTAINER}:${TAG} ..."
