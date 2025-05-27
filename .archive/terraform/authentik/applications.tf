locals {
  oauth_apps = [
    "grafana",
    "headlamp"
  ]
}

module "onepassword_application" {
  for_each = toset(local.oauth_apps)
  source   = "github.com/joryirving/terraform-1password-item"
  vault    = "Automation"
  item     = each.key
}

locals {
  applications = {
    grafana = {
      client_id     = module.onepassword_application["grafana"].fields["GRAFANA_OIDC_CLIENT_ID"]
      client_secret = module.onepassword_application["grafana"].fields["GRAFANA_OIDC_CLIENT_SECRET"]
      group         = "monitoring"
      icon_url      = "https://raw.githubusercontent.com/homarr-labs/dashboard-icons/main/png/grafana.png"
      redirect_uri  = "https://grafana.${var.CLUSTER_DOMAIN}/login/generic_oauth"
      launch_url    = "https://grafana.${var.CLUSTER_DOMAIN}/login/generic_oauth"
    },
    headlamp = {
      client_id     = module.onepassword_application["headlamp"].fields["HEADLAMP_OIDC_CLIENT_ID"]
      client_secret = module.onepassword_application["headlamp"].fields["HEADLAMP_OIDC_CLIENT_SECRET"]
      group         = "infrastructure"
      icon_url      = "https://raw.githubusercontent.com/headlamp-k8s/headlamp/refs/heads/main/frontend/src/resources/icon-dark.svg"
      redirect_uri  = "https://headlamp.${var.CLUSTER_DOMAIN}/oidc-callback"
      launch_url    = "https://headlamp.${var.CLUSTER_DOMAIN}/"
    }
  }
}

resource "authentik_provider_oauth2" "oauth2" {
  for_each              = local.applications
  name                  = each.key
  client_id             = each.value.client_id
  client_secret         = each.value.client_secret
  authorization_flow    = resource.authentik_flow.provider-authorization-implicit-consent.uuid
  invalidation_flow     = resource.authentik_flow.provider-invalidation.uuid
  # authentication_flow   = authentik_flow.authentication.uuid
  # property_mappings     = data.authentik_property_mapping_provider_scope.oauth2.ids
  access_token_validity = "hours=4"
  signing_key           = data.authentik_certificate_key_pair.generated.id
  allowed_redirect_uris = [
    {
      matching_mode = "strict",
      url           = each.value.redirect_uri,
    }
  ]
}

resource "authentik_application" "application" {
  for_each           = local.applications
  name               = title(each.key)
  slug               = each.key
  protocol_provider  = authentik_provider_oauth2.oauth2[each.key].id
  group              = authentik_group.default[each.value.group].name
  open_in_new_tab    = true
  meta_icon          = each.value.icon_url
  meta_launch_url    = each.value.launch_url
  policy_engine_mode = "all"
}

resource "authentik_policy_binding" "application_policy_binding" {
  for_each = local.applications

  target = authentik_application.application[each.key].uuid
  group  = authentik_group.default[each.value.group].id
  order  = 0
}
