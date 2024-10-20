module "s3_gitlab-lfs" {
  source           = "./modules/minio"
  vault            = "Automation"
  bucket_name      = "gitlab-lfs"
  # The OP provider converts the fields with toLower!
  user_name        = "gitlab"
  user_secret_item = "gitlab_lfs_s3_secret_key"
}
