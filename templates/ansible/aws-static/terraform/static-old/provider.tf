provider "aws" {
    version = ">= 2.28.1"
    region  = var.region
}

provider "aws" {
  alias  = "replica"
  region = "us-west-1"
}