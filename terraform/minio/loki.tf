module "s3_loki" {
  source      = "./modules/minio"
  vault       = "Automation"
  bucket_name = "loki"
  # The OP provider converts the fields with toLower!
  user_secret_item = "loki_s3_secret_key"
}
