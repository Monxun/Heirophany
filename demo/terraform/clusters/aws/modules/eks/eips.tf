resource "aws_eip" "eks_eip" {
  count = length(var.eks_private_subnets_cidr)
  depends_on = [
    aws_internet_gateway.eks_internet_gateway
  ]
}