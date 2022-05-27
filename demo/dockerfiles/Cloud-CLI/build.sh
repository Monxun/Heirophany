#!/bin/sh

export IMAGE_NAME=cloud-cli
export IMAGE_REPO=us-east1-docker.pkg.dev/aline-jenkins-gcp/nightwalkers-images
export BUILD_ID=0.0.2

gcloud auth login
gcloud auth configure-docker \
    us-east1-docker.pkg.dev

# docker build . -t $IMAGE_NAME:$BUILD_ID
# docker tag $IMAGE_NAME:$BUILD_ID $IMAGE_REPO/$IMAGE_NAME:$BUILD_ID
# docker push $IMAGE_REPO/$IMAGE_NAME --all-tags

docker build . -t $IMAGE_NAME:$BUILD_ID
docker tag $IMAGE_NAME:$BUILD_ID heirophany/$IMAGE_NAME:$BUILD_ID
docker push heirophany/$IMAGE_NAME --all-tags