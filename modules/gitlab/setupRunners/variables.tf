variable "environment" {
  description = "Environment where we want to deploy"
  type        = string
}

variable "registration_token_infra" {
  description = "Token for infra aws"
  type        = string
}

variable "aux_token" {
  description = "Aux token variable"
  type = string
}

variable "registration_token_cluster_mgmt_chart" {
  description = "Token for cluster mgmt chart"
  type        = string
}

variable "registration_token" {
  description = "Token generic"
  type        = string
}

variable "registration_token_apps_charts" {
  description = "Token for cluster applications chart"
  type        = string
}

variable "gitlab_bucket_name" {
  description = "Gitlab bucket name where to store pipeline logs"
  type        = string
}

/* Gitlab runners parameters */
variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "ami_owners" {
  description = "Account ID from where search the pre-built AMI with all the packages"
  type        = number
}

variable "metrics_autoscaling" {
  description = "List of metrics used for autoscale the runnners"
  type        = list(string)
}

variable "docker_machine_paramenters" {
  description = "List of parameters for the docker machines"
  type = object({
    image_version  = string
    instance_type  = string
    spot_price_bid = string
    url_download   = string
  })
}

variable "runner_parameters" {
  description = "List of parameters for the runners"
  type = object({
    description                = string
    runner_instance_spot_price = string
    instance_type              = string
    gitlab_url                 = string
  })
}

variable "gitlab_project_list" {
  description = "List of GitLab project for which spin up the runners"
  type = object({
    durable            = string
    infra              = string
    cluster_mgmt_chart = string
  })
}

variable "gitlab_project" {
  description = "GitLab project"
  type        = string
}
/* End Gitlab runners parameters */
