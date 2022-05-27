variable "region" {
    default     = "us-west-1"
    description = "AWS region"
}

# S3
# BE MINDFUL OF ENVIRONEMNTS, NAMING, AT SCALE, SELF EVIDENT, SECURITY
variable "jenkins_vpc_name" {
    default     = "jenkins-nightwalkers-vpc"
    description = "Jenkins VPC Name"
}

variable "acl_value" {
    default     = "private"
    description = "Type of Bucket"
}

# RDS
variable "rds_name" {
    default     = "aline-db-mg"
    description = "RDS Name"
}

variable "rds_username" {
    default     = "admin"
    description = "RDS Username"
}

variable "rds_password" {
    default     = "Admin@54132"
    description = "RDS Password"
}