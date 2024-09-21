# ## Get id(s) for ldap user property mappings related for FreeIPA/RedHat IDM authentik source
# data "authentik_property_mapping_source_ldap" "freeipa_user_property_sources" {
#     managed_list            = [
#         "goauthentik.io/sources/ldap/default-name",
#         "goauthentik.io/sources/ldap/default-mail",
#         "goauthentik.io/sources/ldap/openldap-cn",
#         "goauthentik.io/sources/ldap/openldap-uid"
#     ]
# }
# ## Get id(s) for ldap group propery mappings related for FreeIPA/Redhat IDM authentik source
# data "authentik_property_mapping_source_ldap" "freeipa_group_property_sources" {
#     managed                 = "goauthentik.io/sources/ldap/openldap-cn"
# }

# resource "authentik_source_ldap" "rh_idm" {
#   name = "RedHat IDM"
#   slug = "rh-idm"

#   server_uri              = module.secret_authentik.fields.authentik_ldap_uri
#   bind_cn                 = module.secret_authentik.fields.authentik_ldap_bind
#   bind_password           = module.secret_authentik.fields.authentik_ldap_password
#   base_dn                 = module.secret_authentik.fields.authentik_ldap_base_dn
#   sync_users               = true
#   sync_users_password      = true
#   sync_groups             = true
#   start_tls               = false
#   property_mappings       = data.authentik_property_mapping_source_ldap.freeipa_user_property_sources.ids
#   property_mappings_group = [data.authentik_property_mapping_source_ldap.freeipa_group_property_sources.id]
#   additional_user_dn      = "cn=users,cn=accounts"
#   additional_group_dn     = "cn=groups,cn=accounts"
#   user_object_filter      = "(objectClass=person)"
#   group_object_filter     = "(objectClass=groupofnames)"
#   group_membership_field  = "member"
#   object_uniqueness_field = "ipaUniqueID"

# }