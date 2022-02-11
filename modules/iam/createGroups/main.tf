// Create cluster group
resource "aws_iam_group" "eks_cluster_mgmt" {
  depends_on = [aws_iam_policy.cluster_mgmt_policies_list]
  name       = "EKSClusterManagement"
  path       = "/"
}

// Create cluster policies
resource "aws_iam_policy" "cluster_mgmt_policies_list" {
  for_each    = { for k, v in var.eks_cluster_management_list_policies : k => v }
  name        = each.value.name
  path        = each.value.path
  description = each.value.description
  policy      = file("${path.module}/${each.value.name}.json")
}

// Attach managed cluster policies
resource "aws_iam_group_policy_attachment" "cluster_mgmt_policies" {
  for_each    = { for k, v in var.eks_cluster_management_list_policies : k => v }
  depends_on = [aws_iam_policy.cluster_mgmt_policies_list]
  group      = aws_iam_group.eks_cluster_mgmt.name
  policy_arn = "arn:aws:iam::848481299679:policy/${each.value.name}"
}

// Attach AWS IAM cluster policies
resource "aws_iam_group_membership" "attach_user_to_cluster_group" {
  depends_on = [aws_iam_group.eks_cluster_mgmt]
  name       = element(var.attach_user_to_group, 0)
  users      = var.cluster_users_mgmt
  group      = element(var.attach_user_to_group, 0)
}
