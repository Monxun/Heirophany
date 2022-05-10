#!/bin/bash

# CREATE GKE CLUSTER
gcloud container clusters create --zone us-central1-a chart-cluster

# GET CLUSTER CREDS AND GIVE ACCESS TO KUBECTL
gcloud container clusters get-credentials --zone us-central1-a chart-cluster




