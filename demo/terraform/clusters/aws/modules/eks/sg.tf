resource "aws_security_group" "alb_sg" {
  name        = "alb_security_group"
  description = "Load balancer security group."
  vpc_id      = aws_vpc.eks_vpc.id

  ingress {
    cidr_blocks = [aws_vpc.eks_vpc.cidr_block]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }

  ingress {
    cidr_blocks = [aws_vpc.eks_vpc.cidr_block]
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }
}