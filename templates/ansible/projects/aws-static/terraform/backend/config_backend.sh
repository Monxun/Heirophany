#!/usr/bin/env bash

aws-vault exec profile -- terraform init 
    # -backend=true \
    # -backend-config key="${TF_STATE_OBJECT_KEY}" \
    # -backend-config bucket="${TF_STATE_BUCKET}" \
    # -backend-config dynamodb_table="${TF_LOCK_DB}"

aws-vault exec profile -- terraform plan \
    -out=tf.plan

aws-vault exec profile -- terraform apply \
    -input=false \
    -auto-approve=true \
    -lock=true \
    tf.plan