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
output "subnet_cidrs" {
  value = distinct(flatten([
    for k, v in module.this_subnets : [
      for sn in v.subnets : sn.cidr_block
    ]
  ]))
  description = "list of all associated subnet cidrs"
}
output "subnet_ids" {
  value = {
    for k, v in module.this_subnets : k => v.all_subnet_ids
  }
  description = "map of output from resource aws_subnet according to https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet"
}
output "internet_gateway" {
  value       = aws_internet_gateway.this
  description = "Output from resource aws_internet_gateway according to https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway"
}
output "nat_gateway" {
  value       = aws_nat_gateway.this
  description = "Output from resource aws_nat_gateway according to https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway"
}


output "aws_ec2_transit_gateway_vpc_attachment" {
  value       = aws_ec2_transit_gateway_vpc_attachment.this
  description = "output from resource aws_ec2_transit_gateway_vpc_attachment according to https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_vpc_attachment"
}


output "transit_gateway_routes" {
  value = var.transit_gateway_id != "" ? distinct(flatten([
    for k, v in module.this_subnets : [
      for sn in v.subnets : {
        route       = sn.cidr_block
        attachement = join("", aws_ec2_transit_gateway_vpc_attachment.this.*.id, )
      }
    ]
  ])) : []

  description = "map of output from resource aws_subnet according to https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet"
}


output "temp" {
  value = local.all_non_public_subnet_ids
}