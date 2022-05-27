#!/bin/bash

# COMMANDS TO AUTH HELM REPO ON GCP AND PUSH REPO IN ROOT DIR

# GRAB KEY AND REPLACE IN SECOND LINE -p "ya29.--IQUMs16K..."
export GCLOUD_AUTH_TOKEN=("gcloud auth print-access-token")

helm registry login -u oauth2accesstoken -p "$GCLOUD_AUTH_TOKEN" oci://us-central1-docker.pkg.dev/aline-financial/quickstart-helm-repo

helm package aline-financial
helm push aline-financial-0.1.0.tgz oci://us-east1-docker.pkg.dev/aline-jenkins-gcp/nightwalkers-helm
gcloud artifacts docker images list us-east1-docker.pkg.dev/aline-jenkins-gcp/nightwalkers-helm

# helm install aline-financial oci://us-east1-docker.pkg.dev/aline-jenkins-gcp/nightwalkers-helm --version 0.1.0

# REMOVE ARTIFACT REGISTRY AND GKE CLUSTER
# gcloud artifacts repositories delete quickstart-helm-repo --location=us-central1
# gcloud container clusters delete --zone=us-central1-a chart-cluster