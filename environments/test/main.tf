terraform {
  backend "s3" {
    bucket         = "terraform-state-durable-test-env"
    key            = "terraform-state-durable-test-env/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "tfStateLockingDurableTestEnv"
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

  environment            = var.environment
  alb_ingress_controller = var.alb_ingress_controller
}
