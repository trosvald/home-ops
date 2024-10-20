module "s3_gitlab-external-diffs" {
  source           = "./modules/minio"
  vault            = "Automation"
  bucket_name      = "gitlab-external-diffs"
  # The OP provider converts the fields with toLower!
  user_name        = "gitlab"
  user_secret_item = "gitlab_external_diffs_s3_secret_key"
}
