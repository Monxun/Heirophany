FROM google/cloud-sdk:alpine

ENV BASE_URL="https://get.helm.sh"
ENV VERSION="2.12.0"

USER root

RUN apk update && \
    apk add tar && \
    apk add --no-cache aws-cli && \
    apk add --update docker openrc && \
    rc-update add docker boot && \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.18.0/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl && \
    kubectl version --client && \
    case `uname -m` in \
        x86_64) ARCH=amd64; ;; \
        armv7l) ARCH=arm; ;; \
        aarch64) ARCH=arm64; ;; \
        ppc64le) ARCH=ppc64le; ;; \
        s390x) ARCH=s390x; ;; \
        *) echo "un-supported arch, exit ..."; exit 1; ;; \
    esac && \
    apk add --update --no-cache wget git && \
    wget ${BASE_URL}/helm-v${VERSION}-linux-${ARCH}.tar.gz -O - | tar -xz && \
    mv linux-${ARCH}/helm /usr/bin/helm && \
    chmod +x /usr/bin/helm && \
    rm -rf linux-${ARCH} && \
    aws --version && \
    gcloud --version && \
    docker --version && \
    kubectl --version && \
    helm --version



