terraform {
  required_version = ">= 0.12"
}

# create a hosted zone,this zone is for CNAME 1 in cloudfront
resource "aws_route53_zone" "domain1" {
  name = var.module_domain_name_1
}

# do the delegation into my main domain aka happyboy.link
resource "aws_route53_record" "domain1" {
  allow_overwrite = true
  name            = var.module_domain_name_1
  ttl             = 10
  type            = "NS"
  zone_id         = var.module_root_domain_zone_id

  records = [
    aws_route53_zone.domain1.name_servers[0],
    aws_route53_zone.domain1.name_servers[1],
    aws_route53_zone.domain1.name_servers[2],
    aws_route53_zone.domain1.name_servers[3],
  ]
}

# create another hosted zone,this zone is for CNAME2 in cloudfront
resource "aws_route53_zone" "domain2" {
  name = var.module_domain_name_2
}


# do the delegation into my main domain aka happyboy.link
resource "aws_route53_record" "domain2" {
  allow_overwrite = true
  name            = var.module_domain_name_2
  ttl             = 10
  type            = "NS"
  zone_id         = var.module_root_domain_zone_id

  records = [
    aws_route53_zone.domain2.name_servers[0],
    aws_route53_zone.domain2.name_servers[1],
    aws_route53_zone.domain2.name_servers[2],
    aws_route53_zone.domain2.name_servers[3],
  ]
}

