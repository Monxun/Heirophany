#!/bin/sh 

# set -e

gcloud auth configure-docker \
    us-east1-docker.pkg.dev

# TF_VAR_gcloud_auth_token=$(gcloud auth print-access-token)

# helm repo add nightwalkers-helm https://us-east1-docker.pkg.dev/aline-jenkins-gcp/nightwalkers-helm

aws-vault exec profile -- terraform init 
aws-vault exec profile -- terraform plan -input=false -out=tf-static.plan -lock="false"
aws-vault exec profile -- terraform apply -input=false -auto-approve="true" "tf-static.plan"

aws-vault exec profile -- aws eks --region us-west-2 update-kubeconfig --name mg-aline-eks

aws-vault exec profile -- k9s