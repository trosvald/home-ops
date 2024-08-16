data "authentik_group" "admins" {
  name = "authentik Admins"
}

resource "authentik_source_ldap" "rh_idm" {
  name = "rh-idm"
  slug = "rh-idm"

  server_uri              = module.secret_authentik.fields.authentik_ldap_uri
  bind_cn                 = module.secret_authentik.fields.authentik_ldap_bind
  bind_password           = module.secret_authentik.fields.authentik_ldap_password
  base_dn                 = module.secret_authentik.fields.authentik_ldap_base_dn
  #sync_user               = true
  #sync_user_password      = true
  #sync_groups             = true
  start_tls               = false
  property_mappings       = [
    "authentik default LDAP Mapping: mail",
    "authentik default LDAP Mapping: Name",
    "authentik default OpenLDAP Mapping: cn",
    "authentik default OpenLDAP Mapping: uid"
  ]
  property_mappings_group = ["authentik default OpenLDAP: cn"]
  additional_user_dn      = "cn=user,cn=accounts"
  additional_group_dn     = "cn=groups,cn=accounts"
  user_object_filter      = "(objectClass=person)"
  group_object_filter     = "(objectClass=groupofnames)"
  group_membership_field  = "member"
  object_uniqueness_field = "ipaUniqueID"

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
