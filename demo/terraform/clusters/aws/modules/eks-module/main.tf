provider "aws" {
  region = local.region
}

locals {
  name            = "ex-${replace(basename(path.cwd), "_", "-")}mg-aline-eks"
  cluster_version = "1.22"
  region          = "eu-west-2"

  tags = {
    Example    = local.name
    GithubRepo = "terraform-aws-eks"
    GithubOrg  = "terraform-aws-modules"
  }
}

################################################################################
# EKS Module
################################################################################

module "eks" {
  source = "../.."

  cluster_name                    = local.name
  cluster_version                 = local.cluster_version
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  cluster_addons = {
    # Note: https://docs.aws.amazon.com/eks/latest/userguide/fargate-getting-started.html#fargate-gs-coredns
    coredns = {
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {}
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
    }
  }

  cluster_encryption_config = [{
    provider_key_arn = aws_kms_key.eks.arn
    resources        = ["secrets"]
  }]

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # You require a node group to schedule coredns which is critical for running correctly internal DNS.
  # If you want to use only fargate you must follow docs `(Optional) Update CoreDNS`
  # available under https://docs.aws.amazon.com/eks/latest/userguide/fargate-getting-started.html
  eks_managed_node_groups = {
    example = {
      desired_size = 1

      instance_types = ["t3.large"]
      labels = {
        Example    = "managed_node_groups"
        GithubRepo = "terraform-aws-eks"
        GithubOrg  = "terraform-aws-modules"
      }
      tags = {
        ExtraTag = "mg-aline-eks"
      }
    }
  }

  fargate_profiles = {
    default = {
      name = "default"
      selectors = [
        {
          namespace = "backend"
          labels = {
            Application = "backend"
          }
        },
        {
          namespace = "default"
          labels = {
            WorkerType = "fargate"
          }
        }
      ]

      tags = {
        Owner = "default"
      }

      timeouts = {
        create = "20m"
        delete = "20m"
      }
    }

    secondary = {
      name = "secondary"
      selectors = [
        {
          namespace = "default"
          labels = {
            Environment = "test"
            GithubRepo  = "terraform-aws-eks"
            GithubOrg   = "terraform-aws-modules"
          }
        }
      ]

      # Using specific subnets instead of the subnets supplied for the cluster itself
      subnet_ids = [module.vpc.private_subnets[1]]

      tags = {
        Owner = "mg"
      }
    }
  }

  tags = local.tags
}

################################################################################
# Supporting Resources
################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.0"

  name = local.name
  cidr = "10.144.0.0/16"

  azs             = ["${local.region}a", "${local.region}b", "${local.region}c"]
  private_subnets = ["10.144.1.0/24", "10.144.2.0/24", "10.144.3.0/24"]
  public_subnets  = ["10.144.4.0/24", "10.144.5.0/24", "10.144.6.0/24"]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  enable_flow_log                      = true
  create_flow_log_cloudwatch_iam_role  = true
  create_flow_log_cloudwatch_log_group = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.name}" = "shared"
    "kubernetes.io/role/elb"              = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.name}" = "shared"
    "kubernetes.io/role/internal-elb"     = 1
  }

  tags = local.tags
}

resource "aws_kms_key" "eks" {
  description             = "EKS Secret Encryption Key"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  tags = local.tags
}


################################################################################
# Supporting Resources
################################################################################
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
    host                   = data.aws_eks_cluster.mg-aline-eks.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.mg-aline-eks.certificate_authority.0.data)
    exec {
      api_version = "client.authentication.k8s.io/v1alpha1"
      args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.mg-aline-eks.name]
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