environment = "prod"

type_resource = "durable"

// This need to contains only name for test env. For prod env need to be used the prod account
alb_ingress_controller_role_env = ["alb-controller-prod-env"]

// Policies created for EKS resources
iam_customer_eks_policies = ["AWSLoadBalancerControllerIAMPolicy", "AWSFullAccessEC2ForEKS", "AWSLimitedAccessIAM", "AWSAllAccessEKS"]

// AWS policies for EKS resource
iam_aws_eks_policies = ["AmazonEKSVPCResourceController", "AmazonEKSWorkerNodePolicy", "AmazonEKSClusterPolicy", "AmazonEKS_CNI_Policy", "AmazonEC2ContainerRegistryReadOnly"]

// Name of the worker node role
worker_node_role = "WorkerNodeRoleprodEnv"

// Policies for the worker node role
iam_aws_worker_node_policies = ["AmazonEKSWorkerNodePolicy", "AmazonEC2ContainerRegistryReadOnly", "AmazonEKS_CNI_Policy", "AmazonEKSClusterPolicy"]

// Add customer policy to worker node
customer_policy_worker_node = ["AWSLoadBalancerControllerIAMPolicyprodEnv", "listHostedZonePolicy"]

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
terraform_user_access_backend_list_policies = [
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

eks_cluster_role_policies = [
  {
    name        = "AWSLimitedAccessIAMprodEnv"
    path        = "/"
    description = "IAM limited access policy for EKS in Prod Env"
  },
  {
    name        = "AWSFullAccessEC2ForEKSprodEnv"
    path        = "/"
    description = "EC2 Full Access policy for EKS in Prod Env"
  },
  {
    name        = "AWSAllAccessEKSprodEnv"
    path        = "/"
    description = "EKS full access policy in Prod env"
  },
  {
    name        = "AWSLoadBalancerControllerIAMPolicyprodEnv"
    path        = "/"
    description = "ALB controller Policy in Prod Env"
  }
]

iam_user_name = "Terraform_User_Prod_Env"

aws_managed_policies_list = ["ElasticLoadBalancingFullAccess", "AmazonVPCFullAccess"]

cluster_users_mgmt = ["Terraform_User_Prod_Env", "Terraform_User_Dev_Env", "bastiaan@noah.energy", "marco@noah.energy"]

attach_user_to_group = ["EKSClusterManagement"]

// List of applications users with bucket name and policy
application_users = [
  {
    user_name     = "app_User_dev_Env",
    policy_name   = "DjangoBucketPolicydevEnv",
    public_bucket = "django-public-bucket-dev-env",
    private_bucket = "django-private-bucket-dev-env"
  },
  {
    user_name   = "app_User_stage_Env",
    policy_name = "DjangoBucketPolicystageEnv",
    public_bucket = "django-public-bucket-stage-env",
    private_bucket = "django-private-bucket-stage-env"
  },
  {
    user_name   = "app_User_prod_Env",
    policy_name = "DjangoBucketPolicyprodEnv",
    public_bucket = "django-public-bucket-prod-env",
    private_bucket = "django-private-bucket-prod-env"
  }
]

// List of Django public buckets
django_public_buckets = ["django-public-bucket-dev-env", "django-public-bucket-stage-env", "django-public-bucket-prod-env"]

// List of Django private buckets 
django_private_buckets = ["django-private-bucket-dev-env", "django-private-bucket-stage-env", "django-private-bucket-prod-env"]
