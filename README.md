# AWS Durable

## DESCRIPTION

This project allow to create resources which need to be permanent, such as DB, Lambda function, S3 storages


## Content
This is the list of resources created by this project:
- S3 
- RDS DB Postgres
- Elasticache Redis engine 
- IAM accounts/groups/roles
- Networking vpc

# Table of Contents
1. [Pre-requisite](#prerequisite)
2. [Run via laptop](#runlaptop)
3. [VPC Peering](https://gitlab.com/noah-energy/infranoah/infra_aws/-/wikis/VPC-Peering-creation)


## Pre-requisite

You can run this project via [pipeline](https://gitlab.com/noah-energy/infranoah/durable-resources-aws/-/pipelines) or via laptop. 

In case you want to run it by laptop, you need to use a specific [IAM user account](https://console.aws.amazon.com/iamv2/home#/users) which is thighed to prod or dev.

A part for that you need to install [aws cli](https://aws.amazon.com/cli/) and configure it for use the prod or dev account.

Once you got the **_aws_access_key_id_** and **_aws_secret_access_key_** you can set these values in your **~/.aws/credentials** like in the example below

```
[environment_name]
aws_access_key_id=*********TUI
aws_secret_access_key=*********P7O
region=eu-west-1
output=json
```

or you can run aws configure which will ask for the credentials on command line

### IAM Users account for spin up prod or dev

The IAM users credentials are stored on our [bitwarden space](https://bitwarden.com/).

The filename in bitwarden is called **users_account_aws** 

To spin up infra in prod you need to use the credentials called **terraform_user_prod_env** .

To spin up infra in dev you need to use the credentials called **terraform_user_dev_env**


## Run via laptop

After you installed terraform and aws cli and also setup your credentials in the credentials file from aws cli, you're good to create your infra.

Clone the infra repo and go inside the dev or prod folder.

The configuration assigned to all the resources are already there, so you don't need to change or modify anything. 

Just for your information, the values for all the resources for **dev env** are [here](https://gitlab.com/noah-energy/infranoah/durable-resources-aws/-/blob/main/environments/dev/dev.tfvars)

The values for **prod env** are [here](https://gitlab.com/noah-energy/infranoah/durable-resources-aws/-/blob/main/environments/prod/prod.tfvars) 

Finally in order to create we first need to initialise our workspace by running 

this command **terraform init** like in the example below

```
marcodivincenzo@Marcos-MacBook-Pro:[prod]:(main): terraform init
Initializing modules...
- jump_host in ../../modules/bastions
- k8s in ../../modules/eks
- networking in ../../modules/vpc

Initializing the backend...

Successfully configured the backend "s3"! Terraform will automatically
use this backend unless the backend configuration changes.

Initializing provider plugins...
- Finding latest version of hashicorp/aws...
- Finding latest version of hashicorp/kubernetes...
- Installing hashicorp/aws v3.74.0...
- Installed hashicorp/aws v3.74.0 (signed by HashiCorp)
- Installing hashicorp/kubernetes v2.7.1...
- Installed hashicorp/kubernetes v2.7.1 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!
```



After that we run `terraform plan` to have a detailed explanation about what is going to be created like in this example

```
terraform plan -var-file=test.tfvars 
...
...
Plan: 62 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + alb_sg                = (known after apply)
  + azs                   = [
      + "eu-west-1a",
      + "eu-west-1b",
    ]
  + bastions_sg           = (known after apply)
  + db_sg                 = (known after apply)
  + db_subnets_cidr       = [
      + "20.0.96.0/20",
      + "20.0.112.0/20",
    ]
  + eks_cluster_id        = (known after apply)
  + eks_endpoint          = (known after apply)
  + eks_sg                = (known after apply)
  + eks_subnets           = [
      + (known after apply),
      + (known after apply),
    ]
  + private_subnets_cidr  = [
      + "20.0.48.0/20",
      + "20.0.64.0/20",
    ]
  + private_subnets_id    = [
      + (known after apply),
      + (known after apply),
    ]
  + public_subnets_cidr   = [
      + "20.0.0.0/20",
      + "20.0.16.0/20",
    ]
  + public_subnets_id     = [
      + (known after apply),
      + (known after apply),
    ]
  + vpc_cidr_block        = "20.0.0.0/16"
  + vpc_id                = (known after apply)
```

Once you that you validated that everything is fine, you can run `terraform apply` like in this example. 


````
terraform apply -var-file=test.tfvars 
````

If you want to destroy everything, be sure to be in the same folder from where you created the infra. 

To delete everything run this command 
````
terraform destroy -var-file=test.tfvars  -auto-approve
````


