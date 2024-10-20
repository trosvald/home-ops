module "s3_gitlab-tmp" {
  source           = "./modules/minio"
  vault            = "Automation"
  bucket_name      = "gitlab-tmp"
  # The OP provider converts the fields with toLower!
  user_name        = "gitlab"
  user_secret_item = "gitlab_tmp_s3_secret_key"
}
