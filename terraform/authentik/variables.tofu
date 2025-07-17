variable "public_domain" {
  type    = string
  default = "monosense.dev"
}

variable "private_domain" {
  type    = string
  default = "monosense.dev"
}

variable "OP_CONNECT_HOST" {
  type        = string
  description = "Onepass Connect URL"
}

variable "OP_CONNECT_TOKEN" {
  type        = string
  description = "The path to the service account JSON for OnePassword."
  sensitive   = true
  default     = null
}
