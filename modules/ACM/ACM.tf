terraform {
  required_version = ">= 0.12"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# give a certificate for domain #1 , alternative_name set for domain #2
resource "aws_acm_certificate" "domain_1" {
  domain_name = var.module_acm_domain_name_1
  #subject_alternative_names = ["${var.module_acm_domain_name_2}"]
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}
# create a record set in route 53 for domain validatation
resource "aws_route53_record" "domain_1" {
  for_each = {
    for dvo in aws_acm_certificate.domain_1.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = var.module_acm_domain_name_zone_id_1
}

# validate acm certificates
resource "aws_acm_certificate_validation" "domain_1" {
  certificate_arn         = aws_acm_certificate.domain_1.arn
  validation_record_fqdns = [for record in aws_route53_record.domain_1 : record.fqdn]

}


