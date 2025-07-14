terraform {
  backend "s3" {
    bucket         = "bytebytego-terraform-state"  # You must pre-create this S3 bucket
    key            = "infra/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-locks"              # You must pre-create this DynamoDB table
  }
}
