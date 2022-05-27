# ////////////////////////////////////////////////////
# PUBLIC SG
# ////////////////////////////////////////////////////
resource "aws_security_group" "public" {
  count       = var.sg_flag ? 1 : 0
  name = "public-sg"
  description = "Public internet access"
  vpc_id = var.sg_vpc_id

  tags = {
    Name        = "public-sg"
  }
}

#  RULES //////////////////////////////////////////////
resource "aws_security_group_rule" "public_out" {
  count       = var.sg_flag ? 1 : 0
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public[0].id
}

resource "aws_security_group_rule" "public_in_ssh" {
  count       = var.sg_flag ? 1 : 0
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public[0].id
}

resource "aws_security_group_rule" "public_in_http" {
  count       = var.sg_flag ? 1 : 0
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public[0].id
}

resource "aws_security_group_rule" "public_in_https" {
  count       = var.sg_flag ? 1 : 0
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public[0].id
}

 
# ////////////////////////////////////////////////////
# PRIVATE SG
# ////////////////////////////////////////////////////
resource "aws_security_group" "private" {
  count       = var.sg_flag ? 1 : 0
  name = "private-sg"
  description = "Private internet access"
  vpc_id = var.sg_vpc_id

  tags = {
    Name        = "private-sg"
  }
}

#  RULES //////////////////////////////////////////////
resource "aws_security_group_rule" "private_out" {
  count       = var.sg_flag ? 1 : 0
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.private[0].id

}

resource "aws_security_group_rule" "private_in" {
  count       = var.sg_flag ? 1 : 0
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks = [var.sg_vpc_cidr]
  security_group_id = aws_security_group.private[0].id
}