resource "aws_subnet" "eks_public" {
  count                   = length(var.eks_public_subnets_cidr)
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = element(var.eks_public_subnets_cidr, count.index)
  availability_zone       = element(data.aws_availability_zones.available_zones.names, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name                        = "mg-aline-eks-public-${count.index}"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/elb"    = 1
  }
}

resource "aws_subnet" "eks_private" {
  count             = length(var.eks_private_subnets_cidr)
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = element(var.eks_private_subnets_cidr, count.index)
  availability_zone = element(data.aws_availability_zones.available_zones.names, count.index)

  tags = {
    Name                              = "mg-aline-eks-private-${count.index}"
    "kubernetes.io/role/internal-elb" = 1
  }
}
