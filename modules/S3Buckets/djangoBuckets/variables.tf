variable "django_public_buckets" {
  description = "List of public buckets used by django app"
  type        = list(string)
}

variable "django_private_buckets" {
  description = "List of private buckets used by django app"
  type        = list(string)
}
