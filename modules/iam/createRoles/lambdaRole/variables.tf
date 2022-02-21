variable "lambda_role_bubble_backup" {
  description = "Role name for lambda function to call teh Bubble backup script"
  type        = string
}

variable "environment" {
  description = "Environment to deploy"
  type        = string
}
