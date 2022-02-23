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

variable "eks_cluster_management_list_policies" {
  description = "List of the policies to associate to the cluster management group"
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

variable "attach_user_to_group" {
  description = "List of group to which the user is going to be part of "
  type        = list(string)
}

variable "cluster_users_mgmt" {
  description = "List of user to attach to the EKS IAM user gorup"
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

variable "eks_cluster_role_policies" {
  description = "List of policies for cluster role"
  type = list(object({
    name        = string
    path        = string
    description = string
  }))
}

variable "application_users" {
  description = "List of users to be used for development, staging and production environments"
  type = list(object({
    user_name      = string
    policy_name    = string
    public_bucket  = string
    private_bucket = string
  }))
}

variable "django_public_buckets" {
  description = "List of public buckets used by django app"
  type        = list(string)
}

variable "django_private_buckets" {
  description = "List of private buckets used by django app"
  type        = list(string)
}

variable "manage_hosted_zone_policy" {
  description = "Policy to manage hosted zone"
  type        = string
}

variable "cnames_landing_pages_mgmt_policy_name" {
  description = "Policy Name to create/update CNAMEs records"
  type        = string
}

variable "user_name_mgmt_landing_page" {
  description = "Username used to update CNAMEs Records for HubSpot LandingPages"
  type        = string
}

variable "lambda_role_bubble_backup" {
  description = "Role name for lambda function to call teh Bubble backup script"
  type        = string
}

variable "lambdaFunctionsEnvironmets" {
  description = "List of Lambda names for different backup script to call"
  type        = list(string)
}