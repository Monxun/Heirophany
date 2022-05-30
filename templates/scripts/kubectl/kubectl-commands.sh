# GET STUFF
kubectl get services
kubectl get pods --all-namespaces
kubectl get deployment -A
kubectl get nodes

# GENERAL
kubectl create ns tacos
kubectl apply -f config.yaml
kubectl get pods --field-selector-status.phase=Running

# CLUSTER
kubectl cluster-info
kubectl config current-context
kubectl config get-contexts

# JENKINS GKE CONTEXT / PORT FORWARDING
kubectl config use-context gke_aline-jenkins-gcp_us-east1-d_jenkins-cd
kubectl get pods --all-namespaces
kubectl port-forward cd-jenkins-0 8080:8080

# JENKINS GKE SONARQUBE LOGS / NAMESPACE-CONTEXT / PORT FORWARDING
kubectl logs deploy/sonarqube-sonarqube --namespace=kubesphere-devops-system
kubectl config set-context --current --namespace=kubesphere-devops-system
kubectl port-forward sonarqube-sonarqube 9000:9000

kubectl logs -l app=sonarqube


kubectl config use-context arn:aws:eks:us-west-2:778295182882:cluster/mg-aline-eks


# DELETE CLUSTERS / CONTEXTS
kubectl config delete-cluster arn:aws:eks:us-west-2:778295182882:cluster/mg-aline-eks
kubectl config delete-cluster gke_aline-jenkins-gcp_us-east1-d_jenkins-cd 
kubectl config delete-context arn:aws:eks:us-west-2:778295182882:cluster/mg-aline-eks
kubectl config delete-context gke_aline-jenkins-gcp_us-east1-d_jenkins-cd 
