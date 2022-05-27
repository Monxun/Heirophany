output "aline_db_id" {
  value = aws_db_instance.aline-db.*.id
}