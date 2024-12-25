data "authentik_group" "admins" {
  name = "authentik Admins"
}

resource "authentik_group" "superusers" {
  name         = "superusers"
  is_superuser = true
}

resource "authentik_group" "users" {
  name         = "users"
  is_superuser = false
}

resource "authentik_group" "external" {
  name         = "external"
  is_superuser = false
}

resource "authentik_group" "developers" {
  name         = "developers"
  is_superuser = false
}

resource "authentik_group" "media" {
  name         = "media"
  is_superuser = false
  parent       = resource.authentik_group.users.id
}

resource "authentik_group" "nextcloud" {
  name         = "nextcloud"
  is_superuser = false
  parent       = resource.authentik_group.users.id
  attributes = jsonencode({
    defaultQuota = "100 GB"
  })
}

resource "authentik_group" "infrastructure" {
  name         = "infrastructure"
  is_superuser = false
}

# Create user
resource "authentik_user" "monosense" {
  username = module.secret_authentik.fields.AUTHENTIK_ORG_USER
  name     = module.secret_authentik.fields.AUTHENTIK_ORG_USER_FULL
  password = module.secret_authentik.fields.AUTHENTIK_ORG_USER_PASSWORD
  email    = module.secret_authentik.fields.AUTHENTIK_ORG_USER_EMAIL
  groups   = [
    authentik_group.superusers.id,
    authentik_group.media.id,
    authentik_group.infrastructure.id,
    authentik_group.nextcloud.id,
    authentik_group.developers.id
  ]
}

resource "authentik_user" "trosvald" {
  username = module.secret_authentik.fields.AUTHENTIK_DEV_USER
  name     = module.secret_authentik.fields.AUTHENTIK_ORG_USER_FULL
  password = module.secret_authentik.fields.AUTHENTIK_DEV_PASSWORD
  email    = module.secret_authentik.fields.AUTHENTIK_DEV_EMAIL
  groups    = [
    authentik_group.superusers.id,
    authentik_group.media.id,
    authentik_group.infrastructure.id,
    authentik_group.nextcloud.id,
    authentik_group.developers.id
  ]
}
