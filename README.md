# pipeline works fine on Jenkins.
# AWS resources looks well after tf applying.

## Remaining work needs to be done:
* input and output naming rules in modules. e.g. main.tf / variables.tf
* change path correctly to match repo folder structure. e.g. ./application/aws_frontend.
* I don't know how to define a ACM certificate for more than one domain name (subject_alternative_names) by using Terraform.
* I don't know how to use lookup to set values for multiple workspaces in the same .tfvars.