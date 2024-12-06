# create S3 bucket for Terraform state
module "s3_state" {
  source      = "../../modules/s3"
  bucket_name = var.s3_bucket_name
  tags        = var.tags
}
