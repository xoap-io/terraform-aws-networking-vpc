module "this_label_route_table" {
  source     = "git::github.com/xoap-io/terraform-aws-misc-label?ref=v0.1.0"
  context    = var.context
  attributes = ["rt", var.name, var.vpc_id]
}
resource "aws_route_table" "this" {
  vpc_id = var.vpc_id
  tags = merge(var.tags,
    {
      "Name" = module.this_label_route_table.id,
      "vpc"  = var.vpc_id
  })
}
module "this_label_igw" {
  source     = "git::github.com/xoap-io/terraform-aws-misc-label?ref=v0.1.0"
  context    = var.context
  attributes = ["igw", var.name, var.vpc_id]
}


resource "aws_route" "this" {
  count                  = var.operation_mode != "not_routed" && var.operation_mode != "database" ? 1 : 0
  route_table_id         = aws_route_table.this.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.operation_mode == "public" ? var.internet_gateway_id : null
  nat_gateway_id         = var.operation_mode == "nat" ? var.nat_gateway_id : null
  timeouts {
    create = "5m"
  }
}

resource "aws_route" "transit" {
  for_each               = var.transit_gateway_id != "" ? toset(var.transit_gateway_routes) : []
  route_table_id         = aws_route_table.this.id
  destination_cidr_block = each.key
  transit_gateway_id     = var.transit_gateway_id
}

module "this_label_subnet" {
  for_each   = var.subnet_mappings
  source     = "git::github.com/xoap-io/terraform-aws-misc-label?ref=v0.1.0"
  context    = var.context
  attributes = [var.vpc_id, var.name, each.key]
}
resource "aws_subnet" "this" {
  for_each                = var.subnet_mappings
  vpc_id                  = var.vpc_id
  availability_zone_id    = each.value.availability_zone_id
  cidr_block              = each.value.cidr
  map_public_ip_on_launch = each.value.public_ip_on_launch
  tags = merge(var.tags, each.value.tags, {
    Name = module.this_label_subnet[each.key].id
  })
}

resource "aws_route_table_association" "this" {
  for_each       = var.subnet_mappings
  subnet_id      = aws_subnet.this[each.key].id
  route_table_id = aws_route_table.this.id
}
resource "aws_db_subnet_group" "this" {
  count       = var.operation_mode == "database" ? 1 : 0
  description = "Database subnet group for ${var.name}"
  subnet_ids  = [for k, v in aws_subnet.this : v.id]
}
