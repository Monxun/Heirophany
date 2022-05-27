output "public_alb_id" {
  value = aws_alb.public_alb[*].id
}

output "private_alb_id" {
  value = aws_lb.private_alb[*].id
}