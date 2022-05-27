output "vpc" {
    description = "VPC"
    value       = module.vpc.vpc_id
}

output "private" {
    description = "Private Subnets"
    value       = module.vpc.private_subnets
}

output "public" {
    description = "Public Subnets"
    value       = module.vpc.public_subnets
}