variable "module_origin_domain_name" {
  type        = string
  description = "origin domain who wants to cache on cloudfront"
}

variable "module_distribution_OAI" {
  type        = string
  description = "OAI for this distribution"
}

variable "module_alternate_domain_name_1" {
  type        = string
  description = "CNAME #1 For a Distribution"
}

variable "module_acm_certificate_arn_1" {
  type        = string
  description = "arn for ssl certificate of the alias for domain name 1"
}

variable "module_alternate_domain_name_2" {
  type        = string
  description = "CNAME #2 For a Distribution"
}

variable "module_alternate_domain_name_1_zone_id" {
  type        = string
  description = "zone_id of the domain name #1"
}