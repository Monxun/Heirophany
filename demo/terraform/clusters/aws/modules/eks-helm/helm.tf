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