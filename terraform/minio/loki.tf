module "s3_loki" {
  source      = "./modules/minio"
  vault       = "Automation"
  bucket_name = "loki"
  # The OP provider converts the fields with toLower!
  user_secret_item = "LOKI_S3_SECRET_KEY"
}
