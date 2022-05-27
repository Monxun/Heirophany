FROM dwolla/jenkins-agent-sonar-scanner

USER root

RUN apk update && \
    apk add --no-cache maven && \
    mvn --version

USER jenkins