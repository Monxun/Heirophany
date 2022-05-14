terraform {
    backend "s3" {
        bucket = "jenkins-state-nightwalkers"
        key = "global/s3/terraform.tfstate"
        region = "us-west-1"
        dynamodb_table = "terraform-state-locking"
        encrypt = true
    }
}