FROM google/cloud-sdk:alpine

USER root

RUN apk update && \
    apk add --no-cache aws-cli && \
    aws --version

