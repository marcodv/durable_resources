<!-- BEGIN_TF_DOCS -->
This module is used to create a IAM groups for dev and prod environment

To each group are assigned different IAM accounts

Each group have managed and custom policies  

These are the groups created

- EKSClusterManagement

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
| [aws_iam_group.eks_cluster_mgmt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group) | resource |
| [aws_iam_group_membership.attach_user_to_cluster_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_membership) | resource |
| [aws_iam_group_policy_attachment.cluster_mgmt_policies](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_policy.cluster_mgmt_policies_list](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attach_user_to_group"></a> [attach\_user\_to\_group](#input\_attach\_user\_to\_group) | List of group to which the user is going to be part of | `list(string)` | n/a | yes |
| <a name="input_cluster_users_mgmt"></a> [cluster\_users\_mgmt](#input\_cluster\_users\_mgmt) | List of user to attach to the EKS IAM user gorup | `list(string)` | n/a | yes |
| <a name="input_eks_cluster_management_list_policies"></a> [eks\_cluster\_management\_list\_policies](#input\_eks\_cluster\_management\_list\_policies) | List of the policies to associate to the cluster management group | <pre>list(object({<br>    name        = string<br>    path        = string<br>    description = string<br>  }))</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->