environment = "test"

type_resource = "durable"

alb_ingress_controller = {
  name        = "AWSLoadBalancerControllerIAMPolicy"
  path        = "/"
  description = "AWS ALB controller Policy"
}
