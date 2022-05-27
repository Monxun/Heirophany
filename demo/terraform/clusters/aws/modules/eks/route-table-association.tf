resource "aws_route_table_association" "eks_public_route_table" {
  count     = length(aws_subnet.eks_public)
  subnet_id = aws_subnet.eks_public[count.index].id

  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count     = length(aws_subnet.eks_private)
  subnet_id = aws_subnet.eks_private[count.index].id

  route_table_id = aws_route_table.private[count.index].id
}
