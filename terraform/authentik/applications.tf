# module "proxy-transmission" {
#   source             = "./proxy_application"
#   name               = "Transmission"
#   description        = "Torrent client"
#   icon_url           = "https://github.com/transmission/transmission/raw/main/web/assets/img/logo.png"
#   group              = "Downloads"
#   slug               = "torrent"
#   domain             = var.public_domain
#   authorization_flow = resource.authentik_flow.provider-authorization-implicit-consent.uuid
#   invalidation_flow  = resource.authentik_flow.provider-invalidation.uuid
#   auth_groups        = [authentik_group.media.id]
# }


module "oauth2-grafana" {
  source             = "./oauth2_application"
  name               = "Grafana"
  icon_url           = "https://raw.githubusercontent.com/grafana/grafana/main/public/img/icons/mono/grafana.svg"
  launch_url         = "https://grafana.${var.public_domain}"
  description        = "Infrastructure graphs"
  newtab             = true
  group              = "Infrastructure"
  auth_groups        = [authentik_group.infrastructure.id]
  authorization_flow = resource.authentik_flow.provider-authorization-implicit-consent.uuid
  invalidation_flow  = resource.authentik_flow.provider-invalidation.uuid
  client_id          = module.secret_grafana.fields["GRAFANA_OIDC_CLIENT_ID"]
  client_secret      = module.secret_grafana.fields["GRAFANA_OIDC_CLIENT_SECRET"]
  redirect_uris      = ["https://grafana.${var.public_domain}/login/generic_oauth"]
}

module "oauth2-pgadmin" {
  source             = "./oauth2_application"
  name               = "PGAdmin"
  icon_url           = "https://upload.wikimedia.org/wikipedia/commons/thumb/2/29/Postgresql_elephant.svg/1200px-Postgresql_elephant.svg.png"
  launch_url         = "https://pgadmin.${var.public_domain}"
  description        = "Database"
  newtab             = true
  group              = "Infrastructure"
  auth_groups        = [authentik_group.infrastructure.id]
  authorization_flow = resource.authentik_flow.provider-authorization-implicit-consent.uuid
  invalidation_flow  = resource.authentik_flow.provider-invalidation.uuid
  client_id          = module.secret_pgadmin.fields["PGADMIN_OIDC_CLIENT_ID"]
  client_secret      = module.secret_pgadmin.fields["PGADMIN_OIDC_CLIENT_SECRET"]
  redirect_uris      = ["https://pgadmin.${var.public_domain}/oauth/authorize"]
}

module "oauth2-gatus" {
  source             = "./oauth2_application"
  name               = "Gatus"
  icon_url           = "https://raw.githubusercontent.com/TwiN/gatus/refs/heads/master/web/app/src/assets/logo.svg"
  launch_url         = "https://status.${var.public_domain}"
  description        = "Uptime monitoring"
  newtab             = true
  group              = "Infrastructure"
  auth_groups        = [authentik_group.infrastructure.id]
  authorization_flow = resource.authentik_flow.provider-authorization-implicit-consent.uuid
  invalidation_flow  = resource.authentik_flow.provider-invalidation.uuid
  client_id          = module.secret_gatus.fields["GATUS_OIDC_CLIENT_ID"]
  client_secret      = module.secret_gatus.fields["GATUS_OIDC_CLIENT_SECRET"]
  redirect_uris      = ["https://status.${var.public_domain}/authorization-code/callback"]
}

module "oauth2-headlamp" {
  source             = "./oauth2_application"
  name               = "Headlamp"
  icon_url           = "https://raw.githubusercontent.com/headlamp-k8s/headlamp/refs/heads/main/frontend/src/resources/icon-dark.svg"
  launch_url         = "https://headlamp.${var.public_domain}"
  description        = "K8S Infrastructure"
  newtab             = true
  group              = "Infrastructure"
  auth_groups        = [authentik_group.infrastructure.id]
  authorization_flow = resource.authentik_flow.provider-authorization-implicit-consent.uuid
  invalidation_flow  = resource.authentik_flow.provider-invalidation.uuid
  client_id          = module.secret_headlamp.fields["HEADLAMP_OIDC_CLIENT_ID"]
  client_secret      = module.secret_headlamp.fields["HEADLAMP_OIDC_CLIENT_SECRET"]
  redirect_uris      = ["https://headlamp.${var.public_domain}/login/generic_oauth"]
}


# module "oauth2-immich" {
#   source             = "./oauth2_application"
#   name               = "Immich"
#   icon_url           = "https://github.com/immich-app/immich/raw/main/docs/static/img/favicon.png"
#   launch_url         = "https://photos.${var.public_domain}"
#   description        = "Photo managment"
#   newtab             = true
#   group              = "Selfhosted"
#   auth_groups        = [authentik_group.media.id]
#   authorization_flow = resource.authentik_flow.provider-authorization-implicit-consent.uuid
#   invalidation_flow  = resource.authentik_flow.provider-invalidation.uuid
#   client_id          = module.secret_immich.fields["OIDC_CLIENT_ID"]
#   client_secret      = module.secret_immich.fields["OIDC_CLIENT_SECRET"]
#   redirect_uris = [
#     "https://photos.${var.public_domain}/auth/login",
#     "app.immich:///oauth-callback"
#   ]
# }

# module "oauth2-audiobookshelf" {
#   source             = "./oauth2_application"
#   name               = "Audiobookshelf"
#   icon_url           = "https://raw.githubusercontent.com/advplyr/audiobookshelf-web/master/static/Logo.png"
#   launch_url         = "https://audiobooks.${var.public_domain}"
#   description        = "Media player"
#   newtab             = true
#   group              = "Selfhosted"
#   auth_groups        = [authentik_group.media.id]
#   authorization_flow = resource.authentik_flow.provider-authorization-implicit-consent.uuid
#   invalidation_flow  = resource.authentik_flow.provider-invalidation.uuid
#   client_id          = module.secret_audiobookshelf.fields["OIDC_CLIENT_ID"]
#   client_secret      = module.secret_audiobookshelf.fields["OIDC_CLIENT_SECRET"]
#   redirect_uris      = ["https://audiobooks.${var.public_domain}/auth/openid/callback", "audiobookshelf://oauth"]
# }

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
#   launch_url         = "https://ocis.${var.public_domain}"
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
#     "https://ocis.${var.public_domain}",
#     "https://ocis.${var.public_domain}/oidc-callback.html",
#     "https://ocis.${var.public_domain}/oidc-silent-redirect.html"
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
