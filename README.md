# pipeline works fine on Jenkins.
# AWS resources looks well after tf applying.

## Remaining work needs to be done:
* input and output naming rules in modules. e.g. main.tf / variables.tf
* change path correctly to match repo folder structure. e.g. ./application/aws_frontend
<!-- * implement remote backend-lock to store statefile in s3. I'm still using local state file as encountering some glitches. -->
* I don't know how to define a ACM certificate for more than one domain name (subject_alternative_names) by using Terraform.