module "s3_gitlab-registry" {
  source           = "./modules/minio"
  vault            = "Automation"
  bucket_name      = "gitlab-registry"
  # The OP provider converts the fields with toLower!
  user_name        = "gitlab"
  user_secret_item = "GITLAB_REGISTRY_S3_SECRET_KEY"
}
