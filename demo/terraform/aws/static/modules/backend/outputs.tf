output "s3_bucket_id" {
  value = aws_s3_bucket.this.*.id
}

output "s3_bucket_public_access_block_id" {
  value = aws_s3_bucket_public_access_block.this.*.id
}

output "dynamo_table_id" {
  value = aws_dynamodb_table.this.*.id
}