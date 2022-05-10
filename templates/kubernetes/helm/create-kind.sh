#!/bin/bash

# ///////////////////////////////////////////////////////////////////////////
# CREATE CLUSTER
# ///////////////////////////////////////////////////////////////////////////

cat <<EOF | kind create cluster --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
name: aline-financial-mg
nodes:
- role: control-plane
  kubeadmConfigPatches:
  - |
    kind: InitConfiguration
    nodeRegistration:
      kubeletExtraArgs:
        node-labels: "ingress-ready=true"
  extraPortMappings:
  - containerPort: 80
    hostPort: 80
    protocol: TCP
  - containerPort: 443
    hostPort: 443
    protocol: TCP
EOF


# ///////////////////////////////////////////////////////////////////////////
# CONFIGURE NGINX INGRESS
# ///////////////////////////////////////////////////////////////////////////

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml


# ///////////////////////////////////////////////////////////////////////////
# CONFIGURE METALLB LOADBALANCER
# ///////////////////////////////////////////////////////////////////////////

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.12.1/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.12.1/manifests/metallb.yaml

METALLB_IP_RANGE=$(docker network inspect -f '{{.IPAM.Config}}' kind 2>&1)

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ConfigMap
metadata:
  namespace: metallb-system
  name: config
data:
  config: |
    address-pools:
    - name: default
      protocol: layer2
      addresses:
      - $METALLB_IP_RANGE
EOF


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


# ///////////////////////////////////////////////////////////////////////////
# CONFIGURE KUBERNETES DASHBOARD [FINAL STEP] 
# ///////////////////////////////////////////////////////////////////////////

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.5.0/aio/deploy/recommended.yaml

# CREATE SERVICE ACCOUNT WITH THE NAME admin-user IN NAMESPACE kubernetes-dashboard
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kubernetes-dashboard
EOF

# CREATE CLUSTER ROLEBINDING FOR admin-user
cat <<EOF | kubectl apply -f -
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kubernetes-dashboard
EOF

# RETRIEVE LOGIN TOKEN FOR USER 
kubectl -n kubernetes-dashboard get secret $(kubectl -n kubernetes-dashboard get sa/admin-user -o jsonpath="{.secrets[0].name}") -o go-template="{{.data.token | base64decode}}"

# VISIT DASHBOARD 
echo "VISIT LINK:"
echo "http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/"
echo ""
echo "COPY TOKEN FROM AND PASTE TO LOGIN SCREEN"

# START KUBERNETES DASHBOARD
kubectl proxy




