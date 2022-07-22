# terraform {
#   backend "s3" {
#     encrypt        = true
#     bucket         = "s3-terraform-remote-state-storage-happyboy"
#     region         = "ap-southeast-2"
#     key            = "./terraform.tfstate"
#     # dynamodb_table = "terraform-state-lock-dynamodb"
#   }
# }

# resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
#   name         = "terraform-state-lock-dynamodb"
#   billing_mode = "PAY_PER_REQUEST"
#   hash_key     = "LockID"
#   attribute {
#     name = "LockID"
#     type = "S"
#   }
# }

# output "dynamodb_table_name" {
#   value       = aws_dynamodb_table.dynamodb-terraform-state-lock.name
#   description = "The name of the DynamoDB table"
# }
