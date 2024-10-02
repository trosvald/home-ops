module "s3_crunchy-pgo" {
  source      = "./modules/minio"
  vault       = "Automation"
  bucket_name = "crunchy-pgo"
  # The OP provider converts the fields with toLower!
  user_secret_item = "crunchy_s3_secret_key"
}
