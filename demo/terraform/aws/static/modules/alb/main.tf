# ///////////////////////////////////////////////
# PUBLIC ALB
# ///////////////////////////////////////////////
resource "aws_alb" "public_alb" {
  count           = var.alb_flag ? 1 : 0
  name            = var.public_alb_name
  subnets         = var.public_subnet_ids
  security_groups = var.public_sg_ids
  internal        = var.internal_alb_flag
  idle_timeout    = var.idle_timeout
  tags = {
    Name = var.public_alb_name
  }
  access_logs {
    bucket = var.alb_s3_bucket
    prefix = "ALB-public-logs"
  }
}

# ///////////////////////////////////////////////
# INTERNAL ALB
# ///////////////////////////////////////////////
resource "aws_lb" "private_alb" {
  count              = var.alb_flag ? 1 : 0
  name               = "private-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = var.private_sg_ids
  #subnets            = [for subnet in aws_subnet.public : subnet.id]
  subnets                    = var.private_subnet_ids
  enable_deletion_protection = var.deletion_protection
  access_logs {
    bucket  = var.alb_s3_bucket
    prefix  = "ALB-private-logs"
  }

  tags = {
    Environment = var.environment_name
  }
}

# ///////////////////////////////////////////////
# TARGET GROUPS / ATTACHMENTS / LISTENERS
# ///////////////////////////////////////////////

# INTERNAL ALB
# resource "aws_lb_target_group" "private-alb-tg" {
#   for_each    = var.services
#   name        = "private-alb-tg-${each.key}"
#   port        = each.value[0]
#   protocol    = "HTTP"
#   vpc_id      = var.alb_main_vpc
#   target_type = "instance"
# }

# # ATTACH INTERNAL ALB TARGET GROUP TO PRIVATE CLUSTER SG
# resource "aws_lb_target_group_attachment" "private-alb-tg-attachment" {
#   for_each         = var.services
#   target_group_arn = aws_lb_target_group.private-alb-tg[each.key].arn
#   target_id        = var.alb_target_resource_id # CLUSTER SECURITY GROUP ID
#   port             = each.value[0]
# }

# #  PUBLIC ALB LISTENER
# resource "aws_lb_listener" "private-alb-listener-for-public-alb" {
#   for_each          = var.services
#   load_balancer_arn = aws_lb.private_alb[0].arn
#   port              = "80"
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.private-alb-tg[each.key].arn
#   }
# }
