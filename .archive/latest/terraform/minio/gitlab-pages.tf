module "s3_gitlab-pages" {
  source           = "./modules/minio"
  vault            = "Automation"
  bucket_name      = "gitlab-pages"
  # The OP provider converts the fields with toLower!
  user_name        = "gitlab"
  user_secret_item = "GITLAB_PAGES_S3_SECRET_KEY"
}
