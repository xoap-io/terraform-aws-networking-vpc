output "context" {
  value       = var.context
  description = "Exported context from input variable"
}
output "vpc" {
  value       = aws_vpc.this
  description = "Map of  aws_vpc according to https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc"
}
output "route_tables" {
  value = {
    for k, v in module.this_subnets : k => v.route_table
  }
  description = "map of output from resource aws_route_table according to https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table"
}
output "subnets" {
  value = {
    for k, v in module.this_subnets : k => v.subnets
  }
  description = "map of output from resource aws_subnet according to https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet"
}
output "internet_gateways" {
  value = {
    for k, v in module.this_subnets : k => v.internet_gateway
  }
  description = "map of output from resource aws_internet_gateway according to https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway"
}
output "nat_gateways" {
  value = {
    for k, v in module.this_subnets : k => v.nat_gateway
  }
  description = "map of output from resource aws_nat_gateway according to https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway"
}
