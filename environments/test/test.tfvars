environment = "test"

type_resource = "durable"

alb_ingress_controller = {
  name        = "AWSLoadBalancerControllerIAMPolicy"
  path        = "/"
  description = "ALB controller Policy"
}

ec2_full_access = {
  name        = "AWSFullAccessEC2ForEKS"
  path        = "/"
  description = "EC2 Full Access policy for EKS"
}

iam_limited_access = {
  name        = "AWSLimitedAccessIAM"
  path        = "/"
  description = "IAM limited access policy for EKS"
}

eks_all_access = {
  name        = "AWSAllAccessEKS"
  path        = "/"
  description = "EKS full access policy"
}