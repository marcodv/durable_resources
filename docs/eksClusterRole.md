<!-- BEGIN_TF_DOCS -->
This module is used to create a IAM Cluster roles for dev and prod environment

To each role are assigned different IAM accounts

Each role have managed and custom policies  

These are the roles created

- eks-role-dev-env
- eks-role-prod-env

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
| [aws_iam_policy.iam_cluster_role_policies](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.iam_role_eks_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.aws_custom_policies_attachment_eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.aws_managed_policies_attachment_eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_ingress_controller_role_env"></a> [alb\_ingress\_controller\_role\_env](#input\_alb\_ingress\_controller\_role\_env) | List of ALB ingress controller roles for environment | `list(string)` | n/a | yes |
| <a name="input_eks_cluster_role_policies"></a> [eks\_cluster\_role\_policies](#input\_eks\_cluster\_role\_policies) | List of policies for cluster role | <pre>list(object({<br>    name        = string<br>    path        = string<br>    description = string<br>  }))</pre> | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment to deploy | `string` | n/a | yes |
| <a name="input_iam_aws_eks_policies"></a> [iam\_aws\_eks\_policies](#input\_iam\_aws\_eks\_policies) | AWS IAM managed policies for EKS | `list(string)` | n/a | yes |
| <a name="input_iam_customer_eks_policies"></a> [iam\_customer\_eks\_policies](#input\_iam\_customer\_eks\_policies) | AWS IAM customer policies for EKS | `list(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->