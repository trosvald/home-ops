terraform {
  backend "s3" {
    bucket                      = "terraform"
    region                      = "p-rh8-zfs"
    key                         = "authentik/state.tfstate"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    use_path_style              = true
  }

  required_providers {
    authentik = {
      source  = "goauthentik/authentik"
      version = "2025.2.0"
    }
    onepassword = {
      source = "1Password/onepassword"
      version = "2.1.2"
    }
  }
}

provider "onepassword" {
  url   = var.onepassword_host
  token = var.onepassword_token
}

module "secret_authentik" {
  # Remember to export OP_CONNECT_HOST and OP_CONNECT_TOKEN
  source = "github.com/joryirving/terraform-1password-item"
  vault  = "Automation"
  item   = "authentik"
}

module "secret_grafana" {
  source = "github.com/joryirving/terraform-1password-item"
  vault  = "Automation"
  item   = "grafana"
}

module "secret_gitlab" {
  source = "github.com/joryirving/terraform-1password-item"
  vault  = "Automation"
  item   = "gitlab"
}

module "secret_ocis" {
  source = "github.com/joryirving/terraform-1password-item"
  vault  = "Automation"
  item   = "ocis"
}

module "secret_gatus" {
  source = "github.com/joryirving/terraform-1password-item"
  vault  = "Automation"
  item   = "gatus"
}

module "secret_planka" {
  source = "github.com/joryirving/terraform-1password-item"
  vault  = "Automation"
  item   = "planka"
}

provider "authentik" {
  url   = module.secret_authentik.fields["AUTHENTIK_ENDPOINT_URL"]
  token = module.secret_authentik.fields["AUTHENTIK_API_TOKEN"]
}
