terraform {
  backend "s3" {
    bucket         = "terraform-state-devs-env"
    key            = "terraform-state-devs-env/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "tfStateLockingDevsEnv"
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