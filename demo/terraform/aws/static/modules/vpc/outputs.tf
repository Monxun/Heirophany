output "vpc_main_id" {
  value = aws_vpc.main[0].id
}

output "public_subnet_ids" {
  value = tolist(aws_subnet.public)[*].id
}

output "private_subnet_ids" {
  value = tolist(aws_subnet.private)[*].id
}

output "rds_subnet_ids" {
  value = tolist(aws_subnet.rds)[*].id
}

output "nat_gateway_ids" {
  value = aws_nat_gateway.main[*].id
}

output "nat_eip_ids" {
  value = aws_eip.nat[*].id
}

