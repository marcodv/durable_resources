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
worker_node_role = "WorkerNodeRoleprodEnv"

// Policies for the worker node role
aim_aws_worker_node_policies = ["AmazonEKSWorkerNodePolicy", "AmazonEC2ContainerRegistryReadOnly", "AmazonEKS_CNI_Policy"]

// Add customer policy to worker node
customer_policy_worker_node = ["AWSLoadBalancerControllerIAMPolicyprodEnv"]

// Policies for EKS Cluster group Management
eks_cluster_management_list_policies = [
  {
    name        = "EKSClusterAdmin",
    path        = "/"
    description = "Full admin rights to manage EKS"
  },
  {
    name        = "EKSDescribeCluster",
    path        = "/"
    description = "List and describe cluster"
  },
  {
    name        = "EKSUpdateCluster",
    path        = "/"
    description = "Allow update EKS cluster version"
  },
  {
    name        = "EKSViewNodesWorkload",
    path        = "/"
    description = "Describe node and workload"
  }
]

// Policies name for access to tf backend 
custom_policies_list = [
  {
    name        = "AccessDynamoDBBackendProdUser",
    path        = "/"
    description = "Access DynamoDB for store/read lockstate file for Prod user"
  },
  {
    name        = "AccessS3BackendProdUser",
    path        = "/"
    description = "Access S3 for store/read tf state file for Prod user"
  },
  {
    name        = "BastionEC2RolePolicyProdUser",
    path        = "/"
    description = "Role policy to access to the bastion"
  },
  {
    name        = "MixedPermissionProdUser",
    path        = "/"
    description = "List of permission for Prod user"
  }
]

iam_user_name = "Terraform_User_Prod_Env"

aws_managed_policies_list = ["ElasticLoadBalancingFullAccess", "AmazonVPCFullAccess"]

attach_user_to_group = ["EKSClusterManagement"]
