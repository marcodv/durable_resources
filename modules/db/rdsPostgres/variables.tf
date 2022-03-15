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

variable "environment" {
  description = "Environment where we want to deploy"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}