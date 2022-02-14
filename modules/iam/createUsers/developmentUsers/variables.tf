variable "application_users" {
  description = "List of users to be used for development, staging and production environments"
  type = list(object({
    user_name      = string
    policy_name    = string
    public_bucket  = string
    private_bucket = string
  }))
}
