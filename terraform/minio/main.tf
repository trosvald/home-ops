terraform {
  backend "s3" {
    bucket                      = "terraform"
    key                         = "minio/state.tfstate"
    region                      = "p-rh8-zfs"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    use_path_style              = true
  }

  required_providers {
    minio = {
      source  = "aminueza/minio"
      version = "3.2.2"
    }
    onepassword = {
      source = "1password/onepassword"
      version = "2.1.2"
    }
  }
}

provider "onepassword" {
  url   = var.onepassword_host
  token = var.onepassword_token
}

module "onepassword_item_minio" {
  source = "github.com/bjw-s/terraform-1password-item?ref=main"
  vault  = "Automation"
  item   = "minio"
}

provider "minio" {
  minio_server   = "s3.monosense.io"
  minio_user     = module.onepassword_item_minio.fields.MINIO_USER
  minio_password = module.onepassword_item_minio.fields.MINIO_PASSWORD
  minio_ssl      = true
}
