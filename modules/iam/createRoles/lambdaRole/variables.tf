variable "lambda_role_bubble_backup" {
  description = "Role name for lambda function to call teh Bubble backup script"
  type        = string
}

variable "environment" {
  description = "Environment to deploy"
  type        = string
}

variable "lambda_role_delete_bubble_backup" {
  description = "Role name for lambda function to call Bubble backup deletion script"
  type        = string
}
