<!-- BEGIN_TF_DOCS -->
This module is used to create IAM Lambda roles for dev and prod environment

This Role is used to make call to the Bubble backup script in Google App script

To each role are assigned different IAM accounts

Each role have managed and custom policies  

These are the roles created

- lambdaRoleBubbleBackupprodEnv

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
| [aws_iam_role.iam_role_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Environment to deploy | `string` | n/a | yes |
| <a name="input_lambda_role_bubble_backup"></a> [lambda\_role\_bubble\_backup](#input\_lambda\_role\_bubble\_backup) | Role name for lambda function to call teh Bubble backup script | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->