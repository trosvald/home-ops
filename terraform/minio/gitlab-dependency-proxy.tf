module "s3_gitlab-dependency-proxy" {
  source           = "./modules/minio"
  vault            = "Automation"
  bucket_name      = "gitlab-dependency-proxy"
  # The OP provider converts the fields with toLower!
  user_name        = "gitlab"
  user_secret_item = "GITLAB_DEPENDENCY_PROXY_S3_SECRET_KEY"
}
