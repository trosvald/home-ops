module "s3_gitlab-packages" {
  source           = "./modules/minio"
  vault            = "Automation"
  bucket_name      = "gitlab-packages"
  # The OP provider converts the fields with toLower!
  user_name        = "gitlab"
  user_secret_item = "gitlab_packages_s3_secret_key"
}
