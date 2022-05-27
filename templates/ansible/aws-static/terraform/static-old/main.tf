# STATIC RESOURCES
terraform {
    required_version = ">= 0.12.0"
}

data "aws_availability_zones" "available" {}

# VPC
module "vpc" {
    source  = "terraform-aws-modules/vpc/aws"
    version = "2.6.0"

    name                 = "mg-vpc"
    cidr                 = "10.0.0.0/16"
    azs                  = data.aws_availability_zones.available_names
    private_subnets      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
    public_subnets       = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
    database_subnets     = ["10.0.7.0/24", "10.0.8.0/24"]

    enable_nat_gateway           = true
    single_nat_gateway           = true
    enable_dns_hostnames         = true
    create_database_subnet_group = true
}

