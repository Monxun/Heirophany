resource "aws_internet_gateway" "eks_internet_gateway" {
  vpc_id = aws_vpc.eks_vpc.id

  tags = {
    Name = "mg-aline-eks internet gateway"
  }
}