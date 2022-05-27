resource "aws_vpc" "eks_vpc" {
  cidr_block = var.vpc_cidr

  # Shared instances on the host.
  instance_tenancy = "default"

  enable_dns_support   = true
  enable_dns_hostnames = true

  enable_classiclink               = false
  enable_classiclink_dns_support   = false
  assign_generated_ipv6_cidr_block = false

  tags = {
    Name = var.vpc_name
  }
}

output "vpc_id" {
  value       = aws_vpc.eks_vpc.id
  description = "ID of the eks_vpc"
  sensitive   = false
}
