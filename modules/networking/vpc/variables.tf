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
