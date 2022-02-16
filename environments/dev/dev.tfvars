environment = "dev"

type_resource = "durable"

// This need to contains only name for test env. For dev env need to be used the dev account
alb_ingress_controller_role_env = ["alb-controller-dev-env"]

// Policies created for EKS resources
iam_customer_eks_policies = ["AWSLoadBalancerControllerIAMPolicy", "AWSFullAccessEC2ForEKS", "AWSLimitedAccessIAM", "AWSAllAccessEKS"]

// AWS policies for EKS resource
iam_aws_eks_policies = ["AmazonEKSVPCResourceController", "AmazonEKSWorkerNodePolicy", "AmazonEKSClusterPolicy", "AmazonEKS_CNI_Policy", "AmazonEC2ContainerRegistryReadOnly"]

// Name of the worker node role
worker_node_role = "WorkerNodeRoledevEnv"

// Policies for the worker node role
iam_aws_worker_node_policies = ["AmazonEKSWorkerNodePolicy", "AmazonEC2ContainerRegistryReadOnly", "AmazonEKS_CNI_Policy", "AmazonEKSClusterPolicy"]

// Add customer policy to worker node
customer_policy_worker_node = ["AWSLoadBalancerControllerIAMPolicydevEnv", "listHostedZonePolicy"]

// Policies name for access to tf backend 
terraform_user_access_backend_list_policies = [
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

eks_cluster_role_policies = [
  {
    name        = "AWSAllAccessEKSdevEnv"
    path        = "/"
    description = "EKS full access policy in dev env"
  },
  {
    name        = "AWSLimitedAccessIAMdevEnv"
    path        = "/"
    description = "IAM limited access policy for EKS in Dev Env"
  },
  {
    name        = "AWSFullAccessEC2ForEKSdevEnv"
    path        = "/"
    description = "EC2 Full Access policy for EKS in Dev Env"
  },
  {
    name        = "AWSLoadBalancerControllerIAMPolicydevEnv"
    path        = "/"
    description = "ALB controller Policy in Dev Env"
  }
]

iam_user_name = "Terraform_User_Dev_Env"

aws_managed_policies_list = ["ElasticLoadBalancingFullAccess", "AmazonVPCFullAccess"]
