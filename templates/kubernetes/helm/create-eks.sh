#!/bin/bash

# CREATE EKS CLUSTER (ADD VPC AND SUBNET FLAGS & ID'S)
eksctl create cluster \
--name aline-cluster-mg \
--version 1.21 \
--region us-west-1 \
--nodegroup-name mg-aline-nodes \
--node-type t2.micro \
--nodes 4

# CONFIGURE EKS CLUSTER (INSTALL ALB LOADBALANCER CONTROLER)
aws iam create-policy \
    --policy-name Aline_MG_LoadBalancerControllerIAMPolicy \
    --policy-document file://iam_policy.json

eksctl utils associate-iam-oidc-provider --region=us-west-1 --cluster=aline-cluster-mg --approve

eksctl create iamserviceaccount \
  --cluster=aline-cluster-mg \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --role-name "AmazonEKSLoadBalancerControllerRole" \
  --attach-policy-arn=arn:aws:iam::778295182882:policy/Aline_MG_LoadBalancerControllerIAMPolicy \
  --approve

helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=aline-cluster-mg \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller --set region=us-west-1 --set vpcId=vpc-07106699039716190

eksctl create fargateprofile \
    --cluster aline-cluster-mg \
    --region us-west-1 \
    --name alb-aline --namespace default