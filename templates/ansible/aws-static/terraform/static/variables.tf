variable "region" {
  default     = "us-west-1"
  description = "AWS region"
}

# S3
# BE MINDFUL OF ENVIRONEMNTS, NAMING, AT SCALE, SELF EVIDENT, SECURIT
variable "state_bucket_name" {
  type        = string
  description = "RDS Name"
}

variable "state_lock_table_name" {
  type        = string
  description = "RDS Name"
}


# db_username   = "${TF_VAR_db_username}"
# db_password   = "${TF_VAR_db_password}"
# db_engine     = "${TF_VAR_db_engine}"
# db_identifier = "${TF_VAR_db_identifier}"
# db_name       = "${TF_VAR_db_name}"

# NETWORK
variable "shared_vpc_name" {
  type        = string
  description = "RDS Name"
}

# RDS
variable "db_username" {
  type        = string
  description = "RDS Name"
}

variable "db_password" {
  type        = string
  description = "RDS Name"
}

variable "db_engine" {
  type        = string
  description = "RDS Name"
}

variable "db_name" {
  type        = string
  description = "RDS Name"
}

variable "db_identifier" {
  type        = string
  description = "RDS Name"
}


