module "s3_harbor" {
  source      = "./modules/minio"
  vault       = "Automation"
  bucket_name = "harbor"
  # The OP provider converts the fields with toLower!
  user_secret_item = "HARBOR_S3_SECRET_KEY"
}
