module "proxy-transmission" {
  source             = "./proxy_application"
  name               = "Transmission"
  description        = "Torrent client"
  icon_url           = "https://github.com/transmission/transmission/raw/main/web/assets/img/logo.png"
  group              = "Downloads"
  slug               = "qb"
  domain             = module.secret_authentik.fields["AUTHENTIK_CLUSTER_DOMAIN"]
  authorization_flow  = resource.authentik_flow.provider-authorization-implicit-consent.uuid
  invalidation_flow   = resource.authentik_flow.provider-invalidation.uuid
  auth_groups        = [authentik_group.media.id]
}

module "proxy-pinchflat" {
  source             = "./proxy_application"
  name               = "Pinchflat"
  description        = "YouTube Donwloader"
  icon_url           = "https://cdn.monosense.io/branding/yt.png"
  group              = "Downloads"
  slug               = "pinchflat"
  domain             = module.secret_authentik.fields["AUTHENTIK_CLUSTER_DOMAIN"]
  authorization_flow  = resource.authentik_flow.provider-authorization-implicit-consent.uuid
  invalidation_flow   = resource.authentik_flow.provider-invalidation.uuid
  auth_groups        = [authentik_group.media.id]
}

module "proxy-prowlarr" {
  source             = "./proxy_application"
  name               = "Prowlarr"
  description        = "Torrent indexer"
  icon_url           = "https://raw.githubusercontent.com/Prowlarr/Prowlarr/develop/Logo/128.png"
  group              = "Downloads"
  slug               = "prowlarr"
  domain             = module.secret_authentik.fields["AUTHENTIK_CLUSTER_DOMAIN"]
  authorization_flow  = resource.authentik_flow.provider-authorization-implicit-consent.uuid
  invalidation_flow   = resource.authentik_flow.provider-invalidation.uuid
  auth_groups        = [authentik_group.media.id]
}

module "proxy-radarr" {
  source             = "./proxy_application"
  name               = "Radarr"
  description        = "Movies"
  icon_url           = "https://github.com/Radarr/Radarr/raw/develop/Logo/128.png"
  group              = "Downloads"
  slug               = "radarr"
  domain             = module.secret_authentik.fields["AUTHENTIK_CLUSTER_DOMAIN"]
  authorization_flow  = resource.authentik_flow.provider-authorization-implicit-consent.uuid
  invalidation_flow   = resource.authentik_flow.provider-invalidation.uuid
  auth_groups        = [authentik_group.media.id]
}

module "proxy-sonarr" {
  source             = "./proxy_application"
  name               = "Sonarr"
  description        = "TV"
  icon_url           = "https://github.com/Sonarr/Sonarr/raw/develop/Logo/128.png"
  group              = "Downloads"
  slug               = "sonarr"
  domain             = module.secret_authentik.fields["AUTHENTIK_CLUSTER_DOMAIN"]
  authorization_flow  = resource.authentik_flow.provider-authorization-implicit-consent.uuid
  invalidation_flow   = resource.authentik_flow.provider-invalidation.uuid
  auth_groups        = [authentik_group.media.id]
}

module "proxy-bazarr" {
  source             = "./proxy_application"
  name               = "Bazarr"
  description        = "Subtitles"
  icon_url           = "https://github.com/morpheus65535/bazarr/raw/master/frontend/public/images/logo128.png"
  group              = "Downloads"
  slug               = "bazarr"
  domain             = module.secret_authentik.fields["AUTHENTIK_CLUSTER_DOMAIN"]
  authorization_flow  = resource.authentik_flow.provider-authorization-implicit-consent.uuid
  invalidation_flow   = resource.authentik_flow.provider-invalidation.uuid
  auth_groups        = [authentik_group.media.id]
}

module "proxy-lidarr" {
  source             = "./proxy_application"
  name               = "Lidarr"
  description        = "Music"
  icon_url           = "https://github.com/Lidarr/Lidarr/raw/develop/Logo/128.png"
  group              = "Downloads"
  slug               = "music"
  domain             = module.secret_authentik.fields["AUTHENTIK_CLUSTER_DOMAIN"]
  authorization_flow  = resource.authentik_flow.provider-authorization-implicit-consent.uuid
  invalidation_flow   = resource.authentik_flow.provider-invalidation.uuid
  auth_groups        = [authentik_group.media.id]
}


## UNUSED PROXY
# module "proxy-navidrome" {
#   source             = "./proxy_application"
#   name               = "Navidrome"
#   description        = "Music player"
#   icon_url           = "https://github.com/navidrome/navidrome/raw/master/resources/logo-192x192.png"
#   group              = "Selfhosted"
#   slug               = "navidrome"
#   domain             = module.secret_authentik.fields["AUTHENTIK_CLUSTER_DOMAIN"]
#   authorization_flow = resource.authentik_flow.provider-authorization-implicit-consent.uuid
#   auth_groups        = [authentik_group.media.id]
#   ignore_paths       = <<-EOT
#   /rest/*
#   /share/*
#   EOT
# }

