# JENKINS CICD CLUSTER

GOALS: Create a modular, portable CI/CD pipeline template that is easy to execute and cloud agnostic while maintining best production practices for SCM, CI/CD, SEC, etc...

Components:

    - Pipeline Helm charts deployed to their own namespaces:
        1. Jenkins
        2. Sonarqube
        3. Artifactory
        
    - Sidecar Helm Chart:
        1. Portainer Agent
        2. Istio
        3. ArgoCD
        4. Prometheus Stack
        5. Crossplane
