variable "environment" {
  description = "Policies applied to a specific environment user"
  type        = string
}

variable "access_tf_backend_policies" {
  description = "S3 and DynamoDB policies for using the remote tf backend"
  type = list(object({
    name        = string
    path        = string
    description = string
  }))
}

variable "custom_policies_list" {
  description = "List of CUSTOM policies to attach to the user"
  type = list(object({
    name        = string
    path        = string
    description = string
  }))
}
