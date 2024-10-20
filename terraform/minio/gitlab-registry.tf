module "s3_gitlab-registry" {
  source           = "./modules/minio"
  vault            = "Automation"
  bucket_name      = "gitlab-registry"
  # The OP provider converts the fields with toLower!
  user_name        = "gitlab"
  user_secret_item = "gitlab_registry_s3_secret_key"
}
