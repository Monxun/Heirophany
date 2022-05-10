#!/bin/bash

# EXPORT VALUES FROM .env FILE FOR USE IN values.yaml FOR HELM
set -o allexport
source ./.env
set +o allexport

# LOGIN TO GCLOUD
GCLOUD_AUTH_TOKEN=$(gcloud auth print-access-token)
helm registry login -u oauth2accesstoken -p "$GCLOUD_AUTH_TOKEN" https://us-central1-docker.pkg.dev/aline-financial/quickstart-helm-repo


# # INSTALL ALL 4 MS USING SINGLE HELM CHART AND 4 values.yaml FILES {LOCAL}
# helm install -f ./aline-financial/values/values.bank.yaml bank aline-financial
# helm install -f ./aline-financial/values/values.transaction.yaml transaction aline-financial
# helm install -f ./aline-financial/values/values.underwriter.yaml underwriter aline-financial
# helm install -f ./aline-financial/values/values.user.yaml user aline-financial


# INSTALL ALL 4 MS USING SINGLE HELM CHART AND 4 values.yaml FILES {REMOTE}
helm install -f ./aline-financial/values/values.bank.yaml bank oci://us-central1-docker.pkg.dev/aline-financial/quickstart-helm-repo/aline-financial --version 0.1.0
helm install -f ./aline-financial/values/values.transaction.yaml transaction oci://us-central1-docker.pkg.dev/aline-financial/quickstart-helm-repo/aline-financial --version 0.1.0
helm install -f ./aline-financial/values/values.underwriter.yaml underwriter oci://us-central1-docker.pkg.dev/aline-financial/quickstart-helm-repo/aline-financial --version 0.1.0
helm install -f ./aline-financial/values/values.user.yaml user oci://us-central1-docker.pkg.dev/aline-financial/quickstart-helm-repo/aline-financial --version 0.1.0
