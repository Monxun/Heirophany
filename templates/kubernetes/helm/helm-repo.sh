#!/bin/bash

# COMMANDS TO AUTH HELM REPO ON GCP AND PUSH REPO IN ROOT DIR

# GRAB KEY AND REPLACE IN SECOND LINE -p "ya29.--IQUMs16K..."
gcloud auth print-access-token
helm registry login -u oauth2accesstoken -p "$GCLOUD_AUTH_TOKEN" https://us-central1-docker.pkg.dev/aline-financial/quickstart-helm-repo

helm package aline-financial
helm push aline-financial-0.1.0.tgz oci://us-central1-docker.pkg.dev/aline-financial/quickstart-helm-repo
gcloud artifacts docker images list us-central1-docker.pkg.dev/aline-financial/quickstart-helm-repo

helm install aline-financial oci://us-central1-docker.pkg.dev/aline-financial/quickstart-helm-repo/aline-financial --version 0.1.0

# REMOVE ARTIFACT REGISTRY AND GKE CLUSTER
# gcloud artifacts repositories delete quickstart-helm-repo --location=us-central1
# gcloud container clusters delete --zone=us-central1-a chart-cluster