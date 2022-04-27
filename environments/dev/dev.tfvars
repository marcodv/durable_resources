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

// Policy to manage hosted zone
manage_hosted_zone_policy = "listHostedZonePolicydevEnv"

// Add customer policy to worker node
customer_policy_worker_node = ["AWSLoadBalancerControllerIAMPolicydevEnv", "listHostedZonePolicydevEnv"]

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

// policy to assign the read only view for grafana
read_only_billing_policy = "awsBillingPolicydevEnv"

// Grafana user name
grafana_user = "grafanaUserdevEnv"

// Grafana role name
grafana_role = "grafanaRoleddevEnv"

// Cluster Policy list for terraform user
tf_user_cluster_policies_mgmt = ["adminCluster", "describeCluster", "updateCluster", "viewNodeWorkload"]

/* Networking section */
bastions-ami                   = "ami-04dd4500af104442f"
vpc_cidr_block                 = "30.0.0.0/16"
public_subnets_cidr            = ["30.0.0.0/20", "30.0.16.0/20"]  //, "10.0.32.0/20"]
private_subnets_cidr           = ["30.0.48.0/20", "30.0.64.0/20"] //, "10.0.80.0/20"]
db_private_subnets_cidr        = ["30.0.96.0/20", "30.0.112.0/20"]
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

gitlab_user = "gitlabUserdevEnv"

gitlab_bucket_name = "gitlab-pipeline-execution-logs-dev-env"

registration_token_infra = "gitlabRunnerInfra"

aux_token = ""

registration_token_cluster_mgmt_chart = "gitlabRunnerClusterMgmtChart"



/* Gitlab runners parameters */
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
}

gitlab_project = ""
/* End Gitlab runners parameters */
