module "s3_thanos" {
  source      = "./modules/minio"
  vault       = "Automation"
  bucket_name = "thanos"
  # The OP provider converts the fields with toLower!
  user_secret_item = "thanos_s3_secret_key"
}
