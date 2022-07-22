output "bucket1_regional_domain_name" {
  value       = aws_s3_bucket.bucket1.bucket_regional_domain_name
  description = "this shows s3_regional_domain_name,used as Origin on CloudFront"
}

output "bucket1_OAI" {
  value       = aws_cloudfront_origin_access_identity.bucket1.id
  description = "the OAI id for bucket 1"
}