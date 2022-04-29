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

/* Networking Section*/
variable "vpc_cidr_block" {
  description = "VPC cidr block"
  type        = string
}

variable "public_subnets_cidr" {
  description = "List of cidr blocks"
  type        = list(string)
}

variable "private_subnets_cidr" {
  description = "List of cidr blocks"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "bastion_ingress_rule" {
  description = "List of open ports for inbound connections"
  type        = list(number)
}

variable "public_subnet_alb" {
  description = "List of public subnets for ALB"
  default     = ""
}

variable "sg_alb" {
  description = "Security group for ALB"
  default     = ""
}

variable "vpc_id" {
  description = "VPC id"
  default     = ""
}

variable "alb_ingress_rule" {
  description = "List of open ports for inbound connections"
  type        = list(number)
}

variable "eks_ingress_rule" {
  description = "List of open ports for inbound connections"
  type        = list(number)
}

variable "private_instances_ingress_rule" {
  description = "List of open ports for inbound connections"
  type        = list(number)
}

variable "acl_public_subnet_rule" {
  description = "List of rule_no and inbound ports open"
  type = object({
    ingress_rule = list(object({
      rule_no   = number
      from_port = number
      to_port   = number
    }))
  })
}

variable "acl_private_subnet_rule" {
  description = "List of rule_no and inbound ports open"
  type = object({
    ingress_rule = list(object({
      rule_no   = number
      from_port = number
      to_port   = number
    }))
  })
}

variable "sg_db_rule" {
  description = "List of open ports for inbound connections"
  type        = list(string)
}

variable "acl_db_rule" {
  description = "List of rule_no and inbound ports open"
  type = object({
    ingress_rule = list(object({
      rule_no   = number
      from_port = number
      to_port   = number
    }))
  })
}

variable "db_private_subnets_cidr" {
  description = "List of private subnets for DB"
  type        = list(string)
  default     = []
}

variable "sg_gitlab_runners_rules" {
  description = "List of open ports for inbound connections for GitLab runners"
  type        = list(string)
}
/* End Networking Section*/

variable "db_subnet_ids" {
  description = "List of private subnets for DB"
  type        = list(string)
  default     = []
}

variable "db_sg" {
  description = "DB Security group id"
  type        = string
  default     = ""
}

// Create gitlab users
variable "gitlab_user" {
  description = "GitLab username"
  type        = string
}

// Define S3 policy name for GitLab 
variable "gitlab_bucket_name" {
  description = "Gitlab bucket name where to store pipeline logs"
  type        = string
}

/* Gitlab runners parameters */
variable "registration_token_infra" {
  description = "Token for infra aws"
  type        = string
}

variable "aux_token" {
  description = "Aux token variable"
  type = string
  default = ""
}

variable "registration_token_cluster_mgmt_chart" {
  description = "Token for cluster mgmt chart"
  type        = string
}

variable "registration_token" {
  description = "Token generic"
  type        = string
  default = ""
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "ami_owners" {
  description = "Account ID from where search the pre-built AMI with all the packages"
  type        = number
}

variable "metrics_autoscaling" {
  description = "List of metrics used for autoscale the runnners"
  type        = list(string)
}

variable "docker_machine_paramenters" {
  description = "List of parameters for the docker machines"
  type = object({
    image_version  = string
    instance_type  = string
    spot_price_bid = string
    url_download   = string
  })
}

variable "runner_parameters" {
  description = "List of parameters for the runners"
  type = object({
    description                = string
    runner_instance_spot_price = string
    instance_type              = string
    gitlab_url                 = string
  })
}

variable "gitlab_project_list" {
  description = "List of GitLab project for which spin up the runners"
  type = object({
    durable            = string
    infra              = string
    cluster_mgmt_chart = string
  })
}

variable "gitlab_project" {
  description = "GitLab project"
  type        = string
}
/* End Gitlab runners parameters */
