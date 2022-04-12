# Table of Contents

- [Table of Contents](#table-of-contents)
  - [Usage](#usage)
  - [Requirements](#requirements)
  - [Providers](#providers)
  - [Modules](#modules)
  - [Resources](#resources)
  - [Inputs](#inputs)
  - [Outputs](#outputs)

## Usage

various commands

[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg)](code_of_conduct.md)

<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_this_label_igw"></a> [this\_label\_igw](#module\_this\_label\_igw) | git::github.com/xoap-io/terraform-aws-misc-label | v0.1.0 |
| <a name="module_this_label_route_table"></a> [this\_label\_route\_table](#module\_this\_label\_route\_table) | git::github.com/xoap-io/terraform-aws-misc-label | v0.1.0 |
| <a name="module_this_label_subnet"></a> [this\_label\_subnet](#module\_this\_label\_subnet) | git::github.com/xoap-io/terraform-aws-misc-label | v0.1.0 |

## Resources

| Name | Type |
|------|------|
| [aws_db_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_route.transit](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_context"></a> [context](#input\_context) | Default context for naming and tagging purpose | <pre>object({<br>    organization = string<br>    environment  = string<br>    account      = string<br>    product      = string<br>    tags         = map(string)<br>  })</pre> | n/a | yes |
| <a name="input_enable_ipv6"></a> [enable\_ipv6](#input\_enable\_ipv6) | Adds support for ipv6 | `bool` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Base name of the subnets to create | `string` | n/a | yes |
| <a name="input_operation_mode"></a> [operation\_mode](#input\_operation\_mode) | Operation mode of the subnets. Can be nat, not\_routed or public | `string` | n/a | yes |
| <a name="input_subnet_mappings"></a> [subnet\_mappings](#input\_subnet\_mappings) | Mapping for subnet creation | <pre>map(object({<br>    cidr                 = string<br>    availability_zone_id = string<br>    public_ip_on_launch  = bool<br>    tags                 = map(string)<br>  }))</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A list of tags to add | `map(string)` | `{}` | no |
| <a name="input_transit_gateway_id"></a> [transit\_gateway\_id](#input\_transit\_gateway\_id) | Id of the transit gateway to attach to the subnets | `string` | n/a | yes |
| <a name="input_transit_gateway_routes"></a> [transit\_gateway\_routes](#input\_transit\_gateway\_routes) | List of transit gateway routes to attach to the subnets | `list(string)` | `[]` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Id of the vpc to attach these subnets to | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_all_subnet_arn"></a> [all\_subnet\_arn](#output\_all\_subnet\_arn) | List of all arns from created subnets |
| <a name="output_all_subnet_ids"></a> [all\_subnet\_ids](#output\_all\_subnet\_ids) | List of all ids from created subnets |
| <a name="output_operation_mode"></a> [operation\_mode](#output\_operation\_mode) | Operational mode same value as input variable 'operation\_mode' |
| <a name="output_route_table"></a> [route\_table](#output\_route\_table) | Output from resource aws\_internet\_gateway according to https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | Map of  aws\_subnet according to https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- markdownlint-disable -->
<!-- prettier-ignore-end -->
