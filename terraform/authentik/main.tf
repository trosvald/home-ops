terraform {
  backend "s3" {
    bucket                      = "terraform"
    key                         = "authentik/state.tfstate"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    use_path_style              = true
  }

  required_providers {
    authentik = {
      source  = "goauthentik/authentik"
      version = "2024.8.4"
    }
  }
}

module "secret_authentik" {
  # Remember to export OP_CONNECT_HOST and OP_CONNECT_TOKEN
  source = "github.com/bjw-s/terraform-1password-item?ref=main"
  vault  = "Automation"
  item   = "authentik"
}

module "secret_grafana" {
  source = "github.com/bjw-s/terraform-1password-item?ref=main"
  vault  = "Automation"
  item   = "grafana"
}

module "secret_gitlab" {
  source = "github.com/bjw-s/terraform-1password-item?ref=main"
  vault  = "Automation"
  item   = "gitlab"
}

module "secret_ocis" {
  source = "github.com/bjw-s/terraform-1password-item?ref=main"
  vault  = "Automation"
  item   = "ocis"
}

module "secret_gatus" {
  source = "github.com/bjw-s/terraform-1password-item?ref=main"
  vault  = "Automation"
  item   = "gatus"
}

provider "authentik" {
  url   = module.secret_authentik.fields["authentik_endpoint_url"]
  token = module.secret_authentik.fields["authentik_api_token"]

}
