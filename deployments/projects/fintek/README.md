# FINTEK CLUSTER

DESCRIPTION: Full stack financial data api that runs scheduled cron jobs to consume 3rd party api's and store for analysis. Frontend client consumes microservices to query database, run backtesting analysis, update portfolio, configure trading bot signals, visualize trends, etc...

Ideally part of a three cluster team: 
    - Fintek UI 
    - Fintek API / Microservices
    - Akacia (Database & Pre Processing)
    - Clair (Live Trading Bot)
    - Hynd (Backtesting Cluster)

# ///////////////////////////////////////////////////////////////////////////
# TOOLING
# ///////////////////////////////////////////////////////////////////////////

App Tooling:

    Frontend: Django / HTMX / React / NextJS
    Backend: Django / NinjaAPI / Flask
    Caching: Redis 
    Messaging: RabbitMQ
    Database: Postgres / ArcticDB(Mongo)

Cluster Tooling:

    Node Image: TALOS
    Service Mesh: ISTIO
    Provisioner: TERRAFORM
    CD: ARGOCD / GITFLOW
    Storage: ROOK
    SCM: GITHUB/GITLAB
    Hypervisor: PROXMOX
    DNS/SSL: CLOUDFLARE
    SECRETS: GITHUB/AWS/VAULT

Infrastructure Tooling:

    - Repos: Images / Helm / SCM / IAC-State
    - 1 x Domain Name
    - 2 x Databases
    - 3 x Cluster Networks