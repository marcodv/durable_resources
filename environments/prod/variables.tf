variable "environment" {}

variable "alb_ingress_controller" {}

variable "type_resource" {}

variable "ec2_full_access" {}

variable "iam_limited_access" {}

variable "eks_all_access" {}

variable "alb_ingress_controller_role_env" {
  description = "List of ALB ingress controller roles for environment"
  type = list(string)
}

variable "iam_customer_eks_policies" {
  description = "AWS IAM customer policies for EKS"
  type        = list(string)
}

variable "iam_aws_eks_policies" {
  description = "AWS IAM managed policies for EKS"
  type        = list(string)
}

variable "worker_node_role" {
  description = "Name of the worker node role"
  type = string
}

variable "aim_aws_worker_node_policies" {
  description = "List of policies to attach to the worker node role"
  type        = list(string)
}

variable "customer_policy_worker_node" {
  description = "AWS IAM customer policies for worker node role"
  type        = list(string)
}

variable "eks_cluster_management_list_policies" {
  description = "List of the policies to associate to the cluster management group"
  type = list(object({
    name        = string
    path        = string
    description = string
  }))
}

variable "custom_policies_list" {
  description = "List of CUSTOM policies to attach to the user"
  type = list(object({
    name        = string
    path        = string
    description = string
  }))
}

variable "iam_user_name" {
  description = "Name of the IAM user"
  type = string
}

variable "aws_managed_policies_list" {
  description = "List of AWS Managed policies to attach to user"
  type = list(string)
}

variable "attach_user_to_group" {
  description = "List of group to which the user is going to be part of "
  type = list(string)
}

variable "cluster_users_mgmt" {
  description = "List of user to attach to the EKS IAM user gorup"
  type = list(string)
}