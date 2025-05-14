module "s3_renovate" {
  source      = "./modules/minio"
  vault       = "Automation"
  bucket_name = "renovate"
  # The OP provider converts the fields with toLower!
  user_secret_item = "renovate_s3_secret_key"
}
