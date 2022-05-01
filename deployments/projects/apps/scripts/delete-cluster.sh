#!/bin/sh

# EXPORT VALUES FROM .env FILE FOR USE IN values.yaml FOR HELM
set -o allexport
source ./.env
set +o allexport

gcloud container clusters delete monxun-apps
gcloud container images delete gcr.io/PROJECT_ID/monxun-apps
gcloud sql instances delete INSTANCE_NAME