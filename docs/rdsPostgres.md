<!-- BEGIN_TF_DOCS -->
This module is used to deploy a SINGLE Postgres DB version 13 in one of the 2 Private AZ.

Also created a parameter group which defined the parameters that
we need to update or change

The DB creation depend from the db parameters group and also the private subnets.

DB passwd and username are stored in [AWS secret management](http://eu-west-1.console.aws.amazon.com/secretsmanager/home?region=eu-west-1)

DB credentials are passed to Terraform at pipeline execution time

The DB created have these configurations:

- 10GB of storage
- Tagged by AZ and environment
- Port open: 5432

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
| [aws_db_instance.db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_parameter_group.pg_db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_db_subnet_group.subnet_group_name](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_secretsmanager_secret.prod_secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret) | data source |
| [aws_secretsmanager_secret_version.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | List of availability zones | `list(string)` | n/a | yes |
| <a name="input_db_sg"></a> [db\_sg](#input\_db\_sg) | DB Security group id | `string` | `""` | no |
| <a name="input_db_subnet_ids"></a> [db\_subnet\_ids](#input\_db\_subnet\_ids) | List of private subnets for DB | `list(string)` | `[]` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment where we want to deploy | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->