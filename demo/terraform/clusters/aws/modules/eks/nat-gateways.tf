resource "aws_nat_gateway" "nat_gateway" {
  count = length(var.eks_public_subnets_cidr)
  # Set the allocation_id to the elastic ip nat1 defined in eips.tf
  allocation_id = aws_eip.eks_eip[count.index].id
  # Set the subnet_id to the subnet public_1 defined in subnets.tf
  subnet_id = aws_subnet.eks_public[count.index].id

  tags = {
    Name = "mg-aline-eks NAT Gateway : ${count.index}"
  }
}