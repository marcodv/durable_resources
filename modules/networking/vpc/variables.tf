variable "environment" {
  description = "Environment where we want to deploy"
  type        = string
}

variable "vpc_cidr_block" {
  description = "VPC Cidr Block"
  type = string
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

variable "sg_db_rule" {
  description = "List of open ports for inbound connections"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "public_subnets_cidr" {
  description = "List of cidr blocks"
  type        = list(string)
}

variable "private_subnets_cidr" {
  description = "List of cidr blocks"
  type        = list(string)
}

variable "bastions-ami" {
  description = "Ami id used to create bastion"
  type        = string
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

variable "sg_gitlab_runners_rules" {
  description = "List of open ports for inbound connections for GitLab runners"
  type        = list(string)
}