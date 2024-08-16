module "s3_ocis" {
  source      = "./modules/minio"
  vault       = "Automation"
  bucket_name = "ocis"
  # The OP provider converts the fields with toLower!
  user_secret_item = "ocis_s3_secret_key"
}
