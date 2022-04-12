output "subnets" {
  value = {
    for k, v in var.subnet_mappings : k => aws_subnet.this[k]
  }
  description = "Map of  aws_subnet according to https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet"
}
output "all_subnet_ids" {
  value       = [for v in aws_subnet.this : v.id]
  description = "List of all ids from created subnets"
}
output "all_subnet_arn" {
  value       = [for v in aws_subnet.this : v.arn]
  description = "List of all arns from created subnets"
}
output "route_table" {
  value       = aws_route_table.this
  description = "Output from resource aws_internet_gateway according to https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway"
}
output "operation_mode" {
  value       = var.operation_mode
  description = "Operational mode same value as input variable 'operation_mode'"
}
