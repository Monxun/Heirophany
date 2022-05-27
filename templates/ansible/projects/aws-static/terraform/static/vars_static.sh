#!/usr/bin/env bash

# export TERRAFORM_WORKSPACE=jason-local-farm-runner
export TF_STATE_BUCKET=jenkins-state-nightwalkers 
export TF_STATE_OBJECT_KEY=us-east-1/s3/jenkins-terraform.tfstate
export TF_LOCK_DB=tf-state-jenkins-lock

export TF_VAR_shared_vpc_name=nightwalkers-vpc

export TF_VAR_db_username=$db_username
export TF_VAR_db_password=$db_password 
export TF_VAR_db_engine=$db_engine
export TF_VAR_db_identifier=$db_identifier
export TF_VAR_db_name=$db_name