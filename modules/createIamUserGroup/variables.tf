variable "eks_cluster_management_list_policies" {
  description = "List of the policies to associate to the cluster management group"
  type = list(object({
    name        = string
    path        = string
    description = string
  }))
}

variable "cluster_users_mgmt" {
  description = "List of user to attach to the EKS IAM user gorup"
  type = list(string)
}

variable "attach_user_to_group" {
  description = "List of group to which the user is going to be part of "
  type = list(string)
}