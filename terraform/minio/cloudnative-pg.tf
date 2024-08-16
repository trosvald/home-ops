module "s3_cloudnative-pg" {
  source      = "./modules/minio"
  vault       = "Automation"
  bucket_name = "cloudnative-pg"
  # The OP provider converts the fields with toLower!
  user_secret_item = "cnpg_s3_secret_key"
}
