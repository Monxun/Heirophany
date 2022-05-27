output "route53_public_zone_id" {
  value = aws_route53_zone.public_zone.*.zone_id
}

output "route53_route_record_id" {
  value = aws_route53_record.domain_record.*.id
}