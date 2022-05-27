variable "vpc_flag" {
  type = bool
}

variable "rds_flag" {
  type = bool
}

variable "environment_name" {
  type = string
}

variable "vpc_cidr" {
  type    = string
  default = "10.44.0.0/16"
}

variable "db_name" {
  type = string
}