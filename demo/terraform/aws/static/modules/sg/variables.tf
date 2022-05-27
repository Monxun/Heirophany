variable "sg_flag" {
  type = bool
}

variable "alb_flag" {
  type = bool
}

variable "rds_flag" {
  type = bool
}

variable "cluster_sg_flag" {
  type = bool
}

variable "sg_vpc_id" {
  type = string
}

variable "sg_vpc_cidr" {
  type = string
  default = "10.44.0.0/16"
}