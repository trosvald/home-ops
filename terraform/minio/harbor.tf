module "s3_harbor" {
  source      = "./modules/minio"
  vault       = "Automation"
  bucket_name = "harbor"
  # The OP provider converts the fields with toLower!
  user_secret_item = "harbor_s3_secret_key"
}
