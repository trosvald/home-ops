module "s3_gitlab-terraform-state" {
  source           = "./modules/minio"
  vault            = "Automation"
  bucket_name      = "gitlab-terraform-state"
  # The OP provider converts the fields with toLower!
  user_name        = "gitlab"
  user_secret_item = "GITLAB_TERRAFORM_S3_SECRET_KEY"
}
