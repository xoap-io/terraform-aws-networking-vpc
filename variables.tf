variable "name" {
  type        = string
  description = "Name of the vpc to create"
}
variable "kms_id" {
  type        = string
  description = "Name of the kms key to use for encryption of flow logs"
}
variable "config" {
  type = object({
    cidr                 = string
    dns_support          = bool
    ipv6_support         = bool
    classic_link_support = bool
  })
  default = {
    cidr                 = "10.10.0.0/16"
    dns_support          = true
    ipv6_support         = false
    classic_link_support = false
  }
  description = "Configuration parameters for the vpc. Per default the vpc is provisioned with the subnet cidr 10.10.0.0.0/16 and full dns support"
}
variable "dhcp_options" {
  type = object({
    domain_name          = string
    domain_name_servers  = list(string)
    ntp_servers          = list(string)
    netbios_name_servers = list(string)
    netbios_node_type    = string
  })
  default     = null
  description = "Configuration parameters for dhcp. Per default this features are disabled"
}
variable "subnets" {
  type = map(object({
    operation_mode = string
    mappings = map(object({
      cidr                 = string
      availability_zone_id = string
      public_ip_on_launch  = bool
      tags                 = map(string)
    }))
  }))
  description = "Flexible subnet mapping option"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A list of tags to add"
}
variable "context" {
  type = object({
    organization = string
    environment  = string
    account      = string
    product      = string
    tags         = map(string)
  })
  description = "Default context for naming and tagging purpose"
}
