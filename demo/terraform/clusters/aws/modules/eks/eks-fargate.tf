resource "aws_eks_fargate_profile" "main_fargate_profile" {
  cluster_name           = aws_eks_cluster.eks.name
  fargate_profile_name   = "mg-aline-eks-fp-main"
  pod_execution_role_arn = aws_iam_role.fargate_pod_execution_role.arn
  subnet_ids             = aws_subnet.eks_private[*].id

  selector {
    namespace = "default"
  }

  selector {
    namespace = "kube-system"
  }

  selector {
    namespace = "aline-financial"
  }
}