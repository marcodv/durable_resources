variable "gitlab_user" {
  description = "GitLab username"
  type        = string
}

variable "gitlab_bucket_name" {
  description = "Gitlab bucket name where to store pipeline logs"
  type        = string
}

variable "environment" {
  description = "Policies applied to a specific environment user"
  type        = string
}