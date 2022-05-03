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


/////////////////////////////////////////////////////////////////////
JENKINS CONFIG / PIPELINES
////////////////////////////////////////////////////////////////////

PIPELINES:

- CHECKOUT / TEST / BUILD / PUSH ARTIFACTS 
    Dependencies: JFrog Cli, Docker, Git, Sonarqube, Maven<version>, gcloud cli / aws cli
    Actions: Notify Scan Results / Optional Approval

    STEPS: 

        * Define Agent Type
        * Define ENV Variables
        * Define Kubernetes Agent
        * Install Dependencies
        
        - gcloud auth / aws auth
        - jfrog cli + auth
        - clean workspace
        - checkout scm
        - init submodules
        - mvn clean package --sonarqube
        - jfrog upload jarfile + scanning + versioning
        - docker build image
        - jfrog upload image + scanning + versioning

- DEPLOY 
    Dependencies: JFrog Cli, Ansible Docker (Docker Bench, Anchore), Git, , Kubectl, gcloud cli 
    Actions: Notify Scan Results / Optional Approval

    STEPS: 

        * Define Agent Type
        * Define ENV Variables
        * Define Kubernetes Agent
        * Install Dependencies
        
        - gcloud auth / aws auth
        - jfrog cli + auth
        - clean workspace
        - checkout scm
        - helm package
        - jfrog upload helmchart + scanning + versioning
        - helm install <chart>

- PROVISION
    Dependencies: JFrog Cli (Docker Run Slim / Cloud), Ansible, Git Secrets, Terraform, gcloud cli / aws cli
    Actions: Notify Scan Results / Optional Approval

    STEPS: 

        * Define Agent Type
        * Define ENV Variables
        * Define Kubernetes Agent
        * Install Dependencies
        
        - gcloud auth / aws auth
        - jfrog cli + auth
        - clean workspace
        - checkout scm
        - helm package
        - jfrog upload helmchart + scanning + versioning
        - helm install <chart>


IMAGE-SCANNERS / REPOS
https://geekflare.com/container-security-scanners/
https://artifactoryaline.jfrog.io/ui/admin/artifactory/configuration/artifactory_general

PLUGINS:
1. Cloud Bees AWS Credentials
2. gcloud cli
3. Maven
4. JFrog
5. Git Secrets
6. Kubernetes
7. Dark Theme
8. Sonarqube
9. AWS Secrets
10. Docker-Pipeline


/////////////////////////////////////////////////////////////////////
JENKINS CONFIG / GCP
////////////////////////////////////////////////////////////////////

Ingredients:

- Create Git Token for Jenkins
- Service Account with permissions for all the resources you will need for the pipelines 
- Create Json key from that service account 
- Add credential to Jenkins credential manager 
- Create Pipeline environment variables in the pipeline / system config for the PROJECT_ID/ CLIENT_EMAIL/GCLOUD_CREDS of the project and service account 
- Add Steps to the Jenkins file pipeline that use the json credential
- add gcloud CLI commands for authorizing into the account and setting the project 
- add another step for the specific commands of your pipeline 
- Add final step of revoking auth / docker system prune / workspace clean commands
- Configure Kubernetes agents (gcloud CLI, AWS CLI, Terraform, Ansible, Docker, Maven Version, etc...)
- Multiple Repos | Same Pipeline Multi-branch Pipeline, Dev, Stage, Prod For Aline Microservices | Scan Periodically
- Git actions For Quality Gate Reporting / Approval
- Configure Sonarqube 

/////////////////////////////////////////////////////////////////////
ANSIBLE JENKINS CONFIG / GCP
////////////////////////////////////////////////////////////////////

(USE TO CONFIGURE CLUSTERS AFTER PROVISIONING)

- PROVISION K8 AGENTS VIA MANIFESTS WITH NEEDED TOOLING
- CREATE GLOBAL ENVIRONEMNT VARIABLES FOR AGENT DEPENDENCIES / CLOUD PROVIDER VARIABLES 
- CREATE SERVICE ACCOUNT
- DOWNLOAD JSON KEY
- CREATE CLUSTER
- INSTAL JENKINS / SONARQUBE VIA HELM
- INJECT JSON KEY INTO JENKINS CREDENTIALS
- DOWNLOAD PLUGINS
- CONFIGURE KUBERNETES AGENTS
- CONFIGURE JENKINS / GIT / SONARQUBE
- CREATE GLOBAL ENVIRONMENT VARIABLES
- CREATE PIPELINES WITH SCM AND WEBHOOKS 
- CONFIGURE GITFLOWS FOR TESTING RESULTS / QUALITY GATES / APPROVAL AND REVIEW / ETC...

/////////////////////////////////////////////////////////////////////
TERRAFORM JENKINS CONFIG / GCP
////////////////////////////////////////////////////////////////////

- Create ECR in Terraform files 
- Reference State From S3 Bucket / Artifact Repo
- Run tfswitch shell and pass tf commands 
- Create version.tf
- Terraform Plan Pipeline Jenkinsfile
- Git Action for Plan Review / Approval
- Terraform Apply Pipeline Jenkinsfile

/////////////////////////////////////////////////////////////////////
GIT JENKINS CONFIG / GCP
////////////////////////////////////////////////////////////////////

GOALS: 
    - Create multi-branch pipelines for Aline microservices
    - Use Polling for Production
    - dev, stage, prod branches (namespaces in same cluster for deployment)
    - microservices/frontend, terraform/ansible, helm/argocd (App SOT, IaC SOT, Cluster SOT + Sidecar)


/////////////////////////////////////////////////////////////////////
GIT JENKINS CONFIG / GCP
////////////////////////////////////////////////////////////////////

GOALS: 
    - Create multi-branch pipelines for Aline microservices
