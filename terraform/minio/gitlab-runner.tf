module "s3_gitlab-runner" {
  source           = "./modules/minio"
  vault            = "Automation"
  bucket_name      = "gitlab-runner"
  # The OP provider converts the fields with toLower!
  user_name        = "gitlab"
  user_secret_item = "GITLAB_RUNNER_S3_SECRET_KEY"
}
