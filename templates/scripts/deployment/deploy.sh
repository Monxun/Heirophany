#!/bin/bash

aws eks --region us-west-2 update-kubeconfig --name mg-aline-eks
# kubectl config use-context arn:aws:eks:us-west-2:778295182882:cluster/mg-aline-eks
kubectl get nodes
cd .. 
cd tools/helm
helm install aline-financial

