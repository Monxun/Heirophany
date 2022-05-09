FROM google/cloud-sdk:alpine

USER root

RUN apk update && \
    apk add --no-cache aws-cli && \
    apk add --update docker openrc && \
    rc-update add docker boot && \
    aws --version && \
    gcloud --version && \
    docker --version

