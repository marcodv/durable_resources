<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_iam"></a> [iam](#module\_iam) | ../../modules/iam | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aim_aws_worker_node_policies"></a> [aim\_aws\_worker\_node\_policies](#input\_aim\_aws\_worker\_node\_policies) | List of policies to attach to the worker node role | `list(string)` | n/a | yes |
| <a name="input_alb_ingress_controller"></a> [alb\_ingress\_controller](#input\_alb\_ingress\_controller) | n/a | `any` | n/a | yes |
| <a name="input_alb_ingress_controller_role_env"></a> [alb\_ingress\_controller\_role\_env](#input\_alb\_ingress\_controller\_role\_env) | List of ALB ingress controller roles for environment | `list(string)` | n/a | yes |
| <a name="input_customer_policy_worker_node"></a> [customer\_policy\_worker\_node](#input\_customer\_policy\_worker\_node) | AWS IAM customer policies for worker node role | `list(string)` | n/a | yes |
| <a name="input_ec2_full_access"></a> [ec2\_full\_access](#input\_ec2\_full\_access) | n/a | `any` | n/a | yes |
| <a name="input_eks_all_access"></a> [eks\_all\_access](#input\_eks\_all\_access) | n/a | `any` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `any` | n/a | yes |
| <a name="input_iam_aws_eks_policies"></a> [iam\_aws\_eks\_policies](#input\_iam\_aws\_eks\_policies) | AWS IAM managed policies for EKS | `list(string)` | n/a | yes |
| <a name="input_iam_customer_eks_policies"></a> [iam\_customer\_eks\_policies](#input\_iam\_customer\_eks\_policies) | AWS IAM customer policies for EKS | `list(string)` | n/a | yes |
| <a name="input_iam_limited_access"></a> [iam\_limited\_access](#input\_iam\_limited\_access) | n/a | `any` | n/a | yes |
| <a name="input_type_resource"></a> [type\_resource](#input\_type\_resource) | n/a | `any` | n/a | yes |
| <a name="input_worker_node_role"></a> [worker\_node\_role](#input\_worker\_node\_role) | Name of the worker node role | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->