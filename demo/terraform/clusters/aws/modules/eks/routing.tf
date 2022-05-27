resource "aws_route_table" "public" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.eks_internet_gateway.id
  }

  tags = {
    Name = "Public route table for the EKS VPC."
  }
}

resource "aws_route_table" "private" {
  count  = length(aws_nat_gateway.nat_gateway)
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway[count.index].id
  }
}
