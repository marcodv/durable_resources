<!-- BEGIN_TF_DOCS -->
This module is used to create a IAM Worker Node roles for dev and prod environment

To each role are assigned different IAM accounts

Each role have managed and custom policies  

These are the roles created

- WorkerNodeRoledevEnv
- WorkerNodeRoleprodEnv

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
| [aws_iam_policy.list_hosted_zone_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.iam_role_worker_node](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.aim_customer_policy_attachment_worker_node](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.iam_managed_policy_attachment_worker_node](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_customer_policy_worker_node"></a> [customer\_policy\_worker\_node](#input\_customer\_policy\_worker\_node) | AWS IAM customer policies for worker node role | `list(string)` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment to deploy | `string` | n/a | yes |
| <a name="input_iam_aws_worker_node_policies"></a> [iam\_aws\_worker\_node\_policies](#input\_iam\_aws\_worker\_node\_policies) | AWS IAM managed policies for worker node | `list(string)` | n/a | yes |
| <a name="input_manage_hosted_zone_policy"></a> [manage\_hosted\_zone\_policy](#input\_manage\_hosted\_zone\_policy) | Policy to manage hosted zone | `string` | n/a | yes |
| <a name="input_worker_node_role"></a> [worker\_node\_role](#input\_worker\_node\_role) | Name of the worker node role | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->