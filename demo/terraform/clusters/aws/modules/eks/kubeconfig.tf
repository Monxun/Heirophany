data "template_file" "kubeconfig" {
  template = file("${path.module}/templates/kubeconfig.tpl")

  vars = {
    kube_config_name    = "eks_${aws_eks_cluster.eks.name}"
    cluster_name        = aws_eks_cluster.eks.name
    endpoint            = data.aws_eks_cluster.cluster.endpoint
    cluster_auth_base64 = data.aws_eks_cluster.cluster.certificate_authority[0].data
    region_code         = var.aws_region
    account_id          = data.aws_caller_identity.current.account_id
  }
}

resource "local_file" "kubeconfig" {
  content  = data.template_file.kubeconfig.rendered
  filename = pathexpand("~/.kube/config")
}