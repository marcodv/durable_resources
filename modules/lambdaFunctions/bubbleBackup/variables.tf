variable "environment" {
  description = "Environment to deploy"
  type        = string
}

variable "lambda_role_bubble_backup" {
  description = "Role name for lambda function to call teh Bubble backup script"
  type        = string
}

variable "lambdaFunctionsEnvironmets" {
  description = "List of Lambda names for different backup script to call"
  type        = list(string)
}
