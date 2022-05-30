#!/bin/bash

cd ..
cd tools/terraform/clusters/aws/eks-main


gcloud auth configure-docker \
    us-east1-docker.pkg.dev

terraform init 
terraform plan -input=false -out=tf-eks.plan -lock="false"
terraform apply -input=false -auto-approve=true "tf-eks.plan"
terraform output -json | jq '.' | cat

# cd ../../../../../dev
# cd ..
# cd ..
# cd ..
# cd ..
# cd dev