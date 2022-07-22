output "domain_1_ACM_arn" {
  value       = aws_acm_certificate.domain_1.arn
  description = "the arn of ACM of domain #1"
}
