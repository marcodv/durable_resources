variable "environment" {
  description = "Environment to deploy"
  type        = string
}

variable "grafana_user" {
  description = "Grafana User"
  type        = string
}

variable "read_only_billing_policy" {
  description = "Policy to view dashboard metrics for Grafana"
  type        = string
}