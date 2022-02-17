variable "environment" {
  description = "Environment to deploy"
  type        = string
}

variable "worker_node_role" {
  description = "Name of the worker node role"
  type        = string
}

variable "iam_aws_worker_node_policies" {
  description = "AWS IAM managed policies for worker node"
  type        = list(string)
}

variable "customer_policy_worker_node" {
  description = "AWS IAM customer policies for worker node role"
  type        = list(string)
}

variable "manage_hosted_zone_policy" {
  description = "Policy to manage hosted zone"
  type        = string
}
