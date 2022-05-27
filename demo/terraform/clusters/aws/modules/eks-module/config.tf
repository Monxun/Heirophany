terraform {
    backend "s3" {
        bucket = "jenkins-state-nightwalkers"
        key = "us-east-1/s3/mg-aws-eks-terraform.tfstate"
        region = "us-west-1"
        dynamodb_table = "tf-state-mg-aws-eks--lock"
        encrypt = true
    }
}