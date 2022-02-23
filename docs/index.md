# AWS Durable Resources 

This docs describe the durable resources deploy by Terraform via GitLab

## Resources created summary

This repo manage the creation of the following 

- S3 buckets
- IAM users accounts
- IAM groups users
- IAM roles
- Lambda functions



## Command to run to create resources

Once you got your aws configured, you can run terraform.

Initiate your terraform space running `terraform init` like in the example below

```
marcodivincenzo@Marcos-MacBook-Pro:[prod]:(main): terraform init
Initializing modules...
- createClusterRoles in ../../modules/iam/createRoles/eksClusterRole
- createUsers in ../../modules/iam/createUsers/terraformUsers
- createWorkerNodeRole in ../../modules/iam/createRoles/eksWorkerNodeRole

Initializing the backend...
Successfully configured the backend "s3"! Terraform will automatically
use this backend unless the backend configuration changes.

Initializing provider plugins...
- Finding latest version of hashicorp/aws...
- Installing hashicorp/aws v4.0.0...
- Installed hashicorp/aws v4.0.0 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.
Terraform has been successfully initialized!
```

## Create resources

After that we run `terraform plan` to have a detailed explanation about what is going to be created like in this example

```
terraform plan -var-file=dev.tfvars
```
```
...
...
Terraform will perform the following actions:
  # module.createClusterMgmtGroup.aws_iam_group.eks_cluster_mgmt will be created
  + resource "aws_iam_group" "eks_cluster_mgmt" {
      + arn       = (known after apply)
      + id        = (known after apply)
      + name      = "EKSClusterManagement"
      + path      = "/"
      + unique_id = (known after apply)
    }
  # module.createClusterMgmtGroup.aws_iam_group_membership.attach_user_to_cluster_group will be created
  + resource "aws_iam_group_membership" "attach_user_to_cluster_group" {
      + group = "EKSClusterManagement"
      + id    = (known after apply)
      + name  = "EKSClusterManagement"
      + users = [
          + "Terraform_User_Dev_Env",
          + "Terraform_User_Prod_Env",
          + "bastiaan@noah.energy",
          + "marco@noah.energy",
        ]
    }
  # module.createClusterMgmtGroup.aws_iam_group_policy_attachment.cluster_mgmt_policies["0"] will be created
  + resource "aws_iam_group_policy_attachment" "cluster_mgmt_policies" {
      + group      = "EKSClusterManagement"
      + id         = (known after apply)
      + policy_arn = "arn:aws:iam::848481299679:policy/EKSClusterAdmin"
    }
  # module.createClusterMgmtGroup.aws_iam_group_policy_attachment.cluster_mgmt_policies["1"] will be created
  + resource "aws_iam_group_policy_attachment" "cluster_mgmt_policies" {
      + group      = "EKSClusterManagement"
      + id         = (known after apply)
      + policy_arn = "arn:aws:iam::848481299679:policy/EKSDescribeCluster"
    }
  # module.createClusterMgmtGroup.aws_iam_group_policy_attachment.cluster_mgmt_policies["2"] will be created
  + resource "aws_iam_group_policy_attachment" "cluster_mgmt_policies" {
      + group      = "EKSClusterManagement"
      + id         = (known after apply)
      + policy_arn = "arn:aws:iam::848481299679:policy/EKSUpdateCluster"
    }
  # module.createClusterMgmtGroup.aws_iam_group_policy_attachment.cluster_mgmt_policies["3"] will be created
  + resource "aws_iam_group_policy_attachment" "cluster_mgmt_policies" {
      + group      = "EKSClusterManagement"
      + id         = (known after apply)
      + policy_arn = "arn:aws:iam::848481299679:policy/EKSViewNodesWorkload"
    }
  # module.createClusterMgmtGroup.aws_iam_policy.cluster_mgmt_policies_list["0"] will be created
  + resource "aws_iam_policy" "cluster_mgmt_policies_list" {
      + arn         = (known after apply)
      + description = "Full admin rights to manage EKS"
      + id          = (known after apply)
      + name        = "EKSClusterAdmin"
      + path        = "/"
      + policy      = jsonencode(
            {
              + Statement = [
                  + {
                      + Action   = "eks:*"
                      + Effect   = "Allow"
                      + Resource = "*"
                      + Sid      = "eksadministrator"
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + policy_id   = (known after apply)
      + tags_all    = {
          + "Environment"   = "prod"
          + "Type_Resource" = "durable"
        }
    }
  # module.createClusterMgmtGroup.aws_iam_policy.cluster_mgmt_policies_list["1"] will be created
  + resource "aws_iam_policy" "cluster_mgmt_policies_list" {
      + arn         = (known after apply)
      + description = "List and describe cluster"
      + id          = (known after apply)
      + name        = "EKSDescribeCluster"
      + path        = "/"
      + policy      = jsonencode(
            {
              + Statement = [
                  + {
                      + Action   = [
                          + "eks:DescribeCluster",
                          + "eks:ListClusters",
                        ]
                      + Effect   = "Allow"
                      + Resource = "*"
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + policy_id   = (known after apply)
      + tags_all    = {
          + "Environment"   = "prod"
          + "Type_Resource" = "durable"
        }
    }
  # module.createClusterMgmtGroup.aws_iam_policy.cluster_mgmt_policies_list["2"] will be created
  + resource "aws_iam_policy" "cluster_mgmt_policies_list" {
      + arn         = (known after apply)
      + description = "Allow update EKS cluster version"
      + id          = (known after apply)
      + name        = "EKSUpdateCluster"
      + path        = "/"
      + policy      = jsonencode(
            {
              + Statement = [
                  + {
                      + Action   = "eks:UpdateClusterVersion"
                      + Effect   = "Allow"
                      + Resource = "arn:aws:eks:*:848481299679:cluster/*"
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + policy_id   = (known after apply)
      + tags_all    = {
          + "Environment"   = "prod"
          + "Type_Resource" = "durable"
        }
    }
  # module.createClusterMgmtGroup.aws_iam_policy.cluster_mgmt_policies_list["3"] will be created
  + resource "aws_iam_policy" "cluster_mgmt_policies_list" {
      + arn         = (known after apply)
      + description = "Describe node and workload"
      + id          = (known after apply)
      + name        = "EKSViewNodesWorkload"
      + path        = "/"
      + policy      = jsonencode(
            {
              + Statement = [
                  + {
                      + Action   = [
                          + "eks:DescribeNodegroup",
                          + "eks:ListNodegroups",
                          + "eks:DescribeCluster",
                          + "eks:ListClusters",
                          + "eks:AccessKubernetesApi",
                          + "ssm:GetParameter",
                          + "eks:ListUpdates",
                          + "eks:ListFargateProfiles",
                        ]
                      + Effect   = "Allow"
                      + Resource = "*"
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + policy_id   = (known after apply)
      + tags_all    = {
          + "Environment"   = "prod"
          + "Type_Resource" = "durable"
        }
    }
Plan: 10 to add, 0 to change, 0 to destroy.
```

