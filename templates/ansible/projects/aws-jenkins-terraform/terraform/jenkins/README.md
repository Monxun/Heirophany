# AMAZON EKS + JENKINS TERRAFORM PROVISION

https://faun.pub/multi-region-jenkins-ci-cd-deployment-to-aws-via-ansible-and-terraform-1-94122cfe89f1

https://aws.amazon.com/blogs/opensource/continuous-integration-using-jenkins-and-hashicorp-terraform-on-amazon-eks/

https://awstip.com/three-best-friends-terraform-ansible-and-jenkins-828285dcf8b

https://a4937.medium.com/serverless-jenkins-on-aws-ecs-with-fargate-and-ecr-using-terraform-771e638d6abb

# TODO:

1. Map out Static Resources and Backend
2. Create Playbook for Deployment
3. Create python scripts to handle resource id's / outputs and populate into tfvars files for deployments
4.

Steps:
    1. run ./bootstrap/deploy_bootstrap.sh
    2. take bootsrap output id's/names...
    3. plug into module deployment ./static/vars.sh in root of directory
    4. run script ./static/deploy_static.sh