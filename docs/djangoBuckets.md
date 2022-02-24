<!-- BEGIN_TF_DOCS -->
This module is used create S3 bucket for app in dev,staging and prod environment

Each of the environments have 1 public and 1 private bucket

These are the buckets created

- django-private-bucket-dev-env
- django-private-bucket-stage-env
- django-private-bucket-prod-env
- django-public-bucket-dev-env
- django-public-bucket-stage-env
- django-public-bucket-prod-env

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.74 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.74 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.django_private_buckets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.django_public_buckets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.policy_django_public_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.django_private_buckets_acl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_django_private_buckets"></a> [django\_private\_buckets](#input\_django\_private\_buckets) | List of private buckets used by django app | `list(string)` | n/a | yes |
| <a name="input_django_public_buckets"></a> [django\_public\_buckets](#input\_django\_public\_buckets) | List of public buckets used by django app | `list(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->