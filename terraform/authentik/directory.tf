data "authentik_group" "admins" {
  name = "authentik Admins"
}

resource "authentik_group" "superusers" {
  name = "superusers"
}

resource "authentik_group" "users" {
  name         = "users"
  is_superuser = false
}

resource "authentik_group" "media" {
  name         = "media"
  is_superuser = false
  parent       = resource.authentik_group.users.id
}

resource "authentik_group" "employee" {
  name         = "nextcloud"
  is_superuser = false
  parent       = resource.authentik_group.users.id
  attributes = jsonencode({
    defaultQuota = "20 GB"
  })
}

resource "authentik_group" "infrastructure" {
  name         = "infrastructure"
  is_superuser = false
}

#
# Users (Directory resources)
# https://registry.terraform.io/providers/goauthentik/authentik/latest/docs/resources/user
#
resource "authentik_user" "orguser" {
  username  = module.secret_authentik.fields["authentik_org_user"]
  name      = module.secret_authentik.fields["authentik_org_user_full"]
  email     = module.secret_authentik.fields["authentik_org_user_email"]
}

resource "authentik_group" "administrator" {
  name          = "administrator"
  users         = [authentik_user.orguser.id]
  is_superuser  = true
}


