data "aws_availability_zones" "available_zones" {
  state = "available"
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

data "aws_iam_policy_document" "openid_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.openid_provider.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-node"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.openid_provider.arn]
      type        = "Federated"
    }
  }
}

data "aws_eks_cluster" "cluster" {
  name = aws_eks_cluster.eks.id
}

data "aws_eks_cluster_auth" "cluster" {
  name = aws_eks_cluster.eks.id
}

data "tls_certificate" "eks_tls_cert" {
  url = aws_eks_cluster.eks.identity[0].oidc[0].issuer
}

data "aws_caller_identity" "current" {

}