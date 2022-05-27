resource "aws_alb" "eks_alb" {
  name            = "eks-alb"
  security_groups = [aws_security_group.alb_sg.id]
  subnets         = aws_subnet.eks_public[*].id
  tags = {
    Name = "eks_alb"
  }
}