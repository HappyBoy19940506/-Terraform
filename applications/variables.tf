variable "root_domain_zone_id" {
  type        = string
  description = "this main_zone_id belongs to your apex root domain name i.e.happyboy.link"
}

variable "domain_name_1" {
  type        = string
  description = "url domain name for CloudFront CNAME 1"
}

variable "domain_name_2" {
  type        = string
  description = "url domain name for CloudFront CNAME 2"
}

variable "main_bucket_name" {
  type        = string
  description = "main bucket to store objects and web hosting"
}

variable "backup_bucket_name" {
  type        = string
  description = "back-up bucket, used to back up"
}

