<!-- BEGIN_TF_DOCS -->
This module is used to deploy ElastiCache instance based on Redis engine with a single instance

ElastiCache is used by the Django apps to

A part that Redis based instance, this module also create

- cluster parameter group
- subnet group needed
- cluster user  

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
| [aws_elasticache_cluster.elasticache_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_cluster) | resource |
| [aws_elasticache_parameter_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_parameter_group) | resource |
| [aws_elasticache_subnet_group.redis_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_subnet_group) | resource |
| [aws_elasticache_user.redis_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_user) | resource |
| [aws_secretsmanager_secret.prod_secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret) | data source |
| [aws_secretsmanager_secret_version.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_elasticache_setting"></a> [elasticache\_setting](#input\_elasticache\_setting) | List for the Elastic Cache Redis based engine instance setting | <pre>object({<br>    engine          = string<br>    node_type       = string<br>    num_cache_nodes = number<br>    port            = number<br>    engine_version  = string<br>    family          = string<br>  })</pre> | n/a | yes |
| <a name="input_elasticache_sg_ids"></a> [elasticache\_sg\_ids](#input\_elasticache\_sg\_ids) | Security groups ids for Elasticache | `list(string)` | n/a | yes |
| <a name="input_elasticache_subnets"></a> [elasticache\_subnets](#input\_elasticache\_subnets) | Subnets for Elasticache | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environments that we want to deploy | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_elasticache_endpoint"></a> [elasticache\_endpoint](#output\_elasticache\_endpoint) | ElastiCache endpoint |
<!-- END_TF_DOCS -->