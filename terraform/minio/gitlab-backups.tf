module "s3_gitlab-backups" {
  source           = "./modules/minio"
  vault            = "Automation"
  bucket_name      = "gitlab-backups"
  # The OP provider converts the fields with toLower!
  user_name        = "gitlab"
  user_secret_item = "gitlab_backups_s3_secret_key"
}
