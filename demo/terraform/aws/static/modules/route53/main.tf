# UPDATE
data "aws_ssm_parameter" "domain_name" {
  name = "jenkins-domain-name"
}


resource "aws_route53_zone" "public_zone" {
  count    = var.route53_flag ? 1 : 0
  name     = data.aws_ssm_parameter.domain_name.value
  comment  = "${data.aws_ssm_parameter.domain_name.value} public zone"
  provider = aws
}

resource "aws_route53_record" "domain_record" {
  count   = var.route53_flag ? 1 : 0
  zone_id = aws_route53_zone.public_zone[0].zone_id
  name    = "${data.aws_ssm_parameter.domain_name.value}.smootheststack.com"
  type    = "A"
  ttl     = "300"
  records = [var.record_target]
}