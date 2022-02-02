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