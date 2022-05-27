data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
  region     = data.aws_region.current.name

  tags = {
    team     = "nightwalkers"
    solution = "jenkins"
  }
}

resource "aws_s3_bucket" "this" {
  count  = var.backend_flag ? 1 : 0
  bucket = var.state_bucket_name

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning {
    enabled = true
  }
  lifecycle {
    prevent_destroy = true
  }

  tags = local.tags
}

resource "aws_s3_bucket_public_access_block" "this" {
  count                   = var.backend_flag ? 1 : 0
  bucket                  = aws_s3_bucket.this[count.index].id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_dynamodb_table" "this" {
  count        = var.backend_flag ? 1 : 0
  name         = var.state_lock_table_name
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }

  server_side_encryption {
    enabled = true
  }

  tags = {
    Name = "DynamoDB Terraform State Lock Table"
  }
}