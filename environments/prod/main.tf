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

/*
module "iamGroupUsers" {
  source = "../../modules/createIamUserGroup"

  eks_cluster_management_list_policies = var.eks_cluster_management_list_policies
  attach_user_to_group                 = var.attach_user_to_group
  cluster_users_mgmt                   = var.cluster_users_mgmt
} */

