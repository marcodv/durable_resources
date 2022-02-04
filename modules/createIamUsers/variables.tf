variable "environment" {
  description = "Policies applied to a specific environment user"
  type        = string
}

variable "custom_policies_list" {
  description = "List of CUSTOM policies to attach to the user"
  type = list(object({
    name        = string
    path        = string
    description = string
  }))
}

variable "iam_user_name" {
  description = "Name of the IAM user"
  type = string
}

variable "aws_managed_policies_list" {
  description = "List of AWS Managed policies to attach to user"
  type = list(string)
}
