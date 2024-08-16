data "cloudflare_zones" "prod" {
  filter {
    name = module.secret_cf.fields.cloudflare_prod_domain
  }
}

data "http" "ipv4" {
  url = "http://ipv4.icanhazip.com"
}

resource "cloudflare_record" "ipv4" {
  name    = module.secret_cf.fields.cloudflare_prod_domain
  zone_id = lookup(data.cloudflare_zones.domain.zones[0], "id")
  value   = chomp(data.http.ipv4.response_body)
  type    = "A"
  ttl     = 120
}

resource "cloudflare_record" "caa" {
  zone_id = lookup(data.cloudflare_zones.domain.zones[0], "id")
  name    = module.secret_cf.fields.cloudflare_prod_domain
  data {
    flags = "0"
    tag   = "issue"
    value = "letsencrypt.org"
  }
  type = "CAA"
  ttl  = 1
}

resource "cloudflare_record" "dkim" {
  zone_id = lookup(data.cloudflare_zones.domain.zones[0], "id")
  name    = "zmail._domainkey"
  value   = "${module.secret_cf.fields.cloudflare_prod_dkim}"
  type    = "TXT"
  ttl     = 1
}

resource "cloudflare_record" "mailmx-1" {
  zone_id  = lookup(data.cloudflare_zones.domain.zones[0], "id")
  name     = module.secret_cf.fields.cloudflare_prod_domain
  value    = "mx.zoho.com"
  type     = "MX"
  priority = 10
  ttl      = 1
}

resource "cloudflare_record" "mailmx-2" {
  zone_id  = lookup(data.cloudflare_zones.domain.zones[0], "id")
  name     = module.secret_cf.fields.cloudflare_prod_domain
  value    = "mx2.zoho.com"
  type     = "MX"
  priority = 20
  ttl      = 1
}

resource "cloudflare_record" "mailmx-3" {
  zone_id  = lookup(data.cloudflare_zones.domain.zones[0], "id")
  name     = module.secret_cf.fields.cloudflare_prod_domain
  value    = "mx3.zoho.com"
  type     = "MX"
  priority = 50
  ttl      = 1
}

resource "cloudflare_record" "txt_spf" {
  zone_id = lookup(data.cloudflare_zones.domain.zones[0], "id")
  name    = module.secret_cf.fields.cloudflare_prod_domain
  value   = "${module.secret_cf.fields.cloudflare_prod_spf}"
  type    = "TXT"
  ttl     = 1
}

resource "cloudflare_record" "txt_dmarc" {
  zone_id = lookup(data.cloudflare_zones.domain.zones[0], "id")
  name    = module.secret_cf.fields.cloudflare_prod_domain
  value   = "${module.secret_cf.fields.cloudflare_prod_dmarc}"
  type    = "TXT"
  ttl     = 1
}