# module "proxy-homepage" {
#   source             = "./proxy_application"
#   name               = "Home"
#   description        = "Homepage"
#   icon_url           = "https://raw.githubusercontent.com/gethomepage/homepage/main/public/android-chrome-192x192.png"
#   group              = "Selfhosted"
#   slug               = "home"
#   domain             = module.secret_authentik.fields["AUTHENTIK_CLUSTER_DOMAIN"]
#   authorization_flow = resource.authentik_flow.provider-authorization-implicit-consent.uuid
#   auth_groups        = [authentik_group.users.id]
# }

module "oauth2-gitlab" {
  source             = "./oauth2_application"
  name               = "GitLab"
  icon_url           = "https://cdn.monosense.io/branding/gitlab.png"
  launch_url         = "https://gitlab.${module.secret_authentik.fields["AUTHENTIK_CLUSTER_DOMAIN"]}"
  description        = "Private SCM"
  newtab             = true
  group              = "Developers"
  sub_mode           = "user_email"
  auth_groups        = [authentik_group.developers.id]
  authorization_flow  = resource.authentik_flow.provider-authorization-implicit-consent.uuid
  invalidation_flow   = resource.authentik_flow.provider-invalidation.uuid
  client_id          = module.secret_gitlab.fields["GITLAB_OIDC_CLIENT_ID"]
  client_secret      = module.secret_gitlab.fields["GITLAB_OIDC_CLIENT_SECRET"]
  redirect_uris      = ["https://gitlab.${module.secret_authentik.fields["AUTHENTIK_CLUSTER_DOMAIN"]}/users/auth/openid_connect/callback"]
}

# module "oauth2-synapse" {
#   source             = "./oauth2_application"
#   name               = "Synapse"
#   icon_url           = "https://cdn.monosense.io/branding/element250.png"
#   launch_url         = "https://matrix.${module.secret_authentik.fields["AUTHENTIK_CLUSTER_DOMAIN"]}"
#   description        = "Messaging"
#   newtab             = true
#   group              = "Selfhosted"
#   auth_groups        = [authentik_group.users.id]
#   authorization_flow  = resource.authentik_flow.provider-authorization-implicit-consent.uuid
#   invalidation_flow   = resource.authentik_flow.provider-invalidation.uuid
#   client_id          = module.secret_synapse.fields["SYNAPSE_OIDC_CLIENT_ID"]
#   client_secret      = module.secret_synapse.fields["SYNAPSE_OIDC_CLIENT_SECRET"]
#   redirect_uris      = ["https://matrix.${module.secret_authentik.fields["AUTHENTIK_CLUSTER_DOMAIN"]}/_synapse/client/oidc/callback"]
# }

module "oauth2-grafana" {
  source             = "./oauth2_application"
  name               = "Grafana"
  icon_url           = "https://raw.githubusercontent.com/grafana/grafana/main/public/img/icons/mono/grafana.svg"
  launch_url         = "https://grafana.${module.secret_authentik.fields["AUTHENTIK_CLUSTER_DOMAIN"]}"
  description        = "Infrastructure monitoring"
  newtab             = true
  group              = "Infrastructure"
  auth_groups        = [authentik_group.infrastructure.id]
  authorization_flow  = resource.authentik_flow.provider-authorization-implicit-consent.uuid
  invalidation_flow   = resource.authentik_flow.provider-invalidation.uuid
  client_id          = module.secret_grafana.fields["GRAFANA_OIDC_CLIENT_ID"]
  client_secret      = module.secret_grafana.fields["GRAFANA_OIDC_CLIENT_SECRET"]
  redirect_uris      = ["https://grafana.${module.secret_authentik.fields["AUTHENTIK_CLUSTER_DOMAIN"]}/login/generic_oauth"]
}

module "oauth2-gatus" {
  source             = "./oauth2_application"
  name               = "Gatus"
  icon_url           = "https://gatus.io/img/logo-with-light-text.svg"
  launch_url         = "https://status.${module.secret_authentik.fields["AUTHENTIK_CLUSTER_DOMAIN"]}"
  description        = "Uptime Monitor"
  newtab             = true
  group              = "Infrastructure"
  auth_groups        = [authentik_group.infrastructure.id]
  authorization_flow  = resource.authentik_flow.provider-authorization-implicit-consent.uuid
  invalidation_flow   = resource.authentik_flow.provider-invalidation.uuid
  client_id          = module.secret_gatus.fields["GATUS_OIDC_CLIENT_ID"]
  client_secret      = module.secret_gatus.fields["GATUS_OIDC_CLIENT_SECRET"]
  redirect_uris      = ["https://status.${module.secret_authentik.fields["AUTHENTIK_CLUSTER_DOMAIN"]}/authorization-code/callback"]
}


