data "authentik_group" "admins" {
  name = "authentik Admins"
}

data "authentik_user" "user" {
  username = "akadmin"
}

resource "authentik_group" "users" {
  name         = "users"
  is_superuser = false
}

resource "authentik_group" "media" {
  name         = "media"
  is_superuser = false
}

resource "authentik_group" "family" {
  name         = "family"
  is_superuser = false
  parent       = resource.authentik_group.users.id
  attributes = jsonencode({
    defaultQuota = "500 GB"
  })
}

resource "authentik_group" "infrastructure" {
  name         = "infrastructure"
  is_superuser = false
  users        = [
    data.authentik_user.user.id
  ]
}

data "authentik_group" "media" {
  name = "media"
}

data "authentik_group" "infrastructure" {
  name = "infrastructure"
}

resource "authentik_user" "sysadmin" {
  username = module.secret_authentik.fields["SYSADMIN_USERNAME"]
  name     = module.secret_authentik.fields["SYSADMIN_NAME"]
  email    = module.secret_authentik.fields["SYSADMIN_EMAIL"]
  password = module.secret_authentik.fields["SYSADMIN_PASSWORD"]
  groups   = [
    data.authentik_group.admins.id,
    data.authentik_group.infrastructure.id
  ]
}

