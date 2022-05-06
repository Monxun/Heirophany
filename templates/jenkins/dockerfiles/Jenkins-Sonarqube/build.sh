#!/bin/sh

export IMAGE_NAME=jenkins-sonarqube-agent
export IMAGE_REPO=us-east1-docker.pkg.dev/aline-jenkins-gcp/nightwalkers-images
export BUILD_ID=0.0.1

gcloud auth login
gcloud auth configure-docker \
    us-east1-docker.pkg.dev
gcloud auth configure-docker
docker build . -t $IMAGE_NAME:$BUILD_ID
docker tag $IMAGE_NAME:$BUILD_ID $IMAGE_REPO/$IMAGE_NAME:$BUILD_ID
docker push $IMAGE_REPO/$IMAGE_NAME --all-tags

# docker build . -t jenkins-sonarqube-agent
# docker tag jenkins-sonarqube-agent us-east1-docker.pkg.dev/aline-jenkins-gcp/nightwalkers-images/jenkins-sonarqube-agent
# docker push us-east1-docker.pkg.dev/aline-jenkins-gcp/nightwalkers-images/jenkins-sonarqube-agent --all-tags
