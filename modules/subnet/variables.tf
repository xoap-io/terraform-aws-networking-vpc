variable "name" {
  type        = string
  description = "Base name of the subnets to create"
}
variable "vpc_id" {
  type        = string
  description = "Id of the vpc to attach these subnets to"
}
variable "operation_mode" {
  type        = string
  description = "Operation mode of the subnets. Can be nat, not_routed or public"
  validation {
    condition     = contains(["nat", "not_routed", "public"], var.operation_mode)
    error_message = "Valid values for var: operation_mode are nat, not_routed, public"
  }
}
variable "enable_ipv6" {
  type        = bool
  description = "Adds support for ipv6"
}
variable "subnet_mappings" {
  type = map(object({
    cidr                 = string
    availability_zone_id = string
    public_ip_on_launch  = bool
    tags                 = map(string)
  }))
  description = "Mapping for subnet creation"
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
