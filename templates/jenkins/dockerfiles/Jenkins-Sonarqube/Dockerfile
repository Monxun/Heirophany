FROM dwolla/jenkins-agent-sonar-scanner:latest

ENV SONAR_RUNNER_HOME=/usr/lib/sonar-scanner

USER root
WORKDIR /opt/

RUN apk add --no-cache aws-cli mvn && \
    curl https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-384.0.1-linux-x86_64.tar.gz && \
    tar –xvzf google-cloud-cli-384.0.1-linux-x86_64.tar.gz && \
    ./google-cloud-sdk/install.sh && \
    rm google-cloud-cli-384.0.1-linux-x86_64.tar.gz

COPY sonar-runner.properties ${SONAR_RUNNER_HOME}/conf/sonar-scanner.properties

USER jenkins