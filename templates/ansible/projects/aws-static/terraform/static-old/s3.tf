resource "aws_s3_bucket" "aline-bucket" {
    bucket = "${var.bucket_name}" 
    acl = "${var.acl_value}"   
}
