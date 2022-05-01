#!/bin/sh

cd ..
cd terraform/gcp
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