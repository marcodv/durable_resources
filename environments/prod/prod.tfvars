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

// Policy to manage hosted zone
manage_hosted_zone_policy = "listHostedZonePolicyprodEnv"

// Add customer policy to worker node
customer_policy_worker_node = ["AWSLoadBalancerControllerIAMPolicyprodEnv", "listHostedZonePolicyprodEnv"]

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

cluster_users_mgmt = ["bastiaan@noah.energy", "marco@noah.energy"]

attach_user_to_group = ["EKSClusterManagement"]

// List of applications users with bucket name and policy
application_users = [
  {
    user_name      = "app_User_dev_Env",
    policy_name    = "DjangoBucketPolicydevEnv",
    public_bucket  = "django-public-bucket-dev-env",
    private_bucket = "django-private-bucket-dev-env"
  },
  {
    user_name      = "app_User_stage_Env",
    policy_name    = "DjangoBucketPolicystageEnv",
    public_bucket  = "django-public-bucket-stage-env",
    private_bucket = "django-private-bucket-stage-env"
  },
  {
    user_name      = "app_User_prod_Env",
    policy_name    = "DjangoBucketPolicyprodEnv",
    public_bucket  = "django-public-bucket-prod-env",
    private_bucket = "django-private-bucket-prod-env"
  }
]

// List of Django public buckets
django_public_buckets = ["django-public-bucket-dev-env", "django-public-bucket-stage-env", "django-public-bucket-prod-env"]

// List of Django private buckets 
django_private_buckets = ["django-private-bucket-dev-env", "django-private-bucket-stage-env", "django-private-bucket-prod-env"]

// account to create cnames records 
user_name_mgmt_landing_page = "user_mgmt_cnames_records"

// Policy name to assign to the user for create cnames records
cnames_landing_pages_mgmt_policy_name = "cnameRecordsMgmtPolicy"

// Role name for Lambda function in order to call the Bubble backups script
lambda_role_bubble_backup = "lambdaRoleBubbleBackupprodEnv"

// List of environment in app script for call backup 
lambdaFunctionsEnvironmets = ["UAT", "test", "production"]

// policy to assign the read only view for grafana
read_only_billing_policy = "awsBillingPolicyprodEnv"

// Grafana role name
grafana_role = "grafanaRoledprodEnv"

// Grafana user name
grafana_user = "grafanaUserprodEnv"

// Role name for Lambda function in order to call the Bubble backups deletion script
lambda_role_delete_bubble_backup = "lambdaRoleDeleteBubbleBackup"

// ==== THESE SETTING ARE FOR PROD VPC WHERE SETUP POSTGRES ====
bastions-ami                   = "ami-04dd4500af104442f"
vpc_cidr_block                 = "10.0.0.0/16"
public_subnets_cidr            = ["10.0.0.0/20", "10.0.16.0/20"]  //, "10.0.32.0/20"]
private_subnets_cidr           = ["10.0.48.0/20", "10.0.64.0/20"] //, "10.0.80.0/20"]
db_private_subnets_cidr        = ["10.0.96.0/20", "10.0.112.0/20"]
availability_zones             = ["eu-west-1a", "eu-west-1b"] //, "eu-west-1c"]
alb_ingress_rule               = [80, 443]
eks_ingress_rule               = [22, 53, 80, 443]
bastion_ingress_rule           = [22, 80, 443]
private_instances_ingress_rule = [22, 53, 80, 443, 30080]
sg_db_rule                     = [22, 5432, 6379]
sg_gitlab_runners_rules        = [22, 2376]
acl_public_subnet_rule = {
  ingress_rule = [{
    rule_no   = 100
    from_port = 22
    to_port   = 22
    },
    {
      rule_no   = 101
      from_port = 80
      to_port   = 80
    },
    {
      rule_no   = 102
      from_port = 443
      to_port   = 443
    },
    {
      rule_no   = 103
      from_port = 5432
      to_port   = 5432
    },
    {
      rule_no   = 104
      from_port = 6379
      to_port   = 6379
    },
    {
      rule_no   = 105
      from_port = 30080
      to_port   = 30080
    },
    {
      rule_no   = 200
      from_port = 1025
      to_port   = 65535
  }]
}

acl_private_subnet_rule = {
  ingress_rule = [{
    rule_no   = 100
    from_port = 22
    to_port   = 22
    },
    {
      rule_no   = 101
      from_port = 80
      to_port   = 80
    },
    {
      rule_no   = 102
      from_port = 443
      to_port   = 443
    },
    {
      rule_no   = 103
      from_port = 5432
      to_port   = 5432
    },
    {
      rule_no   = 104
      from_port = 6379
      to_port   = 6379
    },
    {
      rule_no   = 105
      from_port = 5671
      to_port   = 5671
    },
    {
      rule_no   = 106
      from_port = 30080
      to_port   = 30080
    },
    {
      rule_no   = 107
      from_port = 53
      to_port   = 53
    },
    {
      rule_no   = 108
      from_port = 443
      to_port   = 443
    },
    {
      rule_no   = 109
      from_port = 2376
      to_port   = 2376
    },
    {
      rule_no   = 200
      from_port = 1025
      to_port   = 65535
  }]
}

acl_db_rule = {
  ingress_rule = [{
    rule_no   = 100
    from_port = 5432
    to_port   = 5432
    },
    {
      rule_no   = 101
      from_port = 6379
      to_port   = 6379
    },
    {
      rule_no   = 102
      from_port = 22
      to_port   = 22
    }
  ]
}
/* End Networking section*/

// ===== Elasticache Settings ====
elasticache_setting = {
  engine          = "redis"
  node_type       = "cache.t3.micro"
  num_cache_nodes = 1
  engine_version  = "6.x"
  family          = "redis6.x"
  port            = 6379
}

// Cluster Policy list for terraform user
tf_user_cluster_policies_mgmt = ["adminCluster", "describeCluster", "updateCluster", "viewNodeWorkload"]

/* Gitlab runners parameters */
gitlab_user = "gitlabUserdevEnv"

gitlab_bucket_name = "gitlab-pipeline-execution-logs-dev-env"

registration_token_infra = "gitlabRunnerInfra"

aux_token = ""

registration_token_cluster_mgmt_chart = "gitlabRunnerClusterMgmtChart"

registration_token_apps_charts = "gitlabRunnerApplicationsChart"

aws_region = "eu-west-1"

ami_owners = "848481299679"

metrics_autoscaling = ["GroupDesiredCapacity", "GroupInServiceCapacity"]

docker_machine_paramenters = {
  image_version  = "docker:19.03.8-dind"
  instance_type  = "t3.medium"
  spot_price_bid = "0.0137"
  url_download   = "https://gitlab-docker-machine-downloads.s3.amazonaws.com/v0.16.2-gitlab.2/docker-machine"
}

runner_parameters = {
  description                = "runner-agent"
  runner_instance_spot_price = "0.0137"
  instance_type              = "t3.medium"
  gitlab_url                 = "https://gitlab.com/"
}

gitlab_project_list = {
  durable            = "durable-resource-aws"
  infra              = "infra-aws"
  cluster_mgmt_chart = "cluster_mgmt_chart"
  applications_chart = "applications_chart"
}

gitlab_project = ""
/* End Gitlab runners parameters */