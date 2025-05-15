# module "proxy-prowlarr" {
#   source             = "./proxy_application"
#   name               = "Prowlarr"
#   description        = "Torrent indexer"
#   icon_url           = "https://raw.githubusercontent.com/Prowlarr/Prowlarr/develop/Logo/128.png"
#   group              = "Downloads"
#   slug               = "indexer"
#   domain             = var.CLUSTER_DOMAIN
#   authorization_flow = resource.authentik_flow.provider-authorization-implicit-consent.uuid
#   invalidation_flow  = resource.authentik_flow.provider-invalidation.uuid
#   auth_groups        = [authentik_group.media.id]
# }

# module "proxy-radarr" {
#   source             = "./proxy_application"
#   name               = "Radarr"
#   description        = "Movies"
#   icon_url           = "https://github.com/Radarr/Radarr/raw/develop/Logo/128.png"
#   group              = "Downloads"
#   slug               = "movies"
#   domain             = var.CLUSTER_DOMAIN
#   authorization_flow = resource.authentik_flow.provider-authorization-implicit-consent.uuid
#   invalidation_flow  = resource.authentik_flow.provider-invalidation.uuid
#   auth_groups        = [authentik_group.media.id]
# }

# module "proxy-sonarr" {
#   source             = "./proxy_application"
#   name               = "Sonarr"
#   description        = "TV"
#   icon_url           = "https://github.com/Sonarr/Sonarr/raw/develop/Logo/128.png"
#   group              = "Downloads"
#   slug               = "tv"
#   domain             = var.CLUSTER_DOMAIN
#   authorization_flow = resource.authentik_flow.provider-authorization-implicit-consent.uuid
#   invalidation_flow  = resource.authentik_flow.provider-invalidation.uuid
#   auth_groups        = [authentik_group.media.id]
# }


module "oauth2-grafana" {
  source             = "./oauth2_application"
  name               = "Grafana"
  icon_url           = "https://raw.githubusercontent.com/grafana/grafana/main/public/img/icons/mono/grafana.svg"
  launch_url         = "https://grafana.${var.CLUSTER_DOMAIN}"
  description        = "Infrastructure graphs"
  newtab             = true
  group              = "Infrastructure"
  auth_groups        = [authentik_group.infrastructure.id]
  authorization_flow = resource.authentik_flow.provider-authorization-implicit-consent.uuid
  invalidation_flow  = resource.authentik_flow.provider-invalidation.uuid
  client_id          = module.secret_grafana.fields["OIDC_CLIENT_ID"]
  client_secret      = module.secret_grafana.fields["OIDC_CLIENT_SECRET"]
  redirect_uris      = ["https://grafana.${var.CLUSTER_DOMAIN}/login/generic_oauth"]
}

# module "oauth2-paperless" {
#   source             = "./oauth2_application"
#   name               = "Paperless"
#   icon_url           = "https://raw.githubusercontent.com/paperless-ngx/paperless-ngx/dev/resources/logo/web/svg/Color%20logo%20-%20no%20background.svg"
#   launch_url         = "https://documents.${var.private_domain}"
#   description        = "Documents"
#   newtab             = true
#   group              = "Selfhosted"
#   auth_groups        = [authentik_group.infrastructure.id]
#   authorization_flow = resource.authentik_flow.provider-authorization-implicit-consent.uuid
#   invalidation_flow  = resource.authentik_flow.provider-invalidation.uuid
#   client_id          = module.secret_paperless.fields["OIDC_CLIENT_ID"]
#   client_secret      = module.secret_paperless.fields["OIDC_CLIENT_SECRET"]
#   redirect_uris      = ["https://documents.${var.private_domain}/accounts/oidc/authentik/login/callback/"]
# }

# module "oauth2-ocis" {
#   source             = "./oauth2_application"
#   name               = "Owncloud"
#   icon_url           = "https://raw.githubusercontent.com/owncloud/owncloud.github.io/main/static/favicon/favicon.png"
#   launch_url         = "https://ocis.${var.CLUSTER_DOMAIN}"
#   description        = "ownCloud Infinite Scale"
#   newtab             = true
#   group              = "Selfhosted"
#   auth_groups        = [authentik_group.media.id]
#   client_type        = "public"
#   authorization_flow = resource.authentik_flow.provider-authorization-implicit-consent.uuid
#   invalidation_flow  = resource.authentik_flow.provider-invalidation.uuid
#   client_id          = module.secret_ocis.fields["OIDC_CLIENT_ID"]
#   # additional_property_mappings = formatlist(authentik_scope_mapping.openid-nextcloud.id)
#   redirect_uris = [
#     "https://ocis.${var.CLUSTER_DOMAIN}",
#     "https://ocis.${var.CLUSTER_DOMAIN}/oidc-callback.html",
#     "https://ocis.${var.CLUSTER_DOMAIN}/oidc-silent-redirect.html"
#   ]
# }

# module "oauth2-ocis-android" {
#   source             = "./oauth2_application"
#   name               = "Owncloud-android"
#   launch_url         = "blank://blank"
#   auth_groups        = [authentik_group.media.id]
#   authorization_flow = resource.authentik_flow.provider-authorization-implicit-consent.uuid
#   invalidation_flow  = resource.authentik_flow.provider-invalidation.uuid
#   client_id          = "e4rAsNUSIUs0lF4nbv9FmCeUkTlV9GdgTLDH1b5uie7syb90SzEVrbN7HIpmWJeD"
#   client_secret      = "dInFYGV33xKzhbRmpqQltYNdfLdJIfJ9L5ISoKhNoT9qZftpdWSP71VrpGR9pmoD"
#   redirect_uris      = ["oc://android.owncloud.com"]
# }

# module "oauth2-ocis-desktop" {
#   source             = "./oauth2_application"
#   name               = "Owncloud-desktop"
#   launch_url         = "blank://blank"
#   auth_groups        = [authentik_group.media.id]
#   authorization_flow = resource.authentik_flow.provider-authorization-implicit-consent.uuid
#   invalidation_flow  = resource.authentik_flow.provider-invalidation.uuid
#   client_id          = "xdXOt13JKxym1B1QcEncf2XDkLAexMBFwiT9j6EfhhHFJhs2KM9jbjTmf8JBXE69"
#   client_secret      = "UBntmLjC2yYCeHwsyj73Uwo9TAaecAetRwMw0xYcvNL9yRdLSUi0hUAHfvCHFeFh"
#   redirect_uris = [
#     { matching_mode = "regex", url = "http://127.0.0.1(:.*)?" },
#     { matching_mode = "regex", url = "http://localhost(:.*)?" }
#   ]
# }
