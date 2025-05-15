terraform {
  backend "s3" {
    bucket                      = "terraform"
    key                         = "authentik/state.tfstate"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
  }

  required_providers {
    authentik = {
      source  = "goauthentik/authentik"
      version = "2025.4.0"
    }

    onepassword = {
      source = "1password/onepassword"
      version = "2.1.2"
    }
  }
}

module "secret_authentik" {
  source = "github.com/bjw-s/terraform-1password-item?ref=main"
  vault  = "Automation"
  item   = "authentik"
}

module "secret_grafana" {
  source = "github.com/bjw-s/terraform-1password-item?ref=main"
  vault  = "Automation"
  item   = "grafana"
}

# module "secret_nextcloud" {
#   source = "github.com/bjw-s/terraform-1password-item?ref=main"
#   vault  = "Automation"
#   item   = "nextcloud"
# }

# module "secret_paperless" {
#   source = "github.com/bjw-s/terraform-1password-item?ref=main"
#   vault  = "Automation"
#   item   = "paperless"
# }

# module "secret_ocis" {
#   source = "github.com/bjw-s/terraform-1password-item?ref=main"
#   vault  = "Automation"
#   item   = "ocis"
# }

provider "onepassword" {
  url = var.OP_CONNECT_HOST
  token = var.OP_CONNECT_TOKEN
}

provider "authentik" {
  url   = "https://sso.${var.CLUSTER_DOMAIN}"
  token = module.secret_authentik.fields["AUTHENTIK_TOKEN"]
}
