output "domain1_name" {
  value       = aws_route53_zone.domain1.name
  description = "name of domain 1 "
}

output "domain1_zone_id" {
  value       = aws_route53_zone.domain1.zone_id
  description = "zone id of domain 1 "
}

output "domain2_name" {
  value       = aws_route53_zone.domain2.name
  description = "name of domain 2"
}

output "domain2_zone_id" {
  value       = aws_route53_zone.domain2.zone_id
  description = "zone id of domain 2 "
}