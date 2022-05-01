# KUBEFLOW ML CLUSTER

GOALS: Create a modular, portable kubeflow ml pipeline template that is easy to execute and cloud agnostic while maintining best production practices for SCM, CICD, SEC, etc...

Components:

    - Pipeline Helm charts deployed to their own namespaces:
        1. Kubeflow
        2. Arrikto
        3. PySpark
        
    - Sidecar Helm Chart:
        1. Portainer Agent
        2. Istio
        3. ArgoCD
        4. Prometheus Stack
        5. Crossplane