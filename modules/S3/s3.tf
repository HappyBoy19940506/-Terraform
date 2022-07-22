terraform {
  required_version = ">= 0.12"
}

# main_bucket 
resource "aws_s3_bucket" "bucket1" {
  bucket = var.module_main_bucket_name
}

resource "aws_cloudfront_origin_access_identity" "bucket1" {
  comment = "This OAI is used for bucket 1 in ${terraform.workspace}"
}

resource "aws_s3_bucket_ownership_controls" "bucket1" {
  bucket = aws_s3_bucket.bucket1.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}
# I use BuckerOwnerEnforced, then ACL should be disabled.
resource "aws_s3_bucket_public_access_block" "bucket1" {
  bucket = aws_s3_bucket.bucket1.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# resource "aws_s3_bucket_acl" "bucket1" {
#   bucket = aws_s3_bucket.bucket1.id
#   acl    = "private"
# }

resource "aws_s3_bucket_policy" "bucket1" {
  bucket = aws_s3_bucket.bucket1.id
  policy = <<POLICY
{
    "Version": "2008-10-17",
    "Id": "PolicyForCloudFrontPrivateContent",
    "Statement": [
        {
            "Sid": "1",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${aws_cloudfront_origin_access_identity.bucket1.id}"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${aws_s3_bucket.bucket1.id}/*"
        }
    ]
}
POLICY
}

# resource "aws_s3_bucket_website_configuration" "bucket1" {
#   bucket = aws_s3_bucket.bucket1.bucket

#   index_document {
#     suffix = "index.html"
#   }

#   error_document {
#     key = "error.html"
#   }

#   routing_rules = <<EOF
# [{
#     "Condition": {
#         "KeyPrefixEquals": "docs/"
#     },
#     "Redirect": {
#         "ReplaceKeyPrefixWith": ""
#     }
# }]
# EOF
# }

# sub_bucket  
resource "aws_s3_bucket" "bucket2" {
  bucket = var.module_sub_bucket_name
}

resource "aws_cloudfront_origin_access_identity" "bucket2" {
  comment = "This OAI is used for bucket 2 in ${terraform.workspace}"
}

resource "aws_s3_bucket_ownership_controls" "bucket2" {
  bucket = aws_s3_bucket.bucket2.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}
# I use BuckerOwnerEnforced, then ACL should be disabled.
resource "aws_s3_bucket_public_access_block" "bucket2" {
  bucket = aws_s3_bucket.bucket2.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# resource "aws_s3_bucket_acl" "bucket1" {
#   bucket = aws_s3_bucket.bucket1.id
#   acl    = "private"
# }

resource "aws_s3_bucket_policy" "bucket2" {
  bucket = aws_s3_bucket.bucket2.id
  policy = <<POLICY
{
    "Version": "2008-10-17",
    "Id": "PolicyForCloudFrontPrivateContent",
    "Statement": [
        {
            "Sid": "1",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${aws_cloudfront_origin_access_identity.bucket2.id}"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${aws_s3_bucket.bucket2.id}/*"
        }
    ]
}
POLICY
}

# resource "aws_s3_bucket_website_configuration" "bucket1" {
#   bucket = aws_s3_bucket.bucket1.bucket

#   index_document {
#     suffix = "index.html"
#   }

#   error_document {
#     key = "error.html"
#   }

#   routing_rules = <<EOF
# [{
#     "Condition": {
#         "KeyPrefixEquals": "docs/"
#     },
#     "Redirect": {
#         "ReplaceKeyPrefixWith": ""
#     }
# }]
# EOF
# }
