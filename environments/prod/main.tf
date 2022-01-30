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

module "iam" {
  source = "../../modules/iam"

  environment                     = var.environment
  alb_ingress_controller          = var.alb_ingress_controller
  ec2_full_access                 = var.ec2_full_access
  iam_limited_access              = var.iam_limited_access
  eks_all_access                  = var.eks_all_access
  alb_ingress_controller_role_env = var.alb_ingress_controller_role_env
}
