terraform {
  backend "s3" {
    bucket         = "terraform-state-durable-dev-env"
    key            = "terraform-state-durable-dev-env/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "tfStateLockingDurableDevEnv"
  }
}

provider "aws" {
  region = "eu-west-1"
  default_tags {
    tags = {
      Environment   = var.environment
      Type_Resource = var.type_resource
    }
  }
}

// Create IAM terraform user
module "createUsers" {
  source = "../../modules/iam/createUsers/terraformUsers"

  environment                                 = var.environment
  iam_user_name                               = var.iam_user_name
  terraform_user_access_backend_list_policies = var.terraform_user_access_backend_list_policies
  aws_managed_policies_list                   = var.aws_managed_policies_list
}

// Create cluster roles
module "createClusterRoles" {
  source = "../../modules/iam/createRoles/eksClusterRole"

  environment                     = var.environment
  iam_aws_eks_policies            = var.iam_aws_eks_policies
  iam_customer_eks_policies       = var.iam_customer_eks_policies
  alb_ingress_controller_role_env = var.alb_ingress_controller_role_env
  eks_cluster_role_policies       = var.eks_cluster_role_policies

}

// Create worker node role
module "createWorkerNodeRole" {
  source = "../../modules/iam/createRoles/eksWorkerNodeRole"

  environment                  = var.environment
  worker_node_role             = var.worker_node_role
  iam_aws_worker_node_policies = var.iam_aws_worker_node_policies
  customer_policy_worker_node  = var.customer_policy_worker_node
}

/*
module "iam" {
  source = "../../modules/iam"

  //environment = var.environment
  // refactor these policies to use a list of policies
  //alb_ingress_controller          = var.alb_ingress_controller
  //ec2_full_access                 = var.ec2_full_access
  //iam_limited_access              = var.iam_limited_access
  //eks_all_access                  = var.eks_all_access
  //alb_ingress_controller_role_env = var.alb_ingress_controller_role_env
  //worker_node_manage_ebs_volume   = var.worker_node_manage_ebs_volume
  /* refactor up to these policies */
/*iam_customer_eks_policies    = var.iam_customer_eks_policies
  iam_aws_eks_policies         = var.iam_aws_eks_policies
  iam_aws_worker_node_policies = var.iam_aws_worker_node_policies
  worker_node_role             = var.worker_node_role
  customer_policy_worker_node  = var.customer_policy_worker_node 
} */
