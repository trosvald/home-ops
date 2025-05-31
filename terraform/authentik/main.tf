terraform {
  backend "s3" {
    bucket                      = "terraform-state"
    key                         = "authentik/state.tfstate"
    region                      = "bsd-lat-obj"

    endpoints = {
      s3 = "https://s3.monosense.dev"
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
      version = "2.1.1"
    }
    authentik = {
      source  = "goauthentik/authentik"
      version = "2025.4.0"
    }

  }
}

module "secret_authentik" {
  # Remember to export OP_CONNECT_HOST and OP_CONNECT_TOKEN
  source = "github.com/bjw-s/terraform-1password-item?ref=main"
  vault  = "Automation"
  item   = "authentik"
}

module "secret_headlamp" {
  source = "github.com/bjw-s/terraform-1password-item?ref=main"
  vault  = "Automation"
  item   = "headlamp"
}

module "secret_grafana" {
  source = "github.com/bjw-s/terraform-1password-item?ref=main"
  vault  = "Automation"
  item   = "grafana"
}

module "secret_gatus" {
  # Remember to export OP_CONNECT_HOST and OP_CONNECT_TOKEN
  source = "github.com/bjw-s/terraform-1password-item?ref=main"
  vault  = "Automation"
  item   = "gatus"
}
module "secret_pgadmin" {
  # Remember to export OP_CONNECT_HOST and OP_CONNECT_TOKEN
  source = "github.com/bjw-s/terraform-1password-item?ref=main"
  vault  = "Automation"
  item   = "pgadmin"
}
provider "authentik" {
  url   = "https://sso.${var.public_domain}"
  token = module.secret_authentik.fields["AUTHENTIK_BOOTSTRAP_TOKEN"]
}

provider "onepassword" {
  url = var.OP_CONNECT_HOST
  token = var.OP_CONNECT_TOKEN
}
