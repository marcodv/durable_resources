variable "environment" {
  description = "Environment where we want to deploy"
  type        = string
}

variable "type_resource" {
  description = "Tag applied to each resources created in dev env"
  type        = string
}

variable "alb_ingress_controller_role_env" {
  description = "List of ALB ingress controller roles for environment"
  type        = list(string)
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
  type        = string
}

variable "iam_aws_worker_node_policies" {
  description = "List of policies to attach to the worker node role"
  type        = list(string)
}

variable "customer_policy_worker_node" {
  description = "AWS IAM customer policies for worker node role"
  type        = list(string)
}


variable "terraform_user_access_backend_list_policies" {
  description = "List of CUSTOM policies for access to tf state backend"
  type = list(object({
    name        = string
    path        = string
    description = string
  }))
}

variable "iam_user_name" {
  description = "Name of the IAM user"
  type        = string
}

variable "aws_managed_policies_list" {
  description = "List of AWS Managed policies to attach to user"
  type        = list(string)
}


variable "eks_cluster_role_policies" {
  description = "List of policies for cluster role"
  type = list(object({
    name        = string
    path        = string
    description = string
  }))
}

variable "manage_hosted_zone_policy" {
  description = "Policy to manage hosted zone"
  type        = string
}

variable "read_only_billing_policy" {
  description = "Policy to view dashboard metrics for Grafana"
  type        = string
}

variable "grafana_user" {
  description = "Grafana User"
  type        = string
}

variable "grafana_role" {
  description = "Grafana Role name"
  type        = string
}

variable "tf_user_cluster_policies_mgmt" {
  description = "List of values for cluster policies"
  type        = list(string)
}