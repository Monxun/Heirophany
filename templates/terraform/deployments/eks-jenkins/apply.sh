#!/bin/sh

git clone https://github.com/aws-samples/amazon-eks-jenkins-terraform.git
cd amazon-eks-jenkins-terraform/terraform/

terraform init
terraform plan
terraform apply -auto-approve