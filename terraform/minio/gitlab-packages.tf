module "s3_gitlab-packages" {
  source           = "./modules/minio"
  vault            = "Automation"
  bucket_name      = "gitlab-packages"
  # The OP provider converts the fields with toLower!
  user_name        = "gitlab"
  user_secret_item = "GITLAB_PACKAGES_S3_SECRET_KEY"
}
