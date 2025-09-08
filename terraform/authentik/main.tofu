terraform {
  backend "s3" {
    bucket                      = "terraform-state"
    key                         = "authentik/state.tfstate"
    region                      = "auto"

    endpoints = {
      s3 = "https://eca0833f608b5745af030307a99bdbb4.r2.cloudflarestorage.com"
    }

    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    use_path_style              = true
  }

  required_providers {
    onepassword = {
      source  = "1Password/onepassword"
      version = "2.1.2"
    }
    authentik = {
      source  = "goauthentik/authentik"
      version = "2025.8.1"
    }

  }
}

module "secret_authentik" {
  # Remember to export OP_CONNECT_HOST and OP_CONNECT_TOKEN
  source = "github.com/bjw-s/terraform-1password-item?ref=main"
  vault  = "Dev"
  item   = "dev-sso"
}

module "secret_headlamp" {
  source = "github.com/bjw-s/terraform-1password-item?ref=main"
  vault  = "Dev"
  item   = "dev-headlamp"
}

module "secret_grafana" {
  source = "github.com/bjw-s/terraform-1password-item?ref=main"
  vault  = "Dev"
  item   = "dev-grafana"
}

module "secret_gatus" {
  # Remember to export OP_CONNECT_HOST and OP_CONNECT_TOKEN
  source = "github.com/bjw-s/terraform-1password-item?ref=main"
  vault  = "Dev"
  item   = "dev-gatus"
}
module "secret_pgadmin" {
  source = "github.com/bjw-s/terraform-1password-item?ref=main"
  vault  = "Infra"
  item   = "shared-pgadmin"
}

provider "authentik" {
  url   = "https://auth.${var.private_domain}"
  token = module.secret_authentik.fields["SSO_BOOTSTRAP_TOKEN"]
}

provider "onepassword" {
  url = var.OP_CONNECT_HOST
  token = var.OP_CONNECT_TOKEN
}
