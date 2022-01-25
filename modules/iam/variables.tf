variable "environment" {
  type = string
}

variable "alb_ingress_controller" {
  type = object({
    name        = string
    path        = string
    description = string
  })
}
