terraform {
  backend "s3" {
    bucket         = "my-s3-bucket-to-terraform"
    key            = "myproject/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    # dynamodb_table = "terraform-state-lock-table"
  }
}
