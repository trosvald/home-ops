module "s3_gitlab-terraform-state" {
  source           = "./modules/minio"
  vault            = "Automation"
  bucket_name      = "gitlab-terraform-state"
  # The OP provider converts the fields with toLower!
  user_name        = "gitlab"
  user_secret_item = "gitlab_terraform_s3_secret_key"
}
