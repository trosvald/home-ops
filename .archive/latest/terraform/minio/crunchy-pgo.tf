module "s3_crunchy-pgo" {
  source      = "./modules/minio"
  vault       = "Automation"
  bucket_name = "crunchy-pgo"
  # The OP provider converts the fields with toLower!
  user_secret_item = "CRUNCHY_S3_SECRET_KEY"
}
