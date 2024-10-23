module "s3_gitlab-runner" {
  source           = "./modules/minio"
  vault            = "Automation"
  bucket_name      = "gitlab-runner"
  # The OP provider converts the fields with toLower!
  user_name        = "gitlab"
  user_secret_item = "gitlab_runner_s3_secret_key"
}
