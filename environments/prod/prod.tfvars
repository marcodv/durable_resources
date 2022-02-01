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

// This need to contains only name for test env. For prod env need to be used the prod account
alb_ingress_controller_role_env = ["alb-controller-prod-env"]

// Policies created for EKS resources
iam_customer_eks_policies = ["AWSLoadBalancerControllerIAMPolicy", "AWSFullAccessEC2ForEKS", "AWSLimitedAccessIAM", "AWSAllAccessEKS"]

// AWS policies for EKS resource
iam_aws_eks_policies = ["AmazonEKSVPCResourceController", "AmazonEKSWorkerNodePolicy", "AmazonEKSClusterPolicy", "AmazonEKS_CNI_Policy", "AmazonEC2ContainerRegistryReadOnly"]

// Name of the worker node role
worker_node_role = "WorkerNodeRoletestEnv"

// Policies for the worker node role
aim_aws_worker_node_policies = ["AmazonEKSWorkerNodePolicy", "AmazonEC2ContainerRegistryReadOnly", "AmazonEKS_CNI_Policy"]
