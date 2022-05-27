resource "aws_ecr_repository" "aline_bank" {
  name                 = "aline-bank-mg"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "aline_underwriter" {
  name                 = "aline-underwriter-mg"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "aline_user" {
  name                 = "aline-user-mg"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "aline_transaction" {
  name                 = "aline-transaction-mg"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}