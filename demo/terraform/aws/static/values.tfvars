# ////////////////////////////////////////////////////
# FEATURE FLAGS 
# ////////////////////////////////////////////////////

vpc_flag        = true
rds_flag        = true
alb_flag        = true
backend_flag    = false
route53_flag    = false
sg_flag         = true

# ////////////////////////////////////////////////////
# AWS
# ////////////////////////////////////////////////////

region          = "us-west-1"
secret_key_name = "alinedbSecret"

# ////////////////////////////////////////////////////
# BACKEND
# ////////////////////////////////////////////////////

state_bucket_name     = "jenkins-state-nightwalkers"
state_lock_table_name = "tf-state-jenkins-lock"

# ////////////////////////////////////////////////////
# VPC
# ////////////////////////////////////////////////////

environment_name = "dev"

# ////////////////////////////////////////////////////
# ALB
# ////////////////////////////////////////////////////

services = {
  bank        = [8083]
  transaction = [8073]
  underwriter = [8071]
  user        = [8070]
}

internal_alb_flag   = true
idle_timeout        = "300"
public_alb_name     = "nightwalkers-shared-alb"
alb_s3_bucket       = "jenkins-state-nightwalkers"
deletion_protection = false

# ////////////////////////////////////////////////////
# ROUTE 53
# ////////////////////////////////////////////////////

# record_target = module.alb.public_alb_id

# ////////////////////////////////////////////////////
# RDS
# ////////////////////////////////////////////////////

db_name = "alinedb"

# ////////////////////////////////////////////////////
# SG
# ////////////////////////////////////////////////////

# sg_vpc_id = module.vpc.vpc_main_id
cluster_sg_flag = true