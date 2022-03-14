/* 
 * The file in the Dev folder of this project, allow you to create durable resources for Dev env
 *
 * Dev and Prod env create different resources.
 *
 * If you want to change any of the values for the resources created here,  
 *
 * you need to edit dev.tfvars
 *
 * This is the list of durable resources created for **Dev environment**
 *
 * - Terraform users
 * - Cluster role 
 * - Worker node role
*/

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
  manage_hosted_zone_policy    = var.manage_hosted_zone_policy
}

// Create Grafana role 
module "createGrafanaRole" {
  source = "../../modules/iam/createRoles/grafanaRoleCloudWatch"

  environment              = var.environment
  read_only_billing_policy = var.read_only_billing_policy
  grafana_role             = var.grafana_role
}

// Create Grafana User
module "createGrafanaUser" {
  source = "../../modules/iam/createUsers/grafanaUser"

  environment              = var.environment
  grafana_user             = var.grafana_user
  read_only_billing_policy = var.read_only_billing_policy
}
