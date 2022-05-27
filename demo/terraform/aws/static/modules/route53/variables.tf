variable "route53_flag" {
  type = bool
}

variable "record_target" {
  type        = string
  description = "target resource to route inbound traffic"
}

