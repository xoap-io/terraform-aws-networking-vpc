variable "name" {
  type        = string
  description = "Name of the vpc to create"
}

variable "config" {
  type = object({
    cidr               = string
    dns_support        = bool
    ipv6_support       = bool
    enable_nat_gateway = bool
    nat_gateway_subnet = string
  })
  default = {
    cidr                 = "10.10.0.0/16"
    dns_support          = true
    ipv6_support         = false
    classic_link_support = false
    enable_nat_gateway   = true
    nat_gateway_subnet   = "public"
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
    operation_mode         = string
    transit_gateway_routes = list(string)
    mappings = map(object({
      cidr                 = string
      availability_zone_id = string
      public_ip_on_launch  = bool
      tags                 = map(string)
    }))
  }))
  description = "Flexible subnet mapping option"
}
variable "transit_gateway_id" {
  type        = string
  default     = ""
  description = "ID of the transit gateway to attach the vpc to"
}
variable "transit_gateway_subnet_map" {
  type        = string
  default     = ""
  description = "Subnet mapping for the transit gateway"
}
variable "transit_gateway_routes" {
  type        = list(string)
  default     = []
  description = "Routes to be added to the transit gateway"
}
variable "share_vpc_organisation_wide" {
  type        = bool
  default     = false
  description = "Share the vpc with  organisation"
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
