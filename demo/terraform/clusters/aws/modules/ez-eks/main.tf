terraform {
  required_version = ">= 0.12.0"
}

provider "aws" {
  version = ">= 2.28.1"
  region  = var.region
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

data "aws_availability_zones" "available" {
}

resource "aws_security_group" "worker_group_mgmt_one" {
  name_prefix = "worker_group_mgmt_one"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/8",
    ]
  }
}

resource "aws_security_group" "all_worker_mgmt" {
  name_prefix = "all_worker_management"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/8",
      "172.16.0.0/12",
      "192.168.0.0/16",
    ]
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.6.0"

  name                 = "test-vpc"
  cidr                 = "10.144.0.0/16"
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = ["10.144.1.0/24", "10.144.2.0/24", "10.144.3.0/24"]
  public_subnets       = ["10.144.4.0/24", "10.144.5.0/24", "10.144.6.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}

module "eks" {
  source       = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  cluster_version = "1.17"
  subnets         = module.vpc.private_subnets
  version = "12.2.0"
  cluster_create_timeout = "1h"
  cluster_endpoint_private_access = true 

  vpc_id = module.vpc.vpc_id

  worker_groups = [
    {
      name                          = "worker-group-1"
      instance_type                 = "t2.small"
      additional_userdata           = "echo foo bar"
      asg_desired_capacity          = 1
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
    },
  ]

  worker_additional_security_group_ids = [aws_security_group.all_worker_mgmt.id]
  # map_roles                            = var.map_roles
  # map_users                            = var.map_users
  # map_accounts                         = var.map_accounts
}



provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
  version                = "~> 1.11"
}

data "aws_secretsmanager_secret" "alinekeys" {
  name = var.secret_key_name
}

data "aws_secretsmanager_secret_version" "aline_creds_version" {
  secret_id     = data.aws_secretsmanager_secret.alinekeys.id
  version_stage = "AWSCURRENT"
}

locals {
  aline_creds = jsondecode(data.aws_secretsmanager_secret_version.aline_creds_version.secret_string)
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.dev-cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.dev-cluster.certificate_authority.0.data)
    exec {
      api_version = "client.authentication.k8s.io/v1alpha1"
      args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.dev-cluster.name]
      command     = "aws"
    }
  }
}

resource "helm_release" "jenkins" {
  name       = "aline-financial"
  repository = "https://us-east1-docker.pkg.dev/aline-jenkins-gcp/nightwalkers-helm"
  chart      = "aline-financial"

  values = [
    "${file("helm-values.yaml")}"
  ]

  set_sensitive {
    name  = "DB_USERNAME"
    value = local.aline_creds["DB_USERNAME"]
  }

  set_sensitive {
    name  = "DB_PASSWORD"
    value = local.aline_creds["DB_PASSWORD"]
  }

  set_sensitive {
    name  = "dbPort"
    value = local.aline_creds["DB_PORT"]
  }

  set_sensitive {
    name  = "DB_NAME"
    value = local.aline_creds["DB_NAME"]
  }

  set_sensitive {
    name  = "DB_HOST"
    value = local.aline_creds["DB_HOST"]
  }

  set_sensitive {
    name  = "APP_SERVICE_HOST"
    value = local.aline_creds["APP_SERVICE_HOST"]
  }

  set_sensitive {
    name  = "APP_USER_ACCESS_KEY"
    value = local.aline_creds["APP_USER_ACCESS_KEY"]
  }

  set_sensitive {
    name  = "ENCRYPT_SECRET_KEY"
    value = local.aline_creds["ENCRYPT_SECRET_KEY"]
  }

  set_sensitive {
    name  = "APP_USER_ACCESS_KEY"
    value = local.aline_creds["APP_USER_ACCESS_KEY"]
  }

  set_sensitive {
    name  = "S3_TEMPLATE_BUCKET"
    value = local.aline_creds["S3_TEMPLATE_BUCKET"]
  }

}