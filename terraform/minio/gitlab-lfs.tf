module "s3_gitlab-lfs" {
  source           = "./modules/minio"
  vault            = "Automation"
  bucket_name      = "gitlab-lfs"
  # The OP provider converts the fields with toLower!
  user_name        = "gitlab"
  user_secret_item = "GITLAB_LFS_S3_SECRET_KEY"
}
