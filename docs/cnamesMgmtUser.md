<!-- BEGIN_TF_DOCS -->
This module is used to create a IAM User account for manage CNAMEs records binded to HubSpot landing pages

This account only need to have route53 permissions in order to create and update CNAMEs records

This is the account created

- landing\_pages\_cname\_records\_user\_mgmt

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
| [aws_iam_policy.cname_mgmt_user_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_user.cname_mgmt_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_policy_attachment.attach_custom_policies_to_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cnames_landing_pages_mgmt_policy_name"></a> [cnames\_landing\_pages\_mgmt\_policy\_name](#input\_cnames\_landing\_pages\_mgmt\_policy\_name) | Policy Name to create/update CNAMEs records | `string` | n/a | yes |
| <a name="input_user_name_mgmt_landing_page"></a> [user\_name\_mgmt\_landing\_page](#input\_user\_name\_mgmt\_landing\_page) | Username used to update CNAMEs Records for HubSpot LandingPages | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->