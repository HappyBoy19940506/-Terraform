terraform {
  required_version = ">= 0.12"
}

locals {
  s3_origin_id = "S3-Origin"
}
# name for this origin

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = var.module_origin_domain_name
    origin_id   = local.s3_origin_id
    # name for this origin

    s3_origin_config {
      origin_access_identity = "origin-access-identity/cloudfront/${var.module_distribution_OAI}"
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Created by Terraform"
  default_root_object = "index.html"


  aliases = ["${var.module_alternate_domain_name_1}"]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 60
    max_ttl                = 86400
  }


  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE", "AU"]
    }
  }

  viewer_certificate {
    acm_certificate_arn      = var.module_acm_certificate_arn_1
    minimum_protocol_version = "TLSv1"
    ssl_support_method       = "sni-only"

  }
}

# write A record of distribution alias back to domain hosted zone
resource "aws_route53_record" "domain1" {
  name    = var.module_alternate_domain_name_1
  type    = "A"
  zone_id = var.module_alternate_domain_name_1_zone_id

  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = true
  }
}