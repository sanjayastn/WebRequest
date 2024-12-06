
variable "s3_bucket_name" {
  description = "Name of the S3 bucket for storing Terraform state"
  default     = "terraform-state-bucket-eu-west-1"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    Categody  = "assignment"
    ManagedBy = "Terraform"
  }
}
