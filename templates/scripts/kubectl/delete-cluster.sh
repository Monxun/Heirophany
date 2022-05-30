#!/bin/bash

# Pass cluster name and context name as flags -cluster, -   

# CLUSTER NAME
kubectl config delete-cluster $1

# CONTEXT NAME
kubectl config delete-context $2

# CLUSTER USER
kubectl config unset users.my-cluster-admin



kubectl config delete-cluster arn:aws:eks:us-west-2:778295182882:cluster/mg-aline-eks
kubectl config delete-cluster gke_aline-jenkins-gcp_us-east1-d_jenkins-cd 
kubectl config delete-context arn:aws:eks:us-west-2:778295182882:cluster/mg-aline-eks
kubectl config delete-context gke_aline-jenkins-gcp_us-east1-d_jenkins-cd 
