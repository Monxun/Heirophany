FROM dwolla/jenkins-agent-sonar-scanner:latest

ENV SONAR_RUNNER_HOME=/usr/lib/sonar-scanner

USER root
WORKDIR /opt/

RUN apk add --no-cache aws-cli mvn

COPY sonar-runner.properties ${SONAR_RUNNER_HOME}/conf/sonar-scanner.properties

USER jenkins