Once you that you validated that everything is fine, you can run `terraform apply` like in this example. 



````
terraform apply -var-file=dev.tfvars 
````

## Destroy resources

For destroy infra run this command 
````
terraform destroy -var-file=dev.tfvars 
````

**And you will prompted to type yes** in case you want destroy it

```
Terraform will perform the following actions:
  # module.createClusterMgmtGroup.aws_iam_group.eks_cluster_mgmt will be created
  + resource "aws_iam_group" "eks_cluster_mgmt" {
      + arn       = (known after apply)
      + id        = (known after apply)
      + name      = "EKSClusterManagement"
      + path      = "/"
      + unique_id = (known after apply)
    }
  # module.createClusterMgmtGroup.aws_iam_group_membership.attach_user_to_cluster_group will be created
  + resource "aws_iam_group_membership" "attach_user_to_cluster_group" {
      + group = "EKSClusterManagement"
      + id    = (known after apply)
      + name  = "EKSClusterManagement"
      + users = [
          + "Terraform_User_Dev_Env",
          + "Terraform_User_Prod_Env",
          + "bastiaan@noah.energy",
          + "marco@noah.energy",
        ]
    }
  # module.createClusterMgmtGroup.aws_iam_group_policy_attachment.cluster_mgmt_policies["0"] will be created
  + resource "aws_iam_group_policy_attachment" "cluster_mgmt_policies" {
      + group      = "EKSClusterManagement"
      + id         = (known after apply)
      + policy_arn = "arn:aws:iam::848481299679:policy/EKSClusterAdmin"
    }
  # module.createClusterMgmtGroup.aws_iam_group_policy_attachment.cluster_mgmt_policies["1"] will be created
  + resource "aws_iam_group_policy_attachment" "cluster_mgmt_policies" {
      + group      = "EKSClusterManagement"
      + id         = (known after apply)
      + policy_arn = "arn:aws:iam::848481299679:policy/EKSDescribeCluster"
    }
  # module.createClusterMgmtGroup.aws_iam_group_policy_attachment.cluster_mgmt_policies["2"] will be created
  + resource "aws_iam_group_policy_attachment" "cluster_mgmt_policies" {
      + group      = "EKSClusterManagement"
      + id         = (known after apply)
      + policy_arn = "arn:aws:iam::848481299679:policy/EKSUpdateCluster"
    }
  # module.createClusterMgmtGroup.aws_iam_group_policy_attachment.cluster_mgmt_policies["3"] will be created
  + resource "aws_iam_group_policy_attachment" "cluster_mgmt_policies" {
      + group      = "EKSClusterManagement"
      + id         = (known after apply)
      + policy_arn = "arn:aws:iam::848481299679:policy/EKSViewNodesWorkload"
    }
  # module.createClusterMgmtGroup.aws_iam_policy.cluster_mgmt_policies_list["0"] will be created
  + resource "aws_iam_policy" "cluster_mgmt_policies_list" {
      + arn         = (known after apply)
      + description = "Full admin rights to manage EKS"
      + id          = (known after apply)
      + name        = "EKSClusterAdmin"
      + path        = "/"
      + policy      = jsonencode(
            {
              + Statement = [
                  + {
                      + Action   = "eks:*"
                      + Effect   = "Allow"
                      + Resource = "*"
                      + Sid      = "eksadministrator"
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + policy_id   = (known after apply)
      + tags_all    = {
          + "Environment"   = "prod"
          + "Type_Resource" = "durable"
        }
    }
  # module.createClusterMgmtGroup.aws_iam_policy.cluster_mgmt_policies_list["1"] will be created
  + resource "aws_iam_policy" "cluster_mgmt_policies_list" {
      + arn         = (known after apply)
      + description = "List and describe cluster"
      + id          = (known after apply)
      + name        = "EKSDescribeCluster"
      + path        = "/"
      + policy      = jsonencode(
            {
              + Statement = [
                  + {
                      + Action   = [
                          + "eks:DescribeCluster",
                          + "eks:ListClusters",
                        ]
                      + Effect   = "Allow"
                      + Resource = "*"
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + policy_id   = (known after apply)
      + tags_all    = {
          + "Environment"   = "prod"
          + "Type_Resource" = "durable"
        }
    }
  # module.createClusterMgmtGroup.aws_iam_policy.cluster_mgmt_policies_list["2"] will be created
  + resource "aws_iam_policy" "cluster_mgmt_policies_list" {
      + arn         = (known after apply)
      + description = "Allow update EKS cluster version"
      + id          = (known after apply)
      + name        = "EKSUpdateCluster"
      + path        = "/"
      + policy      = jsonencode(
            {
              + Statement = [
                  + {
                      + Action   = "eks:UpdateClusterVersion"
                      + Effect   = "Allow"
                      + Resource = "arn:aws:eks:*:848481299679:cluster/*"
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + policy_id   = (known after apply)
      + tags_all    = {
          + "Environment"   = "prod"
          + "Type_Resource" = "durable"
        }
    }
  # module.createClusterMgmtGroup.aws_iam_policy.cluster_mgmt_policies_list["3"] will be created
  + resource "aws_iam_policy" "cluster_mgmt_policies_list" {
      + arn         = (known after apply)
      + description = "Describe node and workload"
      + id          = (known after apply)
      + name        = "EKSViewNodesWorkload"
      + path        = "/"
      + policy      = jsonencode(
            {
              + Statement = [
                  + {
                      + Action   = [
                          + "eks:DescribeNodegroup",
                          + "eks:ListNodegroups",
                          + "eks:DescribeCluster",
                          + "eks:ListClusters",
                          + "eks:AccessKubernetesApi",
                          + "ssm:GetParameter",
                          + "eks:ListUpdates",
                          + "eks:ListFargateProfiles",
                        ]
                      + Effect   = "Allow"
                      + Resource = "*"
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + policy_id   = (known after apply)
      + tags_all    = {
          + "Environment"   = "prod"
          + "Type_Resource" = "durable"
        }
    }
Plan: 10 to add, 0 to change, 0 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value:
```
