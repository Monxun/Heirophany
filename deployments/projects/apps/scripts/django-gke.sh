#!/bin/sh

# STEPS TO DEPLOY DJANGO INTO PRDOUCTION VIA GKE
# https://cloud.google.com/python/django/kubernetes-engine

export PROJECT_ID=monxun-apps
export INSTANCE_NAME=monxun_apps_db
export REGION=us-west1
export AZ=us-west1-a
export DATABASE_NAME=monxun_apps
export DATABASE_PASSWORD=mint
export PATH_TO_CREDENTIAL_FILE=/

# CREATE GCP SQL DATABASE INSTANCE
gcloud sql instances create INSTANCE_NAME \
    --project PROJECT_ID \
    --database-version POSTGRES_13 \
    --tier db-f1-micro \
    --region REGION

# CREATE DATABASE
gcloud sql databases create DATABASE_NAME \
    --instance INSTANCE_NAME

# CREATE DATABASE USER
gcloud sql users create DATABASE_USERNAME \
    --instance INSTANCE_NAME \
    --password DATABASE_PASSWORD

# CREATE SERVICE ACCOUNT FOR SQL
# CREATE SERVICE ACCOUNT JSON KEYS FOR SQL

# DEPLOY TO GKE

# CREATE CLOUD STORAGE BUCKET FOR STATIC FILES
gsutil mb gs://${PROJECT_ID}_MEDIA_BUCKET
gsutil defacl set public-read gs://${PROJECT_ID}_MEDIA_BUCKET

# GATHER STATIC FILES
python manage.py collectstatic

# UPLOAD STATIC FILES
gsutil -m rsync -r ./static gs://${PROJECT_ID}_MEDIA_BUCKET/static

# SET STATIC_URL IN SETTINGS.PY TO:
# http://storage.googleapis.com/${PROJECT_ID}_MEDIA_BUCKET/static/




# INITIALIZE CLUSTER
gcloud container clusters create polls \
  --scopes "https://www.googleapis.com/auth/userinfo.email","cloud-platform" \
  --num-nodes 4 --zone "us-central1-a"

# MAKE SURE KUBECTL IS CONNECTED
gcloud container clusters get-credentials polls --zone ${AZ}

# SETUP CLOUD SQL SECRETS / ACCESS (PATH TO JSON KEY FOR SERVICE ACCT)
kubectl create secret generic cloudsql-oauth-credentials \
  --from-file=credentials.json=[PATH_TO_CREDENTIAL_FILE]

# CREATE SECRETS FOR DB
kubectl create secret generic cloudsql \
  --from-literal=database=DATABASE_NAME \
  --from-literal=username=DATABASE_USERNAME \
  --from-literal=password=DATABASE_PASSWORD

# RETRIEVE CLOUD SQL PROXY IMAGE
docker pull b.gcr.io/cloudsql-docker/gce-proxy

# BUILD IMAGE
docker build -t gcr.io/PROJECT_ID/monxun-apps .

# CONFIG AUTH FOR IMAGE PUSH
gcloud auth configure-docker

# PUSH IMAGE
docker push gcr.io/PROJECT_ID/monxun-apps

