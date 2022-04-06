module "this_label_route_table" {
  source     = "git::github.com/xoap-io/terraform-aws-misc-label?ref=v0.1.0"
  context    = var.context
  attributes = ["rt", var.name, "vpc", var.vpc_id]
}
resource "aws_route_table" "this" {
  vpc_id = var.vpc_id
  tags = merge(var.tags,
    {
      "Name" = module.this_label_route_table.id,
      "VPC"  = var.vpc_id
  })
}
module "this_label_igw" {
  source     = "git::github.com/xoap-io/terraform-aws-misc-label?ref=v0.1.0"
  context    = var.context
  attributes = ["igw", var.name, "vpc", var.vpc_id]
}
resource "aws_internet_gateway" "this" {
  for_each = var.operation_mode == "public" ? [1] : []
  vpc_id   = var.vpc_id
  tags = merge(var.tags,
    {
      "Name" = module.this_label_igw.id
    }
  )
}
module "this_label_nat_gateway" {
  source     = "git::github.com/xoap-io/terraform-aws-misc-label?ref=v0.1.0"
  context    = var.context
  attributes = ["nat", var.name, "vpc", var.vpc_id]
}
resource "aws_eip" "this" {
  for_each = var.operation_mode == "nat" ? [1] : []
  vpc      = true
  tags = merge(
    {
      "Name" = module.this_label_nat_gateway.id
    },
    var.tags
  )
}

resource "aws_nat_gateway" "this" {
  for_each      = var.operation_mode == "nat" ? [1] : []
  allocation_id = aws_eip.this.allocation_id
  subnet_id     = ""
  tags = merge(var.tags,
    {
      "Name" = module.this_label_nat_gateway.id
    }
  )
  depends_on = [aws_internet_gateway.this]
}
resource "aws_route" "this" {
  for_each               = var.operation_mode != "not_routed" ? [1] : []
  route_table_id         = aws_route_table.this.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.operation_mode == "public" ? join("", aws_internet_gateway.this.*.id) : null
  nat_gateway_id         = var.operation_mode == "nat" ? join("", aws_nat_gateway.this.*.id) : null
  timeouts {
    create = "5m"
  }
}
resource "aws_route" "this_v6" {
  for_each                    = var.operation_mode != "not_routed" && var.enable_ipv6 ? [1] : []
  route_table_id              = aws_route_table.this.id
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = var.operation_mode == "public" ? join("", aws_internet_gateway.this.*.id) : null
}
module "this_label_subnet" {
  for_each   = var.subnet_mappings
  source     = "git::github.com/xoap-io/terraform-aws-misc-label?ref=v0.1.0"
  context    = var.context
  attributes = ["vpc", var.vpc_id, "subnet", var.name, each.key]
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
