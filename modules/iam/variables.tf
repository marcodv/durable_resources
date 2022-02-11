<<<<<<< HEAD
variable "environment" {
  description = "Environment to deploy"
  type        = string
}
=======
>>>>>>> develop


/*

variable "ec2_full_access" {
  type = object({
    name        = string
    path        = string
    description = string
  })
}

variable "iam_limited_access" {
  type = object({
    name        = string
    path        = string
    description = string
  })
}

variable "eks_all_access" {
  type = object({
    name        = string
    path        = string
    description = string
  })
} */




<<<<<<< HEAD
variable "worker_node_role" {
  description = "Name of the worker node role"
  type        = string
}

variable "customer_policy_worker_node" {
  description = "AWS IAM customer policies for worker node role"
  type        = list(string)
}

variable "worker_node_manage_ebs_volume" {
  description = "Worker node policy in order to access to the volume"
  type = object({
    name        = string
    path        = string
    description = string
  })
}
=======
>>>>>>> develop
