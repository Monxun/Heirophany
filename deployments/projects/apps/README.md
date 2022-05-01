# MONXUN DEV CLUSTER

GOALS: Create a modular, portable deployment of my development cluster template that is easy to execute and cloud agnostic while maintining best production practices for SCM, CICD, SEC, etc...

Components:

    - Apps Helm charts deployed to their own namespaces:
        1. ml 
        2. portfolio
        3. treehaus
        4. aline

    - Storage Helm Charts:
        1. Redis
        2. Postgres
        3. RabbitMQ
        4. OpenEBS

    - Sidecar Helm Chart:
        1. Portainer Agent
        2. Istio
        3. ArgoCD / Keel
        4. Prometheus Stack
        5. Crossplane
        
