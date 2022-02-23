<!-- BEGIN_TF_DOCS -->
This module is used to create Lambda function prod environment

This function call the Bubble script for make the backup of the following

- Bubble DB
- Landing infos
- Users
- Installers
- Companies  

The Lambda functions can be found at [this url](https://eu-west-1.console.aws.amazon.com/lambda/home?region=eu-west-1#/functions)

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | n/a |
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.scheduled_event_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_cloudwatch_log_group.logs_for_labda_execution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_policy.lambda_logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role_policy_attachment.lambda_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.deploy_lambda_backup_script](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [archive_file.lambda_zip](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Environment to deploy | `string` | n/a | yes |
| <a name="input_lambdaFunctionsEnvironmets"></a> [lambdaFunctionsEnvironmets](#input\_lambdaFunctionsEnvironmets) | List of Lambda names for different backup script to call | `list(string)` | n/a | yes |
| <a name="input_lambda_role_bubble_backup"></a> [lambda\_role\_bubble\_backup](#input\_lambda\_role\_bubble\_backup) | Role name for lambda function to call teh Bubble backup script | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->