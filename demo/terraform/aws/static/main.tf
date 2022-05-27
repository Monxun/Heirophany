provider "aws" {
  # version = "~> 2.0"
  region = var.region
}


# ////////////////////////////////////////////////////
# BACKEND - TF Remote State S3 + DynamoDB Table
# ////////////////////////////////////////////////////
module "static_backend" {
  source = "./modules/backend"

  backend_flag = var.backend_flag

  state_bucket_name     = var.state_bucket_name
  state_lock_table_name = var.state_lock_table_name
}


# ////////////////////////////////////////////////////
# NETWORK 
# ////////////////////////////////////////////////////
module "static_vpc" {
  source = "./modules/vpc"

  vpc_flag = var.vpc_flag
  rds_flag = var.rds_flag

  environment_name = var.environment_name

  vpc_cidr = "10.44.0.0/16"
  db_name  = var.db_name
}


# ////////////////////////////////////////////////////
# ALB
# ////////////////////////////////////////////////////
module "static_alb" {
  source = "./modules/alb"

  alb_flag          = var.alb_flag
  internal_alb_flag = var.internal_alb_flag

  services               = var.services
  environment_name       = var.environment_name
  alb_main_vpc           = module.static_vpc.vpc_main_id
  alb_target_resource_id = module.static_alb.private_alb_id[0]
  idle_timeout           = var.idle_timeout
  deletion_protection    = var.deletion_protection
  public_alb_name        = var.public_alb_name
  public_subnet_ids      = module.static_vpc.public_subnet_ids
  private_subnet_ids     = module.static_vpc.private_subnet_ids
  public_sg_ids          = module.static_sg.public_sg_ids
  private_sg_ids          = module.static_sg.private_sg_ids
  alb_s3_bucket          = var.alb_s3_bucket
}


# ////////////////////////////////////////////////////
# ROUTE 53
# ////////////////////////////////////////////////////
module "static_route53" {
  source = "./modules/route53"

  route53_flag = var.route53_flag

  record_target = module.static_alb.public_alb_id[0]
}


# ////////////////////////////////////////////////////
# RDS
# ////////////////////////////////////////////////////
module "static_rds" {
  source = "./modules/rds"

  rds_flag = var.rds_flag

  db_name           = var.db_name
  db_instance_class = var.db_instance_class
  secret_key_name   = var.secret_key_name
}


# ////////////////////////////////////////////////////
# SG
# ////////////////////////////////////////////////////
module "static_sg" {
  source = "./modules/sg"

  sg_flag         = var.sg_flag
  alb_flag        = var.alb_flag
  rds_flag        = var.rds_flag
  cluster_sg_flag = var.cluster_sg_flag

  sg_vpc_id = module.static_vpc.vpc_main_id
  sg_vpc_cidr = "10.44.0.0/16"
}