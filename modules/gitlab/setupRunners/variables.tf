variable "environment" {
  description = "Environment where we want to deploy"
  type        = string
}

variable "registration_token" {
  description = "Token generated from GitLab to register runners"
  type = string
}

variable "gitlab_bucket_name" {
  description = "Gitlab bucket name where to store pipeline logs"
  type        = string
}