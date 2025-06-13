data "authentik_group" "admins" {
  name = "authentik Admins"
}

data "authentik_user" "user" {
  username = "akadmin"
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
  attributes = jsonencode({
    defaultQuota = "5 GB"
  })
}

resource "authentik_group" "infrastructure" {
  name         = "infrastructure"
  is_superuser = false
  users        = [data.authentik_user.user.id]
}
