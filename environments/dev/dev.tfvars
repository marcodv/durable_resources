environment = "dev"

type_resource = "durable"

alb_ingress_controller = {
  name        = "AWSLoadBalancerControllerIAMPolicydevEnv"
  path        = "/"
  description = "ALB controller Policy in Dev Env"
}

ec2_full_access = {
  name        = "AWSFullAccessEC2ForEKSdevEnv"
  path        = "/"
  description = "EC2 Full Access policy for EKS in Dev Env"
}

iam_limited_access = {
  name        = "AWSLimitedAccessIAMdevEnv"
  path        = "/"
  description = "IAM limited access policy for EKS in Dev Env"
}

eks_all_access = {
  name        = "AWSAllAccessEKSdevEnv"
  path        = "/"
  description = "EKS full access policy in dev env"
}

// This need to contains only name for test env. For dev env need to be used the dev account
alb_ingress_controller_role_env = ["alb-controller-dev-env"]

// Policies created for EKS resources
iam_customer_eks_policies = ["AWSLoadBalancerControllerIAMPolicy", "AWSFullAccessEC2ForEKS", "AWSLimitedAccessIAM", "AWSAllAccessEKS"]

// AWS policies for EKS resource
iam_aws_eks_policies = ["AmazonEKSVPCResourceController", "AmazonEKSWorkerNodePolicy", "AmazonEKSClusterPolicy", "AmazonEKS_CNI_Policy", "AmazonEC2ContainerRegistryReadOnly"]

// Name of the worker node role
worker_node_role = "WorkerNodeRoledevEnv"

// Policies for the worker node role
aim_aws_worker_node_policies = ["AmazonEKSWorkerNodePolicy", "AmazonEC2ContainerRegistryReadOnly", "AmazonEKS_CNI_Policy"]

// Add customer policy to worker node
customer_policy_worker_node = ["AWSLoadBalancerControllerIAMPolicydevEnv"]
