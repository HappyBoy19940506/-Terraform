terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  #shared_config_file      = "/Users/user/.aws/config"
  shared_credentials_file = "/Users/user/.aws/credentials"
  profile                 = "default"
  region                  = "ap-southeast-2"
}

provider "aws" {
  alias                   = "us"
  shared_credentials_file = "/Users/user/.aws/credentials"
  profile                 = "default"
  region                  = "us-east-1"
}

module "my_s3_module" {
  source = "../modules/S3"
  // pass the variables value into the modules
  module_main_bucket_name = var.main_bucket_name
  module_sub_bucket_name  = var.backup_bucket_name
}

module "my_route53_module" {
  source                     = "../modules/Route53"
  module_domain_name_1       = var.domain_name_1
  module_domain_name_2       = var.domain_name_2
  module_root_domain_zone_id = var.root_domain_zone_id
}

module "my_cloudfront_module" {
  source                                 = "../modules/CloudFront"
  module_origin_domain_name              = module.my_s3_module.bucket1_regional_domain_name
  module_distribution_OAI                = module.my_s3_module.bucket1_OAI
  module_alternate_domain_name_1         = module.my_route53_module.domain1_name
  module_alternate_domain_name_2         = module.my_route53_module.domain2_name
  module_acm_certificate_arn_1           = module.my_ACM_module.domain_1_ACM_arn
  module_alternate_domain_name_1_zone_id = module.my_route53_module.domain1_zone_id
  depends_on                             = [module.my_ACM_module, module.my_s3_module]
}

module "my_ACM_module" {
  source = "../modules/ACM"
  providers = {
    aws = aws.us
  }
  module_acm_domain_name_1         = module.my_route53_module.domain1_name
  module_acm_domain_name_zone_id_1 = module.my_route53_module.domain1_zone_id
  module_acm_domain_name_2         = module.my_route53_module.domain2_name
  module_acm_domain_name_zone_id_2 = module.my_route53_module.domain2_zone_id
  depends_on                       = [module.my_route53_module]
}

