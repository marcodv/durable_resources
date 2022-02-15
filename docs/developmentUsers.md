<!-- BEGIN_TF_DOCS -->
This module is used to create a IAM Django app account for dev, stage and prod environment

To each account are assigned different IAM bucket policies

These are the accounts created

- app\_User\_dev\_Env
- app\_User\_stage\_Env
- app\_User\_prod\_Env

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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_users"></a> [application\_users](#input\_application\_users) | List of users to be used for development, staging and production environments | <pre>list(object({<br>    user_name      = string<br>    policy_name    = string<br>    public_bucket  = string<br>    private_bucket = string<br>  }))</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->