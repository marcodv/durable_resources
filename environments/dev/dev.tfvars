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

worker_node_manage_ebs_volume = {
  name        = "EFSClusterPolicydevEnv"
  path        = "/"
  description = "Worker node policy to manage EBS volume"
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
customer_policy_worker_node = ["AWSLoadBalancerControllerIAMPolicydevEnv", "EFSClusterPolicydevEnv"]

// Policies name for access to tf backend 
custom_policies_list = [
  {
    name        = "AccessDynamoDBBackendDevUser",
    path        = "/"
    description = "Access DynamoDB for store/read lockstate file for Dev user"
  },
  {
    name        = "AccessS3BackendDevUser",
    path        = "/"
    description = "Access S3 for store/read tf state file for Dev user"
  },
  {
    name        = "BastionEC2RolePolicyDevUser",
    path        = "/"
    description = "Role policy to access to the bastion"
  },
  {
    name        = "MixedPermissionDevUser",
    path        = "/"
    description = "List of permission for Dev user"
  }
]

iam_user_name = "Terraform_User_Dev_Env"

aws_managed_policies_list = ["ElasticLoadBalancingFullAccess", "AmazonVPCFullAccess"]
