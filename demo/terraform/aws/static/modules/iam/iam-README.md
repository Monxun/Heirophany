# MODULE: AWS BACKEND - NIGHTWALKERS - STATIC RESOURCES

Description: 
    Creates policies for resources that sets least-neccesary permissions

    Resources:

    - EKS: LB/Ing+Egr/EC2/Fargate/ECR/Secrets
    - ECS: LB/Ing+Egr/EC2/Fargate/ECR/secrets
    - Jenkins: LB/Ing+Egr/EC2/Fargate/ECR/Secrets

# VARIABLES / SOURCE
- region : TF_VAR env

# RESOURCE ID'S
- vpc_id

////////////////////////////////////////////////////////////////////////
# RESOURCE DETAILS: