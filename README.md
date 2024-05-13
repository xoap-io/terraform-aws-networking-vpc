[![Maintained](https://img.shields.io/badge/Maintained%20by-XOAP-success)](https://xoap.io)
[![Terraform](https://img.shields.io/badge/Terraform-%3E%3D1.1.6-blue)](https://terraform.io)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

# Table of Contents

- [Introduction](#introduction)
- [Guidelines](#guidelines)
- [Requirements](#requirements)
- [Providers](#providers)
- [Modules](#modules)
- [Resources](#resources)
- [Inputs](#inputs)
- [Outputs](#outputs)

---

## Introduction

This is a template for Terraform modules.

It is part of our XOAP Automation Forces Open Source community library to give you a quick start into Infrastructure as Code deployments with Terraform.

We have a lot of Terraform modules that are Open Source and maintained by the XOAP staff.

Please check the links for more info, including usage information and full documentation:

- [XOAP Website](https://xoap.io)
- [XOAP Documentation](https://docs.xoap.io)
- [Twitter](https://twitter.com/xoap_io)
- [LinkedIn](https://www.linkedin.com/company/xoap_io)

---

## Guidelines

We are using the following guidelines to write code and make it easier for everyone to follow a destinctive guideline. Please check these links before starting to work on changes.

[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg)](CODE_OF_CONDUCT.md)

Git Naming Conventions are an important part of the development process. They descrtibe how Branched, Commit Messages, Pull Requests and Tags should look like to make the easily understandebla for everybody in the development chain.

[Git Naming Conventions](https://namingconvention.org/git/)

he Conventional Commits specification is a lightweight convention on top of commit messages. It provides an easy set of rules for creating an explicit commit history; which makes it easier to write automated tools on top of.

[Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)

The better a Pull Request description is, the better a review can understand and decide on how to review the changes. This improves implementation speed and reduces communication between the requester and the reviewer resulting in much less overhead.

[Wiriting A Great Pull Request Description](https://www.pullrequest.com/blog/writing-a-great-pull-request-description/)

Versioning is a crucial part for Terraform Stacks and Modules. Without version tags you cannot clearly create a stable environment and be sure that your latest changes won't crash your production environment (sure it still can happen, but we are trying our best to implement everything that we can to reduce the risk)

[Semantic Versioning](https://semver.org)

Naming Conventions for Terraform resources must be used.

[Terraform Naming Conventions](https://www.terraform-best-practices.com/naming)

---

## Usage

### Installation

For the first ime using this template necessary tools need to be installed.
A script for PowerShell Core is provided under ./build/init.ps1

This script will install following dependencies:

- [pre-commit](https://github.com/pre-commit/pre-commit)
- [terraform-docs](https://github.com/terraform-docs/terraform-docs)
- [tflint](https://github.com/terraform-linters/tflint)
- [tfsec](https://github.com/aquasecurity/tfsec)
- [checkov](https://github.com/bridgecrewio/checkov)
- [terrascan](https://github.com/accurics/terrascan)
- [kics](https://github.com/Checkmarx/kics)

This script configures:

- global git template under ~/.git-template
- global pre-commit hooks for prepare-commit-msg and commit-msg under ~/.git-template/hooks
- github actions:
  - linting and checks for pull requests from dev to master/main
  - automatic tagging and release creation on pushes to master/main
  - dependabot updates

It currently supports the automated installation for macOS. Support for Windows and Linux will be available soon.

### Synchronisation

We provided a script under ./build/sync_template.ps1 to fetch the latest changes from this template repository.
Please be aware that this is mainly a copy operation which means all your current changes have to be committed first and after running the script you have to merge this changes into your codebase.

### Configuration

---

<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.1.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.8.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.8.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_sg_endpoints"></a> [sg\_endpoints](#module\_sg\_endpoints) | git::github.com/xoap-io/terraform-aws-compute-security-group.git | n/a |
| <a name="module_this_label"></a> [this\_label](#module\_this\_label) | git::github.com/xoap-io/terraform-aws-misc-label | v0.1.0 |
| <a name="module_this_subnets"></a> [this\_subnets](#module\_this\_subnets) | ./modules/subnet | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_default_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_security_group) | resource |
| [aws_ec2_transit_gateway_vpc_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_vpc_attachment) | resource |
| [aws_eip.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_ram_principal_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_principal_association) | resource |
| [aws_ram_resource_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_association) | resource |
| [aws_ram_resource_share.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_share) | resource |
| [aws_route.igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_vpc_dhcp_options.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_dhcp_options) | resource |
| [aws_vpc_dhcp_options_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_dhcp_options_association) | resource |
| [aws_vpc_endpoint.dynamodb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_organizations_organization.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [aws_region.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_config"></a> [config](#input\_config) | Configuration parameters for the vpc. Per default the vpc is provisioned with the subnet cidr 10.10.0.0.0/16 and full dns support | <pre>object({<br>    cidr               = string<br>    dns_support        = bool<br>    ipv6_support       = bool<br>    enable_nat_gateway = bool<br>    nat_gateway_subnet = string<br>  })</pre> | <pre>{<br>  "cidr": "10.10.0.0/16",<br>  "classic_link_support": false,<br>  "dns_support": true,<br>  "enable_nat_gateway": true,<br>  "ipv6_support": false,<br>  "nat_gateway_subnet": "public"<br>}</pre> | no |
| <a name="input_context"></a> [context](#input\_context) | Default context for naming and tagging purpose | <pre>object({<br>    organization = string<br>    environment  = string<br>    account      = string<br>    product      = string<br>    tags         = map(string)<br>  })</pre> | n/a | yes |
| <a name="input_dhcp_options"></a> [dhcp\_options](#input\_dhcp\_options) | Configuration parameters for dhcp. Per default this features are disabled | <pre>object({<br>    domain_name          = string<br>    domain_name_servers  = list(string)<br>    ntp_servers          = list(string)<br>    netbios_name_servers = list(string)<br>    netbios_node_type    = string<br>  })</pre> | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the vpc to create | `string` | n/a | yes |
| <a name="input_share_vpc_organisation_wide"></a> [share\_vpc\_organisation\_wide](#input\_share\_vpc\_organisation\_wide) | Share the vpc with  organisation | `bool` | `false` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Flexible subnet mapping option | <pre>map(object({<br>    operation_mode         = string<br>    transit_gateway_routes = list(string)<br>    mappings = map(object({<br>      cidr                 = string<br>      availability_zone_id = string<br>      public_ip_on_launch  = bool<br>      tags                 = map(string)<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A list of tags to add | `map(string)` | `{}` | no |
| <a name="input_transit_gateway_id"></a> [transit\_gateway\_id](#input\_transit\_gateway\_id) | ID of the transit gateway to attach the vpc to | `string` | `""` | no |
| <a name="input_transit_gateway_routes"></a> [transit\_gateway\_routes](#input\_transit\_gateway\_routes) | Routes to be added to the transit gateway | `list(string)` | `[]` | no |
| <a name="input_transit_gateway_subnet_map"></a> [transit\_gateway\_subnet\_map](#input\_transit\_gateway\_subnet\_map) | Subnet mapping for the transit gateway | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_ec2_transit_gateway_vpc_attachment"></a> [aws\_ec2\_transit\_gateway\_vpc\_attachment](#output\_aws\_ec2\_transit\_gateway\_vpc\_attachment) | output from resource aws\_ec2\_transit\_gateway\_vpc\_attachment according to https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_vpc_attachment |
| <a name="output_context"></a> [context](#output\_context) | Exported context from input variable |
| <a name="output_internet_gateway"></a> [internet\_gateway](#output\_internet\_gateway) | Output from resource aws\_internet\_gateway according to https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway |
| <a name="output_nat_gateway"></a> [nat\_gateway](#output\_nat\_gateway) | Output from resource aws\_nat\_gateway according to https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway |
| <a name="output_route_tables"></a> [route\_tables](#output\_route\_tables) | map of output from resource aws\_route\_table according to https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table |
| <a name="output_subnet_cidrs"></a> [subnet\_cidrs](#output\_subnet\_cidrs) | list of all associated subnet cidrs |
| <a name="output_subnet_ids"></a> [subnet\_ids](#output\_subnet\_ids) | map of output from resource aws\_subnet according to https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | map of output from resource aws\_subnet according to https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet |
| <a name="output_temp"></a> [temp](#output\_temp) | n/a |
| <a name="output_transit_gateway_routes"></a> [transit\_gateway\_routes](#output\_transit\_gateway\_routes) | map of output from resource aws\_subnet according to https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet |
| <a name="output_vpc"></a> [vpc](#output\_vpc) | Map of  aws\_vpc according to https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- markdownlint-disable -->
<!-- prettier-ignore-end -->
