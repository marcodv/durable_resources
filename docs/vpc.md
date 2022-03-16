<!-- BEGIN_TF_DOCS -->
This module is used to deploy a VPC that span across 2 AZ

The only resource deployed in this VPC is Postgres DB

The db will be access via vpc peering from others vpc

This module will deploy a vpc structured in this way

- Private subnets for db
- route table with vpc peering routes
- ACL and SG definition

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_route.prod_to_dev](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.prod_to_prod](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.db_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.db_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_vpc_peering_connection.prod_to_dev](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acl_db_rule"></a> [acl\_db\_rule](#input\_acl\_db\_rule) | List of rule\_no and inbound ports open | <pre>object({<br>    ingress_rule = list(object({<br>      rule_no   = number<br>      from_port = number<br>      to_port   = number<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | List of availability zones | `list(string)` | n/a | yes |
| <a name="input_db_private_subnets_cidr"></a> [db\_private\_subnets\_cidr](#input\_db\_private\_subnets\_cidr) | List of private subnets for DB | `list(string)` | `[]` | no |
| <a name="input_sg_db_rule"></a> [sg\_db\_rule](#input\_sg\_db\_rule) | List of open ports for inbound connections | `list(string)` | n/a | yes |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | VPC Cidr Block | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db_private_subnets_id"></a> [db\_private\_subnets\_id](#output\_db\_private\_subnets\_id) | Return a list of db subnets id |
| <a name="output_db_sg"></a> [db\_sg](#output\_db\_sg) | Return the db security group id |
<!-- END_TF_DOCS -->