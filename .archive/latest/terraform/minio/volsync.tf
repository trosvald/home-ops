module "s3_volsync" {
  source      = "./modules/minio"
  vault       = "Automation"
  bucket_name = "volsync"
  # The OP provider converts the fields with toLower!
  user_secret_item = "VOLSYNC_S3_SECRET_KEY"
}
