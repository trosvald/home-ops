module "s3_gitlab-uploads" {
  source           = "./modules/minio"
  vault            = "Automation"
  bucket_name      = "gitlab-uploads"
  # The OP provider converts the fields with toLower!
  user_name        = "gitlab"
  user_secret_item = "GITLAB_UPLOADS_S3_SECRET_KEY"
}
