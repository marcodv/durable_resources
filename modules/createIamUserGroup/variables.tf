variable "eks_cluster_management_list_policies" {
  description = "List of the policies to associate to the cluster management group"
  type = list(object({
    name        = string
    path        = string
    description = string
  }))
}
