variable "onepassword_host" {
  type = string
  description = "1password connect host"
  sensitive = true
  default = null
}

variable "onepassword_token" {
  type = string
  description = "1password connect token"
  sensitive = true
  default = null
}
