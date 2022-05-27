apiVersion: v1
kind: Config

clusters:
 - cluster:
    server: ${endpoint}
    certificate-authority-data: ${cluster_auth_base64}
   name: arn:aws:eks:${region_code}:${account_id}:cluster/${cluster_name}

contexts:
 - context:
    cluster: arn:aws:eks:${region_code}:${account_id}:cluster/${cluster_name}
    user: arn:aws:eks:${region_code}:${account_id}:cluster/${cluster_name}
   name: arn:aws:eks:${region_code}:${account_id}:cluster/${cluster_name}

current-context: arn:aws:eks:${region_code}:${account_id}:cluster/${cluster_name}

users:
 - name: arn:aws:eks:${region_code}:${account_id}:cluster/${cluster_name}
   user:
     exec:
       apiVersion: client.authentication.k8s.io/v1alpha1
       command: aws-vault
       args:
        - exec
        - nightwalkers
        - --
        - aws
        - eks
        - get-token
        - --cluster-name
        - ${cluster_name}
       interactiveMode: IfAvailable