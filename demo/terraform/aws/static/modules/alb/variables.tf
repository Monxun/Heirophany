variable "services" {
  type = map(any)
  default = {
    bank        = [8083]
    transaction = [8073]
    underwriter = [8071]
    user        = [8070]
  }
}

variable "alb_flag" {
  type = bool
}

variable "internal_alb_flag" {
  type = bool
}

variable "environment_name" {
  type = string
}

variable "alb_main_vpc" {
  type = string
}

variable "alb_target_resource_id" {
  type = string
}

variable "idle_timeout" {
  type = string
}

variable "public_alb_name" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "public_sg_ids" {
  type = list(string)
}

variable "private_sg_ids" {
  type = list(string)
}

variable "alb_s3_bucket" {
  type = string
}

variable "deletion_protection" {
  type = bool
}