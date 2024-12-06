# Configure backend to use the S3 bucket
terraform {
  backend "s3" {
    bucket  = "terraform-state-bucket-eu-west-1"
    key     = "terraform/state/terraform.tfstate"
    region  = "eu-west-1"
    encrypt = true
  }
}
