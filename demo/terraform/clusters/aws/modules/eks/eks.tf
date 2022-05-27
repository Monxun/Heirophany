resource "aws_cloudwatch_log_group" "eks_cluster_log_group" {
  name              = "/aws/eks/${var.eks_cluster_name}/cluster"
  retention_in_days = 30

  tags = {
    name = "${var.eks_cluster_name}-cloudwatch-log-group"
  }
}

resource "aws_iam_openid_connect_provider" "openid_provider" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks_tls_cert.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.eks.identity[0].oidc[0].issuer
}

resource "aws_eks_cluster" "eks" {
  name                      = var.eks_cluster_name
  role_arn                  = aws_iam_role.eks_cluster_role.arn
  version                   = var.k8_version
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  vpc_config {
    endpoint_private_access = false
    endpoint_public_access  = true

    subnet_ids = concat(aws_subnet.eks_public[*].id, aws_subnet.eks_private[*].id)
  }

  /* This resources requires the eks_cluster_policy to be properly attached before it can configure itself properly. */
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSServicePolicy,
    aws_cloudwatch_log_group.eks_cluster_log_group
  ]
}
