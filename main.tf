module "this_label" {
  source     = "git::github.com/xoap-io/terraform-aws-misc-label?ref=v0.1.0"
  context    = var.context
  attributes = ["vpc", var.name]
}

resource "aws_vpc" "this" {
  cidr_block                       = var.config.cidr
  enable_dns_hostnames             = var.config.dns_support
  enable_dns_support               = var.config.dns_support
  enable_classiclink               = var.config.classic_link_support
  enable_classiclink_dns_support   = var.config.classic_link_support
  assign_generated_ipv6_cidr_block = var.config.ipv6_support

  tags = merge(var.tags,
    {
      "Name" = module.this_label.id
  })
}
resource "aws_default_security_group" "this" {
  vpc_id = aws_vpc.this[0].id
  tags = merge(var.tags,
    {
      "Name" = module.this_label.id
    }
  )
}
resource "aws_vpc_dhcp_options" "this" {
  for_each             = var.dhcp_options != null ? [1] : []
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
  for_each        = var.dhcp_options != null ? [1] : []
  vpc_id          = aws_vpc.this.id
  dhcp_options_id = join("", aws_vpc_dhcp_options.this[*].id)
}

module "this_subnets" {
  for_each        = var.subnets
  source          = "./modules/subnet"
  context         = var.context
  enable_ipv6     = var.config.ipv6_support
  name            = each.key
  operation_mode  = each.value.operation_mode
  subnet_mappings = each.value.mappings
  vpc_id          = aws_vpc.this.id
}
module "this_cloudwatch" {
  source         = "git::github.com/xoap-io/terraform-aws-security-cloudwatch-group?ref=v0.1.0"
  context        = var.context
  kms_id         = var.kms_id
  name           = "vpc-${var.name}-flow"
  retention_days = 7
}
module "this_role" {
  source             = "git::github.com/xoap-io/terraform-aws-iam-role?ref=v0.1.1"
  context            = var.context
  allow_logging      = true
  allow_xray         = false
  assume_role_grants = []
  caller_account_ids = []
  caller_arns        = []
  caller_services = [
    "vpc-flow-logs.amazonaws.com"
  ]
  kms_keys        = [var.kms_id]
  name            = "vpc-${var.name}"
  policies        = []
  policy_document = []
}

resource "aws_flow_log" "this" {
  log_destination_type     = "cloud-watch-logs"
  log_destination          = module.this_cloudwatch.arn
  log_format               = "parquet"
  iam_role_arn             = module.this_role.role.arn
  traffic_type             = "ALL"
  vpc_id                   = aws_vpc.this.id
  max_aggregation_interval = 60
  tags                     = merge(var.tags)
}
