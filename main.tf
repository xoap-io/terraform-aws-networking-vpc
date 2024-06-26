data "aws_region" "this" {}
module "this_label" {
  source     = "git::github.com/xoap-io/terraform-aws-misc-label?ref=v0.1.1"
  context    = var.context
  attributes = ["vpc", var.name]
}

resource "aws_vpc" "this" {
  cidr_block                       = var.config.cidr
  enable_dns_hostnames             = var.config.dns_support
  enable_dns_support               = var.config.dns_support
  assign_generated_ipv6_cidr_block = var.config.ipv6_support

  tags = merge(var.tags,
    {
      "Name" = module.this_label.id
  })
}
resource "aws_default_security_group" "this" {
  vpc_id = aws_vpc.this.id
  tags = merge(var.tags,
    {
      "Name" = module.this_label.id
    }
  )
}
resource "aws_vpc_dhcp_options" "this" {
  count                = var.dhcp_options != null ? 1 : 0
  domain_name          = var.dhcp_options.domain_name
  domain_name_servers  = var.dhcp_options.domain_name_servers
  ntp_servers          = var.dhcp_options.ntp_servers
  netbios_name_servers = var.dhcp_options.netbios_name_servers
  netbios_node_type    = var.dhcp_options.netbios_node_type

  tags = merge(
    { "Name" = module.this_label.id },
    var.tags,
  )
}

resource "aws_vpc_dhcp_options_association" "this" {
  count           = var.dhcp_options != null ? 1 : 0
  vpc_id          = aws_vpc.this.id
  dhcp_options_id = join("", aws_vpc_dhcp_options.this[*].id)
}

module "this_subnets" {
  for_each               = var.subnets
  source                 = "./modules/subnet"
  context                = var.context
  enable_ipv6            = var.config.ipv6_support
  name                   = each.key
  operation_mode         = each.value.operation_mode
  subnet_mappings        = each.value.mappings
  vpc_id                 = aws_vpc.this.id
  transit_gateway_id     = var.transit_gateway_id
  transit_gateway_routes = concat(var.transit_gateway_routes, each.value.transit_gateway_routes)
  depends_on             = [aws_vpc.this]
}

resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  count                                           = var.transit_gateway_id != "" ? 1 : 0
  subnet_ids                                      = module.this_subnets[var.transit_gateway_subnet_map].all_subnet_ids
  transit_gateway_id                              = var.transit_gateway_id
  vpc_id                                          = aws_vpc.this.id
  transit_gateway_default_route_table_association = true
  transit_gateway_default_route_table_propagation = true
  tags = merge(
    { "Name" = module.this_label.id },
    var.tags,
  )
}
data "aws_organizations_organization" "this" {
  count = var.share_vpc_organisation_wide == true ? 1 : 0
}

resource "aws_ram_resource_share" "this" {
  count                     = var.share_vpc_organisation_wide == true ? 1 : 0
  name                      = module.this_label.id
  allow_external_principals = false
}

resource "aws_ram_resource_association" "this" {
  for_each           = var.share_vpc_organisation_wide == true ? toset(flatten([for k, v in module.this_subnets : v.all_subnet_arn])) : []
  resource_arn       = each.key
  resource_share_arn = aws_ram_resource_share.this[0].id
}

resource "aws_ram_principal_association" "this" {
  count              = var.share_vpc_organisation_wide == true ? 1 : 0
  principal          = data.aws_organizations_organization.this[0].arn
  resource_share_arn = aws_ram_resource_share.this[0].id
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = merge(var.tags,
    {
      "Name" = module.this_label.id
    }
  )
}

resource "aws_eip" "this" {
  count = var.config.enable_nat_gateway ? 1 : 0
  vpc   = true
  tags = merge(
    {
      "Name" = module.this_label.id
    },
    var.tags
  )
}

resource "aws_nat_gateway" "this" {
  count         = var.config.enable_nat_gateway ? 1 : 0
  allocation_id = aws_eip.this[0].allocation_id
  subnet_id     = module.this_subnets[var.config.nat_gateway_subnet].all_subnet_ids[0]
  tags = merge(var.tags,
    {
      "Name" = module.this_label.id
    }
  )
  depends_on = [aws_internet_gateway.this]
}

resource "aws_route" "igw" {
  for_each               = { for k, v in var.subnets : k => {} if v.operation_mode == "public" }
  route_table_id         = module.this_subnets[each.key].route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
  timeouts {
    create = "5m"
  }
}
resource "aws_route" "nat" {
  for_each               = { for k, v in var.subnets : k => {} if v.operation_mode == "nat" && var.config.enable_nat_gateway }
  route_table_id         = module.this_subnets[each.key].route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = join("", aws_nat_gateway.this.*.id)
  timeouts {
    create = "5m"
  }
}
module "sg_endpoints" {
  source             = "git::github.com/xoap-io/terraform-aws-compute-security-group.git"
  context            = var.context
  name               = "aws_endpoints"
  description        = "Security group for aws endpoints in vpc ${aws_vpc.this.id}"
  allow_self_ingress = true
  vpc_id             = aws_vpc.this.id
  ingress = {
    ingress = {
      from        = 0
      to          = 0
      protocol    = "-1"
      cidr_blocks = [aws_vpc.this.cidr_block]
    }
  }
  egress = {
    allow_any = {
      from        = 0
      to          = 0
      protocol    = "-1"
      cidr_blocks = [aws_vpc.this.cidr_block]
    }
  }
}
locals {
  routes_services           = toset(["ecr.dkr", "ecr.api"])
  all_non_public_subnet_ids = setproduct(flatten([for k, v in module.this_subnets : v.all_subnet_ids if v.operation_mode != "public"]), [for k, v in aws_vpc_endpoint.this : v.id])
}
resource "aws_vpc_endpoint" "this" {
  for_each            = local.routes_services
  private_dns_enabled = true
  service_name        = join(".", ["com.amazonaws", data.aws_region.this.name, each.key])
  vpc_endpoint_type   = "Interface"
  vpc_id              = aws_vpc.this.id

  security_group_ids = [
    module.sg_endpoints.aws_security_group.id
  ]
  subnet_ids = module.this_subnets["public"].all_subnet_ids
}
resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.this.id
  service_name      = "com.amazonaws.${data.aws_region.this.name}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [for k, v in module.this_subnets : v.route_table.id if v.operation_mode != "public"]
}
resource "aws_vpc_endpoint" "dynamodb" {
  vpc_id            = aws_vpc.this.id
  service_name      = "com.amazonaws.${data.aws_region.this.name}.dynamodb"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [for k, v in module.this_subnets : v.route_table.id if v.operation_mode != "public"]
}
