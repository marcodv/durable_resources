<!-- BEGIN_TF_DOCS -->
This module is used to create a IAM terraform account for dev and prod environment

To each account are assigned different IAM custom and AWS policies

These are the accounts created

- Terraform\_User\_Dev\_Env
- Terraform\_User\_Prod\_Env

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
| [aws_iam_policy.custom_policies_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_user.iam_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_policy_attachment.attach_custom_policies_to_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy_attachment) | resource |
| [aws_iam_user_policy_attachment.attach_managed_policies_to_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_managed_policies_list"></a> [aws\_managed\_policies\_list](#input\_aws\_managed\_policies\_list) | List of AWS Managed policies to attach to user | `list(string)` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Policies applied to a specific environment user | `string` | n/a | yes |
| <a name="input_iam_user_name"></a> [iam\_user\_name](#input\_iam\_user\_name) | Name of the IAM user | `string` | n/a | yes |
| <a name="input_terraform_user_access_backend_list_policies"></a> [terraform\_user\_access\_backend\_list\_policies](#input\_terraform\_user\_access\_backend\_list\_policies) | List of CUSTOM policies to attach to the user | <pre>list(object({<br>    name        = string<br>    path        = string<br>    description = string<br>  }))</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->