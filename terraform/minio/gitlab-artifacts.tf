module "s3_gitlab-artifacts" {
  source           = "./modules/minio"
  vault            = "Automation"
  bucket_name      = "gitlab-artifacts"
  # The OP provider converts the fields with toLower!
  user_name        = "gitlab"
  user_secret_item = "GITLAB_ARTIFACTS_S3_SECRET_KEY"
}
