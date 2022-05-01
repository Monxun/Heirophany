#!/bin/sh

# EXPORT VALUES FROM .env FILE FOR USE IN values.yaml FOR HELM
set -o allexport
source ./.env
set +o allexport

# CREATE CLUSTER
cd terraform
source apply.sh


# ///////////////////////////////////////////////////////////////////////////
# CONFIGURE NAMESPACES
# ///////////////////////////////////////////////////////////////////////////

# DEV
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Namespace
metadata:
    name: dev
EOF

# STAGE
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Namespace
metadata:
    name: stage
EOF

# PROD
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Namespace
metadata:
    name: prod
EOF


cd ..
cd ..
cd scripts