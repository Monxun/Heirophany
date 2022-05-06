# DEPLOYMENT PIPELINE TEMPLATES
AWS:
    - AWS Jenkins Pipeline File Templates
GCLOUD:
    - GCLOUD Jenkins Pipeline File Templates
BARE-METAL:
    - On Prem Jenkins Pipeline File Templates


# TODO
1. Create Templates For Both Cloud Providers
2. Test Pipelines

* TRY CONFIGURING KUBERNETES BUILD PODS USING CUSTOM AGENT DOCKERFILES
https://devopscube.com/jenkins-build-agents-kubernetes/

<!-- 
    docker pull \
    us-east1-docker.pkg.dev/aline-jenkins-gcp/nightwalkers-images/jenkins-sonarqube-agent:latest 
-->

<!-- 
    docker build . -t jenkins-sonarqube-agent
    docker tag jenkins-sonarqube-agent us-east1-docker.pkg.dev/aline-jenkins-gcp/nightwalkers-images/jenkins-sonarqube-agent
    docker push us-east1-docker.pkg.dev/aline-jenkins-gcp/nightwalkers-images/jenkins-sonarqube-agent --all-tags 
-->

<!-- EXAMPLE K8S DEPLOYMENT / SERVICE HOSTNAME -->
<!-- http://<service-name>.<namespace>.svc.cluster.local:8080 -->
<!-- http://cd-jenkins.default.svc.cluster.local:8080 -->
<!-- http://sonarqube.kubesphere-devops-system.svc.cluster.local:9000 -->
 