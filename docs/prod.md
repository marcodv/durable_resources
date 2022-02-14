<!-- BEGIN_TF_DOCS -->
The file in the Dev folder of this project, allow you to create durable resources for Dev env

Dev and Prod env create different resources.

If you want to change any of the values for the resources created here,  

you need to edit dev.tfvars

This is the list of durable resources created for **Dev environment**

- Terraform users
- Cluster role
- Worker node role
- Cluster Group management users
- Django apps IAM accounts
- S3 public and private bucket to be used by IAM accounts

## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_createAppsUsers"></a> [createAppsUsers](#module\_createAppsUsers) | ../../modules/iam/createUsers/developmentUsers | n/a |
| <a name="module_createClusterMgmtGroup"></a> [createClusterMgmtGroup](#module\_createClusterMgmtGroup) | ../../modules/iam/createGroups | n/a |
| <a name="module_createClusterRoles"></a> [createClusterRoles](#module\_createClusterRoles) | ../../modules/iam/createRoles/eksClusterRole | n/a |
| <a name="module_createDjangoBuckets"></a> [createDjangoBuckets](#module\_createDjangoBuckets) | ../../modules/S3Buckets/djangoBuckets | n/a |
| <a name="module_createUsers"></a> [createUsers](#module\_createUsers) | ../../modules/iam/createUsers/terraformUsers | n/a |
| <a name="module_createWorkerNodeRole"></a> [createWorkerNodeRole](#module\_createWorkerNodeRole) | ../../modules/iam/createRoles/eksWorkerNodeRole | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_ingress_controller_role_env"></a> [alb\_ingress\_controller\_role\_env](#input\_alb\_ingress\_controller\_role\_env) | List of ALB ingress controller roles for environment | `list(string)` | n/a | yes |
| <a name="input_application_users"></a> [application\_users](#input\_application\_users) | List of users to be used for development, staging and production environments | <pre>list(object({<br>    user_name      = string<br>    policy_name    = string<br>    public_bucket  = string<br>    private_bucket = string<br>  }))</pre> | n/a | yes |
| <a name="input_attach_user_to_group"></a> [attach\_user\_to\_group](#input\_attach\_user\_to\_group) | List of group to which the user is going to be part of | `list(string)` | n/a | yes |
| <a name="input_aws_managed_policies_list"></a> [aws\_managed\_policies\_list](#input\_aws\_managed\_policies\_list) | List of AWS Managed policies to attach to user | `list(string)` | n/a | yes |
| <a name="input_cluster_users_mgmt"></a> [cluster\_users\_mgmt](#input\_cluster\_users\_mgmt) | List of user to attach to the EKS IAM user gorup | `list(string)` | n/a | yes |
| <a name="input_customer_policy_worker_node"></a> [customer\_policy\_worker\_node](#input\_customer\_policy\_worker\_node) | AWS IAM customer policies for worker node role | `list(string)` | n/a | yes |
| <a name="input_django_private_buckets"></a> [django\_private\_buckets](#input\_django\_private\_buckets) | List of private buckets used by django app | `list(string)` | n/a | yes |
| <a name="input_django_public_buckets"></a> [django\_public\_buckets](#input\_django\_public\_buckets) | List of public buckets used by django app | `list(string)` | n/a | yes |
| <a name="input_eks_cluster_management_list_policies"></a> [eks\_cluster\_management\_list\_policies](#input\_eks\_cluster\_management\_list\_policies) | List of the policies to associate to the cluster management group | <pre>list(object({<br>    name        = string<br>    path        = string<br>    description = string<br>  }))</pre> | n/a | yes |
| <a name="input_eks_cluster_role_policies"></a> [eks\_cluster\_role\_policies](#input\_eks\_cluster\_role\_policies) | List of policies for cluster role | <pre>list(object({<br>    name        = string<br>    path        = string<br>    description = string<br>  }))</pre> | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment where we want to deploy | `string` | n/a | yes |
| <a name="input_iam_aws_eks_policies"></a> [iam\_aws\_eks\_policies](#input\_iam\_aws\_eks\_policies) | AWS IAM managed policies for EKS | `list(string)` | n/a | yes |
| <a name="input_iam_aws_worker_node_policies"></a> [iam\_aws\_worker\_node\_policies](#input\_iam\_aws\_worker\_node\_policies) | List of policies to attach to the worker node role | `list(string)` | n/a | yes |
| <a name="input_iam_customer_eks_policies"></a> [iam\_customer\_eks\_policies](#input\_iam\_customer\_eks\_policies) | AWS IAM customer policies for EKS | `list(string)` | n/a | yes |
| <a name="input_iam_user_name"></a> [iam\_user\_name](#input\_iam\_user\_name) | Name of the IAM user | `string` | n/a | yes |
| <a name="input_terraform_user_access_backend_list_policies"></a> [terraform\_user\_access\_backend\_list\_policies](#input\_terraform\_user\_access\_backend\_list\_policies) | List of CUSTOM policies for access to tf state backend | <pre>list(object({<br>    name        = string<br>    path        = string<br>    description = string<br>  }))</pre> | n/a | yes |
| <a name="input_type_resource"></a> [type\_resource](#input\_type\_resource) | Tag applied to each resources created in dev env | `string` | n/a | yes |
| <a name="input_worker_node_role"></a> [worker\_node\_role](#input\_worker\_node\_role) | Name of the worker node role | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->