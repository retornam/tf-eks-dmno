data "aws_route53_zone" "zone" {
  name = "${var.root_domain}."
}

resource "aws_route53_record" "domain" {
  name    = var.sub_domain
  type    = "CNAME"
  zone_id = data.aws_route53_zone.zone.id
  records = [aws_lb.this.dns_name]
  ttl     = 60
}

resource "aws_route53_record" "wildcard" {
  name    = "*.${var.sub_domain}"
  type    = "CNAME"
  zone_id = data.aws_route53_zone.zone.id
  records = [var.sub_domain]
  ttl     = 60
}
