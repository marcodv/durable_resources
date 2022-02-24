variable "read_only_billing_policy" {
  description = "Policy to view dashboard metrics for Grafana"
  type        = string
}

variable "environment" {
  description = "Environment to deploy"
  type        = string
}

variable "grafana_role" {
  description = "Grafana Role name"
  type        = string
}
