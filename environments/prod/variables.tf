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