module "oauth2-ocis" {
  source             = "./oauth2_application"
  name               = "Owncloud"
  icon_url           = "https://raw.githubusercontent.com/owncloud/owncloud.github.io/main/static/favicon/favicon.png"
  launch_url         = "https://files.monosense.io"
  description        = "Files"
  newtab             = true
  group              = "Selfhosted"
  auth_groups        = [authentik_group.users.id]
  client_type        = "public"
  authorization_flow  = resource.authentik_flow.provider-authorization-implicit-consent.uuid
  invalidation_flow   = resource.authentik_flow.provider-invalidation.uuid
  client_id          = module.secret_ocis.fields["OCIS_OIDC_CLIENT_ID"]
  # additional_property_mappings = formatlist(authentik_scope_mapping.openid-nextcloud.id)
  redirect_uris = [
    "https://files.monosense.io",
    "https://files.monosense.io/oidc-callback.html",
    "https://files.monosense.io/oidc-silent-redirect.html"
  ]
}

module "oauth2-ocis-android" {
  source             = "./oauth2_application"
  name               = "Owncloud-android"
  launch_url         = "blank://blank"
  auth_groups        = [authentik_group.users.id]
  authorization_flow  = resource.authentik_flow.provider-authorization-implicit-consent.uuid
  invalidation_flow   = resource.authentik_flow.provider-invalidation.uuid
  client_id          = "e4rAsNUSIUs0lF4nbv9FmCeUkTlV9GdgTLDH1b5uie7syb90SzEVrbN7HIpmWJeD"
  client_secret      = "dInFYGV33xKzhbRmpqQltYNdfLdJIfJ9L5ISoKhNoT9qZftpdWSP71VrpGR9pmoD"
  redirect_uris      = ["oc://android.owncloud.com", ]
}

module "oauth2-ocis-desktop" {
  source             = "./oauth2_application"
  name               = "owncloud-desktop"
  launch_url         = "blank://blank"
  auth_groups        = [authentik_group.users.id]
  authorization_flow  = resource.authentik_flow.provider-authorization-implicit-consent.uuid
  invalidation_flow   = resource.authentik_flow.provider-invalidation.uuid
  client_id          = "xdXOt13JKxym1B1QcEncf2XDkLAexMBFwiT9j6EfhhHFJhs2KM9jbjTmf8JBXE69"
  client_secret      = "UBntmLjC2yYCeHwsyj73Uwo9TAaecAetRwMw0xYcvNL9yRdLSUi0hUAHfvCHFeFh"
  redirect_uris = [
    { matching_mode = "regex", url = "http://127.0.0.1(:.*)?" },
    { matching_mode = "regex", url = "http://localhost(:.*)?"}
  ]
}

# module "oauth2-paperless" {
#   source             = "./oauth2_application"
#   name               = "Paperless"
#   icon_url           = "https://raw.githubusercontent.com/paperless-ngx/paperless-ngx/dev/resources/logo/web/svg/Color%20logo%20-%20no%20background.svg"
#   launch_url         = "https://arsip.monosense.io"
#   description        = "Arsip"
#   newtab             = true
#   group              = "Selfhosted"
#   auth_groups        = [authentik_group.infrastructure.id]
#   authorization_flow = resource.authentik_flow.provider-authorization-implicit-consent.uuid
#   client_id          = module.secret_paperless.fields["paperless_oidc_client_id"]
#   client_secret      = module.secret_paperless.fields["paperless_oidc_client_secret"]
#   redirect_uris      = ["https://arsip.monosense.io/accounts/oidc/authentik/login/callback/"]
# }

# module "oauth2-kyoo" {
#   source             = "./oauth2_application"
#   name               = "Kyoo"
#   icon_url           = "https://raw.githubusercontent.com/zoriya/Kyoo/master/icons/icon-256x256.png"
#   launch_url         = "https://kyoo.monosense.io"
#   description        = "Movies"
#   newtab             = true
#   group              = "Selfhosted"
#   auth_groups        = [authentik_group.users.id]
#   authorization_flow = resource.authentik_flow.provider-authorization-implicit-consent.uuid
#   client_id          = module.secret_kyoo.fields["OIDC_CLIENT_ID"]
#   client_secret      = module.secret_kyoo.fields["OIDC_CLIENT_SECRET"]
#   redirect_uris      = ["https://kyoo.monosense.io/api/auth/logged/authentik"]
# }
