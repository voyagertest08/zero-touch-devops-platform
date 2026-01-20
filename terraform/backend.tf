terraform {
  backend "s3" {
    bucket         = "expense-tracker-terraform-state-devops-test"
    key            = "terraform.tfstate"
    region         = "ap-south-1"

    dynamodb_table = "expense-tracker-terraform-locks"
    encrypt        = true
  }
}
