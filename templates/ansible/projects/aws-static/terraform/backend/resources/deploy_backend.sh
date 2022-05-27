#!/usr/bin/env bash

# Start from a clean slate
rm -rf .terraform

aws-vault exec profile -- terraform init

aws-vault exec profile -- terraform plan \
    -lock=false \
    -input=false \
    -out=tf.plan

aws-vault exec profile -- terraform apply \
    -input=false \
    -auto-approve=true \
    -lock=true \
    tf.plan