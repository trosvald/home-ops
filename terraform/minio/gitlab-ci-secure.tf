module "s3_gitlab-ci-secure-files" {
  source           = "./modules/minio"
  vault            = "Automation"
  bucket_name      = "gitlab-ci-secure-files"
  # The OP provider converts the fields with toLower!
  user_name        = "gitlab"
  user_secret_item = "gitlab_ci_s3_secret_key"
}
