<!-- BEGIN_TF_DOCS -->
This module is used to create a IAM terraform account for dev and prod environment

To each account are assigned different IAM custom and AWS policies

These are the accounts created

- Grafana\_User\_Dev\_Env
- Grafana\_User\_Prod\_Env

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
| [aws_iam_user.grafana_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_policy_attachment.aim_customer_policy_attachment_worker_node](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Environment to deploy | `string` | n/a | yes |
| <a name="input_grafana_user"></a> [grafana\_user](#input\_grafana\_user) | Grafana User | `string` | n/a | yes |
| <a name="input_read_only_billing_policy"></a> [read\_only\_billing\_policy](#input\_read\_only\_billing\_policy) | Policy to view dashboard metrics for Grafana | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->