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

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=4.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >=4.2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_this_cloudwatch"></a> [this\_cloudwatch](#module\_this\_cloudwatch) | git::github.com/xoap-io/terraform-aws-security-cloudwatch-group | v0.1.0 |
| <a name="module_this_label"></a> [this\_label](#module\_this\_label) | git::github.com/xoap-io/terraform-aws-misc-label | v0.1.0 |
| <a name="module_this_role"></a> [this\_role](#module\_this\_role) | git::github.com/xoap-io/terraform-aws-iam-role | v0.1.1 |
| <a name="module_this_subnets"></a> [this\_subnets](#module\_this\_subnets) | ./modules/subnet | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_default_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_security_group) | resource |
| [aws_flow_log.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log) | resource |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_vpc_dhcp_options.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_dhcp_options) | resource |
| [aws_vpc_dhcp_options_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_dhcp_options_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_config"></a> [config](#input\_config) | Configuration parameters for the vpc. Per default the vpc is provisioned with the subnet cidr 10.10.0.0.0/16 and full dns support | <pre>object({<br>    cidr                 = string<br>    dns_support          = bool<br>    ipv6_support         = bool<br>    classic_link_support = bool<br>  })</pre> | <pre>{<br>  "cidr": "10.10.0.0/16",<br>  "classic_link_support": false,<br>  "dns_support": true,<br>  "ipv6_support": false<br>}</pre> | no |
| <a name="input_context"></a> [context](#input\_context) | Default context for naming and tagging purpose | <pre>object({<br>    organization = string<br>    environment  = string<br>    account      = string<br>    product      = string<br>    tags         = map(string)<br>  })</pre> | n/a | yes |
| <a name="input_dhcp_options"></a> [dhcp\_options](#input\_dhcp\_options) | Configuration parameters for dhcp. Per default this features are disabled | <pre>object({<br>    domain_name          = string<br>    domain_name_servers  = list(string)<br>    ntp_servers          = list(string)<br>    netbios_name_servers = list(string)<br>    netbios_node_type    = string<br>  })</pre> | `null` | no |
| <a name="input_kms_id"></a> [kms\_id](#input\_kms\_id) | Name of the kms key to use for encryption of flow logs | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the vpc to create | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Flexible subnet mapping option | <pre>map(object({<br>    operation_mode = string<br>    mappings = map(object({<br>      cidr                 = string<br>      availability_zone_id = string<br>      public_ip_on_launch  = bool<br>      tags                 = map(string)<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A list of tags to add | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_context"></a> [context](#output\_context) | Exported context from input variable |
| <a name="output_internet_gateways"></a> [internet\_gateways](#output\_internet\_gateways) | map of output from resource aws\_internet\_gateway according to https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway |
| <a name="output_nat_gateways"></a> [nat\_gateways](#output\_nat\_gateways) | map of output from resource aws\_nat\_gateway according to https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway |
| <a name="output_route_tables"></a> [route\_tables](#output\_route\_tables) | map of output from resource aws\_route\_table according to https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | map of output from resource aws\_subnet according to https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet |
| <a name="output_vpc"></a> [vpc](#output\_vpc) | Map of  aws\_vpc according to https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- markdownlint-disable -->
<!-- prettier-ignore-end -->
