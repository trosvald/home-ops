module "s3_gitlab-uploads" {
  source           = "./modules/minio"
  vault            = "Automation"
  bucket_name      = "gitlab-uploads"
  # The OP provider converts the fields with toLower!
  user_name        = "gitlab"
  user_secret_item = "gitlab_uploads_s3_secret_key"
}
