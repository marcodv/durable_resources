environment = "prod"

type_resource = "durable"

alb_ingress_controller = {
  name        = "AWSLoadBalancerControllerIAMPolicyprodEnv"
  path        = "/"
  description = "ALB controller Policy in Prod Env"
}

ec2_full_access = {
  name        = "AWSFullAccessEC2ForEKSprodEnv"
  path        = "/"
  description = "EC2 Full Access policy for EKS in Prod Env"
}

iam_limited_access = {
  name        = "AWSLimitedAccessIAMprodEnv"
  path        = "/"
  description = "IAM limited access policy for EKS in Prod Env"
}

eks_all_access = {
  name        = "AWSAllAccessEKSprodEnv"
  path        = "/"
  description = "EKS full access policy in Prod env"
}

alb_ingress_controller_role_env = ["alb-controller-prod-env"]