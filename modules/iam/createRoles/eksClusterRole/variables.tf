variable "environment" {
  description = "Environment to deploy"
  type        = string
}

variable "iam_aws_eks_policies" {
  description = "AWS IAM managed policies for EKS"
  type        = list(string)
}

variable "iam_customer_eks_policies" {
  description = "AWS IAM customer policies for EKS"
  type        = list(string)
}

variable "alb_ingress_controller_role_env" {
  description = "List of ALB ingress controller roles for environment"
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
