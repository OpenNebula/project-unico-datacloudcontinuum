# Auth

variable "one_user" {
  type        = string
  description = "User account name to authenticate with OpenNebula"
  default     = "oneadmin"
}

variable "ssh_public_key" {
  type = string
  description = "Public SSH key associated to the oneadmin user"
  default = ""
}

variable "one_password" {
  type        = string
  description = "Password for the user account to authenticate with OpenNebula"
}

# Endpoints

variable "oned" {
  type = string
  description = "oned endpoint"
  default = "http://localhost:2633/RPC2"
}

variable "oneflow" {
  type = string
  description = "oneflow endpoint"
  default = "http://localhost:2474"
}

# Content

variable "marketplace" {
  type        = string
  description = "OpenNebula official marketplace endpoint"
  default     = "https://marketplace.opennebula.io/appliance"
}

variable "OneKE_version" {
  type        = string
  description = "Version of the OneKE marketplace appliance"
  default     = "1.29"
}
