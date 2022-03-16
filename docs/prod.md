<!-- BEGIN_TF_DOCS -->
The file in the Dev folder of this project, allow you to create durable resources for Dev env

Dev and Prod env create different resources.

If you want to change any of the values for the resources created here,  

you need to edit dev.tfvars

This is the list of durable resources created for **Prod environment**

- Terraform users
- Cluster role
- Worker node role
- Cluster Group management users
- Django apps IAM accounts
- S3 public and private bucket to be used by IAM accounts
- Prod Postgres DB
- VPC where setup prod db
- VPC peering between vpcs

## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_createAppsUsers"></a> [createAppsUsers](#module\_createAppsUsers) | ../../modules/iam/createUsers/developmentUsers | n/a |
| <a name="module_createBubbleBackupLambda"></a> [createBubbleBackupLambda](#module\_createBubbleBackupLambda) | ../../modules/lambdaFunctions/bubbleBackup | n/a |
| <a name="module_createBubbleBackupRole"></a> [createBubbleBackupRole](#module\_createBubbleBackupRole) | ../../modules/iam/createRoles/lambdaRole | n/a |
| <a name="module_createClusterMgmtGroup"></a> [createClusterMgmtGroup](#module\_createClusterMgmtGroup) | ../../modules/iam/createGroups | n/a |
| <a name="module_createClusterRoles"></a> [createClusterRoles](#module\_createClusterRoles) | ../../modules/iam/createRoles/eksClusterRole | n/a |
| <a name="module_createDeleteBubbleBackupLambda"></a> [createDeleteBubbleBackupLambda](#module\_createDeleteBubbleBackupLambda) | ../../modules/lambdaFunctions/bubbleDeleteOldBackup | n/a |
| <a name="module_createDjangoBuckets"></a> [createDjangoBuckets](#module\_createDjangoBuckets) | ../../modules/S3Buckets/djangoBuckets | n/a |
| <a name="module_createGrafanaRole"></a> [createGrafanaRole](#module\_createGrafanaRole) | ../../modules/iam/createRoles/grafanaRoleCloudWatch | n/a |
| <a name="module_createGrafanaUser"></a> [createGrafanaUser](#module\_createGrafanaUser) | ../../modules/iam/createUsers/grafanaUser | n/a |
| <a name="module_createMgmtLandingPageUser"></a> [createMgmtLandingPageUser](#module\_createMgmtLandingPageUser) | ../../modules/iam/createUsers/cnamesMgmtUser | n/a |
| <a name="module_createUsers"></a> [createUsers](#module\_createUsers) | ../../modules/iam/createUsers/terraformUsers | n/a |
| <a name="module_createVPC"></a> [createVPC](#module\_createVPC) | ../../modules/networking/vpc | n/a |
| <a name="module_createWorkerNodeRole"></a> [createWorkerNodeRole](#module\_createWorkerNodeRole) | ../../modules/iam/createRoles/eksWorkerNodeRole | n/a |
| <a name="module_db"></a> [db](#module\_db) | ../../modules/db/rdsPostgres | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acl_db_rule"></a> [acl\_db\_rule](#input\_acl\_db\_rule) | List of rule\_no and inbound ports open | <pre>object({<br>    ingress_rule = list(object({<br>      rule_no   = number<br>      from_port = number<br>      to_port   = number<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_alb_ingress_controller_role_env"></a> [alb\_ingress\_controller\_role\_env](#input\_alb\_ingress\_controller\_role\_env) | List of ALB ingress controller roles for environment | `list(string)` | n/a | yes |
| <a name="input_application_users"></a> [application\_users](#input\_application\_users) | List of users to be used for development, staging and production environments | <pre>list(object({<br>    user_name      = string<br>    policy_name    = string<br>    public_bucket  = string<br>    private_bucket = string<br>  }))</pre> | n/a | yes |
| <a name="input_attach_user_to_group"></a> [attach\_user\_to\_group](#input\_attach\_user\_to\_group) | List of group to which the user is going to be part of | `list(string)` | n/a | yes |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | List of availability zones | `list(string)` | n/a | yes |
| <a name="input_aws_managed_policies_list"></a> [aws\_managed\_policies\_list](#input\_aws\_managed\_policies\_list) | List of AWS Managed policies to attach to user | `list(string)` | n/a | yes |
| <a name="input_cluster_users_mgmt"></a> [cluster\_users\_mgmt](#input\_cluster\_users\_mgmt) | List of user to attach to the EKS IAM user gorup | `list(string)` | n/a | yes |
| <a name="input_cnames_landing_pages_mgmt_policy_name"></a> [cnames\_landing\_pages\_mgmt\_policy\_name](#input\_cnames\_landing\_pages\_mgmt\_policy\_name) | Policy Name to create/update CNAMEs records | `string` | n/a | yes |
| <a name="input_customer_policy_worker_node"></a> [customer\_policy\_worker\_node](#input\_customer\_policy\_worker\_node) | AWS IAM customer policies for worker node role | `list(string)` | n/a | yes |
| <a name="input_db_private_subnets_cidr"></a> [db\_private\_subnets\_cidr](#input\_db\_private\_subnets\_cidr) | List of private subnets for DB | `list(string)` | `[]` | no |
| <a name="input_db_sg"></a> [db\_sg](#input\_db\_sg) | DB Security group id | `string` | `""` | no |
| <a name="input_db_subnet_ids"></a> [db\_subnet\_ids](#input\_db\_subnet\_ids) | List of private subnets for DB | `list(string)` | `[]` | no |
| <a name="input_django_private_buckets"></a> [django\_private\_buckets](#input\_django\_private\_buckets) | List of private buckets used by django app | `list(string)` | n/a | yes |
| <a name="input_django_public_buckets"></a> [django\_public\_buckets](#input\_django\_public\_buckets) | List of public buckets used by django app | `list(string)` | n/a | yes |
| <a name="input_eks_cluster_management_list_policies"></a> [eks\_cluster\_management\_list\_policies](#input\_eks\_cluster\_management\_list\_policies) | List of the policies to associate to the cluster management group | <pre>list(object({<br>    name        = string<br>    path        = string<br>    description = string<br>  }))</pre> | n/a | yes |
| <a name="input_eks_cluster_role_policies"></a> [eks\_cluster\_role\_policies](#input\_eks\_cluster\_role\_policies) | List of policies for cluster role | <pre>list(object({<br>    name        = string<br>    path        = string<br>    description = string<br>  }))</pre> | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment where we want to deploy | `string` | n/a | yes |
| <a name="input_grafana_role"></a> [grafana\_role](#input\_grafana\_role) | Grafana Role name | `string` | n/a | yes |
| <a name="input_grafana_user"></a> [grafana\_user](#input\_grafana\_user) | Grafana User | `string` | n/a | yes |
| <a name="input_iam_aws_eks_policies"></a> [iam\_aws\_eks\_policies](#input\_iam\_aws\_eks\_policies) | AWS IAM managed policies for EKS | `list(string)` | n/a | yes |
| <a name="input_iam_aws_worker_node_policies"></a> [iam\_aws\_worker\_node\_policies](#input\_iam\_aws\_worker\_node\_policies) | List of policies to attach to the worker node role | `list(string)` | n/a | yes |
| <a name="input_iam_customer_eks_policies"></a> [iam\_customer\_eks\_policies](#input\_iam\_customer\_eks\_policies) | AWS IAM customer policies for EKS | `list(string)` | n/a | yes |
| <a name="input_iam_user_name"></a> [iam\_user\_name](#input\_iam\_user\_name) | Name of the IAM user | `string` | n/a | yes |
| <a name="input_lambdaFunctionsEnvironmets"></a> [lambdaFunctionsEnvironmets](#input\_lambdaFunctionsEnvironmets) | List of Lambda names for different backup script to call | `list(string)` | n/a | yes |
| <a name="input_lambda_role_bubble_backup"></a> [lambda\_role\_bubble\_backup](#input\_lambda\_role\_bubble\_backup) | Role name for lambda function to call teh Bubble backup script | `string` | n/a | yes |
| <a name="input_lambda_role_delete_bubble_backup"></a> [lambda\_role\_delete\_bubble\_backup](#input\_lambda\_role\_delete\_bubble\_backup) | Role name for lambda function to call the Bubble backup deletion script | `string` | n/a | yes |
| <a name="input_manage_hosted_zone_policy"></a> [manage\_hosted\_zone\_policy](#input\_manage\_hosted\_zone\_policy) | Policy to manage hosted zone | `string` | n/a | yes |
| <a name="input_read_only_billing_policy"></a> [read\_only\_billing\_policy](#input\_read\_only\_billing\_policy) | Policy to view dashboard metrics for Grafana | `string` | n/a | yes |
| <a name="input_sg_db_rule"></a> [sg\_db\_rule](#input\_sg\_db\_rule) | List of open ports for inbound connections | `list(string)` | n/a | yes |
| <a name="input_terraform_user_access_backend_list_policies"></a> [terraform\_user\_access\_backend\_list\_policies](#input\_terraform\_user\_access\_backend\_list\_policies) | List of CUSTOM policies for access to tf state backend | <pre>list(object({<br>    name        = string<br>    path        = string<br>    description = string<br>  }))</pre> | n/a | yes |
| <a name="input_type_resource"></a> [type\_resource](#input\_type\_resource) | Tag applied to each resources created in dev env | `string` | n/a | yes |
| <a name="input_user_name_mgmt_landing_page"></a> [user\_name\_mgmt\_landing\_page](#input\_user\_name\_mgmt\_landing\_page) | Username used to update CNAMEs Records for HubSpot LandingPages | `string` | n/a | yes |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | VPC Cidr Block | `string` | n/a | yes |
| <a name="input_worker_node_role"></a> [worker\_node\_role](#input\_worker\_node\_role) | Name of the worker node role | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->