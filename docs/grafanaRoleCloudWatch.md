<!-- BEGIN_TF_DOCS -->
This module is used to create IAM Cloudwatch roles for dev and prod environment

This Role is used from Grafana to access to the metrics and show them

To each role are assigned different IAM accounts

These are the roles created

- grafanaRoleCloudWatchdevEnv
- grafanaRoleCloudWatchprodEnv

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
| [aws_iam_policy.read_only_billing_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.iam_role_grafana](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.aim_customer_policy_attachment_worker_node](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Environment to deploy | `string` | n/a | yes |
| <a name="input_grafana_role"></a> [grafana\_role](#input\_grafana\_role) | Grafana Role name | `string` | n/a | yes |
| <a name="input_read_only_billing_policy"></a> [read\_only\_billing\_policy](#input\_read\_only\_billing\_policy) | Policy to view dashboard metrics for Grafana | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->