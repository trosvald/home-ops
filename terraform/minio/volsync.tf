module "s3_volsync" {
  source      = "./modules/minio"
  vault       = "Automation"
  bucket_name = "volsync"
  # The OP provider converts the fields with toLower!
  user_secret_item = "volsync_s3_secret_key"
}
