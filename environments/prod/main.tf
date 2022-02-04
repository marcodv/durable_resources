terraform {
  backend "s3" {
    bucket         = "terraform-state-durable-prod-env"
    key            = "terraform-state-durable-prod-env/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "tfStateLockingDurableProdEnv"
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

module "iamGroupUsers" {
  source = "../../modules/createIamUserGroup"

  eks_cluster_management_list_policies = var.eks_cluster_management_list_policies
}


module "createUsers" {
  source = "../../modules/createIamUsers"

  environment               = var.environment
  custom_policies_list      = var.custom_policies_list
  iam_user_name             = var.iam_user_name
  aws_managed_policies_list = var.aws_managed_policies_list
  attach_user_to_group      = var.attach_user_to_group
  cluster_users_mgmt = var.cluster_users_mgmt

}

module "iam" {
  source = "../../modules/iam"

  environment                     = var.environment
  alb_ingress_controller          = var.alb_ingress_controller
  ec2_full_access                 = var.ec2_full_access
  iam_limited_access              = var.iam_limited_access
  eks_all_access                  = var.eks_all_access
  alb_ingress_controller_role_env = var.alb_ingress_controller_role_env
  iam_customer_eks_policies       = var.iam_customer_eks_policies
  iam_aws_eks_policies            = var.iam_aws_eks_policies
  aim_aws_worker_node_policies    = var.aim_aws_worker_node_policies
  worker_node_role                = var.worker_node_role
  customer_policy_worker_node     = var.customer_policy_worker_node
}
